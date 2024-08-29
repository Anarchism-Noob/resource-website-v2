use jwt_simple::prelude::*;
use crate::utils::UserClaims;

const JWT_DURATION: u64 = 60 * 60 * 24 * 7;
const JWT_ISS: &str = "rsws_server";
const JWT_AUD: &str = "rsws_web";

pub struct EncodingKey(Ed25519KeyPair);

#[allow(unused)]
pub struct DecodingKey(Ed25519KeyPair);

impl EncodingKey{
    pub fn load(pem: &str) -> Result<Self, jwt_simple::Error>{
        Ok(Self(Ed25519KeyPair::from_pem(pem)?))
    }
    
    pub fn sign(&self, user: impl Into<UserClaims>) -> Result<String, jwt_simple::Error> {
        let claims = Claims::with_custom_claims(user.into(), Duration::from_secs(JWT_DURATION));
        let claims = claims.with_issuer(JWT_ISS).with_audience(JWT_AUD);
        self.0.sign(claims)
    }
}