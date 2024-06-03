<%--
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

<form method="post" action="/saveSellerData" class="row g-3 needs-validation" novalidate>
    <div class="col-md-4">
        <label for="validationCustom01" class="form-label">Item Name</label>
        <input type="text" class="form-control" id="validationCustom01"  name="itemName" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid Name.
        </div>
    </div>
    <div class="col-md-4">
        <label for="validationCustomUsername" class="form-label">Description</label>
        <input type="text" class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend"
               name="description" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid Email.
        </div>
    </div>
    <div class="col-md-3">
        <label for="validationCustom04" class="form-label">Select Condition</label>
        <select class="form-select" id="validationCustom04" name="condition"required>
            <option selected disabled value="">Choose...</option>
            <option value="new">Brand New</option>
            <option value="used">Used</option>
        </select>
        <div class="invalid-feedback">
            Please select a valid state.
        </div>
    </div>

<%--    chose image option--%>
    <div class="col-12">
        <button class="btn btn-primary" type="submit">Submit form</button>
    </div>
</form>




<script src="../JS/formValidation.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
