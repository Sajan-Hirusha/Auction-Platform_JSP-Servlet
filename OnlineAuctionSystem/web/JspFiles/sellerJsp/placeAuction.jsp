<%@page import="java.net.URLEncoder"%>
<%@ page import="com.app.classes.Item, com.app.classes.Auction" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.SQLException, java.sql.Timestamp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Place Auction</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">
    </head>
    <body>
        <%
            String message = "";
            if (request.getMethod().equalsIgnoreCase("post")) {
                String startingTimeAndDate = request.getParameter("startingTimeAndDate");
                String endTimeAndDate = request.getParameter("endTimeAndDate");
                String price = request.getParameter("startingPrice");
                double startingPrice = Double.parseDouble(price);
                String itemId = request.getParameter("itemId");
                String sellerId = request.getParameter("sellerId");

                Timestamp timestamp1 = Timestamp.valueOf(startingTimeAndDate.replace("T", " ") + ":00");
                Timestamp timestamp2 = Timestamp.valueOf(endTimeAndDate.replace("T", " ") + ":00");

                Auction auction = new Auction(timestamp1, timestamp2, startingPrice, itemId, sellerId);

                try {
                    if (auction.placeAuction()) {
                        message = "Auction placed successfully! ";
                    } else {
                        response.sendRedirect("error.jsp?message=" + URLEncoder.encode("Failed to place auction", "UTF-8"));
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }
            message = message == null ? "" : message;
        %>

        <div id="alertContainer1"></div>

        <div class="container">
            <h2>Place Auction</h2>
            <%
                String id = request.getParameter("id");
                Item item = new Item().getItem(id);
            %>

            <div>
                <p>Item ID: <%= item.getItemId()%></p>
                <p>Item Name: <%= item.getItemName()%></p>
                <p>Description: <%= item.getDescription()%></p>
                <p>Category: <%= item.getCategory()%></p>
                <p>Condition: <%= item.getCondition()%></p>
                <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                <% } else { %>
                No Image
                <% }%>
            </div>

            <form method="post" class="row g-3 needs-validation" novalidate>
                <div class="col-md-6">
                    <label for="startingTimeAndDate" class="form-label">Starting Date and Time</label>
                    <input type="datetime-local" class="form-control" id="startingTimeAndDate" name="startingTimeAndDate" required>
                    <div class="valid-feedback">
                        Looks good!
                    </div>
                    <div class="invalid-feedback">
                        Please provide a valid starting date and time.
                    </div>
                </div>
                <div class="col-md-6">
                    <label for="endTimeAndDate" class="form-label">End Date and Time</label>
                    <input type="datetime-local" class="form-control" id="endTimeAndDate" name="endTimeAndDate" required>
                    <div class="valid-feedback">
                        Looks good!
                    </div>
                    <div class="invalid-feedback">
                        Please provide a valid end date and time.
                    </div>
                </div>
                <div class="col-md-6">
                    <label for="startingPrice" class="form-label">Starting Price</label>
                    <input type="number" step="0.01" class="form-control" id="startingPrice" name="startingPrice" required>
                    <div class="valid-feedback">
                        Looks good!
                    </div>
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
                <div class="col-12">
                    <button class="btn btn-primary" type="submit">Submit</button>
                </div>
            </form>
            <div class="col-12 mt-3">
                <a href="viewItems.jsp" class="btn btn-primary">Back to Items</a>
            </div>
        </div>

        <script>
            var serverMessage = "<%= message%>";
        </script>

        <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
