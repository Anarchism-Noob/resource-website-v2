use lettre::{
    transport::smtp::authentication::Credentials,
    message::header::ContentType,
    Message, SmtpTransport, Transport,
};

pub async fn send_email(
    from_email: &str,
    reply_email: &str,
    to_email: &str, 
    message: &str
) -> Result<(), lettre::transport::smtp::Error>{
    
    
    let email = Message::builder()
        .from(from_email.parse().unwrap())
        .reply_to(reply_email.parse().unwrap())
        .to(to_email.parse().unwrap())
        .subject("Send Captcha on Email")
        .header(ContentType::TEXT_PLAIN)
        .body(String::from(message))
        .unwrap();


}
