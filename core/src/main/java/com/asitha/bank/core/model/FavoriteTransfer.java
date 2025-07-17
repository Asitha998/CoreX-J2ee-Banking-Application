package com.asitha.bank.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.time.LocalDateTime;

@Entity
@Table(name = "FAVORITE_TRANSFER")
@NamedQueries({
    @NamedQuery(name = "FavoriteTransfer.getByUsername", query = "SELECT ft FROM FavoriteTransfer ft WHERE ft.fromAccount.owner.username = :username")
})
public class FavoriteTransfer implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nickname;

    @ManyToOne
    @JoinColumn(name = "from_account_id", referencedColumnName = "ID")
    private Account fromAccount;

    @ManyToOne
    @JoinColumn(name = "to_account_id", referencedColumnName = "ID")
    private Account toAccount;

    private boolean verified;

    private LocalDateTime createdAt = LocalDateTime.now();

    public FavoriteTransfer() {
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
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

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}