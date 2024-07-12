
<%@page import="com.app.classes.Seller"%>
<%@page import="java.sql.SQLException"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="../../CSS/Login.css">
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
            String email = request.getParameter("loggingEmail");
            String password = request.getParameter("loggingPassword");

            if (email != null && password != null) {
                try {
                    Seller seller = new Seller(email, password);
                    if (seller.sellerLogin()) {
                        response.sendRedirect("/OnlineAuctionSystem/JspFiles/sellerJsp/sellerDashboard.jsp");
                    } else {
                        message = "Not Matched Login Details!";
                    }
                } catch (SQLException e) {
                    message = "Error!";
                    throw new RuntimeException(e);
                }
            }
             message = message == null ? "" : message;
        %>

        <div id="alertContainer"></div>

        <div id="row1" class="row justify-content-center " >
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
                        <div class="mb-3">
                            <div class="text-center mb-4">
                                <a href="#!">

                                    <img class="mt-4" src="../images/" alt="BootstrapBrain Logo"
                                         width="175" height="25">
                                </a>
                            </div>
                            <h3 id="signIn" class="text-start">SIGN IN</h3>
                        </div>
                    </div>
                </div>
                <form method="POST" action="SellerLogin.jsp" class="row g-3 needs-validation" novalidate>
                    <div id="row2" class="row gy-3 overflow-hidden">
                        <div class="col-12">
                            <div class="form-floating mb-3">
                                <input type="email" class="form-control" name="loggingEmail" id="email" placeholder="sajanhirusha.com"
                                       required>
                                <label for="email" class="form-label">Email</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="form-floating mb-2">
                                <input type="password" class="form-control" name="loggingPassword" id="password" value=""
                                       placeholder="Password" required>
                                <label for="password" class="form-label">Password</label>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-flex flex-column flex-md-row justify-content-md-center">
                                <a href="#!" class="link-secondary text-decoration-none">Forgot password</a>
                            </div>
                        </div>
                        <div class="col-12">
                            <div class="d-grid mt-2 mb-3">
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
                        <div class="d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-center">
                            <a href="SellerRegistrationForm.jsp" class="link-secondary text-decoration-none">Create new account</a>
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
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
    </body>
</html>
