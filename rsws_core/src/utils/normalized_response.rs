use salvo::Depot;

use crate::constants::*;

pub fn set_message(depot: &mut Depot, message: impl Into<String>){
    depot.inser(RESPONSE_MESSAGE, message.into());
}

pub fn get_message(depot: &mut Depot) -> String{
    depot
        .get::<String>(RESPONSE_MESSAGE)
        .ok()
        .unwrap_or(&RESPONSE_MESSAGE_SUCCESS.to_string())
        .to_owned()
}