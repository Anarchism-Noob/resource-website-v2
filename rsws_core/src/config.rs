use std::{env, fs::File, path::PathBuf};

use anyhow::{bail, Result};
use serde::{Deserialize, Serialize};

#[derive(Debug,, Serialize, Deserialize)]
pub struct AppConfig{
    pub server: ServerConfig,
    pub auth: AuthConfig,
}

#[derive(Debug,, Serialize, Deserialize)]
pub struct AuthConfig{
    pub sk: String,
    pub pk: String,
}

#[derive(Debug,, Serialize, Deserialize)]
pub struct ServerConfig{
    pub port: u16,
    pub db_url: String,
    pub base_dir: PathBuf,
}

impl AppConfig {
    pub fn load() -> Result<Self>{
        let ret = match (
            env::var("rsws_config"),
            File::open("./rsws.yml"),
            File::open("../rsws.yml"),
            File::open("/etc/config/rsws.yml"),
            ){
            (Ok(config_str), _, _, _) =>  serde_yaml::from_reader(File::open(config_str)?),
            (_, Ok(reader), _, _) => serde_yaml::from_reader(reader),
            (_, _, Ok(reader), _) => serde_yaml::from_reader(reader),
            (_, _, _, Ok(reader)) => serde_yaml::from_reader(reader),
            _ => bail!("Config file not found"),
        };
        Ok(ret?)
    }
}