package com.asitha.bank.auth.bean;


import com.asitha.bank.core.model.Role;
import com.asitha.bank.core.service.AuthService;
import com.asitha.bank.core.model.Customer;
import com.asitha.bank.core.model.UserAccount;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionManagement;
import jakarta.ejb.TransactionManagementType;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Status;
import jakarta.transaction.UserTransaction;

import java.util.Set;

@Stateless
@TransactionManagement(TransactionManagementType.BEAN)
public class AuthServiceBean implements AuthService {
    @PersistenceContext
    private EntityManager em;

    @Inject
    private UserTransaction tx;

    public void register(String username, String password, String fullName, String email, String contact, String address) throws Exception {

        try {
            if (!em.createNamedQuery("UserAccount.findByUsername", UserAccount.class)
                    .setParameter("u", username).getResultList().isEmpty()) {
                throw new IllegalArgumentException("Username already exists");
            }

            tx.begin();
            UserAccount user = new UserAccount();
            user.setUsername(username);
            user.setPassword(password);
            user.setRoles(Set.of(Role.USER));

            em.persist(user);

            Customer cust = new Customer();
            cust.setFullName(fullName);
            cust.setEmail(email);
            cust.setContact(contact);
            cust.setAddress(address);
            cust.setUserAccount(user);

            em.persist(cust);

            tx.commit();

        } catch (Exception e) {
            if (tx.getStatus() == Status.STATUS_ACTIVE) {
                tx.rollback();
            }
            throw e;
        }
    }

    public UserAccount getUserAccountByUsername(String caller) {
        return em.createNamedQuery(
                        "UserAccount.findByUsername", UserAccount.class)
                .setParameter("u", caller)
                .getResultStream()
                .findFirst().orElse(null);
    }

}
