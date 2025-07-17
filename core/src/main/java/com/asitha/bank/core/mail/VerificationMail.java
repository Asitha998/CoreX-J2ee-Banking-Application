package com.asitha.bank.core.mail;

import jakarta.mail.Message;
import jakarta.mail.internet.InternetAddress;

public class VerificationMail extends Mailable {
    private String to;
    private String verificationCode;

    public VerificationMail(String to, String verificationCode) {
        this.to = to;
        this.verificationCode = verificationCode;
    }

    @Override
    public void build(Message message) throws Exception {
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
        message.setSubject("Your OTP for Fund Transfer");
        message.setContent(
                "<html>" +
                        "<body>" +
                        "<h1>Fund Transfer OTP</h1>" +
                        "<p>Your OTP for the fund transfer is: <strong>" + verificationCode + "</strong></p>" +
                        "<p>Please use this OTP to confirm your transaction.</p>" +
                        "<p>If you did not initiate this transfer, please ignore this email.</p>" +
                        "<p>Thank you for using our service!</p>" +
                        "</body>" +
                        "</html>"
                , "text/html");
    }

}
