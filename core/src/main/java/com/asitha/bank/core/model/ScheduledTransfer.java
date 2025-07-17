package com.asitha.bank.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "SCHEDULED_TRANSFER")
@NamedQueries({
    @NamedQuery(name = "ScheduledTransfer.getByUsername", query = "SELECT st FROM ScheduledTransfer st WHERE st.fromAccount.owner.username = :username")
})
public class ScheduledTransfer implements Serializable {
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

    private BigDecimal amount;

    @Enumerated(EnumType.STRING)
    private ScheduleType scheduleType; // DAILY, WEEKLY, MONTHLY,YEARLY, ONCE

    private Integer scheduleDay; // WEEKLY, MONTHLY
    private LocalDate exactDate; // YEARLY, ONCE

    private boolean verified;
    private boolean active = true;

    private LocalDateTime nextRun;   // When to run next
    private LocalDateTime createdAt = LocalDateTime.now();

    public ScheduledTransfer() {
    }

    @Transient
    public String getFormattedYearly() {
        return exactDate.format(DateTimeFormatter.ofPattern("MMM-dd"));
    }
    @Transient
    public String getFormattedOnce() {
        return exactDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }

    @Override
    public String toString() {
        return "ScheduledTransfer{" +
                "id=" + id +
                ", nickname='" + nickname + '\'' +
                ", fromAccount=" + fromAccount +
                ", toAccount=" + toAccount +
                ", amount=" + amount +
                ", scheduleType=" + scheduleType +
                ", scheduleDay=" + scheduleDay +
                ", exactDate=" + exactDate +
                ", verified=" + verified +
                ", active=" + active +
                ", nextRun=" + nextRun +
                ", createdAt=" + createdAt +
                '}';
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

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public ScheduleType getScheduleType() {
        return scheduleType;
    }

    public void setScheduleType(ScheduleType scheduleType) {
        this.scheduleType = scheduleType;
    }

    public Integer getScheduleDay() {
        return scheduleDay;
    }

    public void setScheduleDay(Integer scheduleDay) {
        this.scheduleDay = scheduleDay;
    }

    public LocalDate getExactDate() {
        return exactDate;
    }

    public void setExactDate(LocalDate exactDate) {
        this.exactDate = exactDate;
    }

    public boolean isVerified() {
        return verified;
    }

    public void setVerified(boolean verified) {
        this.verified = verified;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public LocalDateTime getNextRun() {
        return nextRun;
    }

    public void setNextRun(LocalDateTime nextRun) {
        this.nextRun = nextRun;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}

