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
<form method="post" action="/OnlineAuctionSystem/updateListing" class="row g-3 needs-validation" enctype="multipart/form-data" novalidate>
    <div class="col-md-4">
        <label for="validationCustom06" class="form-label">Item ID</label>
        <input type="text" class="form-control" id="validationCustom08"  name="itemIDDisabled" value="<%=item != null ? item.getItemId() : ""%>" disabled required>
        <input type="hidden" class="form-control" id="validationCustom06"  name="itemID" value="<%=item != null ? item.getItemId() : ""%>" required>
    </div>
    <div class="col-md-4">
        <label for="validationCustom01" class="form-label">Edit Item Name</label>
        <input type="text" class="form-control" id="validationCustom01"  name="updateItemName" value="<%=item != null ? item.getItemName() : ""%>" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid .
        </div>
    </div>
    <div class="col-md-4">
        <label for="validationCustomUsername" class="form-label">Edit Description</label>
        <input type="text" class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend"
               name="updateDescription" value="<%=item != null ? item.getDescription() : ""%>" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid Email.
        </div>
    </div>
    <div class="col-md-3">
        <label for="validationCustom07" class="form-label">Select Category</label>
        <select class="form-select" id="validationCustom07" name="updateCategory" required>
            <option selected disabled value="">Choose...</option>
            <option value="tech" <%= item != null && "Tech".equals(item.getCategory()) ? "selected" : ""%>>Tech</option>
            <option value="home" <%= item != null && "Home".equals(item.getCategory()) ? "selected" : ""%>>Home</option>
            <option value="electronic">Electronic</option>
        </select>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please select a valid condition.
        </div>
    </div>
    <div class="col-md-3">
        <label for="validationCustom04" class="form-label">Edit Condition</label>
        <select class="form-select" id="validationCustom04" name="updateCondition" required>
            <option selected disabled value="">Choose...</option>
            <option value="new" <%= item != null && "new".equals(item.getCondition()) ? "selected" : ""%>>Brand New</option>
            <option value="used" <%= item != null && "used".equals(item.getCondition()) ? "selected" : ""%>>Used</option>
        </select>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please select a valid condition.
        </div>
    </div>

    <%--    chose image option--%>
    <div class="md-3">
        <img style="height: 100px; width: 100px;" src="<%= request.getContextPath() %>/productImages/<%= item.getItemImageUrl() %>">
        <label for="validationCustom05" class="form-label">Edit Image </label>
        <input type="file" name="updateProductImage" accept="image/*" id="validationCustom05" />
        <input type="hidden"   name="previousImageName" value="<%=item.getItemImageUrl()%>"  />
        <div class="invalid-feedback">Please upload a image file.</div>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please select a valid image.
        </div>
    </div>
    <div class="col-12">
        <button class="btn btn-primary" type="submit">Submit form</button>
    </div>
</form>
<div class="col-12">
    <a href="../../viewListingsForUpdateAndDelete?id=update" class="btn btn-primary" type="submit">back To Update</a>
</div>



<script src="../../JS/formValidation.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
