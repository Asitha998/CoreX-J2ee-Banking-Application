package com.asitha.bank.core.service;

import com.asitha.bank.core.model.UserAccount;
import jakarta.ejb.Remote;

@Remote
public interface AuthService {
    void register(String username, String password, String fullName, String email,String contact, String address) throws Exception;
    UserAccount getUserAccountByUsername(String caller);
}
