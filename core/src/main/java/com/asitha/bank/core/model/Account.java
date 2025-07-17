package com.asitha.bank.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;

@Entity
@Table(name = "BANK_ACCOUNT")
@NamedQueries({
        @NamedQuery(name = "Account.findAll", query = "SELECT a FROM Account a"),
        @NamedQuery(name = "Account.findByOwner", query = "SELECT a FROM Account a WHERE a.owner = :owner"),
        @NamedQuery(name = "Account.findByAccountNumber", query = "SELECT a FROM Account a WHERE a.accountNumber = :accNo")
})
public class Account implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(unique = true)
    private String accountNumber;
    private BigDecimal balance = BigDecimal.ZERO;

    @Enumerated(EnumType.STRING)
    @Column(name="TYPE")
    private AccountType type;

    @ManyToOne
    @JoinColumn(name = "USER_ID")
    private UserAccount owner;

    public Account() {
    }

    public Account(String accountNumber, UserAccount owner, AccountType type) {
        this.accountNumber = accountNumber;
        this.owner = owner;
        this.type = type;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public BigDecimal getBalance() {
        return balance;
    }
    public void setBalance(BigDecimal balance) {
        this.balance = balance;
    }

    public AccountType getType() {
        return type;
    }

    public void setType(AccountType type) {
        this.type = type;
    }

    public UserAccount getOwner() {
        return owner;
    }

    public void setOwner(UserAccount owner) {
        this.owner = owner;
    }
}