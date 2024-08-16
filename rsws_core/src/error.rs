use crate::constants::errors::*;
use salvo::{
    async_trait,
    http::{
        ResBody, StatusCode, StatusError
    },
    oapi::{
        self, EndpointOutRegister, ToSchema
    },
    Depot, Request, Response, Writer
};
use std::{
    error::Error as StdError, fmt::Debug
};
use sea_orm::sqlx;
use thiserror::Error;

pub type AppResult<T> = Result<T, AppError>;

#[macro_export]
macro_rules! business_error {
    ($status:expr, $error:expr) => {
        Err(APPError::new_business_error($status, $error.1, $error.0, $error.1).into())
    };
}
#[derive(Debug)]
pub struct ErrorOutput {
    pub error: Box<dyn StdError + Sync + Send + 'static>,
    pub visible_error: String,
    pub status: StatusCode,
    pub error_code: i32,
}
impl ErrorOutput {
    pub fn new(
        error: impl Into<Box<dyn StdError + Sync + Send + 'static>>,
        status: StatusCode,
        error_code: i32,
        visible_error: impl Into<String>,
    ) -> Self {
        Self {
            error: error.into(),
            visible_error: visible_error.into(),
            status,
            error_code,
        }
    }
}

#[async_trait]
impl Writer for ErrorOutput {
    async fn write(self, _req: &mut Request, _depot: &mut Depot, res: &mut Response) {
        res.status_code(self.status);
        let mut error = StatusError::from_code(self.status).unwrap_or(StatusError::not_found());
        error.detail = Some(self.error.to_string());
        error.brief = serialize_error(self.error_code, self.visible_error);
        error.cause = Some(self.error);
        res.replace_body(ResBody::Error(error));
    }
}

pub fn get_error_code(error: Option<&(dyn StdError + Sync + Send + 'static)>) -> i32 {
    match error {
        Some(e) => {
            if e.downcast_ref::<salvo::http::ParseError>().is_some() {
                SERDE_ERROR.0
            } else {
                -1
            }
        }
        None => -1,
    }
}

fn serialize_error(num: i32, text: String) -> String {
    format!("{}|{}", num, text)
}

pub fn deserialize_error(data: String) -> (Option<i32>, String) {
    let parts: Vec<&str> = data.splitn(2, '|').collect();
    if parts.len() == 2 {
        let num = parts[0].parse::<i32>().ok();
        let text = parts[1].to_string();
        (num, text)
    } else {
        (None, data)
    }
}

impl UserVisibleError for ErrorOutput {}

pub trait UserVisibleError: Debug {
    fn user_message(&self) -> (i32, String) {
        (-1, format!("{:?}", self))
    }
    fn status_code(&self) -> StatusCode {
        StatusCode::INTERNAL_SERVER_ERROR
    }
}

#[derive(Error, Debug)]
pub enum AppError {
    #[error("{}:{error}", BUSINESS_ERROR_MSG)]
    BusinessError {
        status: StatusCode,
        error: Box<dyn StdError + Sync + Send + 'static>,
        error_code: i32,
        visible_error: String,
    },
    #[error("{}:{0}", NOT_FOUND.1)]
    NotFound(String),

    #[error("{}:{0}", IO_ERROR.1)]
    IoError(#[from] std::io::Error),

    #[error("{}:{0}", SQL_ERROR.1)]
    SqlxError(#[from] sqlx::Error),

    #[error("{}:{0}", ANYHOW_ERROR.1)]
    AnyhowError(#[from] anyhow::Error),

    #[error("{}:{0}", EMAIL_EXISTS.1)]
    UserNameAlreadyExists(String),

    #[error("{}:{0}", PASSWORD_HASH_ERROR.1)]
    PasswordHashError(#[from] argon2::password_hash::Error),
}
impl AppError {
    pub fn new_business_error(
        status: StatusCode,
        error: impl Into<Box<dyn StdError + Sync + Send + 'static>>,
        error_code: i32,
        visible_error: impl Into<String>,
    ) -> Self {
        AppError::BusinessError {
            status,
            error_code,
            error: error.into(),
            visible_error: visible_error.into(),
        }
    }
}

impl UserVisibleError for AppError {
    fn user_message(&self) -> (i32, String) {
        match self {
            AppError::BusinessError {
                error, error_code, ..
            } => (*error_code, error.to_string()),
            AppError::NotFound(e) => (NOT_FOUND.0, e.to_owned()),
            AppError::IoError(e) => (IO_ERROR.0, e.to_string()),
            AppError::SqlxError(e) => (SQL_ERROR.0, e.to_string()),
            AppError::AnyhowError(e) => (ANYHOW_ERROR.0, e.to_string()),
            AppError::UserNameAlreadyExists(e) => (EMAIL_EXISTS.0, e.to_owned()),
            AppError::PasswordHashError(e) => (PASSWORD_HASH_ERROR.0, e.to_string()),
        }
    }

    fn status_code(&self) -> StatusCode {
        match self {
            AppError::BusinessError { status, .. } => *status,
            AppError::NotFound(_) => StatusCode::NOT_FOUND,
            AppError::IoError(_) => StatusCode::INTERNAL_SERVER_ERROR,
            AppError::SqlxError(_) => StatusCode::INTERNAL_SERVER_ERROR,
            AppError::AnyhowError(_) => StatusCode::INTERNAL_SERVER_ERROR,
            AppError::UserNameAlreadyExists(_) => StatusCode::BAD_REQUEST,
            AppError::PasswordHashError(_) => StatusCode::INTERNAL_SERVER_ERROR,
        }
    }
}

#[async_trait]
impl Writer for AppError {
    async fn write(mut self, _req: &mut Request, _depot: &mut Depot, res: &mut Response) {
        let status_code = self.status_code();
        let message = self.user_message();
        let error = ErrorOutput::new(self.to_string().clone(), status_code, message.0, message.1);
        error.write(_req, _depot, res).await;
    }
}

impl EndpointOutRegister for AppError {
    fn register(components: &mut oapi::Components, operation: &mut oapi::Operation) {
        operation.responses.insert(
            StatusCode::INTERNAL_SERVER_ERROR.as_str(),
            oapi::Response::new("Internal server error")
                .add_content("application/json", StatusError::to_schema(components)),
        );
        operation.responses.insert(
            StatusCode::NOT_FOUND.as_str(),
            oapi::Response::new("Not found")
                .add_content("application/json", StatusError::to_schema(components)),
        );
        operation.responses.insert(
            StatusCode::BAD_REQUEST.as_str(),
            oapi::Response::new("Bad request")
                .add_content("application/json", StatusError::to_schema(components)),
        );
    }
}
