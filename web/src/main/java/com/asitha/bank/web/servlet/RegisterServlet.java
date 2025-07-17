package com.asitha.bank.web.servlet;

import com.asitha.bank.core.service.AuthService;
import com.asitha.bank.core.util.Encryption;
import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @EJB
    private AuthService authService;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String contact = req.getParameter("contact");
        String password = req.getParameter("password");
        String line1 = req.getParameter("address_line1");
        String line2 = req.getParameter("address_line2");

        String encryptedPassword = Encryption.encrypt(password);

        String address = line1 + (line2 != null && !line2.isEmpty() ? ", " + line2 : "");

        try {
            authService.register(email, encryptedPassword, name, email, contact,address);

            resp.sendRedirect(req.getContextPath() + "/login.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration failed: " + e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
