package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/account")
public class ViewAccountServlet extends HttpServlet {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private CustomerService customerService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!request.isUserInRole("USER")) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        String accNo = request.getParameter("acc");
        Account account = customerService.getAccountByAccountNumber(accNo);

        request.setAttribute("account", account);
        request.getRequestDispatcher("/user/account.jsp").forward(request, response);
    }
}
