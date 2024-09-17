/*
 * @Author: Anarchism-Noob 105835720+Anarchism-Noob@users.noreply.github.com
 * @Date: 2024-08-16 18:51:24
 * @LastEditors: Anarchism-Noob 105835720+Anarchism-Noob@users.noreply.github.com
 * @LastEditTime: 2024-09-17 21:38:29
 * @FilePath: /resource-website-v2/rsws_core/src/utils/jwt.rs
 * @Description: 这是默认设置,请设置`customMade`, 打开koroFileHeader查看配置 进行设置: https://github.com/OBKoro1/koro1FileHeader/wiki/%E9%85%8D%E7%BD%AE
 */
use crate::utils::UserClaims;
use jwt_simple::prelude::*;

const JWT_DURATION: u64 = 60 * 60 * 24 * 7;
const JWT_ISS: &str = "rsws_server";
const JWT_AUD: &str = "rsws_web";

pub struct EncodingKey(Ed25519KeyPair);

#[allow(unused)]
pub struct DecodingKey(Ed25519KeyPair);

impl EncodingKey {
    pub fn load(pem: &str) -> Result<Self, jwt_simple::Error> {
        Ok(Self(Ed25519KeyPair::from_pem(pem)?))
    }

    pub fn sign(&self, user: impl Into<UserClaims>) -> Result<String, jwt_simple::Error> {
        let claims = Claims::with_custom_claims(user.into(), Duration::from_secs(JWT_DURATION));
        let claims = claims.with_issuer(JWT_ISS).with_audience(JWT_AUD);
        self.0.sign(claims)
    }
}

impl DecodingKey {
    pub fn load(pem: &str) -> Result<Self, jwt_simple::Error> {
        Ok(Self(Ed25519KeyPair::from_pem(pem)?))
    }

    #[allow(unused)]
    pub fn decode(&self, token: &str) -> Result<UserClaims, jwt_simple::Error> {
        let opts = VerificationOptions {
            allowed_issuers: Some(HashSet::from_strings(&[JWT_ISS])),
            allowed_audiences: Some(HashSet::from_strings(&[JWT_AUD])),
            ..Default::default()
        };

        let claims = self.0.verify_token::<UserClaims>(token, Some(opts))?;
        Ok(claims)
    }
}
