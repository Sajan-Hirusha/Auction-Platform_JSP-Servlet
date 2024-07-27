
<%@page import="com.app.classes.Customer"%>
<%@page import="com.app.classes.Seller"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String customerID = (String) session.getAttribute("customerID");
    if (customerID != null) {
        response.sendRedirect("../customerJsp/customerDashboard.jsp");
        return;
    }
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID != null) {
        response.sendRedirect("../sellerJsp/sellerDashboard.jsp");
        return;
    }
%>
<html>
    <head>
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="../../CSS/Login.css">
        <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
        <link rel="stylesheet" href="../../CSS/alertSuccess.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">

        <style>
            #imgSection img{
                height: 100%;
                width: 100%;
                object-fit: cover;
            }

        </style>
    </head>
    <body>
        <%
            String message = "";
            String message1 = "";
            String id = request.getParameter("id");
            if ("0".equals(id)) {
                message1 = "You Successfully Registered!";
            }

            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String email = request.getParameter("loggingEmail");
                String password = request.getParameter("loggingPassword");
                String position = request.getParameter("position");
                if (email != null && password != null && position != null) {
                    try {
                        if ("admin".equals(position)) {

                        } else if ("seller".equals(position)) {
                            Seller seller = new Seller(email, password);
                            if (seller.sellerLogin()) {
                                System.out.println(seller.getSellerID());
                                session.setAttribute("sellerID", seller.getSellerID());
                                response.sendRedirect(request.getContextPath() + "/JspFiles/sellerJsp/sellerDashboard.jsp");
                                return;
                            } else {
                                message = "Not Matched Login Details!";
                            }
                        } else if ("customer".equals(position)) {
                            Customer customer = new Customer(email, password);
                            if (customer.customerLogin()) {
                                System.out.println(customer);
                                session.setAttribute("customerID", customer.getCustomerID());
                                response.sendRedirect("../customerJsp/customerDashboard.jsp");
                            } else {
                                message = "Not Matched Login Details!";
                            }
                        } else {
                            message = "Invalid position!";
                        }
                    } catch (SQLException e) {
                        message = "Error!";
                        throw new RuntimeException(e);
                    }
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
                <a href="../../index.html" class="nav-menu-item">Home</a>
                <a href="../../index.html#about" class="nav-menu-item">About Us</a>
                <a href="../../index.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../index.html#contact" class="nav-menu-item">Contact Us</a>
            </div>

            <div class="dropdown mx-4 px-4" >
                <button class="btn btn-primary dropdown-toggle nav-button mx-4 w-100" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
                    OR Sign Up
                </button>
                <ul class="dropdown-menu " aria-labelledby="dropdownMenuButton" >
                    <li><a class="dropdown-item" href="../customerJsp/customerRegistrationForm.jsp" >Customer</a></li>
                    <li><a class="dropdown-item" href="../sellerJsp/SellerRegistrationForm.jsp">Seller</a></li>
                </ul>
            </div>
        </div>

        <div id="row1" class="row justify-content-center my-5" >
            <div id="imgSection" class=" col-sm-4 col-md-4 col-lg-4 text-center">
                <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
                    <div class="carousel-inner">
                        <div class="carousel-item active">
                            <img  src="../images/login-slider-1.jpeg" alt="slider1" >
                        </div>
                        <div class="carousel-item">
                            <img src="../images/login-slider-2.jpeg" alt="slider2" >
                        </div>
                        <div class="carousel-item">
                            <img src="../images/login-slider-3.jpeg" alt="slider3" >
                        </div>
                    </div>
                </div>
            </div>
            <div id="loginSection" class="col-sm-5 col-md-5 col-lg-5 text-center">
                <div class="row">
                    <div class="col-12">
                        <div class="mb-2">
                            <div class="text-center mb-2">
                                <a id="signInLogo" href="../../index.html">

                                    <img class="mt-2" src="../images/logo.png" alt="logo"
                                         width="50" height="50">
                                    AuctionPulse 
                                </a>
                            </div>
                            <h3 id="signIn" class="text-start">SIGN IN</h3>
                        </div>
                    </div>
                </div>
                <form method="POST" action="login.jsp" class="row g-3 needs-validation" novalidate>
                    <div id="row2" class="row gy-3 overflow-hidden">
                        <div class="col-12">
                            <div class="form-floating mb-0">
                                <input type="email" class="form-control" name="loggingEmail" id="email" placeholder="sajanhirusha.com"
                                       required>
                                <label for="email" class="form-label">Email</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating mb-0">
                                <input type="password" class="form-control" name="loggingPassword" id="password" value=""
                                       placeholder="Password" required>
                                <label for="password" class="form-label">Password</label>
                            </div>
                        </div>
                        <div class="col-md-12">
                            <div class="form-floating mb-0">
                                <select class="form-select" id="position" name="position" required>
                                    <option selected disabled value="">Choose...</option>
                                    <option value="admin">Administrator</option>
                                    <option value="seller">Seller</option>
                                    <option value="customer">Customer</option>
                                </select>
                                <label for="position" class="form-label">Position</label>
                            </div>

                        </div>
                        <div class="col-12">
                            <div class="d-flex flex-column flex-md-row justify-content-md-center">
                                <a href="#!" class="link-secondary text-decoration-none">Forgot password</a>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-grid">
                                <button class="btn btn-dark btn-lg" type="submit">Log in now</button>
                            </div>
                        </div>
                    </div>
                </form>
                <div class="row">
                    <div class="col-12">
                        <hr class="w-75  mx-auto">
                        <p class="text-center ">Or </p>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="d-flex gap-0  flex-column flex-md-row justify-content-md-center">
                            Create new account? 
                            <a href="../sellerJsp/SellerRegistrationForm.jsp" class="link-secondary text-decoration-none backToRegistration mx-2">Seller /</a>
                            <a href="../customerJsp/customerRegistrationForm.jsp" class="link-secondary text-decoration-none backToRegistration mx-2">Customer</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">
            Copyright &#169; <span>AuctionHub</span>. All rights reserved.
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
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    </body>
</html>
