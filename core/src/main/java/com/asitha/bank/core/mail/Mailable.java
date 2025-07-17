package com.asitha.bank.core.mail;

import com.asitha.bank.core.provider.MailServiceProvider;
import com.asitha.bank.core.util.Env;
import jakarta.mail.Message;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public abstract class Mailable implements Runnable {

    private MailServiceProvider provider;

    public Mailable() {
        provider = MailServiceProvider.getInstance();
    }

    @Override
    public void run() {
        try {
            Session session = Session.getInstance(provider.getProperties(), provider.getAuthenticator());

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Env.get("app.email")));
            build(message);
            Transport.send(message);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public abstract void build(Message message) throws Exception;
}
