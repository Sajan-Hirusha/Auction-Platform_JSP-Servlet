package com.app.servlets.sellerServlets;

import com.app.classes.Item;
import com.app.classes.Seller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;

public class RemoveListingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String id = req.getParameter("id");
        try {
            Item item=new Item();
            if (item.deleteItem(id)) {
                resp.sendRedirect("../OnlineAuctionSystem/viewListingsForUpdateAndDelete?id=delete");
            } else {
                resp.sendRedirect("error.jsp?message=" + "Incorrect data");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
