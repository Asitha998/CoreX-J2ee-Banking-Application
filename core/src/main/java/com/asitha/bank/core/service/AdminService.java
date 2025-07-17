package com.asitha.bank.core.service;

import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.model.UserAccount;
import jakarta.ejb.Remote;

import java.util.List;

@Remote
public interface AdminService {
    int getTotalUsers();
    int getTotalAccounts();
    int getTodayTransactionCount();

    List<UserAccount> getAllUsers();
    List<Transaction> getAllTransactions();
}
