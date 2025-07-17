package com.asitha.bank.customer.admin;

import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.model.UserAccount;
import com.asitha.bank.core.service.AdminService;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.time.LocalDate;
import java.util.List;

@Stateless
public class AdminServiceBean implements AdminService {

    @PersistenceContext
    private EntityManager em;

    @Override
    public int getTotalUsers() {
        return ((Number) em.createQuery("SELECT COUNT(u) FROM UserAccount u").getSingleResult()).intValue();
    }

    @Override
    public int getTotalAccounts() {
        return ((Number) em.createQuery("SELECT COUNT(a) FROM Account a").getSingleResult()).intValue();
    }

    @Override
    public int getTodayTransactionCount() {
        LocalDate today = LocalDate.now();
        return ((Number) em.createQuery("SELECT COUNT(t) FROM Transaction t WHERE DATE(t.timestamp) = :today")
                .setParameter("today", today)
                .getSingleResult()).intValue();
    }

    @Override
    public List<UserAccount> getAllUsers() {
        return em.createQuery("SELECT u FROM UserAccount u", UserAccount.class).getResultList();
    }

    @Override
    public List<Transaction> getAllTransactions() {
        return em.createQuery("SELECT t FROM Transaction t ORDER BY t.timestamp DESC", Transaction.class)
                .getResultList();
    }
}

