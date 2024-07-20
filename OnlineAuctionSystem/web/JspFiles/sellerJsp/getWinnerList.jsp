<%@page import="com.app.classes.ItemWinnerDetails"%>
<%@page import="com.app.classes.Auction"%>
<%@ page import="java.util.List" %>

<%
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Item and Winner Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 15px;
            text-align: left;
        }
    </style>
</head>
<body>
    <h2>Waiting For customer approval</h2>
    <table>
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
                <td><%= item.getItemId() %></td>
                <td><%= item.getItemName() %></td>
                <td> <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                <img alt="Item Image" width="100" height="100" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                <% } else { %>
                No Image
                <% }%> </td>
                <td><%= item.getBidAmount() %></td>
                <td><%= item.getFullName() %></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
