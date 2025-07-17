package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.AccountType;
import com.asitha.bank.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.security.Principal;

@WebServlet("/create-account")
public class CreateAccountServlet extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String type = req.getParameter("type");
        BigDecimal balance = BigDecimal.valueOf(Double.parseDouble(req.getParameter("balance")));

        Principal principal = req.getUserPrincipal();

        if (principal == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        try {
            customerService.createAccount(principal.getName(), AccountType.valueOf(type), balance);
            resp.sendRedirect("user/dashboard");
        } catch (Exception e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/createAccount").forward(req, resp);
        }
    }
}