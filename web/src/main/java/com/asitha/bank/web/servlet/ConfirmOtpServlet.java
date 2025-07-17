package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/confirm-otp")
public class ConfirmOtpServlet extends HttpServlet {
    @EJB
    private TransactionService transactionService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userOtp = req.getParameter("otp");
        String sessionOtp = (String) req.getSession().getAttribute("otp");
        Transaction tx = (Transaction) req.getSession().getAttribute("pendingTx");

        if (tx.getOtp().equals("Fav")) {
            transactionService.transferFunds(tx);

            req.getSession().removeAttribute("otp");
            resp.sendRedirect(req.getContextPath() + "/user/transferSuccess.jsp");
//            req.getSession().removeAttribute("pendingTx");

        } else {

            if (sessionOtp != null && sessionOtp.equals(userOtp)) {
                tx.setOtp("Verified");
                transactionService.transferFunds(tx);

                req.getSession().removeAttribute("otp");
                resp.sendRedirect(req.getContextPath() + "/user/transferSuccess.jsp");
//                req.getSession().removeAttribute("pendingTx");
            } else {
                resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp?error=Invalid+OTP");
            }
        }
    }
}
