use salvo::Depot;

use crate::constants::REQUEST_ID_HEADER;

pub fn get_request_id(depot: &mut Depot) -> String{
    depot
        .get::<String>(REQUEST_ID_HEADER)
        .unwrap_or(&"-1".to_string())
        .to_owned()
}