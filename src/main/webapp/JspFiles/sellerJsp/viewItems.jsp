<%@ page import="com.app.models.Item" %>
<%@ page import="java.util.List" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

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
                    List<Item> items = (List<Item>) request.getAttribute("items");
                    if (items != null) {
                        for (Item item : items) {
                %>
                <tr>
                    <td><%= item.getItemId() %></td>
                    <td><%= item.getItemName() %></td>
                    <td><%= item.getDescription() %></td>
                    <td><%= item.getCondition() %></td>
                    <td><%= item.getCategory() %></td>
<%--                    <td><%= item.getItemImageUrl() %></td>--%>
                    <td><%= item.getItemImageUrl() %></td>
<%--                    <img src="../../p" alt="">--%>
                    <td><img style="height: 100px; width: 100px;" src="../../productImages/<%=item.getItemImageUrl()%>" ></td>
<%--                    <td><img src="../uploads/" style="width: 100px; height: 100px"></td>--%>
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
