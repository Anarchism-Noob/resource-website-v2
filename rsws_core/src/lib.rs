pub use config::AppConfig;
pub use error::{AppError, AppResult, ErrorOutput};
use sea_orm::Database;
use sea_orm::DatabaseConnection;
use std::{fmt, ops::Deref, sync::Arc};
use salvo::oapi::KnownFormat::Duration;
use tokio::sync::OnceCell;
pub use utils::{get_request_id, UserClaims};
use utils::{DecodingKey, EncodingKey};
pub mod config;
pub mod constants;
pub mod error;
pub mod middlewares;
pub mod utils;
mod router;

pub static CORE_SERVICE: OnceCell<CoreService> = OnceCell::const_new();

pub async fn get_core_service() -> CoreService {
    CORE_SERVICE
        .get_or_init(|| async {
            CoreService::try_new()
                .await
                .expect("CoreService::try_new failed")
        })
        .await
        .clone()
}

pub fn get_db_pool() -> DatabaseConnection {
    CORE_SERVICE
        .get()
        .expect("db pool not init")
        .db_connection
        .clone()
}

pub fn get_ek() -> &'static EncodingKey {
    &CORE_SERVICE.get().expect("ek not init").ek
}

pub fn get_dk() -> &'static DecodingKey {
    &CORE_SERVICE.get().expect("dk not init").dk
}

#[derive(Debug, Clone)]
pub struct CoreService {
    pub inner: Arc<CoreServiceInner>,
}

impl fmt::Debug for CoreServiceInner {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.debug_struct("CoreStateInner")
            .field("config", &self.config)
            .finish()
    }
}

#[allow(unused)]
pub struct CoreServiceInner {
    pub config: AppConfig,
    pub dk: DecodingKey,
    pub ek: EncodingKey,
    pub db_connection: DatabaseConnection,
}

impl Deref for CoreService {
    type Target = CoreServiceInner;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

impl CoreService {
    async fn try_new() -> Result<Self, AppError> {
        let config = AppConfig::load()?;

        let mut connect_options = sea_orm::ConnectOptions::new(config.server.db_url.clone());
        connect_options.connect_timeout(Duration::new(10, 0));

        let db_connection = Database::connect(connect_options).await?;

        let dk = DecodingKey::load(&config.auth.pk)?;
        let ek = EncodingKey::load(&config.auth.sk)?;

        Ok(Self {
            inner: Arc::new(CoreServiceInner {
                config,
                dk,
                ek,
                db_connection,
            }),
        })
    }
}
