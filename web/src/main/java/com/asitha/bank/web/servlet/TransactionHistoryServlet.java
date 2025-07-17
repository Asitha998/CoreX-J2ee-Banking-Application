package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.service.CustomerService;
import com.asitha.bank.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/transactions")
public class TransactionHistoryServlet extends HttpServlet {

    @EJB
    private TransactionService transactionService;

    @EJB
    private CustomerService customerService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getUserPrincipal().getName();
        String type = req.getParameter("type");
        String accNo = req.getParameter("acc");

        List<Transaction> transactions;

        if ("credited".equalsIgnoreCase(type)) {
            if (accNo != null) {
                transactions = transactionService.getCreditedTransactionsByAccNo(accNo);
            } else {
                transactions = transactionService.getCreditedTransactions(username);
            }
        } else {
            if (accNo != null) {
                transactions = transactionService.getDebitedTransactionsByAccNo(accNo);
            } else {
                transactions = transactionService.getDebitedTransactions(username);
            }
        }

        req.setAttribute("transactions", transactions);
        req.getRequestDispatcher("/user/transactions.jsp").forward(req, resp);
    }
}
