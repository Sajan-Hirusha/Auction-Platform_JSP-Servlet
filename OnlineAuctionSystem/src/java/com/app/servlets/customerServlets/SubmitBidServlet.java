package com.app.servlets.customerServlets;

import com.app.classes.Bid;
import com.app.classes.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class SubmitBidServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String price = req.getParameter("bidAmount");
        //System.out.println(price);
        double bidAmount = Double.parseDouble(price);

        String itemId = req.getParameter("itemId");
        LocalDateTime currentDateTime = LocalDateTime.now();
        Timestamp timestamp = Timestamp.valueOf(currentDateTime);
        //System.out.println(timestamp);
        Bid bid = null;
        try {
            bid = new Bid(bidAmount, itemId,timestamp,"CUS/1");
            if (bid.placeBid()) {
                resp.sendRedirect("/OnlineAuctionSystem/JspFiles/customerJsp/bidForm.jsp?id="+itemId);
            } else {
                resp.sendRedirect("error.jsp?message=" + "Incorrect data");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }
}
