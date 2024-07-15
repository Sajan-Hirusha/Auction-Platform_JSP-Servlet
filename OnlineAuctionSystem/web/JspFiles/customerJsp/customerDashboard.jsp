<%@page import="com.app.classes.Auction"%>
<%@page import="java.util.ArrayList"%>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    String customerID = (String) session.getAttribute("customerID");
    if (customerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<html>
    <head>
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <a href="wonItemsListOfCustomer.jsp" class="btn btn-secondary">View Won Items</a>
        <a href="cart.jsp" class="btn btn-secondary">View Cart</a>
        <h1>Active Auctions</h1>

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
                                    Auction auction = new Auction();
                                    items = auction.getAllActiveAuctionItems();
                                 
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
                                <td><% if (!item.getBase64Image().isEmpty()) {%>
                                    <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                                    <% } else { %> No Image <% }%>
                                </td>
                               <td><a class="btn btn-success" href="/OnlineAuctionSystem/JspFiles/customerJsp/bidForm.jsp?id=<%=item.getItemId()%>&auctionId=<%=item.getAuctionIDForBID()%>">Bid To This</a></td>

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
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </body>
</html>
