<%--
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
</head>
<body>

<div class="col-md-6">
    <label for="validationCustom03" class="form-label">Select starting Date And Starting Time</label>
    <input type="datetime-local" class="form-control" id="validationCustom03" name="startingTime" required>
    <div class="valid-feedback">
        Looks good!
    </div>
    <div class="invalid-feedback">
        Please provide a valid Address.
    </div>
</div>
<div class="col-md-6">
    <label for="validationCustom03" class="form-label">Select starting Date And Starting Time</label>
    <input type="datetime-local" class="form-control" id="validationCustom04" name="endTime" required>
    <div class="valid-feedback">
        Looks good!
    </div>
    <div class="invalid-feedback">
        Please provide a valid Address.
    </div>
</div>
<div class="col-md-6">
    <label for="validationCustom03" class="form-label">Password</label>
    <input type="password" class="form-control" id="validationCustom05" name="password" required>
    <div class="valid-feedback">
        Looks good!
    </div>
    <div class="invalid-feedback">
        Please provide a valid Password.
    </div>
</div>
<div class="col-md-6">
    <label for="validationCustom03" class="form-label">Re_Enter Password</label>
    <input type="password" class="form-control" id="validationCustom06" name="confirmPassword" required>
    <div class="valid-feedback">
        Looks good!
    </div>
    <div class="invalid-feedback">
        Please provide a valid Password.
    </div>
</div>
</body>
</html>
