package com.asitha.bank.web.servlet;

import com.asitha.bank.core.service.TransactionService;
import com.asitha.bank.transaction.scheduler.ScheduledTransferTimerManager;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/scheduled/toggle")
public class ToggleScheduledTransferServlet extends HttpServlet {

    @EJB
    private TransactionService transactionService;

    @EJB
    private ScheduledTransferTimerManager scheduledTransferTimerManager;


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            Long id = Long.parseLong(req.getParameter("id"));
            boolean currentState = Boolean.parseBoolean(req.getParameter("currentState"));
            boolean newState = !currentState;
            transactionService.setScheduledTransferActive(id, newState);
            if (newState) {
                scheduledTransferTimerManager.createTimerFor(transactionService.findScheduledTransfer(id));
            } else {
                scheduledTransferTimerManager.cancelTimer(id);
            }
            resp.sendRedirect(req.getContextPath() + "/user/favorites");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/user/favorites?error=toggleFailed");
        }
    }
}
