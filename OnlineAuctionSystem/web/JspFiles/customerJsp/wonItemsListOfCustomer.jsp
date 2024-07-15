<%@ page import="com.app.classes.Cart" %>
<%@ page import="com.app.classes.Auction" %>
<%@ page import="com.app.classes.ItemWinnerDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.io.FileOutputStream" %>
<%@ page import="java.io.File" %>
<%
    String message = "";
    String customerID = (String) session.getAttribute("customerID");
    if (customerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Process form submission for addToCart
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String itemId = request.getParameter("itemId");
        String sellerID = request.getParameter("sellerID");
        String auctionID = request.getParameter("auctionID");

        try {
            Cart cart = new Cart();
            boolean addedToCart = cart.addToCart(customerID, itemId, sellerID, auctionID);

            if (addedToCart) {
                message = "Item added to cart successfully!";
            } else {
                message = "Failed to add item to cart.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }

    // Fetch items with winners
    Auction dataFetcher = new Auction();
    List<ItemWinnerDetails> itemsWithWinners = dataFetcher.getCustomerWonItems(customerID);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Item and Winner Details</title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h2>Item and Winner Details</h2>
    <% if (!message.isEmpty()) { %>
        <p><%= message %></p>
    <% } %>
    <table>
        <thead>
            <tr>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Item Image</th>
                <th>Winning Price</th>
                <th>Winner Name</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                for (ItemWinnerDetails item : itemsWithWinners) {
            %>
            <tr>
                <td><%= item.getItemId() %></td>
                <td><%= item.getItemName() %></td>
                <td> <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                <img alt="Item Image" width="100" height="100" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                <% } else { %>
                No Image
                <% }%> </td>
                <td><%= item.getBidAmount() %></td>
                <td><%= item.getFullName() %></td>
                <td>
                    <form method="post">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <input type="hidden" name="sellerID" value="<%= item.getSellrID() %>">
                        <input type="hidden" name="auctionID" value="<%= item.getAuctionID() %>">
                        <button type="submit" class="btn btn-success" name="addToCartBtn">Accept And Add To Cart</button>
                    </form>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
