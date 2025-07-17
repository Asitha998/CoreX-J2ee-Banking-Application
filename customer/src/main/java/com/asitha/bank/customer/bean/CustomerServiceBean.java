package com.asitha.bank.customer.bean;

import com.asitha.bank.core.model.AccountType;
import com.asitha.bank.core.service.CustomerService;
import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.Customer;
import com.asitha.bank.core.model.UserAccount;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import java.math.BigDecimal;
import java.util.List;

@Stateless
public class CustomerServiceBean implements CustomerService {
    @PersistenceContext
    private EntityManager em;

    private String generateAccountNumber() {
        return "CX" + System.currentTimeMillis();
    }

    public Account createAccount(String username, AccountType type, BigDecimal initialBalance) {
        UserAccount user = em.createNamedQuery("UserAccount.findByUsername", UserAccount.class)
                .setParameter("u", username)
                .getSingleResult();

        Account acct = new Account();

        acct.setAccountNumber(generateAccountNumber());
        acct.setBalance(initialBalance);
        acct.setType(type);
        acct.setOwner(user);

        em.persist(acct);

        return acct;
    }

    public void updateCustomer(Customer cust) {
        em.merge(cust);
    }


    public Customer findCustomer(String username) {
        return em.createNamedQuery(
                        "Customer.findByUsername", Customer.class)
                .setParameter("u", username)
                .getSingleResult();
    }

    public List<Account> getAccountsByUsername(String username) {
        UserAccount user = em.createNamedQuery("UserAccount.findByUsername", UserAccount.class)
                .setParameter("u", username)
                .getSingleResult();
        return em.createNamedQuery("Account.findByOwner", Account.class)
                .setParameter("owner", user)
                .getResultList();
    }

    public Account getAccountByAccountNumber(String accountNumber) {
        try {
            return em.createNamedQuery("Account.findByAccountNumber", Account.class)
                    .setParameter("accNo", accountNumber)
                    .getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }
}