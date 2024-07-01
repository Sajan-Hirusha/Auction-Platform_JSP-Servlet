package com.app.servlets.sellerServlets;

import com.app.classes.Auction;
import com.app.classes.Item;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.sql.Timestamp;

public class PlaceAuctionServlet extends HttpServlet {

//    private static final String UPLOAD_DIRECTORY = "C:\\Users\\Dilki\\Desktop\\Campus projects\\Online Auction system\\OnlineAuctionPlatform_JSP\\Online-Auction-Platform-JSP-Servlet-\\src\\main\\webapp\\productImages";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String startingTimeAndDate = req.getParameter("startingTimeAndDate");
        String endTimeAndDate = req.getParameter("endTimeAndDate");
        String price = req.getParameter("startingPrice");
        double startingPrice = Double.parseDouble(price);
        String itemId = req.getParameter("itemId");
        String sellerId = req.getParameter("sellerId");

        Timestamp timestamp1 = Timestamp.valueOf(startingTimeAndDate.replace("T", " ") + ":00");
        Timestamp timestamp2 = Timestamp.valueOf(endTimeAndDate.replace("T", " ") + ":00");

        Auction auction= null;
        try {
            auction = new Auction(timestamp1,timestamp2,startingPrice ,itemId,sellerId);
            if(auction.placeAuction()){
                resp.sendRedirect("../OnlineAuctionSystem/viewListingsForUpdateAndDelete?id=placeAuction");
            }else{
                resp.sendRedirect("error.jsp?message=" + "Wrong data");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


    }
}



