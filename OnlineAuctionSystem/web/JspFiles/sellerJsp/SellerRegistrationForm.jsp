<%@page import="java.net.URLEncoder"%>
<%@page import="com.app.classes.Seller"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html;charset=UTF-8" %>
<%
    
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID != null) {
        response.sendRedirect("../sellerJsp/sellerDashboard.jsp");
        return;
    }
%>
<html>
    <head>
        <title>Seller Registration page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/RegistrationForm.css">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
         <link rel="stylesheet" href="../../CSS/alertBoxFailure.css">
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
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String businessName = request.getParameter("businessName");
            String phoneNumber = request.getParameter("phoneNumber");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirmPassword");
            if (fullName != null && email != null && businessName != null && phoneNumber != null && password != null && confirmPassword != null) {
                try {
                    if (password.equals(confirmPassword)) {
                        Seller seller = new Seller(fullName, email, businessName, Integer.parseInt(phoneNumber), password);
                        if (seller.saveSeller().equals("userAdded")) {
                            response.sendRedirect("../LoginJsp/login.jsp?id=0");
                        } else if (seller.saveSeller().equals("emailExists")) {
                            message = "Email Already Exists!";
                        } else {
                            message = "Incorrect data";
                        }
                    } else {
                        message = "Passwords do not match";
                    }
                } catch (Exception e) {
                    //message = URLEncoder.encode(e.toString(), "UTF-8");
                    message = "Login Error!";
                }
            }
            message = message == null ? "" : message;
        %>
        <div id="alertContainer"></div>

        <div id="navbar-container" >
            <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
            <div class="nav-menu">
                <a href="../../index.html" class="nav-menu-item">Home</a>
                <a href="../../index.html#about" class="nav-menu-item">About Us</a>
                <a href="../../index.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../index.html#contact" class="nav-menu-item">Contact Us</a>
            </div>

            <div class="dropdown mx-4 px-4" >
                <button class="btn btn-primary nav-button mx-4 w-100 z-index-1" type="button" id="dropdownMenuButton" >
                    <a href="../LoginJsp/login.jsp?id=1">OR Sign In</a>
                </button>

            </div>
        </div>


        <div id="container" class="my-5">
            <div id="row1" class="row justify-content-center">
                <div id="imgSection" class="col-sm-4 col-md-4 col-lg-4 text-center">
                    <div id="carouselExampleSlidesOnly" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <img class="image" src="../images/login-slider-1.jpeg" alt="slider3">
                            </div>
                            <div class="carousel-item">
                                <img src="../images/login-slider-2.jpeg" alt="slider1">
                            </div>
                            <div class="carousel-item">
                                <img src="../images/login-slider-3.jpeg" alt="slider2">
                            </div>
                        </div>
                    </div>
                </div>
                <div id="loginSection" class="col-sm-5 col-md-5 col-lg-5 text-center">
                    <div class="row">
                        <div class="col-12">
                            <div class="mb-3">
                                <div class="text-center mb-1">
                                    <a id="signInLogo" href="../../index.html">

                                        <img class="mt-2" src="../images/logo.png" alt="logo"
                                             width="50" height="50">
                                        AuctionPulse 
                                    </a>
                                </div>
                                <h5 id="signIn" class="text-start">SELLER SIGN UP</h5>
                            </div>
                        </div>
                    </div>
                    <form class=" needs-validation" method="POST" action="SellerRegistrationForm.jsp" novalidate>

                        <div id="row2" class="row gy-3 overflow-hidden">
                            <div class="col-6">
                                <div class="form-floating mb-2">
                                    <input type="text" class="form-control" name="fullName" id="fullName" required>
                                    <label for="fullName" class="form-label">Full Name</label>

                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating mb-2">
                                    <input type="email" class="form-control" name="email" id="email"  required>
                                    <label for="email" class="form-label">Email</label>

                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating mb-2">
                                    <input type="text" class="form-control" name="businessName" id="businessName"  required>
                                    <label for="businessName" class="form-label">Business Name</label>

                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating mb-2">
                                    <input type="tel" class="form-control" name="phoneNumber" id="phoneNumber"  required>
                                    <label for="phoneNumber" class="form-label">Phone Number</label>

                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating mb-2">
                                    <input type="password" class="form-control" name="password" id="password" value="" placeholder="Password" required>
                                    <label for="password" class="form-label">Password</label>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="form-floating mb-2">
                                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" value="" placeholder="Password" required>
                                    <label for="confirmPassword"  class="form-label"> Confirm Password</label>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="d-grid mt-2 mb-2">
                                    <button class="btn btn-dark btn-lg" type="submit">Sign Up now</button>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="row">
                        <div class="col-12">
                            <hr class="w-75 mx-auto">
                            <p class="text-center">Or </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-center">
                                <a href="../LoginJsp/login.jsp" class="link-secondary text-decoration-none">Login With Existing Account</a>
                            </div>
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
        </script>


        <script src="../../JS/formValidationWithFailure.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
       crossorigin="anonymous"></script>
    </body>
</html>
