package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.FavoriteTransfer;
import com.asitha.bank.core.model.ScheduledTransfer;
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

@WebServlet("/user/favorites")
public class FavoriteAndScheduledServlet extends HttpServlet {

    @EJB
    private TransactionService transactionService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getUserPrincipal().getName();

        List<FavoriteTransfer> favoriteTransfers = transactionService.getFavoriteTransfersByUsername(username);
        List<ScheduledTransfer> scheduledTransfers = transactionService.getScheduledTransfersByUsername(username);

        req.setAttribute("favorites", favoriteTransfers);
        req.setAttribute("scheduleds", scheduledTransfers);

        req.getRequestDispatcher("/user/favorites.jsp").forward(req, resp);
    }
}
