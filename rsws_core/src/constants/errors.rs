pub const BUSINESS_ERROR_MSG: &str = "业务错误";
pub const NOT_FOUND: (i32, &str) = (1002, "未找到");
pub const IO_ERROR: (i32, &str) = (1003, "IO错误");
pub const SQL_ERROR: (i32, &str) = (1004, "SQL错误");
pub const ANYHOW_ERROR: (i32, &str) = (1006, "通用错误");
pub const SERDE_ERROR: (i32, &str) = (1007, "Serde错误");
pub const UNKNOW_ERROR: (i32, &str) = (-1, "未知错误");

//system error
pub const EMAIL_EXISTS: (i32, &str) = (1101, "邮箱已存在");
pub const INVALID_CREDENTIALS: (i32, &str) = (1102, "用户名或密码错误");
pub const ERROR_MESSAGE_INVALID_CREDENTIALS: (i32, &str) = (1104, "用户名或密码错误");
pub const PASSWORD_HASH_ERROR: (i32, &str) = (1103, "密码哈希错误");
pub const TOKEN_ERROR: (i32, &str) = (1105, "Token无效");
