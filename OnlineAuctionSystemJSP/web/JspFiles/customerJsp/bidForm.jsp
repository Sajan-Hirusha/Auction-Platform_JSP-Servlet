<%@ page import="com.app.classes.Item" %>
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
<div class="col-12">
    <a href="../../viewActiveItemsForCustomers" class="btn btn-primary" type="submit">back To seller dashboard</a>
</div>
<div>
    <p><%=item.getItemId()%></p>
    <p><%=item.getItemName()%></p>
    <p><%=item.getDescription()%></p>
    <p><%=item.getCategory()%></p>
    <p><%=item.getCondition()%></p>
    <img style="height: 100px; width: 100px;" src="<%= request.getContextPath() %>/productImages/<%= item.getItemImageUrl() %>" >
</div>



<form method="post" action="/OnlineAuctionSystem/submitBid" class="row g-3 needs-validation" novalidate>
    <div class="col-md-4">
        <label for="validationCustom01" class="form-label">Bid Amount </label>
        <input type="number"  step="0.01" class="form-control" id="validationCustom01" name="bidAmount" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid .
        </div>
        <input type="hidden" value="<%=item != null ? item.getItemId() : ""%>" name="itemId" id="itemId">
    </div>

    <div class="col-12">
        <button class="btn btn-primary" type="submit">Submit Bid</button>
    </div>
</form>

</body>
</html>
