package com.asitha.bank.core.model;

import jakarta.persistence.*;

import java.io.Serializable;

@Entity
@Table(name = "CUSTOMER_PROFILE")
@NamedQueries({
    @NamedQuery(name = "Customer.findByUsername", query = "SELECT c FROM Customer c WHERE c.userAccount.username = :u")
})
public class Customer implements Serializable {
    @Id
    private Long id;

    private String fullName;
    private String contact;
    private String address;
    private String email;

    @OneToOne
    @MapsId
    @JoinColumn(name="ID")
    private UserAccount userAccount;

    public Customer() {
    }

    public Customer(Long id, String fullName, String contact, String address, String email, UserAccount userAccount) {
        this.id = id;
        this.fullName = fullName;
        this.contact = contact;
        this.address = address;
        this.email = email;
        this.userAccount = userAccount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }
}