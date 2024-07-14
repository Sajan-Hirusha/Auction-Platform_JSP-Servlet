<%@page import="com.app.classes.Seller"%>
<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.dbConnection.DbConnection" %>
<html>
    <head>
        <title>Add Item</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
         <link rel="stylesheet" href="../../CSS/alertBox.css">
    </head>
    <body>

        <%
            String message = "";
            String sellerID = (String) session.getAttribute("sellerID");
            if (sellerID == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            if ("POST".equalsIgnoreCase(request.getMethod())) {

                String itemName = request.getParameter("itemName");
                String description = request.getParameter("description");
                String category = request.getParameter("category");
                String condition = request.getParameter("condition");

                if (itemName != null && description != null && category != null && condition != null) {
                    Part filePart = request.getPart("productImage");
                    InputStream fileContent = filePart.getInputStream();
                    ByteArrayOutputStream output = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int length;
                    while ((length = fileContent.read(buffer)) != -1) {
                        output.write(buffer, 0, length);
                    }
                    byte[] fileBytes = output.toByteArray();
                    try {
                       Item newItem = new Item(description, itemName, fileBytes, condition, category, sellerID);
                        if (newItem.addItem()) {
                             message = "Item Added Successfully!";
                        } else {
                            message = "Failed to add item";
                        }
                    } catch (SQLException e) {
                        message = "Error!";
                        //throw new RuntimeException(e);
                    }
                }
            }
           
            message = message == null ? "" : message;
             System.out.println(message);
        %>

         <div id="alertContainer1"></div>
         
          <div class="col-12">
            <a href="sellerDashboard.jsp" class="btn btn-primary" type="submit">Back to seller dashboard</a>
        </div>
        <div class="container">
            <div class="row">
                <div class="col">
                    <h2>Add Item</h2>
                    <form method="post" action="" class="row g-3 needs-validation" enctype="multipart/form-data" novalidate>
                        <div class="col-md-6">
                            <label for="validationCustom01" class="form-label">Item Name</label>
                            <input type="text" class="form-control" id="validationCustom01" name="itemName" required>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Please provide a valid item name.
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="validationCustomUsername" class="form-label">Description</label>
                            <input type="text" class="form-control" id="validationCustomUsername" name="description" required>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Please provide a valid description.
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="validationCustom06" class="form-label">Category</label>
                            <select class="form-select" id="validationCustom06" name="category" required>
                                <option selected disabled value="">Choose...</option>
                                <option value="tech">Tech</option>
                                <option value="decorations">Decorations</option>
                                <option value="electronic">Electronic</option>
                            </select>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Please select a category.
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="validationCustom04" class="form-label">Condition</label>
                            <select class="form-select" id="validationCustom04" name="condition" required>
                                <option selected disabled value="">Choose...</option>
                                <option value="new">Brand New</option>
                                <option value="used">Used</option>
                            </select>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Please select a condition.
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="validationCustom05" class="form-label">Upload Image</label>
                            <input type="file" class="form-control" id="validationCustom05" name="productImage" accept="image/*" required>
                            <div class="valid-feedback">
                                Looks good!
                            </div>
                            <div class="invalid-feedback">
                                Please upload an image.
                            </div>
                        </div>
                        <div class="col-12">
                            <button class="btn btn-primary" type="submit">Submit</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            var serverMessage = "<%= message%>";
        </script>
      <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
