package com.app.servlets.customerServlets;

import com.app.classes.Customer;
import com.app.classes.Seller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

public class CustomerLoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String email = req.getParameter("loggingEmail");
        String password = req.getParameter("loggingPassword");

        Customer customer = null;
        try {
            customer = new Customer(email, password);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        try {
            if (customer.customerLogin()) {
                resp.sendRedirect("../OnlineAuctionSystem/viewActiveItemsForCustomers");
            } else {
                resp.sendRedirect("error.jsp?message=" + "Incorrect data");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
