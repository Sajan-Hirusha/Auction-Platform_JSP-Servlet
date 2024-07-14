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
        <title>View Item Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">
    </head>
    <body>

        <div id="alertContainer1"></div>

        <div class="container mt-5">
            <h2>Item Details</h2>
            <div>
                <p><strong>ID:</strong> <%= item.getItemId()%></p>
                <p><strong>Name:</strong> <%= item.getItemName()%></p>
                <p><strong>Description:</strong> <%= item.getDescription()%></p>
                <p><strong>Category:</strong> <%= item.getCategory()%></p>
                <p><strong>Condition:</strong> <%= item.getCondition()%></p>
                <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64, <%= item.getBase64Image()%> ">
                <% } else { %>
                <p>No Image</p>
                <% }%>
            </div>

            <div class="mt-3">
                <form action="removeListing.jsp" method="post">
                    <input type="hidden" name="deleteId" value="<%= item.getItemId()%>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </div>

            <div class="mt-3">
                <a href="viewItems.jsp" class="btn btn-primary">Back to Delete Auction</a>
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
