package com.asitha.bank.web.security;

import com.asitha.bank.core.model.UserAccount;
import com.asitha.bank.core.service.AuthService;
import jakarta.ejb.EJB;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.security.enterprise.credential.Credential;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.identitystore.CredentialValidationResult;
import jakarta.security.enterprise.identitystore.IdentityStore;
import static jakarta.security.enterprise.identitystore.CredentialValidationResult.INVALID_RESULT;
import java.util.HashSet;
import java.util.Set;

@ApplicationScoped
public class UserIdentityStore implements IdentityStore {
    @PersistenceContext
    private EntityManager em;

    @EJB
    AuthService authService;

    @Override
    public CredentialValidationResult validate(Credential credential) {
        UsernamePasswordCredential upc = (UsernamePasswordCredential) credential;
        String caller = upc.getCaller();
        String password = upc.getPasswordAsString();

        UserAccount user = authService.getUserAccountByUsername(caller);

        if (user != null && user.getPassword().equals(password)) {

            Set<String> roles = new HashSet<>();
            user.getRoles().forEach(r -> roles.add(r.name()));

            user.getRoles().forEach(role -> System.out.println("Role: " + role.name()));
            user.getRoles().forEach(role -> System.out.println("Role: " + role));

            System.out.println("User Roles:");
            roles.forEach(role -> System.out.println("- " + role));

            return new CredentialValidationResult(user.getUsername(), roles);

        }
        return CredentialValidationResult.INVALID_RESULT;
    }
}
