package com.app.servlets.customerServlets;

import com.app.classes.Customer;
import com.app.classes.Seller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;

public class CustomerRegistrationFormServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String address = req.getParameter("address");
        int phoneNumber = Integer.parseInt(req.getParameter("phoneNumber"));
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        try{
            if(password.equals(confirmPassword)){
                Customer customer=new Customer(fullName,email,address,phoneNumber,password);
                if(customer.saveCustomer()){
                    resp.sendRedirect("/OnlineAuctionSystem/JspFiles/customerJsp/customerDashboard.jsp");
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
