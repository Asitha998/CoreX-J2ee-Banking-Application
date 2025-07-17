package com.asitha.bank.web.servlet;


import com.asitha.bank.core.util.Encryption;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.security.enterprise.AuthenticationStatus;
import jakarta.security.enterprise.SecurityContext;
import jakarta.security.enterprise.credential.UsernamePasswordCredential;
import jakarta.security.enterprise.authentication.mechanism.http.AuthenticationParameters;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Inject
    private SecurityContext securityContext;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String encryptedPassword = Encryption.encrypt(password);

        AuthenticationParameters parameters = AuthenticationParameters
                .withParams()
                .credential(new UsernamePasswordCredential(username, encryptedPassword));

        AuthenticationStatus status = securityContext.authenticate(request, response,parameters);

        System.out.println("Authentication Status: " + status);
//        System.out.println("User Roles login: " + securityContext.isCallerInRole("USER") + ", " +
//                securityContext.isCallerInRole("ADMIN"));

        if (status == AuthenticationStatus.SUCCESS) {

//            if (securityContext.isCallerInRole("ADMIN")) {
//                response.sendRedirect("admin/dashboard");
//            } else {
                response.sendRedirect("user/dashboard");
//            }
        } else {

            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}
