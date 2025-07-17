package com.asitha.bank.core.model;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.Set;

@Entity
@Table(name = "USER_ACCOUNT")
@NamedQueries(
            @NamedQuery(name = "UserAccount.findByUsername",query = "SELECT u FROM UserAccount u WHERE u.username = :u")
)
public class UserAccount implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable=false, unique=true)
    private String username;
    @Column(nullable=false)
    private String password;

    @ElementCollection(fetch = FetchType.EAGER)
    @Enumerated(EnumType.STRING)
    @CollectionTable(name="USER_ROLES", joinColumns=@JoinColumn(name="USER_ID"))
    @Column(name="ROLE")
    private Set<Role> roles;

    @OneToOne(mappedBy="userAccount", cascade=CascadeType.ALL)
    private Customer customer;

    public UserAccount() {
    }
    public UserAccount(String username, String password, Set<Role> roles) {
        this.username = username;
        this.password = password;
        this.roles = roles;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(Set<Role> roles) {
        this.roles = roles;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
