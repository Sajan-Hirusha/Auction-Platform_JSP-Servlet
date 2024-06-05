<%@ page import="com.app.models.Item" %><%--
  Created by IntelliJ IDEA.
  User: Dilki
  Date: 6/3/2024
  Time: 12:54 PM
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
    <img style="height: 100px; width: 100px;" src="../../productImages/<%=item.getItemImageUrl()%>" >
</div>



<form method="post" action="/placeAuction" class="row g-3 needs-validation" novalidate>
    <div class="col-md-6">
        <label for="validationCustom03" class="form-label">Select starting Date And Starting Time</label>
        <input type="datetime-local" class="form-control" id="validationCustom03" name="startingTimeAndDate" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please provide a valid Address.
        </div>
    </div>
    <div class="col-md-6">
        <label for="validationCustom03" class="form-label">Select End Date And Starting Time</label>
        <input type="datetime-local" class="form-control" id="validationCustom04" name="endTimeAndDate" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please provide a valid Date And Time.
        </div>
    </div>
    <div class="col-md-6">
        <label for="validationCustom03" class="form-label">Starting Price</label>
        <input type="number"  step="0.01" class="form-control" id="validationCustom05" name="startingPrice" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please provide a valid valid Date And Time
        </div>
    </div>
    <div class="col-md-6">
        <input type="hidden" class="form-control" id="validationCustom06" name="itemId"
               value="<%=item != null ? item.getItemId() : ""%>" required >
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please provide a valid Password.
        </div>
    </div>

    <div class="col-md-6">
        <input type="hidden" class="form-control" id="validationCustom07" name="sellerId"
               value="<%=item != null ? item.getSellerID() : ""%>"  required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please provide a valid Password.
        </div>
    </div>
    <div class="col-12">
        <button class="btn btn-primary" type="submit">Submit form</button>
    </div>
</form>
<div class="col-12">
    <a href="/JspFiles/sellerJsp/sellerDashboard.jsp" class="btn btn-primary" type="submit">back To seller dashboard</a>
</div>




</body>
</html>
