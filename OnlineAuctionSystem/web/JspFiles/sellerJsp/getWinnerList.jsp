<%@ page import="com.app.classes.ItemWinnerDetails" %>
<%@ page import="com.app.classes.Auction" %>
<%@ page import="java.util.List" %>

<%
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Item and Winner Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/getWinnerList.css">
    </head>
    <body>
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
            <div class="container">
                <div class="header">
                    <h2 class="mb-4 mt-4">Waiting For Customer Approval</h2>
                </div>
                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>Item ID</th>
                            <th>Item Name</th>
                            <th>Item Image</th>
                            <th>Winning Price</th>
                            <th>Winner Name</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Auction dataFetcher = new Auction();
                            List<ItemWinnerDetails> itemsWithWinners = dataFetcher.getEndItemsAndWinners(sellerID);
                            System.out.println(sellerID);
                            for (ItemWinnerDetails item : itemsWithWinners) {
                                System.out.println(item.getItemId());
                        %>
                        <tr>
                            <td><%= item.getItemId()%></td>
                            <td><%= item.getItemName()%></td>
                            <td>
                                <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                                <img alt="Item Image" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                                <% } else { %>
                                No Image
                                <% }%>
                            </td>
                            <td><%= item.getBidAmount()%></td>
                            <td><%= item.getFullName()%></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <footer class="footer" >
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
