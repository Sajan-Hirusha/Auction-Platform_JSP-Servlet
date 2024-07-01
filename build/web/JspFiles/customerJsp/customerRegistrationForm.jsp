
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Seller Registration page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body>
<form method="post" action="/OnlineAuctionSystem/saveCustomerData" class="row g-3 needs-validation" novalidate>
    <div class="col-md-4">
        <label for="validationCustom01" class="form-label">Full name</label>
        <input type="text" class="form-control" id="validationCustom01"  name="fullName" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please choose a valid Name.
        </div>
    </div>
    <div class="col-md-4">
        <label for="validationCustomUsername" class="form-label">Email</label>
            <input type="email" class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend"
                   name="email" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
                Please choose a valid Email.
            </div>
    </div>
    <div class="col-md-6">
        <label for="validationCustom03" class="form-label">Address</label>
        <input type="text" class="form-control" id="validationCustom03" name="address" required>
        <div class="valid-feedback">
            Looks good!
        </div>
        <div class="invalid-feedback">
            Please provide a valid Address.
        </div>
    </div>
    <div class="col-md-6">
        <label for="validationCustom03" class="form-label">Phone Number</label>
        <input type="tel" class="form-control" id="validationCustom04" name="phoneNumber" required>
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
    <div class="col-12">
        <button class="btn btn-primary" type="submit">Submit form</button>
    </div>
</form>







<script src="../../JS/formValidation.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>
