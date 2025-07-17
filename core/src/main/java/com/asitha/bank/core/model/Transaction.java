package com.asitha.bank.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "TRANSACTION_LOG")
@NamedQueries({
    @NamedQuery(name = "Transaction.getDebitedTransactions",
            query = "SELECT t FROM Transaction t WHERE t.fromAccount.owner.username = :u ORDER BY t.timestamp DESC"),
    @NamedQuery(name = "Transaction.getCreditedTransactions",
            query = "SELECT t FROM Transaction t WHERE t.toAccount.owner.username = :u ORDER BY t.timestamp DESC"),
    @NamedQuery(name = "Transaction.getCreditedTransactionsByAccNo",
            query = "SELECT t FROM Transaction t WHERE t.toAccount.accountNumber = :accNo ORDER BY t.timestamp DESC"),
    @NamedQuery(name = "Transaction.getDebitedTransactionsByAccNo",
            query = "SELECT t FROM Transaction t WHERE t.fromAccount.accountNumber = :accNo ORDER BY t.timestamp DESC")
})
public class Transaction implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name="FROM_ACCOUNT_ID")
    private Account fromAccount;

    @ManyToOne
    @JoinColumn(name="TO_ACCOUNT_ID")
    private Account toAccount;

    private BigDecimal amount;
    private LocalDateTime timestamp;

    private String otp = "Pending";


    public Transaction() {
    }
    public Transaction(Account fromAccount, Account toAccount, BigDecimal amount) {
        this.fromAccount = fromAccount;
        this.toAccount = toAccount;
        this.amount = amount;
        this.timestamp = LocalDateTime.now();
    }

    @Transient
    public String getFormattedTimestamp() {
        return timestamp.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Account getFromAccount() {
        return fromAccount;
    }

    public void setFromAccount(Account fromAccount) {
        this.fromAccount = fromAccount;
    }

    public Account getToAccount() {
        return toAccount;
    }

    public void setToAccount(Account toAccount) {
        this.toAccount = toAccount;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }
}