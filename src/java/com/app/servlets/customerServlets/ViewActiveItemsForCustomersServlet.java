package com.app.servlets.customerServlets;


import com.app.classes.Auction;
import com.app.classes.Item;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;

public class ViewActiveItemsForCustomersServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Item> allItems = null;
        try {
            Auction auction = new Auction();
            auction.setSellerId("SEL/1");
            allItems =  auction.getAllActiveAuctionItems();

            if (allItems != null) {
//                System.out.println(allItems);
                request.setAttribute("items", allItems);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JspFiles/customerJsp/customerDashboard.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=" + URLEncoder.encode(e.toString(), "UTF-8"));

        }
    }

}
