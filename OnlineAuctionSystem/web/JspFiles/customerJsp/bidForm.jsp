<%@page import="java.sql.Timestamp"%>
<%@ page import="com.app.classes.Item, com.app.classes.Bid" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Submit Bid</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/bidForm.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">

    </head>
    <body>
        <%
            String message = "";
            String customerID = (String) session.getAttribute("customerID");
            Bid bid = null;
            Bid getMaxBid = new Bid();
            if (customerID == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            String itemId = request.getParameter("id");
            Item item = new Item().getItem(itemId);
            String auctionId = request.getParameter("auctionId");

            if (request.getMethod().equals("POST")) {
                String price = request.getParameter("bidAmount");
                double bidAmount = Double.parseDouble(price);
                try {
                    bid = new Bid(bidAmount, itemId, new Timestamp(System.currentTimeMillis()), customerID);
                    bid.setAuctionID(auctionId);
                    if (bid.placeBid()) {
                        message = "Bid Placed Successfully!";
                    } else {
                        response.sendRedirect("../error.jsp?message=" + "Failed to place bid");
                        return;
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
            message = message == null ? "" : message;
        %>

        <div id="navbar-container" >
            <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
            <div class="nav-menu">
                <a href="../../home.html" class="nav-menu-item">Home</a>
                <a href="../../home.html#about" class="nav-menu-item">About Us</a>
                <a href="../../home.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../home.html#contact" class="nav-menu-item">Contact Us</a>
            </div>

            <div >
                <a id="logout" href="../LoginJsp/logout.jsp">Logout</a>
            </div>

        </div>
        <div id="alertContainer1"></div>
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
                                    <div class="col-md-4  mt-4">
                                        <p class="card-text"><strong>Category:</strong> <%= item.getCategory()%></p>
                                    </div>
                                    <div class="col-md-4  mt-4">
                                        <p class="card-text"><strong>Condition:</strong> <%= item.getCondition()%></p>
                                    </div>
                                    <div class="col-md-4  mt-4">
                                        <p><strong>Maximum Bid:</strong> <%= getMaxBid.maxBid(auctionId)%></p>
                                    </div>
                                    <div class="col-md-6  mb-3">
                                        <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                                        <img class="img-thumbnail" src="data:image/jpeg;base64,<%= item.getBase64Image()%>" alt="Item Image">
                                        <% } else { %>
                                        <p>No Image Available</p>
                                        <% }%>
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
        <footer class="footer" >
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>
        <script>
            var serverMessage = "<%= message%>";
        </script>
        <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
