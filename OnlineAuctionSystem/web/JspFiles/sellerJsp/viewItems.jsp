<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/viewItems.css">
        <style>
           
        </style>
    </head>
    <body>
        <div id="navbar-container" class="d-flex justify-content-between align-items-center p-3 bg-light shadow-sm">
            <img src="../images/logo.png" alt="logo" class="nav-img">
            <div class="nav-menu">
                <a href="../../home.html" class="nav-menu-item">Home</a>
                <a href="../../home.html#about" class="nav-menu-item">About Us</a>
                <a href="../../home.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../home.html#contact" class="nav-menu-item">Contact Us</a>
            </div>
            <div>
                <a id="logout" href="../LoginJsp/logout.jsp" class="btn btn-outline-danger">Logout</a>
            </div>
        </div>
        <%
            String message = "";
            String sellerID = (String) session.getAttribute("sellerID");
            if (sellerID == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div id="alertContainer"></div>

        <div class="col-12 my-3">
            <a href="sellerDashboard.jsp" class="btn btn-primary backButton">Back to seller dashboard</a>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <table class="table table-hover table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>ItemId</th>
                                <th>ItemName</th>
                                <th>Item Description</th>
                                <th>Item Condition</th>
                                <th>Item Category</th>
                                <th>Item image</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                List<Item> items = new ArrayList<Item>();
                                try {
                                    Item item = new Item();
                                    item.setSellerID(sellerID);
                                    items = item.getItemList(); // Fetch items for the seller
                                } catch (Exception e) {
                                    message = "Error fetching items!";
                                }

                                if (items != null && !items.isEmpty()) {
                                    for (Item item : items) {
                            %>
                            <tr>
                                <td><%= item.getItemId()%></td>
                                <td><%= item.getItemName()%></td>
                                <td><%= item.getDescription()%></td>
                                <td><%= item.getCondition()%></td>
                                <td><%= item.getCategory()%></td>
                                <td>
                                    <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                                    <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                                    <% } else { %>
                                    No Image
                                    <% }%>
                                </td>
                                <td>
                                    <div class="btn-group">
                                        <a class="btn btn-success" href="updateListing.jsp?id=<%= item.getItemId()%>">Update</a>
                                        <a class="btn btn-danger" href="removeListing.jsp?id=<%= item.getItemId()%>">Delete</a>
                                        <a class="btn btn-warning" href="placeAuction.jsp?id=<%= item.getItemId()%>">Place Auction</a>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="7" class="text-center">No items found.</td>
                            </tr>
                            <%
                                }
                                message = message == null ? "" : message;
                            %>

                            <script>
                                var serverMessage = "<%= message%>";
                            </script>
                            <script src="../../JS/main.js"></script>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <footer class="footer">
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous"></script>
    </body>
</html>
