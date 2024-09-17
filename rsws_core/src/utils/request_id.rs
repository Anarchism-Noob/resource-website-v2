/*
 * @Author: Anarchism-Noob 105835720+Anarchism-Noob@users.noreply.github.com
 * @Date: 2024-08-16 19:22:57
 * @LastEditors: Anarchism-Noob 105835720+Anarchism-Noob@users.noreply.github.com
 * @LastEditTime: 2024-09-17 21:40:23
 * @FilePath: /resource-website-v2/rsws_core/src/utils/request_id.rs
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
use salvo::Depot;

use crate::constants::REQUEST_ID_HEADER;

pub fn get_request_id(depot: &mut Depot) -> String {
    depot
        .get::<String>(REQUEST_ID_HEADER)
        .unwrap_or(&"-1".to_string())
        .to_owned()
}
