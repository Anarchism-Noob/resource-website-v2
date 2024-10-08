//! `SeaORM` Entity. Generated by sea-orm-codegen 0.12.15

use sea_orm::entity::prelude::*;

#[derive(Clone, Debug, PartialEq, DeriveEntityModel, Eq)]
#[sea_orm(table_name = "rsws_menu")]
pub struct Model {
    #[sea_orm(primary_key, auto_increment = false)]
    pub id: i64,
    pub menu_name: String,
    pub permission: String,
    pub r#type: i64,
    pub parrent_id: i64,
    pub path: Option<String>,
    pub icon: Option<String>,
    pub status: i64,
    pub visible: bool,
    pub always_show: bool,
    pub creator: String,
    pub creater_time: DateTime,
    pub updater: String,
    pub update_time: DateTime,
}

#[derive(Copy, Clone, Debug, EnumIter, DeriveRelation)]
pub enum Relation {}

impl ActiveModelBehavior for ActiveModel {}
