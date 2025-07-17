package com.asitha.bank.web.servlet;

import com.asitha.bank.core.mail.VerificationMail;
import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.provider.MailServiceProvider;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Random;

@WebServlet("/user/send-otp")
public class SendOtpServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Transaction tx = (Transaction) req.getSession().getAttribute("pendingTx");
        String username = req.getUserPrincipal().getName();

        String otp = String.valueOf(new Random().nextInt(900000) + 100000); // 6-digit
        if (tx != null) {
            tx.setOtp(otp);
        }

        req.getSession().setAttribute("otp", otp);

        MailServiceProvider.getInstance().sendMail(new VerificationMail(username, otp));
        resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp?otpSent=true");
    }
}
