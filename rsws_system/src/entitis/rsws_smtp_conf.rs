//! `SeaORM` Entity. Generated by sea-orm-codegen 0.12.15

use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq)]
#[sea_orm(table_name = "rsws_smtp_conf")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub id: i64,
    pub smtp_email: String,
    pub reply_email: String,
    pub smtp_sub: String,
    pub content_type: String,
    pub smtp_body: String,
    pub smtp_username: String,
    pub smtp_password: String,
    pub smtp_starttls: String,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
