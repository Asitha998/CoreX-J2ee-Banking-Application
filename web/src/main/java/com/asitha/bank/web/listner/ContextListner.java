package com.asitha.bank.web.listner;

import com.asitha.bank.core.provider.MailServiceProvider;
import com.asitha.bank.core.util.Env;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class ContextListner implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        MailServiceProvider.getInstance().start();
        System.out.println(Env.get("mailtrap.host"));
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        MailServiceProvider.getInstance().shutdown();
    }
}
