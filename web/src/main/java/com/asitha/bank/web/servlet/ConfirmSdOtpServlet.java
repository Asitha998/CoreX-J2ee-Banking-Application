package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.ScheduledTransfer;
import com.asitha.bank.core.service.TransactionService;
import com.asitha.bank.transaction.scheduler.ScheduledTransferTimerManager;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/add-new-sd-otp")
public class ConfirmSdOtpServlet extends HttpServlet {
    @EJB
    private TransactionService transactionService;

    @EJB
    private ScheduledTransferTimerManager scheduledTransferTimerManager;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userOtp = req.getParameter("otp");
        String sessionOtp = (String) req.getSession().getAttribute("otp");
        ScheduledTransfer sd = (ScheduledTransfer) req.getSession().getAttribute("pendingSd");

        if (sessionOtp != null && sessionOtp.equals(userOtp)) {
            sd.setVerified(true);
            transactionService.saveScheduledTransfer(sd);
            scheduledTransferTimerManager.createTimerFor(sd);

            req.getSession().removeAttribute("otp");
            resp.sendRedirect(req.getContextPath() + "/user/favorites");
            req.getSession().removeAttribute("pendingSd");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp?error=Invalid+OTP");
        }
    }
}
