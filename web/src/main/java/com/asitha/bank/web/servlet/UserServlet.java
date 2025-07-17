package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/user/dashboard")
public class UserServlet extends HttpServlet {
    @PersistenceContext
    private EntityManager em;

    @EJB
    private CustomerService customerService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!request.isUserInRole("USER") && !request.isUserInRole("ADMIN")) {
//            System.out.println("Unauthorized access attempt by user: " + request.isUserInRole("USER")+" admin: " + request.isUserInRole("ADMIN"));
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

//        boolean isAdmin = request.isUserInRole("ADMIN");

        System.out.println("User Roles dashboard: "+ request.isUserInRole("USER") + ", " +
                request.isUserInRole("ADMIN"));
        request.setAttribute("isAdmin", request.isUserInRole("ADMIN"));

        String username = request.getUserPrincipal().getName();
        List<Account> accounts = customerService.getAccountsByUsername(username);

        request.getSession().removeAttribute("pendingTx");
        request.setAttribute("accounts", accounts);

        request.getRequestDispatcher("/user/dashboard.jsp").forward(request, response);
    }
}