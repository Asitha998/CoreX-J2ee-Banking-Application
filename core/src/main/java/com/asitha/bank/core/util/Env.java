package com.asitha.bank.core.util;

import java.io.InputStream;
import java.util.Properties;

public class Env {
    private static Properties props = new Properties();
    static {
        try {
            InputStream inputStream = Env.class.getClassLoader().getResourceAsStream("application.properties");
            props.load(inputStream);
        }catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static String get(String key) {
        return props.getProperty(key);
    }
}
