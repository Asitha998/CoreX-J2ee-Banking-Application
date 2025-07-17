package com.asitha.bank.core.service;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.AccountType;
import com.asitha.bank.core.model.Customer;
import jakarta.ejb.Remote;

import java.math.BigDecimal;
import java.util.List;

@Remote
public interface CustomerService {
    Account createAccount(String username, AccountType type, BigDecimal initialBalance);
    void updateCustomer(Customer cust);
    Customer findCustomer(String username);
    List<Account> getAccountsByUsername(String username);
    Account getAccountByAccountNumber(String accountNumber);

}
