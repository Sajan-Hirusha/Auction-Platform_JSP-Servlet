<%@page import="java.sql.Timestamp"%>
<%@ page import="com.app.classes.Item, com.app.classes.Bid" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Submit Bid</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
    <link rel="stylesheet" href="../../CSS/alertSuccess.css">
    <link rel="stylesheet" href="../../CSS/bidForm.css">
    <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
    <style>
        #countdown {
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%
        String message = "";
        String message1 = "";
        String customerID = (String) session.getAttribute("customerID");
        Bid bid = null;
        Bid getMaxBid = new Bid();
        if (customerID == null) {
            response.sendRedirect("../LoginJsp/login.jsp");
            return;
        }
        String itemId = request.getParameter("id");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        Item item = new Item().getItem(itemId);
        String auctionId = request.getParameter("auctionId");

        if (request.getMethod().equals("POST")) {
            String price = request.getParameter("bidAmount");
            double bidAmount = Double.parseDouble(price);
            try {
                bid = new Bid(bidAmount, itemId, new Timestamp(System.currentTimeMillis()), customerID);
                bid.setAuctionID(auctionId);
                if (bid.placeBid()) {
                    message1 = "Bid Placed Successfully!";
                } else {
                    message = "Bid Failed!";
                    return;
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }
        message = message == null ? "" : message;
        message1 = message1 == null ? "" : message1;
    %>
    <div id="alertContainer"></div>
    <div id="navbar-container">
        <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
        <div class="nav-menu">
            <a href="../../index.html" class="nav-menu-item">Home</a>
            <a href="../../index.html#about" class="nav-menu-item">About Us</a>
            <a href="../../index.html#services" class="nav-menu-item">Our Services</a>
            <a href="../../index.html#contact" class="nav-menu-item">Contact Us</a>
        </div>
        <div>
            <a id="logout" href="../LoginJsp/logout.jsp">Logout</a>
        </div>
    </div>

    <div id="main">
        <div class="container">
            <div class="row mb-4">
                <div class="col-12">
                    <a href="customerDashboard.jsp" class="btn btn-primary backButton">Back to Dashboard</a>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="mb-4">Submit Your Bid</h2>
                    <div class="card mb-4">
                        <div class="card-body">
                            <h4 class="card-title"><%= item.getItemName()%></h4>
                            <div class="row">
                                <div class="col-md-12 mt-4">
                                    <p class="card-text" id="description"><strong>Description:</strong> <%= item.getDescription()%></p>
                                </div>
                                <div class="col-md-4 mt-4">
                                    <p class="card-text"><strong>Category:</strong> <%= item.getCategory()%></p>
                                </div>
                                <div class="col-md-4 mt-4">
                                    <p class="card-text"><strong>Condition:</strong> <%= item.getCondition()%></p>
                                </div>
                                <div class="col-md-4 mt-4">
                                    <p><strong>Maximum Bid:</strong> <%= getMaxBid.maxBid(auctionId)%></p>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                                    <img class="img-thumbnail" src="data:image/jpeg;base64,<%= item.getBase64Image()%>" alt="Item Image">
                                    <% } else { %>
                                    <p>No Image Available</p>
                                    <% }%>
                                </div>
                                <div class="col-12 mb-4">
                                    <div id="countdown"></div>
                                </div>
                                <form method="post" action="" class="needs-validation" novalidate>
                                    <div class="mb-3">
                                        <label for="bidAmount" class="form-label">Bid Amount</label>
                                        <input type="number" step="0.01" class="form-control" id="bidAmount" name="bidAmount" required
                                               min="<%= getMaxBid.maxBid(auctionId)%>" title="Enter your bid amount">
                                        <div class="invalid-feedback">
                                            Please enter a valid bid amount.
                                        </div>
                                    </div>
                                    <input type="hidden" value="<%= item.getItemId()%>" name="itemId" id="itemId">
                                    <div class="mb-3">
                                        <button class="btn btn-primary float-end" type="submit">Submit Bid</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="footer">
        Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
    </footer>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var countdownElement = document.getElementById('countdown');
            var auctionEndDate = "<%= endDate %>";
            var endDate = new Date(auctionEndDate).getTime();

            var countdown = setInterval(function() {
                var now = new Date().getTime();
                var distance = endDate - now;

                if (distance < 0) {
                    clearInterval(countdown);
                    countdownElement.innerHTML = "Auction Ended";
                    return;
                }

                var days = Math.floor(distance / (1000 * 60 * 60 * 24));
                var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                var seconds = Math.floor((distance % (1000 * 60)) / 1000);

                countdownElement.innerHTML = days + "d " + hours + "h " + minutes + "m " + seconds + "s ";
            }, 1000);
        });
    </script>

    <script>
        var serverMessage = "<%= message %>";
        var serverMessage1 = "<%= message1 %>";

        if (serverMessage1 !== "" && serverMessage1 !== null) {
            document.write('<script src="../../JS/formvalidationWithSuccessAlert.js"><\/script>');
        } else if (serverMessage !== "" && serverMessage !== null) {
            document.write('<script src="../../JS/formValidationWithFailure.js"><\/script>');
        } else {
            document.write('<script src="../../JS/formValidationWithFailure.js"><\/script>'); 
        }
    </script>
</body>
</html>
