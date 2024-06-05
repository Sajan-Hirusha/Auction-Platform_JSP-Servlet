package com.app.controllers.sellerServlets;

import com.app.models.Seller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;

@WebServlet("/sellerLogin")
public class SellerLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("loggingEmail");
        String password = req.getParameter("loggingPassword");

        Seller seller = null;
        try {
            seller = new Seller(email, password);
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }

        try {
            if (seller.sellerLogin()) {
                resp.sendRedirect("../viewActiveItems");
            } else {
                resp.sendRedirect("error.jsp?message=" + "Incorrect data");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
