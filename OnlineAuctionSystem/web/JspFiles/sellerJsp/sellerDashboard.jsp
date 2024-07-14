<%@page import="com.app.classes.Auction"%>
<%@page import="java.util.Base64"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.app.classes.Seller" %>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.app.dbConnection.DbConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Seller Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<%
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Item> items = new ArrayList<Item>();
    Auction auction = new Auction();
    auction.setSellerId(sellerID);
    
    try {
        items = auction.getSellerActiveAuctionItems();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    }
%>
<a href="/OnlineAuctionSystem/JspFiles/sellerJsp/addItem.jsp" class="btn btn-secondary">Add listing</a>
<a href="viewItems.jsp" class="btn btn-secondary">View listing</a>
<h1>Active Auctions</h1>

<div class="container">
    <div class="row">
        <div class="col-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ItemId</th>
                    <th>ItemName</th>
                    <th>Item Description</th>
                    <th>Item Condition</th>
                    <th>Item Category</th>
                    <th>Item Image</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (!items.isEmpty()) {
                        for (Item item : items) {
                %>
                <tr>
                    <td><%= item.getItemId() %></td>
                    <td><%= item.getItemName() %></td>
                    <td><%= item.getDescription() %></td>
                    <td><%= item.getCondition() %></td>
                    <td><%= item.getCategory() %></td>
                    <td><% if (!item.getBase64Image().isEmpty()) { %>
                        <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image() %>">
                        <% } else { %> No Image <% } %>
                    </td>
                </tr>
                <%
                        }
                    } else {
                %>
                <tr>
                    <td colspan="6">No items found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>
