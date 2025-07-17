package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.model.UserAccount;
import com.asitha.bank.core.service.AdminService;
import com.asitha.bank.web.singleton.ServerStartTimeManager;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/dashboard")
public class AdminServlet extends HttpServlet {

    @EJB
    private AdminService adminService;

    @EJB
    private ServerStartTimeManager serverStartTimeManager;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int totalUsers = adminService.getTotalUsers();
            int totalAccounts = adminService.getTotalAccounts();
            int dailyTransactions = adminService.getTodayTransactionCount();

            List<UserAccount> users = adminService.getAllUsers();
            List<Transaction> transactions = adminService.getAllTransactions();

            long serverStartTime = serverStartTimeManager.getApplicationStartTime();
            req.setAttribute("serverStartTime", serverStartTime);
//            Logger.log(Level.INFO, "AdminDashboardServlet: Setting serverStartTime attribute: {0}", serverStartTime);

            req.setAttribute("totalUsers", totalUsers);
            req.setAttribute("totalAccounts", totalAccounts);
            req.setAttribute("dailyTransactions", dailyTransactions);
            req.setAttribute("users", users);
            req.setAttribute("transactions", transactions);

            req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/error.jsp");
        }
    }
}
