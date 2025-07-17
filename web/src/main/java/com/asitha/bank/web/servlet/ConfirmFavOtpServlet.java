package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.FavoriteTransfer;
import com.asitha.bank.core.model.Transaction;
import com.asitha.bank.core.service.TransactionService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/add-new-fav-otp")
public class ConfirmFavOtpServlet extends HttpServlet {
    @EJB
    private TransactionService transactionService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userOtp = req.getParameter("otp");
        String sessionOtp = (String) req.getSession().getAttribute("otp");
        FavoriteTransfer fav = (FavoriteTransfer) req.getSession().getAttribute("pendingFav");

        if (sessionOtp != null && sessionOtp.equals(userOtp)) {
            fav.setVerified(true);
            transactionService.saveFavoriteTransfer(fav);

            req.getSession().removeAttribute("otp");
            resp.sendRedirect(req.getContextPath() + "/user/favorites");
            req.getSession().removeAttribute("pendingFav");
        } else {
            resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp?error=Invalid+OTP");
        }
    }
}
