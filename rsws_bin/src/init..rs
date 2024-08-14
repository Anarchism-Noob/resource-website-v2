/*
 * @Author: Anarchism-Noob 105835720+Anarchism-Noob@users.noreply.github.com
 * @Date: 2024-08-14 17:53:55
 * @LastEditors: Anarchism-Noob 105835720+Anarchism-Noob@users.noreply.github.com
 * @LastEditTime: 2024-08-14 17:59:25
 * @FilePath: /resource-website-v2/rsws-bin/src/init..rs
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
use jwt::jwt_middleware;
use salvo::{
    catcher::Catcher,
    compression::{
        Compression, CompressionLevel,
    },
    Router,
    cors::Cors, http::Method, prelude::*,
}
use rsws-core::
