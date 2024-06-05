package com.app.controllers.sellerServlets;

import com.app.models.Item;

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

@WebServlet("/viewListingsForUpdateAndDelete")
public class ViewListingsForUpdateAndDeleteServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        List<Item> allItems = null;
        try {
            Item item = new Item();
            item.setSellerID("SEL/1");
            allItems = item.getItemList();
            if (allItems != null) {
                request.setAttribute("items", allItems);
                switch (id) {
                    case "update":
                        RequestDispatcher dispatcher1 = request.getRequestDispatcher("/JspFiles/sellerJsp/viewItemsForUpdate.jsp");
                        dispatcher1.forward(request, response);
                    case "delete":
                        RequestDispatcher dispatcher2 = request.getRequestDispatcher("/JspFiles/sellerJsp/viewItemsForDelete.jsp");
                        dispatcher2.forward(request, response);
                    case "placeAuction":
                        RequestDispatcher dispatcher3 = request.getRequestDispatcher("/JspFiles/sellerJsp/viewItemsForPlaceAuction.jsp");
                        dispatcher3.forward(request, response);
                }

            }
            // Forward the request to the JSP for rendering
//            request.getRequestDispatcher("sellerJsp/viewItems.jsp").forward(request, response);
        } catch (ClassNotFoundException | SQLException e) {
            response.sendRedirect("error.jsp?message=" + URLEncoder.encode(e.toString(), "UTF-8"));

        }
    }

}
