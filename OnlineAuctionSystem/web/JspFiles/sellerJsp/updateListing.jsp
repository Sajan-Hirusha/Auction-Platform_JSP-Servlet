<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page import="com.app.classes.Item" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Update</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
        <script src="../../JS/formValidation.js"></script>
        <link rel="stylesheet" href="../../CSS/UpdateItem.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">


    </head>
    <body>

        <%
            String message = "";
            String message1 = "";
            String id = request.getParameter("id");
            Item item = new Item().getItem(id);

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String itemId = request.getParameter("itemID");
                String itemName = request.getParameter("updateItemName");
                String description = request.getParameter("updateDescription");
                String category = request.getParameter("updateCategory");
                String condition = request.getParameter("updateCondition");
                String previousImageName = request.getParameter("previousImageName");

                byte[] fileBytes = null;
                Part filePart = request.getPart("updateProductImage");
                if (filePart != null && filePart.getSize() > 0) {

                    InputStream fileContent = filePart.getInputStream();
                    ByteArrayOutputStream output = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = fileContent.read(buffer)) != -1) {
                        output.write(buffer, 0, length);
                    }
                    fileBytes = output.toByteArray();
                } else {
                    fileBytes = item.getItemImage();
                }

                item.setItemId(itemId);
                item.setItemName(itemName);
                item.setDescription(description);
                item.setCategory(category);
                item.setCondition(condition);
                item.setItemImage(fileBytes);

                try {
                    if (item.updateItem()) {
                        message1 = "Item Update successfully! ";
                    } else {
                        message = "Failed to update item";
                    }
                } catch (Exception e) {
                    message = "Failed to update item";
                }
            }
            message = message == null ? "" : message;
            message1 = message1 == null ? "" : message1;
        %>
        <div id="alertContainer"></div>
        <div id="alertContainer1"></div>

        <div id="navbar-container" >
            <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
            <div class="nav-menu">
                <a href="../../home.html" class="nav-menu-item">Home</a>
                <a href="../../home.html#about" class="nav-menu-item">About Us</a>
                <a href="../../home.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../home.html#contact" class="nav-menu-item">Contact Us</a>
            </div>

            <div >
                <a id="logout" href="../LoginJsp/logout.jsp">Logout</a>
            </div>

        </div>
        <div id="main">
            <div class="col-12">
                <a href="viewItems.jsp" class="btn btn-primary backButton" type="submit">back To Update</a>
            </div>
            <div class="container mt-5 col-6" >

                <form method="post" action="" class="row g-3 needs-validation" enctype="multipart/form-data" novalidate>
                    <h1>Update form</h1>

                    <div class="md-6  updateImage">
                        <label for="validationCustom05" class="form-label ">Edit Image </label><br>
                        <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                        <img style="height: 100px; width: 100px;" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                        <% } else { %>
                        No Image
                        <% }%>
                        <input class="mx-5" type="file" name="updateProductImage" accept="image/*" id="validationCustom05"/>
                        <div class="invalid-feedback">Please upload a image file.</div>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                        <div class="invalid-feedback">
                            Please select a valid image.
                        </div>
                    </div>

                    <div class="col-md-6">
                        <label for="validationCustom06" class="form-label">Item ID</label>
                        <input type="text" class="form-control" id="validationCustom08" name="itemIDDisabled"
                               value="<%=item != null ? item.getItemId() : ""%>" disabled required>
                        <input type="hidden" class="form-control" id="validationCustom06" name="itemID"
                               value="<%=item != null ? item.getItemId() : ""%>" required>
                    </div>
                    <div class="col-md-6">
                        <label for="validationCustom01" class="form-label">Edit Item Name</label>
                        <input type="text" class="form-control" id="validationCustom01" name="updateItemName"
                               value="<%=item != null ? item.getItemName() : ""%>" required>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                        <div class="invalid-feedback">
                            Please choose a valid .
                        </div>
                    </div>
                    <div class="col-md-12">
                        <label for="validationCustomUsername" class="form-label">Edit Description</label>
                        <textarea class="form-control" id="validationCustomUsername" aria-describedby="inputGroupPrepend"
                                  rows="3" name="updateDescription" value="<%=item != null ? item.getDescription() : ""%>" required>
                        </textarea>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                        <div class="invalid-feedback">
                            Please choose a valid Email.
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label for="validationCustom07" class="form-label">Edit Category</label>
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
                    <div class="col-md-6">
                        <label for="validationCustom04" class="form-label">Edit Condition</label>
                        <select class="form-select" id="validationCustom04" name="updateCondition" required>
                            <option selected disabled value="">Choose...</option>
                            <option value="new" <%= item != null && "new".equals(item.getCondition()) ? "selected" : ""%>>Brand New
                            </option>
                            <option value="used" <%= item != null && "used".equals(item.getCondition()) ? "selected" : ""%>>Used
                            </option>
                        </select>
                        <div class="valid-feedback">
                            Looks good!
                        </div>
                        <div class="invalid-feedback">
                            Please select a valid condition.
                        </div>
                    </div>
                    <div class="mt-4">
                        <div class="col-12">
                            <button class="btn btn-primary float-end" type="submit">Submit form</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <footer class="footer" >
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>
        <script>
            var serverMessage = "<%= message%>";
            var serverMessage1 = "<%= message1%>";

            if (serverMessage1 !== "" && serverMessage1 !== null) {
                document.write('<script src="../../JS/formvalidationWithSuccessAlert.js"><\/script>');
            } else if (serverMessage !== "" && serverMessage !== null) {
                document.write('<script src="../../JS/formValidationWithFailure.js"><\/script>');
            } else {
                document.write('<script src="../../JS/formValidationWithFailure.js"><\/script>'); // Default behavior
            }
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>

    </body>
</html>



























