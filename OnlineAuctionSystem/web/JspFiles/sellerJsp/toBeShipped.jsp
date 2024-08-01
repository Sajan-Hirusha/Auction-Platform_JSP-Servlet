<%@ page import="com.app.classes.EmailSender" %>
<%@ page import="com.app.classes.ItemWinnerDetails" %>
<%@ page import="com.app.classes.Auction" %>
<%@ page import="java.util.List" %>

<%
    String message = "";
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID == null) {
        response.sendRedirect("../LoginJsp/login.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String auctionID = request.getParameter("auctionID");
        String mailMessage = "Your Item Shipped Now.";
        String subject = "Confirmation of item shipped";
        EmailSender.sendEmail(email, subject, mailMessage);

        if (new Auction().itemShiped(auctionID)) {
            message = "Item Shipped Successfully";
        }
    }
    message = message == null ? "" : message;
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Item and Winner Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/toBeShiped.css">
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
            <div class="col-12">
                <a href="sellerDashboard.jsp" class="btn btn-primary backButton">Back to seller dashboard</a>
            </div>
            <div class="container">
                <div id="alertContainer1"></div>
                <h2 class="mb-4 mt-4">Item and Winner Details</h2>

                <% if (!message.isEmpty()) {%>
                <div class="alert <%= message.contains("Error") ? "alert-danger" : "alert-info"%> alert-dismissible fade show" role="alert">
                    <%= message%>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                <% } %>

                <table class="table table-dark table-hover">
                    <thead>
                        <tr>
                            <th>Item ID</th>
                            <th>Item Name</th>
                            <th>Item Image</th>
                            <th>Winning Price</th>
                            <th>Winner Name</th>
                            <th>Winner Address</th>
                            <th>Winner Phone Number</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            Auction dataFetcher = new Auction();
                            List<ItemWinnerDetails> itemsWithWinners = dataFetcher.itemToBeShiped(sellerID);
                            for (ItemWinnerDetails item : itemsWithWinners) {
                        %>
                        <tr>
                            <td><%= item.getItemId()%></td>
                            <td><%= item.getItemName()%></td>
                            <td>
                                <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                                <img alt="Item Image" width="100" height="100" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                                <% } else { %>
                                No Image
                                <% }%>
                            </td>
                            <td><%= item.getBidAmount()%></td>
                            <td><%= item.getFullName()%></td>
                            <td><%= item.getAddress()%></td>
                            <td><%= item.getPhoneNo()%></td>
                            <td>
                                <form method="post">
                                    <input type="hidden" name="email" value="<%= item.getEmail()%>">
                                    <input type="hidden" name="auctionID" value="<%= item.getAuctionID()%>">
                                    <button type="submit" class="btn btn-success" name="buyNow">Shipped Now</button>
                                </form>
                            </td>
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script>
            var serverMessage = "<%= message%>";
        </script>
        <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
    </body>
</html>
