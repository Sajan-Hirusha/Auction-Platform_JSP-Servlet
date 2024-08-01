<%-- 
    Document   : deleteSeller
    Created on : Jul 26, 2024, 5:06:50 PM
    Author     : test
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.app.dbConnection.DbConnection" %>
<%@page import="com.app.classes.Seller" %>

<%
    String adminId = (String) session.getAttribute("adminId");
    if (adminId == null) {
        response.sendRedirect("../LoginJsp/login.jsp");
        return;
    }
%>

<%
String sellerID = request.getParameter("id");
try {
   
    Seller seller=new Seller();
    boolean isDeleted = seller.deleteSellerById(sellerID);

    if (isDeleted) {
        response.sendRedirect("admindashboard.jsp?deletestatus=1");
    } else {
        response.sendRedirect("admindashboard.jsp?deletestatus=0");
    }
} catch (Exception e) {
    e.printStackTrace();
    response.sendRedirect("admindashboard.jsp?deletestatus=0");
}
%>
