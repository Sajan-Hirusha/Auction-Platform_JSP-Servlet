package com.app.controllers.sellerServlets;

import com.app.models.Seller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/addListing")
public class AddListingServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String fullName = req.getParameter("itemName");
        String email = req.getParameter("description");
        String businessName = req.getParameter("condition");
//        String imageUrl = req.getParameter("condition");
       
        try{
            if(password.equals(confirmPassword)){
                Seller seller=new Seller(fullName,email,businessName,phoneNumber,password);
                if(seller.saveSeller()){
                    resp.sendRedirect("sellerJsp/sellerDashboard.jsp");
                }else {
                    resp.sendRedirect("error.jsp?message=" + "Incorrect data");
                }
            }else{
                resp.sendRedirect("error.jsp?message=" + "Incorrect data password");
            }
        }catch (Exception e1){
            resp.sendRedirect("error.jsp?message=" + URLEncoder.encode(e1.toString(), "UTF-8"));
        }
    }

}
