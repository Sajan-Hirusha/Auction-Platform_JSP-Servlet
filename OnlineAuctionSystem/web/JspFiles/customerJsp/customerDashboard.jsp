<%@ page import="com.app.classes.Auction" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    String customerID = (String) session.getAttribute("customerID");
    if (customerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
<head>
    <title>Active Auctions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
    <link rel="stylesheet" href="../../CSS/customerDashboard.css">
</head>
<body>

    <div id="navbar-container">
        <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
        <div class="nav-menu">
            <a href="../../home.html" class="nav-menu-item">Home</a>
            <a href="../../home.html#about" class="nav-menu-item">About Us</a>
            <a href="../../home.html#services" class="nav-menu-item">Our Services</a>
            <a href="../../home.html#contact" class="nav-menu-item">Contact Us</a>
        </div>

        <div>
            <a id="logout" href="../LoginJsp/logout.jsp">Logout</a>
        </div>
    </div>

    <div class="container">
        <div class="header-buttons">
            <a href="wonItemsListOfCustomer.jsp" class="btn btn-secondary me-2">View Won Items</a>
            <a href="cart.jsp" class="btn btn-secondary">View Cart</a>
        </div>

        <h1 class="mb-4">Active Auctions</h1>

        <% if (!message.isEmpty()) {%>
        <div class="alert <%= message.contains("Error") ? "alert-danger" : "alert-info"%> alert-dismissible fade show alert-container" role="alert">
            <%= message%>
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
        <% } %>

        <div class="row">
            <%
                List<Item> items = new ArrayList<Item>();
                try {
                    Auction auction = new Auction();
                    items = auction.getAllActiveAuctionItems();
                } catch (Exception e) {
                    message = "Error fetching items!";
                }

                if (items != null && !items.isEmpty()) {
                    for (Item item : items) {
                        String startDate = item.getStartingDateAndTime(); // Assuming this method exists
                        String endDate = item.getEndDateAndTime(); // Assuming this method exists
            %>
            <div class="col-md-4">
                <div class="card">
                    <% if (!item.getBase64Image().isEmpty()) {%>
                    <img src="data:image/jpeg;base64,<%= item.getBase64Image()%>" class="card-img-top" alt="<%= item.getItemName()%>">
                    <% } else { %>
                    <img src="https://via.placeholder.com/350x180" class="card-img-top" alt="Placeholder Image">
                    <% }%>
                    <div class="card-body">
                        <h5 class="card-title"><%= item.getItemName()%></h5>
                        <p class="card-text"><strong>Description:</strong> <%= item.getDescription()%></p>
                        <p class="card-text"><strong>Condition:</strong> <%= item.getCondition()%></p>
                        <p class="card-text"><strong>Category:</strong> <%= item.getCategory()%></p>
                        <p class="card-text">
                            <strong>Time Left:</strong> <span id="countdown-<%= item.getItemId() %>" class="countdown-timer"></span>
                        </p>
                        <a class="btn btn-success" href="bidForm.jsp?id=<%= item.getItemId()%>&auctionId=<%= item.getAuctionIDForBID()%>&startDate=<%= startDate %>&endDate=<%= endDate %>">Bid Now</a>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
            <div class="col-12">
                <div class="alert alert-info" role="alert">
                    No items found.
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>

    <footer class="footer">
        Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
    </footer>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
    <script type="text/javascript">
        document.addEventListener('DOMContentLoaded', function() {
            <% 
            for (Item item : items) {
                String endDate = item.getEndDateAndTime();
            %>
            (function() {
                var endDate = new Date("<%= endDate %>").getTime();
                var timerElement = document.getElementById('countdown-<%= item.getItemId() %>');
                
                var countdown = setInterval(function() {
                    var now = new Date().getTime();
                    var distance = endDate - now;

                    if (distance < 0) {
                        clearInterval(countdown);
                        timerElement.innerHTML = "Auction Ended";
                        return;
                    }

                    var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                    var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                    timerElement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";
                }, 1000);
            })();
            <%
            }
            %>
        });
    </script>
</body>
</html>
