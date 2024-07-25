<%@page import="java.net.URLEncoder" %>
<%@ page import="com.app.classes.Item, com.app.classes.Auction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException, java.sql.Timestamp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Place Auction</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
              rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
              crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/PlaceAuction.css">

    </head>

    <body>
        <%  String message = "";
            String message1 = "";
            if (request.getMethod().equalsIgnoreCase("post")) {
                String startingTimeAndDate = request.getParameter("startingTimeAndDate");
                String endTimeAndDate = request.getParameter("endTimeAndDate");
                String price = request.getParameter("startingPrice");
                double startingPrice = Double.parseDouble(price);
                String itemId = request.getParameter("itemId");
                String sellerId = request.getParameter("sellerId");
                Timestamp timestamp1 = Timestamp.valueOf(startingTimeAndDate.replace("T", " ") + ":00");
                Timestamp timestamp2 = Timestamp.valueOf(endTimeAndDate.replace("T", " ") + ":00");
                Auction auction = new Auction(timestamp1, timestamp2, startingPrice, itemId,
                        sellerId);
                try {
                    if (auction.placeAuction()) {
                        message1 = "Auction placed successfully! ";
                    } else {
                        message = " Failed to place auction";
                    }
                } catch (Exception e) {
                    message = " Failed to place auction";
                }
            }
            message = message == null ? "" : message;
            message1 = message1 == null ? "" : message1; %>

        <div id="alertContainer"></div>
        <div id="alertContainer1"></div>

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
        <div id="main">
            <div class="col-12 ">
                <a href="viewItems.jsp" class="btn btn-primary backButton">Back to Items</a>
            </div>
            <div class="container mt-3 col-8">

                <form method="post" class="row g-3 needs-validation" novalidate>
                    <h2 id="h2">Auction Bid Form</h2>
                    <% String id = request.getParameter("id");
                        Item item = new Item().getItem(id);
                    %>
                    <div class="row">
                        <div class="col-md-4">
                            <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                            <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                            <% } else { %>
                            No Image
                            <% }%>
                            <h2 class="mt-2"><%= item.getItemName()%></h2>
                            <p> <%= item.getItemId()%></p>
                        </div>
                        <div class="col-md-8">
                            <div class="row">
                                <div class="col-12">
                                    <p id="description"><i><%= item.getDescription()%></i></p>
                                </div>
                                <div class="col-md-6">
                                    <p><b>Category: </b><i><%= item.getCategory()%></i></p>
                                </div>
                                <div class="col-md-6">
                                    <P><b>Condition: </b><i><%= item.getCondition()%></i></P>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="startingTimeAndDate" class="form-label">Starting Date and Time</label>
                                    <input type="datetime-local" class="form-control" id="startingTimeAndDate" name="startingTimeAndDate" required>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid end date and time.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="endTimeAndDate" class="form-label">End Date and Time</label>
                                    <input type="datetime-local" class="form-control" id="endTimeAndDate" name="endTimeAndDate" required>
                                    <div class="valid-feedback">Looks good!</div>
                                    <div class="invalid-feedback">Please provide a valid end date and time.</div>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="startingPrice" class="form-label">Starting Price</label>
                                    <input type="number" step="0.01" class="form-control" id="startingPrice" name="startingPrice" required>
                                    <div class="valid-feedback"> Looks good!</div>
                                    <div class="invalid-feedback">
                                        Please provide a valid starting price.
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <input type="hidden" class="form-control" id="itemId" name="itemId" value="<%= item.getItemId()%>" required>
                                </div>
                                <div class="col-md-6">
                                    <input type="hidden" class="form-control" id="sellerId" name="sellerId" value="<%= item.getSellerID()%>" required>
                                </div>
                            </div>
                            <div class="col-12 mt-3">
                                <button class="btn btn-primary" type="submit">Submit</button>
                            </div>
                        </div>
                    </div>                                                           

                </form>
            </div>
        </div>
        <br><br>
        <footer class="footer" >
            Copyright &#169; <span>AuctionHub</span>. All rights reserved.
        </footer>

        <script>
            var serverMessage = "<%= message%>";
            var serverMessage1 = "<%= message1%>";

            if (serverMessage1 !== "" && serverMessage1 !== null) {
                document.write('<script src="../../JS/formvalidationWithSuccessAlert.js"><\/script>');
            } else if (serverMessage !== "" && serverMessage !== null) {
                document.write('<script src="../../JS/formValidationWithFailure.js"><\/script>');
            } else {
                document.write('<script src="../../JS/formValidationWithFailure.js"><\/script>'); // Default behavior
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>

</html>