package com.app.servlets.sellerServlets;

import com.app.classes.Item;
import com.app.classes.Seller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ViewListingsServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Item> allItems = null;
        try {
            Item item=new Item();
            item.setSellerID("SEL/1");
            allItems =  item.getItemList();
            if (allItems != null) {
                request.setAttribute("items", allItems);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/JspFiles/sellerJsp/viewItems.jsp");
                dispatcher.forward(request, response);
            }
            // Forward the request to the JSP for rendering
//            request.getRequestDispatcher("sellerJsp/viewItems.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=" + URLEncoder.encode(e.toString(), "UTF-8"));

        }
    }

}
