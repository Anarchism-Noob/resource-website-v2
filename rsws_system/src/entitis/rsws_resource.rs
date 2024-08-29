//! `SeaORM` Entity. Generated by sea-orm-codegen 0.12.15

use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq)]
#[sea_orm(table_name = "rsws_resource")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub id: i64,
    pub rsname: String,
    pub rstype: i64,
    pub rspath: String,
    #[sea_orm(column_type = "Decimal(Some((10, 2)))")]
    pub rsprice: Decimal,
    pub rsavatar: String,
    pub creator: i64,
    pub create_time: DateTime,
    pub rsversion: Option<String>,
    pub updater: Option<String>,
    pub update_time: Option<DateTime>,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
