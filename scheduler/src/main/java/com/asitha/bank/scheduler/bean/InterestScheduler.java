package com.asitha.bank.scheduler.bean;

import com.asitha.bank.core.model.Account;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.util.List;

@Singleton
@Startup
public class InterestScheduler {
    @PersistenceContext
    private EntityManager em;

    @Schedule(dayOfMonth="1", hour="0", minute="0", persistent=false)
    public void applyMonthlyInterest() {

        // e.g. 1% interest
        final BigDecimal rate = new BigDecimal("0.01");
        List<Account> accounts = em.createNamedQuery("Account.findAll", Account.class)
                .getResultList();
        for (Account acct : accounts) {
            BigDecimal interest = acct.getBalance().multiply(rate);
            acct.setBalance(acct.getBalance().add(interest));
            em.merge(acct);
        }
    }
}