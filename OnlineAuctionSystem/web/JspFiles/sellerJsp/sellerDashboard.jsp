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
    Seller seller = (Seller) session.getAttribute("seller");
    if (seller == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection connection = null;
    List<Item> items = new ArrayList<Item>();
    try {
        connection = DbConnection.getConnection();
        String sql = "SELECT * FROM item WHERE Seller_sellerID = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, seller.getEmail());
        ResultSet resultSet = statement.executeQuery();
        while (resultSet.next()) {
            Item item = new Item();
            item.setItemId(resultSet.getString("itemId"));
            item.setItemName(resultSet.getString("itemName"));
            item.setDescription(resultSet.getString("description"));
            item.setCondition(resultSet.getString("itemCondition"));
            item.setCategory(resultSet.getString("categoryID"));
            item.setItemImageUrl(resultSet.getString("itemImageUrl"));
            items.add(item);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (connection != null) {
            try {
                connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
<a href="/OnlineAuctionSystem/JspFiles/sellerJsp/addItem.jsp" class="btn btn-secondary">Add listing</a>
<a href="../../OnlineAuctionSystem/viewListings" class="btn btn-secondary">View listing</a>
<a href="../../OnlineAuctionSystem/viewListingsForUpdateAndDelete?id=update" class="btn btn-secondary">Update listing</a>
<a href="../../OnlineAuctionSystem/viewListingsForUpdateAndDelete?id=delete" class="btn btn-secondary">Delete listing</a>
<a href="../../OnlineAuctionSystem/viewListingsForUpdateAndDelete?id=placeAuction" class="btn btn-secondary">Place Auction</a>

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
                    <th>Item image</th>
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
                    <td><img style="height: 100px; width: 100px;" src="<%= request.getContextPath() %>/productImages/<%= item.getItemImageUrl() %>"></td>
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
