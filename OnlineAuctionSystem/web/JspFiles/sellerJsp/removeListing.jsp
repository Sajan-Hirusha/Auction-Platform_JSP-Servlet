<%@page import="java.net.URLEncoder"%>
<%@ page import="com.app.classes.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page errorPage="error.jsp" %>
<%@ page trimDirectiveWhitespaces="true" %>

<%
    String message = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String deleteId = request.getParameter("deleteId");
        if (deleteId != null && !deleteId.isEmpty()) {
            Item item = new Item();
            boolean deleted = item.deleteItem(deleteId);
            if (deleted) {
                response.sendRedirect("viewItems.jsp");
                message = "Item Delete successfully! ";
                return;
            } else {
                response.sendRedirect("error.jsp?message=" + URLEncoder.encode("Failed to delete item", "UTF-8"));
                return;
            }
        }
    }
    message = message == null ? "" : message;
    String id = request.getParameter("id");
    Item item = new Item().getItem(id);

    if (item == null) {
        response.sendRedirect("error.jsp?message=" + URLEncoder.encode("Item not found", "UTF-8"));
        return;
    }

%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Delete items</title>
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              crossorigin="anonymous">
        <script src="../../JS/formValidation.js"></script>
        <link rel="stylesheet" href="../../CSS/RemoveListing.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">

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
                <a href="viewItems.jsp" class="btn btn-primary backButton">Back to Delete Auction</a>
            </div>
            <div class="container mt-3 col-6" >
                <form action="removeListing.jsp" method="post">
                    <h1 class="mb-4">Delete form</h1>
                    <div class="row">
                        <div class="col-md-4">
                            <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                            <img class="mx-4" src="data:image/jpeg;base64, <%= item.getBase64Image()%> ">
                            <% } else { %>
                            <p>No Image</p>
                            <% }%>
                        </div>
                        <div class="col-md-8 row">
                            <div class="col-md-6">
                                <p><b>Name:</b> <%= item.getItemName()%></p>
                            </div>
                            <div class="col-md-6">
                                <p><b>ID:</b> <%= item.getItemId()%></p>
                            </div>
                            <div class="col-12">
                                <p id="description"><b>Description:</b> <i><%= item.getDescription()%></i></p>
                            </div>
                            <input type="hidden" name="deleteId" value="<%= item.getItemId()%>">
                            <div class="col-12">
                                <button type="submit" class="btn btn-danger float-end">Delete</button>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>
        <br><br>
        <footer class="footer" >
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>

        <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>

    </body>
</html>
