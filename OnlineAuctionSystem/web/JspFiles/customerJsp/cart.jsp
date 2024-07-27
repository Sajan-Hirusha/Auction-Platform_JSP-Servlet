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
                message = "Item Shipped Soon";
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
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/cart.css">

    </head>
    <body>
        <div id="navbar-container" >
            <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
            <div class="nav-menu">
                <a href="../../index.html" class="nav-menu-item">Home</a>
                <a href="../../index.html#about" class="nav-menu-item">About Us</a>
                <a href="../../index.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../index.html#contact" class="nav-menu-item">Contact Us</a>
            </div>

            <div >
                <a id="logout" href="../LoginJsp/logout.jsp">Logout</a>
            </div>

        </div>
        <div id="main">
            <div class="row mb-4">
                <div class="col-12">
                    <a href="customerDashboard.jsp" class="btn btn-primary backButton">Back to Dashboard</a>
                </div>
            </div>
            <div class="container">
                <div id="alertContainer1" class="alert-container"></div>
                <h2 class="my-4">Cart Items for Seller</h2>
                <% if (!message.isEmpty()) {%>
                <div class="alert alert-info" role="alert">
                    <%= message%>
                </div>
                <% } %>
                <div class="row">
                    <% if (cartItems != null && !cartItems.isEmpty()) { %>
                    <% for (CartItemDetails item : cartItems) { %>
                    <div class="col-md-4 mb-3">
                        <div class="card item-card p-3">
                            <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                            <img src="data:image/jpeg;base64,<%= item.getBase64Image()%>" alt="Item Image">
                            <% } else { %>
                            <img src="https://via.placeholder.com/300x200?text=No+Image" alt="No Image">
                            <% }%>
                            <div class="item-card-body">
                                <h5 class="card-title"><%= item.getItemName()%></h5>
                                <p class="card-text"><strong>Description:</strong> <%= item.getDescription()%></p>
                                <p class="card-text"><strong>Condition:</strong> <%= item.getItemCondition()%></p>
                                <p class="card-text"><strong>Auction ID:</strong> <%= item.getAuctionID()%></p>
                                <form method="post">
                                    <input type="hidden" name="auctionID" value="<%= item.getAuctionID()%>">
                                    <button type="submit" class="btn btn-success">Buy Now</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <% } %>
                    <% } else { %>
                    <div class="col-12">
                        <div class="alert alert-warning" role="alert">
                            No items found.
                        </div>
                    </div>
                    <% }%>
                </div>
            </div>
        </div>
        <footer class="footer" >
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>
        <script>
            var serverMessage = "<%= message%>";
        </script>
        <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
    </body>
</html>
