pub const RESPONSE_MESSAGE: &str = "depot-response-message";
pub const RESPONSE_IS_SUCCESS: &str = "depot-response-is-success";

/// key used to insert auth decoded data to depot.
pub const JWT_AUTH_DATA_KEY: &str = "::salvo::jwt_auth::auth_data";
/// key used to insert auth state data to depot.
pub const JWT_AUTH_STATE_KEY: &str = "::salvo::jwt_auth::auth_state";
/// key used to insert auth token data to depot.
pub const JWT_AUTH_TOKEN_KEY: &str = "::salvo::jwt_auth::auth_token";
/// key used to insert auth error to depot.
pub const JWT_AUTH_ERROR_KEY: &str = "::salvo::jwt_auth::auth_error";