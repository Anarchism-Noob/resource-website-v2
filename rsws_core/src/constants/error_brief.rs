use salvo::http::StatusCode;

pub fn get_error_brief_str(status_code: StatusCode) -> &'static str {
    match status_code {
        StatusCode::BAD_REQUEST => "由于语法错误，服务器无法理解该请求。",
        StatusCode::UNAUTHORIZED => "该请求需要用户身份验证。",
        StatusCode::PAYMENT_REQUIRED => "由于缺少付款，该请求无法被处理。",
        StatusCode::FORBIDDEN => "服务器拒绝授权该请求。",
        StatusCode::NOT_FOUND => "找不到请求的资源。",
        StatusCode::METHOD_NOT_ALLOWED => "请求的方法不支持请求的资源。",
        StatusCode::NOT_ACCEPTABLE => {
            "根据请求中发送的 Accept 头，请求的资源无法生成可接受的内容。"
        }
        StatusCode::PROXY_AUTHENTICATION_REQUIRED => "需要与代理进行身份验证。",
        StatusCode::REQUEST_TIMEOUT => "服务器等待请求时超时。",
        StatusCode::CONFLICT => "由于请求中的冲突，请求无法被处理。",
        StatusCode::GONE => "请求的资源不再可用，并且将来也不会再可用。",
        StatusCode::LENGTH_REQUIRED => "请求未指定其内容长度，这是请求资源所要求的。",
        StatusCode::PRECONDITION_FAILED => "服务器不满足请求中指定的一个或多个先决条件。",
        StatusCode::PAYLOAD_TOO_LARGE => "请求大小超过了服务器愿意或能够处理的范围。",
        StatusCode::URI_TOO_LONG => "提供的 URI 太长，服务器无法处理。",
        StatusCode::UNSUPPORTED_MEDIA_TYPE => "请求实体具有服务器或资源不支持的媒体类型。",
        StatusCode::RANGE_NOT_SATISFIABLE => "服务器无法提供请求文件的指定部分。",
        StatusCode::EXPECTATION_FAILED => "服务器无法满足 Expect 请求头字段的要求。",
        StatusCode::IM_A_TEAPOT => "我被要求煮咖啡，但我是一个茶壶。",
        StatusCode::MISDIRECTED_REQUEST => "服务器无法为此请求生成响应。",
        StatusCode::UNPROCESSABLE_ENTITY => "请求格式良好，但由于语义错误而无法遵循。",
        StatusCode::LOCKED => "方法的源或目标资源被锁定。",
        StatusCode::FAILED_DEPENDENCY => {
            "由于请求的动作依赖于另一个动作，且该动作失败，因此无法在资源上执行该方法。"
        }
        StatusCode::UPGRADE_REQUIRED => "需要切换到 Upgrade 头字段中的协议。",
        StatusCode::PRECONDITION_REQUIRED => "服务器要求请求是有条件的。",
        StatusCode::TOO_MANY_REQUESTS => "最近收到了太多请求。",
        StatusCode::REQUEST_HEADER_FIELDS_TOO_LARGE => {
            "服务器不愿处理请求，因为单个头字段或所有头字段集合太大。"
        }
        StatusCode::UNAVAILABLE_FOR_LEGAL_REASONS => {
            "由于法律要求拒绝访问此资源，请求的资源不可用。"
        }
        StatusCode::INTERNAL_SERVER_ERROR => "服务器在处理此请求时遇到内部错误。",
        StatusCode::NOT_IMPLEMENTED => "服务器不识别请求方法，或者缺乏满足请求的能力。",
        StatusCode::BAD_GATEWAY => "在尝试满足请求时，从入站服务器收到无效响应。",
        StatusCode::SERVICE_UNAVAILABLE => "服务器当前不可用。",
        StatusCode::GATEWAY_TIMEOUT => "服务器没有从上游服务器及时收到响应。",
        StatusCode::HTTP_VERSION_NOT_SUPPORTED => {
            "服务器不支持或拒绝支持请求消息中使用的HTTP主要版本。"
        }
        StatusCode::VARIANT_ALSO_NEGOTIATES => "服务器存在内部配置错误。",
        StatusCode::INSUFFICIENT_STORAGE => {
            "由于服务器无法存储成功完成请求所需的表示，无法在资源上执行该方法。"
        }
        StatusCode::LOOP_DETECTED => {
            "服务器在处理具有'Depth:infinity'的请求时遇到无限循环，因此终止了操作。"
        }
        StatusCode::NOT_EXTENDED => "服务器需要对请求进行进一步扩展才能完成它。",
        StatusCode::NETWORK_AUTHENTICATION_REQUIRED => "客户端需要进行身份验证以获得网络访问权限。",
        _ => "未知错误。",
    }
}
