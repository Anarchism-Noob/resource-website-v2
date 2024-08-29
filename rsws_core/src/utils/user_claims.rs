use chrono::{DateTime,Utc};

use serde::{Deserialize, Serialize};

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq)]
pub struct UserClaims{
    pub id: i64,
    pub username: String,
    pub email: String,
    pub crated_time: DateTime<Utc>,
}

impl UserClaims {
    pub fn new(id: i64, username: &str, email: &str) -> Self{
        Self {
            id,
            username: username.to_string(),
            email: email.to_string(),
            crated_time: Utc::now(),
        }
    }
}