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
       response.sendRedirect("../LoginJsp/login.jsp");
        return;
    }

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

    Auction dataFetcher = new Auction();
    List<ItemWinnerDetails> itemsWithWinners = dataFetcher.getCustomerWonItems(customerID);
    message = message == null ? "" : message;
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Item and Winner Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/wonItemsListOfCustomer.css">

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
                <h2 class="my-4">Item and Winner Details</h2>
                <% if (!message.isEmpty()) {%>
                <div class="alert alert-info" role="alert">
                    <%= message%>
                </div>
                <% } %>
                <div class="row">
                    <%
                        for (ItemWinnerDetails item : itemsWithWinners) {
                    %>
                    <div class="col-md-4">
                        <div class="card item-card">
                            <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                            <img src="data:image/jpeg;base64,<%= item.getBase64Image()%>" class="card-img-top" alt="Item Image">
                            <% } else { %>
                            <img src="https://via.placeholder.com/300x200?text=No+Image" class="card-img-top" alt="No Image">
                            <% }%>
                            <div class="card-body item-card-body">
                                <h5 class="card-title"><%= item.getItemName()%></h5>
                                <p class="card-text">Winning Price: $<%= item.getBidAmount()%></p>
                                <p class="card-text">Winner Name: <%= item.getFullName()%></p>
                                <form method="post">
                                    <input type="hidden" name="itemId" value="<%= item.getItemId()%>">
                                    <input type="hidden" name="sellerID" value="<%= item.getSellrID()%>">
                                    <input type="hidden" name="auctionID" value="<%= item.getAuctionID()%>">
                                    <button type="submit" class="btn btn-success">Accept And Add To Cart</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    </body>
</html>
