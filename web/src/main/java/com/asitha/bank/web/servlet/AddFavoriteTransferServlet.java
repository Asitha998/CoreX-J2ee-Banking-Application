package com.asitha.bank.web.servlet;

import com.asitha.bank.core.model.Account;
import com.asitha.bank.core.model.FavoriteTransfer;
import com.asitha.bank.core.service.CustomerService;
import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/user/favorites/add")
public class AddFavoriteTransferServlet extends HttpServlet {
    @EJB
    private CustomerService customerService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String username = req.getUserPrincipal().getName();
        String nickname = req.getParameter("nickname");
        String fromAccNum = req.getParameter("fromAccountNumber");
        String toAccNum = req.getParameter("toAccountNumber");

        Account from = customerService.getAccountByAccountNumber(fromAccNum);
        Account to = customerService.getAccountByAccountNumber(toAccNum);

        if (toAccNum.equals(fromAccNum) || to==null) {
//            req.getSession().setAttribute("transferError", "Invalid Account Number.");
            resp.sendRedirect(req.getContextPath() + "/user/favorites.jsp?error=Invalid+Account+Number.");

        }else {
            FavoriteTransfer fav = new FavoriteTransfer();
            fav.setFromAccount(from);
            fav.setToAccount(to);
            fav.setNickname(nickname);
            fav.setVerified(false); // verify via OTP

            req.getSession().setAttribute("pendingFav", fav);
            resp.sendRedirect(req.getContextPath() + "/user/confirmTransfer.jsp");
        }

    }
}

