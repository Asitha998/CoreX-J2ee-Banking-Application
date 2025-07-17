package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.model.UserAccount;
import com.asitha.bank.core.service.CustomerService;
import com.asitha.bank.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@WebServlet("/user/transfer")
public class ContinueTransferServlet extends HttpServlet {

    @EJB
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getUserPrincipal().getName();
        String toAcc = req.getParameter("toAccount");
        String fromAcc = req.getParameter("fromAccount");
        BigDecimal amount = BigDecimal.valueOf(Double.parseDouble(req.getParameter("amount")));
        boolean isFavorite = Boolean.parseBoolean(req.getParameter("isFavorite"));

        System.out.println(toAcc + " " + fromAcc + " " + amount);

        Account sender = customerService.getAccountByAccountNumber(fromAcc);
        Account receiver = customerService.getAccountByAccountNumber(toAcc);

        if (sender.getBalance().compareTo(amount) < 0) {
//            req.getSession().setAttribute("transferError", "Insufficient balance in the selected account.");
            resp.sendRedirect(req.getContextPath() + "/user/transfer.jsp?error=Insufficient+balance+in+the+selected+account.");

        } else if (toAcc.equals(fromAcc) || receiver == null) {
//            req.getSession().setAttribute("transferError", "Invalid Account Number.");
            resp.sendRedirect(req.getContextPath() + "/user/transfer.jsp?error=Invalid+Account+Number.");

        } else {
            Transaction tx = new Transaction();
            tx.setFromAccount(sender);
            tx.setToAccount(receiver);
            tx.setAmount(amount);
            if (isFavorite) {
                tx.setOtp("Fav");
            } else {
                tx.setOtp("Pending");
            }
            tx.setTimestamp(LocalDateTime.now());

//            req.getSession().removeAttribute("transferError");
            req.getSession().setAttribute("pendingTx", tx);
            resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp");
        }

    }
}

