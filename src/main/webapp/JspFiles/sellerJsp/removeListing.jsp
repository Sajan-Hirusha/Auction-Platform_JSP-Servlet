<%@ page import="com.app.models.Item" %><%--
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
    <img style="height: 100px; width: 100px;" src="../../productImages/<%=item.getItemImageUrl()%>" >
    <a href="../../removeListing?id=<%=item.getItemId()%>"><button>Delete</button></a>
</div>

<div class="col-12">
    <a href="/JspFiles/sellerJsp/sellerDashboard.jsp" class="btn btn-primary" type="submit">back To seller dashboard</a>
</div>
</body>
</html>
