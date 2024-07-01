<%@ page import="com.app.classes.Item" %><%--
  Created by IntelliJ IDEA.
  User: Dilki
  Date: 6/3/2024
  Time: 12:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<%
    String id=request.getParameter("id");
    Item item=new Item().getItem(id);
%>

<div>
    <p><%=item.getItemId()%></p>
    <p><%=item.getItemName()%></p>
    <p><%=item.getDescription()%></p>
    <p><%=item.getCategory()%></p>
    <p><%=item.getCondition()%></p>
    <img style="height: 100px; width: 100px;" src="<%= request.getContextPath() %>/productImages/<%= item.getItemImageUrl() %>">
    <a href="../../removeListing?id=<%=item.getItemId()%>"><button class="btn btn-danger">Delete</button></a>
</div>

<div class="col-12">
    <a href="../../viewListingsForUpdateAndDelete?id=delete" class="btn btn-primary" type="submit">back To Delete Auction</a>
</div>



<script src="../../JS/formValidation.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
