package com.asitha.bank.transaction.bean;

import com.asitha.bank.core.model.FavoriteTransfer;
import com.asitha.bank.core.model.ScheduledTransfer;
import com.asitha.bank.core.service.TransactionService;
import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.Transaction;
import jakarta.ejb.Stateless;
import jakarta.ejb.TransactionAttribute;
import jakarta.ejb.TransactionAttributeType;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Stateless
public class TransactionServiceBean implements TransactionService {

    @PersistenceContext
    private EntityManager em;

    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void transferFunds(Transaction tx) {
        Account from = tx.getFromAccount();
        Account to = tx.getToAccount();

        if (from.getBalance().compareTo(tx.getAmount()) < 0) {
            throw new IllegalArgumentException("Insufficient funds");
        }

        from.setBalance(from.getBalance().subtract(tx.getAmount()));
        to.setBalance(to.getBalance().add(tx.getAmount()));
        em.merge(from);
        em.merge(to);

        em.persist(tx);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<Transaction> getDebitedTransactions(String username) {
        return em.createNamedQuery("Transaction.getDebitedTransactions", Transaction.class)
                .setParameter("u", username)
                .getResultList();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<Transaction> getCreditedTransactions(String username) {
        return em.createNamedQuery("Transaction.getCreditedTransactions", Transaction.class)
                .setParameter("u", username)
                .getResultList();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<Transaction> getCreditedTransactionsByAccNo(String accNo) {
        return em.createNamedQuery("Transaction.getCreditedTransactionsByAccNo", Transaction.class)
                .setParameter("accNo", accNo)
                .getResultList();

    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<Transaction> getDebitedTransactionsByAccNo(String accNo) {
        return em.createNamedQuery("Transaction.getDebitedTransactionsByAccNo", Transaction.class)
                .setParameter("accNo", accNo)
                .getResultList();

    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<FavoriteTransfer> getFavoriteTransfersByUsername(String username) {
        return em.createNamedQuery("FavoriteTransfer.getByUsername", FavoriteTransfer.class)
                .setParameter("username", username)
                .getResultList();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<ScheduledTransfer> getScheduledTransfersByUsername(String username) {
        return em.createNamedQuery("ScheduledTransfer.getByUsername", ScheduledTransfer.class)
                .setParameter("username", username)
                .getResultList();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void saveFavoriteTransfer(FavoriteTransfer fav) {
        em.persist(fav);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void setScheduledTransferActive(Long id, boolean active) {
        ScheduledTransfer st = em.find(ScheduledTransfer.class, id);
        if (st != null) {
            st.setActive(active);
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void executeScheduledTransfer(ScheduledTransfer s) {
        // Reload managed entities in case this method is called by a Timer
        ScheduledTransfer scheduledTransfer = em.find(ScheduledTransfer.class, s.getId());

        if (scheduledTransfer == null || !scheduledTransfer.isActive() || !scheduledTransfer.isVerified()) return;

        Account from = em.find(Account.class, scheduledTransfer.getFromAccount().getId());
        Account to = em.find(Account.class, scheduledTransfer.getToAccount().getId());

        BigDecimal amount = scheduledTransfer.getAmount();

        // Validate funds
        if (from.getBalance().compareTo(amount) < 0) {
            System.out.println("❌ Scheduled transfer failed due to insufficient funds. ID: " + s.getId());
            return;
        }

        // Deduct and update balances
        from.setBalance(from.getBalance().subtract(amount));
        to.setBalance(to.getBalance().add(amount));

        // Create a transaction record
        Transaction tx = new Transaction();
        tx.setFromAccount(from);
        tx.setToAccount(to);
        tx.setAmount(amount);
        tx.setTimestamp(LocalDateTime.now());
        tx.setOtp("AUTO");  // since no manual confirmation needed

        em.persist(tx);
        em.merge(from);
        em.merge(to);

        System.out.println("✅ Executed Scheduled Transfer. ID: " + scheduledTransfer.getId());
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public ScheduledTransfer findScheduledTransfer(Long id) {
        return em.find(ScheduledTransfer.class, id);
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.NOT_SUPPORTED)
    public List<ScheduledTransfer> getActiveAndVerifiedTransfers() {
        return em.createQuery("SELECT s FROM ScheduledTransfer s WHERE s.active = true AND s.verified = true", ScheduledTransfer.class)
                .getResultList();
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void saveScheduledTransfer(ScheduledTransfer st) {
        if (st.getId() == null) {
            em.persist(st);
        } else {
            em.merge(st);
        }
    }

    @Override
    @TransactionAttribute(TransactionAttributeType.REQUIRED)
    public void removeScheduledTransfer(ScheduledTransfer st) {
        ScheduledTransfer scheduledTransfer = em.find(ScheduledTransfer.class, st.getId());
         em.remove(scheduledTransfer);
    }

}