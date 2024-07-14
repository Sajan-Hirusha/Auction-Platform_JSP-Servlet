<%@page import="java.sql.Timestamp"%>
<%@ page import="com.app.classes.Item, com.app.classes.Bid" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Submit Bid</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="../../CSS/alertBox.css">
    </head>
    <body>
        <%
            String message = "";
            String customerID = (String) session.getAttribute("customerID");
            if (customerID == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            String itemId = request.getParameter("id");
            Item item = new Item().getItem(itemId);

            if (request.getMethod().equals("POST")) {
                String price = request.getParameter("bidAmount");
                double bidAmount = Double.parseDouble(price);
                try {
                    Bid bid = new Bid(bidAmount, itemId, new Timestamp(System.currentTimeMillis()), customerID);
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

        <div id="alertContainer1"></div>


        <div class="col-12">
            <a href="customerDashboard.jsp" class="btn btn-primary" type="submit">Back to seller dashboard</a>
        </div>

        <div>
            <p><%=item.getItemId()%></p>
            <p><%=item.getItemName()%></p>
            <p><%=item.getDescription()%></p>
            <p><%=item.getCategory()%></p>
            <p><%=item.getCondition()%></p>
            <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
            <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
            <% } else { %>
            No Image
            <% }%>
        </div>

        <form method="post" action="">
            <div class="col-md-4">
                <label for="validationCustom01" class="form-label">Bid Amount</label>
                <input type="number" step="0.01" class="form-control" id="validationCustom01" name="bidAmount" required>
                <div class="valid-feedback">
                    Looks good!
                </div>
                <div class="invalid-feedback">
                    Please enter a valid bid amount.
                </div>
                <input type="hidden" value="<%= item.getItemId()%>" name="itemId" id="itemId">
            </div>

            <div class="col-12">
                <button class="btn btn-primary" type="submit">Submit Bid</button>
            </div>
        </form>




        <script>
                 var serverMessage = "<%= message%>";
        </script>
        <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
