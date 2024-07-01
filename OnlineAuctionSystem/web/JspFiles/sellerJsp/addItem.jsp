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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>

<form method="post" action="/OnlineAuctionSystem/addListing" class="row g-3 needs-validation" enctype="multipart/form-data" novalidate>
    <div class="col-md-4">
        <label for="validationCustom01" class="form-label">Item </label>
        <input type="text" class="form-control" id="validationCustom01"  name="itemName" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid .
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
        <label for="validationCustom06" class="form-label">Select Category</label>
        <select class="form-select" id="validationCustom06" name="category"required>
            <option selected disabled value="">Choose...</option>
            <option value="tech">Tech</option>
            <option value="home">Home</option>
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
        <label for="validationCustom04" class="form-label">Select Condition</label>
        <select class="form-select" id="validationCustom04" name="condition"required>
            <option selected disabled value="">Choose...</option>
            <option value="new">Brand New</option>
            <option value="used">Used</option>
        </select>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please select a valid condition.
        </div>
    </div>

    <div class="md-3">
        <label for="validationCustom05" class="form-label">Choose Image to upload</label>
        <input type="file" class="form-control" aria-label="file example" name="productImage"
               accept="image/*" id="validationCustom05" required />
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
    <a href="../../viewActiveListings" class="btn btn-primary" type="submit">back To seller dashboard</a>
</div>



<script src="../../JS/formValidation.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
