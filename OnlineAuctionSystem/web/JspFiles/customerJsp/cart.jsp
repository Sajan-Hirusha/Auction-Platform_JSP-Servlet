<%@ page import="com.app.classes.Cart" %>
<%@ page import="com.app.classes.CartItemDetails" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%
   String message = "";
    String customerID = (String) session.getAttribute("customerID");
    if (customerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String auctionID = request.getParameter("auctionID");

        try {
            Cart cart = new Cart();
            boolean buyNow = cart.buyNow(auctionID);

            if (buyNow) {
                message = "Item Shiped Soon";
            } else {
                message = "Failed to buy.";
            }
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        }
    }
    
    
    List<CartItemDetails> cartItems = null;
    try {
        Cart cart = new Cart();
        cartItems = cart.getCartItemsForSeller(customerID);
    } catch (Exception e) {
        e.printStackTrace();
    }
       message = message == null ? "" : message;
%>


<!DOCTYPE html>
<html>
<head>
    <title>Cart Items for Seller</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
       <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
</head>
<body>
    
     <div id="alertContainer1"></div>
    <h2>Cart Items for Seller</h2>
    <table>
        <thead>
            <tr>
                <th>Cart ID</th>
                <th>Customer ID</th>
                <th>Item ID</th>
                <th>Item Name</th>
                <th>Description</th>
                <th>Item Image</th>
                <th>Condition</th>
                <th>Auction ID</th>
            </tr>
        </thead>
        <tbody>
            <% if (cartItems != null) { %>
                <% for (CartItemDetails item : cartItems) { %>
                    <tr>
                        <td><%= item.getCartID() %></td>
                        <td><%= item.getCustomerID() %></td>
                        <td><%= item.getItemId() %></td>
                        <td><%= item.getItemName() %></td>
                        <td><%= item.getDescription() %></td>
                        <td><% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) { %>
                                <img alt="Item Image" width="100" height="100" src="data:image/jpeg;base64,<%= item.getBase64Image() %>">
                            <% } else { %>
                                No Image
                            <% } %>
                        </td>
                        <td><%= item.getItemCondition() %></td>
                        <td><%= item.getAuctionID() %></td>
                       <td>
                    <form method="post">
                        <input type="hidden" name="auctionID" value="<%= item.getAuctionID() %>">
                        <button type="submit" class="btn btn-success" name="buyNow">Buy Now</button>
                    </form>
                </td>
                    </tr>
                <% } %>
            <% } else { %>
                <tr>
                    <td colspan="9">No items found.</td>
                </tr>
            <% } %>
        </tbody>
    </table>
        
        <script>
            var serverMessage = "<%= message%>";
        </script>
      <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
</body>
</html>

