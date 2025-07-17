package com.asitha.bank.core.service;

import com.asitha.bank.core.model.FavoriteTransfer;
import com.asitha.bank.core.model.ScheduledTransfer;
import com.asitha.bank.core.model.Transaction;
import jakarta.ejb.Remote;

import java.math.BigDecimal;
import java.util.List;

@Remote
public interface TransactionService {
    void transferFunds(Transaction tx);
    List<Transaction> getDebitedTransactions(String username);
    List<Transaction> getCreditedTransactions(String username);

    List<Transaction> getCreditedTransactionsByAccNo(String accNo);

    List<Transaction> getDebitedTransactionsByAccNo(String accNo);

    List<FavoriteTransfer> getFavoriteTransfersByUsername(String username);

    List<ScheduledTransfer> getScheduledTransfersByUsername(String username);

    void saveFavoriteTransfer(FavoriteTransfer fav);

    void executeScheduledTransfer(ScheduledTransfer s);

    // This method is needed by the timer to fetch a scheduled transfer
    ScheduledTransfer findScheduledTransfer(Long id);

    List<ScheduledTransfer> getActiveAndVerifiedTransfers();

    void saveScheduledTransfer(ScheduledTransfer sd);
    void setScheduledTransferActive(Long id, boolean active);

    void removeScheduledTransfer(ScheduledTransfer st);
}
