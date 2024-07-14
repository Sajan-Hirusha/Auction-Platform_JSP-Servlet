<%@page import="com.app.classes.Customer"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html;charset=UTF-8" %>

<html>
    <head>
        <title>Seller Registration page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/SellerRegistrationForm.css">

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
            if ("POST".equalsIgnoreCase(request.getMethod())) {

                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                String address = request.getParameter("address");
                int phoneNumber = Integer.parseInt(request.getParameter("phoneNumber"));
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");
                if (fullName != null && email != null && address != null && password != null && confirmPassword != null) {
                    try {
                        if (password.equals(confirmPassword)) {
                            Customer customer = new Customer(fullName, email, address, phoneNumber, password);
                            if (customer.saveCustomer().equals("userAdded")) {
                                response.sendRedirect("customerDashboard.jsp");
                            } else if (customer.saveCustomer().equals("emailExists")) {
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
            }
            message = message == null ? "" : message;
        %>
        <div id="alertContainer"></div>

        <div id="container">
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
                                    <img class="mt-4" src="../images/movie-rental-system-logo.png" alt="BootstrapBrain Logo"
                                         width="175" height="25">
                                </div>
                                <h3 id="signIn" class="text-start">SIGN Up</h3>
                            </div>
                        </div>
                    </div>
                    <form class=" needs-validation" method="POST" action="" novalidate>

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
                                    <input type="text" class="form-control" name="address" id="address"  required>
                                    <label for="address" class="form-label">Address</label>

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




        <script>
            var serverMessage = "<%= message%>";
        </script>

        <script src="../../JS/formValidation.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    </body>
</html>
