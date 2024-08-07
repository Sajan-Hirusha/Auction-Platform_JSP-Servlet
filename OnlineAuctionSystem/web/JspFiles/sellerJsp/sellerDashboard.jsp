<%@ page import="com.app.classes.Auction" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
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
              crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/sellerDashboard.css">
       
    </head>
    <body>
        <%
            String sellerID = (String) session.getAttribute("sellerID");
            if (sellerID == null) {
                response.sendRedirect("../LoginJsp/login.jsp");
                return;
            }

            List<Item> activeItems = new ArrayList<Item>();
            List<Item> upcommingItems = new ArrayList<Item>();
            List<Item> endedItems = new ArrayList<Item>();
            Auction auction = new Auction();
            auction.setSellerId(sellerID);

            try {
                activeItems = auction.getSellerActiveAuctionItems();
                upcommingItems = auction.getSellerUpcommingAuctionItems();
                endedItems = auction.getSellerEnedAuctionItems();
            } catch (SQLException e) {
                e.printStackTrace();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            }
        %>

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
                <div class="nav-buttons text-center">
                    <a href="/OnlineAuctionSystem/JspFiles/sellerJsp/addItem.jsp" class="btn btn-secondary">Add listing</a>
                    <a href="viewItems.jsp" class="btn btn-secondary">View listing</a>
                    <a href="getWinnerList.jsp" class="btn btn-secondary">View End Items</a>
                    <a href="toBeShipped.jsp" class="btn btn-secondary">Items To Be Shipped</a>
                </div>

                <h1>My Active Auctions</h1>

                <div class="row">
                    <div class="col-12">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Item ID</th>
                                    <th>Item Name</th>
                                    <th>Item Description</th>
                                    <th>Item Condition</th>
                                    <th>Item Category</th>
                                    <th>Item Image</th>
                                    <th>Time Left</th>
                                </tr>
                            </thead>
                            <tbody >
                                <%
                                    if (!activeItems.isEmpty()) {
                                        for (Item item : activeItems) {
                                %>
                                <tr >
                                    <td ><%= item.getItemId()%></td>
                                    <td><%= item.getItemName()%></td>
                                    <td><%= item.getDescription()%></td>
                                    <td><%= item.getCondition()%></td>
                                    <td><%= item.getCategory()%></td>
                                    <td>
                                        <% if (!item.getBase64Image().isEmpty()) {%>
                                        <img src="data:image/jpeg;base64,<%= item.getBase64Image()%>" style="width: 100px; height: auto;">
                                        <% } else { %> 
                                        No Image 
                                        <% }%>
                                    </td>
                                    <td id="countdown-<%= item.getItemId()%>" class="countdown-timer"></td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="7" class="no-items">No items found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <h1>My Upcomming Auctions</h1>

                <div class="row">
                    <div class="col-12">
                        <table class="table table-hover" >
                            <thead>
                                <tr>
                                    <th>Item ID</th>
                                    <th>Item Name</th>
                                    <th>Item Description</th>
                                    <th>Item Condition</th>
                                    <th>Item Category</th>
                                    <th>Item Image</th>
                                    <th>Time Left</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (!upcommingItems.isEmpty()) {
                                        for (Item item : upcommingItems) {
                                %>
                                <tr >
                                    <td ><%= item.getItemId()%></td>
                                    <td><%= item.getItemName()%></td>
                                    <td><%= item.getDescription()%></td>
                                    <td><%= item.getCondition()%></td>
                                    <td><%= item.getCategory()%></td>
                                    <td>
                                        <% if (!item.getBase64Image().isEmpty()) {%>
                                        <img src="data:image/jpeg;base64,<%= item.getBase64Image()%>" style="width: 100px; height: auto;">
                                        <% } else { %> 
                                        No Image 
                                        <% }%>
                                    </td>
                                    <td id="countdown2-<%= item.getItemId()%>" class="countdown-timer"></td>
                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="7" class="no-items">No items found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>


                <h1>My Ended Auctions</h1>

                <div class="row">
                    <div class="col-12">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Item ID</th>
                                    <th>Item Name</th>
                                    <th>Item Description</th>
                                    <th>Item Condition</th>
                                    <th>Item Category</th>
                                    <th>Item Image</th>

                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (!endedItems.isEmpty()) {
                                        for (Item item : endedItems) {
                                %>
                                <tr>
                                    <td><%= item.getItemId()%></td>
                                    <td><%= item.getItemName()%></td>
                                    <td><%= item.getDescription()%></td>
                                    <td><%= item.getCondition()%></td>
                                    <td><%= item.getCategory()%></td>
                                    <td>
                                        <% if (!item.getBase64Image().isEmpty()) {%>
                                        <img src="data:image/jpeg;base64,<%= item.getBase64Image()%>" style="width: 100px; height: auto;">
                                        <% } else { %> 
                                        No Image 
                                        <% }%>
                                    </td>

                                </tr>
                                <%
                                    }
                                } else {
                                %>
                                <tr>
                                    <td colspan="7" class="no-items">No items found.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>

                    </div>

                </div>
            </div>
        </div>
        <footer class="footer">
            Copyright &#169; <span>AuctionHub</span>. All rights reserved.
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
        <script type="text/javascript">
            document.addEventListener('DOMContentLoaded', function () {
            <%
         // Active Items Countdown
         for (Item item : activeItems) {
             String endDate = item.getEndDateAndTime();
            %>
                (function () {
                    var endDate = new Date("<%= endDate%>").getTime();
                    var timerElement = document.getElementById('countdown-<%= item.getItemId()%>');

                    var countdown = setInterval(function () {
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

         // Upcoming Items Countdown
         for (Item item : upcommingItems) {
             String startDate = item.getStartingDateAndTime();
            %>
                (function () {
                    var startDate = new Date("<%= startDate%>").getTime();
                    var timerElement = document.getElementById('countdown2-<%= item.getItemId()%>');

                    var countdown = setInterval(function () {
                        var now = new Date().getTime();
                        var distance = startDate - now;

                        if (distance < 0) {
                            clearInterval(countdown);
                            timerElement.innerHTML = "Auction Started";
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
