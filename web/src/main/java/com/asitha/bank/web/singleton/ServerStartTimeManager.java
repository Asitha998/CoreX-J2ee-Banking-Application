package com.asitha.bank.web.singleton;

import jakarta.annotation.PostConstruct;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import java.util.logging.Level;
import java.util.logging.Logger;

@Singleton
@Startup
public class ServerStartTimeManager {

    private static final Logger LOGGER = Logger.getLogger(ServerStartTimeManager.class.getName());

    private long applicationStartTime;

    @PostConstruct
    public void init() {
        // Capture the time when this EJB is initialized by the container
        this.applicationStartTime = System.currentTimeMillis();
        LOGGER.log(Level.INFO, "ServerStartTimeManager initialized. Application Start Time: {0}", this.applicationStartTime);
    }

    // Public method to provide the captured start time
    public long getApplicationStartTime() {
        return applicationStartTime;
    }
}