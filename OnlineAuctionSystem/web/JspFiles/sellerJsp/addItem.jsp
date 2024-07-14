<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.app.classes.Item" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.io.*" %>
<%@ page import="java.nio.file.*" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.http.Part" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.app.dbConnection.DbConnection" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<html>
<head>
    <title>Add Item</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="../../CSS/AddItem.css">
</head>
<body>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String itemName = request.getParameter("itemName");
        String description = request.getParameter("description");
        String category = request.getParameter("category");
        String condition = request.getParameter("condition");
        String sellerID = "SEL/1";

        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DbConnection.getConnection();
            String sql = "INSERT INTO item (itemId,description, itemName, itemImageUrl, itemCondition, categoryID, Seller_sellerID) VALUES (1,?, ?, ?, ?, ?, ?)";
            statement = connection.prepareStatement(sql);

            statement.setString(1, description);
            statement.setString(2, itemName);
            statement.setString(4, condition);
            statement.setString(5, category);
            statement.setString(6, sellerID);

            Part filePart = request.getPart("productImage");
            if (filePart != null) {
                InputStream fileContent = filePart.getInputStream();
                statement.setBinaryStream(3, fileContent);
            }

            int rowsInserted = statement.executeUpdate();
            if (rowsInserted > 0) {
                response.sendRedirect(request.getContextPath() + "/JspFiles/sellerJsp/addItem.jsp");
            } else {
                response.sendRedirect("../../error.jsp?message=" + "Failed to add item");
            }
        } catch (Exception e) {
            response.sendRedirect("../../error.jsp?message=" + URLEncoder.encode(e.toString(), "UTF-8"));
        } finally {
            // Close resources
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException ex) {
                response.sendRedirect("../../error.jsp?message=" + URLEncoder.encode(ex.toString(), "UTF-8"));
            }
        }
    }
%>
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
                        <option value="home">Home</option>
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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
</body>
</html>
