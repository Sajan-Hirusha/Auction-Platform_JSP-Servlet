<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <%
            String message = "";
            String sellerID = (String) session.getAttribute("sellerID");
            if (sellerID == null) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <div id="alertContainer"></div>

        <div class="col-12">
            <a href="sellerDashboard.jsp" class="btn btn-primary" type="submit">Back to seller dashboard</a>
        </div>
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ItemId</th>
                                <th>ItemName</th>
                                <th>Item Description</th>
                                <th>Item Condition</th>
                                <th>Item Category</th>
                                <th>Item image</th>
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
                                    <% } %>
                                </td>
                                 <td>
                                        <a class="btn btn-success" href="updateListing.jsp?id=<%= item.getItemId()%>"> Update </a>
                                     <a class="btn btn-danger" href="removeListing.jsp?id=<%= item.getItemId()%>">Delete </a>
                                    <a class="btn btn-danger" href="placeAuction.jsp?id=<%= item.getItemId()%>">Place Auction </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="6">No items found.</td>
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
    </body>
</html>
