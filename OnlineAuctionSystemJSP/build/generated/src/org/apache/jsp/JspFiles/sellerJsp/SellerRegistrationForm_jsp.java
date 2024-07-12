package org.apache.jsp.JspFiles.sellerJsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.net.URLEncoder;
import com.app.classes.Seller;
import java.sql.*;

public final class SellerRegistrationForm_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<html>\r\n");
      out.write("    <head>\r\n");
      out.write("        <title>Seller Registration page</title>\r\n");
      out.write("        <link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css\" rel=\"stylesheet\"\r\n");
      out.write("              integrity=\"sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH\" crossorigin=\"anonymous\">\r\n");
      out.write("        <link rel=\"stylesheet\" href=\"../../CSS/SellerRegistrationForm.css\">\r\n");
      out.write("    </head>\r\n");
      out.write("    <body>\r\n");
      out.write("        ");

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
                        if (seller.saveSeller()) {
                            response.sendRedirect("/OnlineAuctionSystem/JspFiles/sellerJsp/sellerDashboard.jsp");
                        } else {
                            message = "Incorrect data";
                        }
                    } else if (password != null && confirmPassword != null) {
                        message = "Passwords do not match";
                    }
                } catch (Exception e) {
                    //message = URLEncoder.encode(e.toString(), "UTF-8");
                    message = "Login Error!";
                }
            }
            message = message == null ? "" : message; // Ensure message is not null

      out.write("\r\n");
      out.write("        <div id=\"alertContainer\"></div>\r\n");
      out.write("\r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        \r\n");
      out.write("        <div id=\"container\">\r\n");
      out.write("            <div id=\"row1\" class=\"row justify-content-center\">\r\n");
      out.write("                <div id=\"imgSection\" class=\"col-sm-4 col-md-4 col-lg-4 text-center\">\r\n");
      out.write("                    <div id=\"carouselExampleSlidesOnly\" class=\"carousel slide\" data-bs-ride=\"carousel\">\r\n");
      out.write("                        <div class=\"carousel-inner\">\r\n");
      out.write("                            <div class=\"carousel-item active\">\r\n");
      out.write("                                <img class=\"image\" src=\"../images/login-slider-1.jpeg\" alt=\"slider3\">\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"carousel-item\">\r\n");
      out.write("                                <img src=\"../images/login-slider-2.jpeg\" alt=\"slider1\">\r\n");
      out.write("                            </div>\r\n");
      out.write("                            <div class=\"carousel-item\">\r\n");
      out.write("                                <img src=\"../images/login-slider-3.jpeg\" alt=\"slider2\">\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                </div>\r\n");
      out.write("                <div id=\"loginSection\" class=\"col-sm-5 col-md-5 col-lg-5 text-center\">\r\n");
      out.write("                    <div class=\"row\">\r\n");
      out.write("                        <div class=\"col-12\">\r\n");
      out.write("                            <div class=\"mb-3\">\r\n");
      out.write("                                <div class=\"text-center mb-1\">\r\n");
      out.write("                                    <img class=\"mt-4\" src=\"../images/movie-rental-system-logo.png\" alt=\"BootstrapBrain Logo\"\r\n");
      out.write("                                         width=\"175\" height=\"25\">\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <h3 id=\"signIn\" class=\"text-start\">SIGN Up</h3>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                    </div>\r\n");
      out.write("                    <form class=\"movieRegistration needs-validation\" method=\"POST\" action=\"SellerRegistrationForm.jsp\" novalidate>\r\n");
      out.write("                        \r\n");
      out.write("                            <div id=\"row2\" class=\"row gy-3 overflow-hidden\">\r\n");
      out.write("                                <div class=\"col-6\">\r\n");
      out.write("                                    <div class=\"form-floating mb-2\">\r\n");
      out.write("                                        <input type=\"text\" class=\"form-control\" name=\"fullName\" id=\"fullName\" required>\r\n");
      out.write("                                        <label for=\"fullName\" class=\"form-label\">Full Name</label>\r\n");
      out.write("                                        <div class=\"valid-feedback\">\r\n");
      out.write("                                            Looks good!\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                        <div class=\"invalid-feedback\">\r\n");
      out.write("                                            Please choose a valid Name.\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-6\">\r\n");
      out.write("                                    <div class=\"form-floating mb-2\">\r\n");
      out.write("                                        <input type=\"email\" class=\"form-control\" name=\"birthday\" id=\"email\"  required>\r\n");
      out.write("                                        <label for=\"email\" class=\"form-label\">Email</label>\r\n");
      out.write("                                        <div class=\"valid-feedback\">\r\n");
      out.write("                                            Looks good!\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                        <div class=\"invalid-feedback\">\r\n");
      out.write("                                            Please choose a valid Email.\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-6\">\r\n");
      out.write("                                    <div class=\"form-floating mb-2\">\r\n");
      out.write("                                        <input type=\"text\" class=\"form-control\" name=\"businessName\" id=\"businessName\"  required>\r\n");
      out.write("                                        <label for=\"businessName\" class=\"form-label\">Business Name</label>\r\n");
      out.write("                                        <div class=\"valid-feedback\">\r\n");
      out.write("                                            Looks good!\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                        <div class=\"invalid-feedback\">\r\n");
      out.write("                                            Please provide a valid Business Name.\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-6\">\r\n");
      out.write("                                    <div class=\"form-floating mb-2\">\r\n");
      out.write("                                        <input type=\"tel\" class=\"form-control\" name=\"phoneNumber\" id=\"phoneNumber\"  required>\r\n");
      out.write("                                        <label for=\"phoneNumber\" class=\"form-label\">Phone Number</label>\r\n");
      out.write("                                        <div class=\"valid-feedback\">\r\n");
      out.write("                                            Looks good!\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                        <div class=\"invalid-feedback\">\r\n");
      out.write("                                            Please provide a valid Phone Number.\r\n");
      out.write("                                        </div>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-6\">\r\n");
      out.write("                                    <div class=\"form-floating mb-2\">\r\n");
      out.write("                                        <input type=\"password\" class=\"form-control\" name=\"password\" id=\"password\" value=\"\" placeholder=\"Password\" required>\r\n");
      out.write("                                        <label for=\"password\" class=\"form-label\">Password</label>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("                                <div class=\"col-6\">\r\n");
      out.write("                                    <div class=\"form-floating mb-2\">\r\n");
      out.write("                                        <input type=\"password\" class=\"form-control\" name=\"confirmPassword\" id=\"confirmPassword\" value=\"\" placeholder=\"Password\" required>\r\n");
      out.write("                                        <label for=\"confirmPassword\"  class=\"form-label\"> Confirm Password</label>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("\r\n");
      out.write("                                <div class=\"col-12\">\r\n");
      out.write("                                    <div class=\"d-grid mt-2 mb-2\">\r\n");
      out.write("                                        <button class=\"btn btn-dark btn-lg\" type=\"submit\">Sign Up now</button>\r\n");
      out.write("                                    </div>\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </form>\r\n");
      out.write("                        <div class=\"row\">\r\n");
      out.write("                            <div class=\"col-12\">\r\n");
      out.write("                                <hr class=\"w-75 mx-auto\">\r\n");
      out.write("                                <p class=\"text-center\">Or </p>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                        <div class=\"row\">\r\n");
      out.write("                            <div class=\"col-12\">\r\n");
      out.write("                                <div class=\"d-flex gap-2 gap-md-4 flex-column flex-md-row justify-content-md-center\">\r\n");
      out.write("                                    <a href=\"movieRentalSystemLogin.html\" class=\"link-secondary text-decoration-none\">Login With Existing Account</a>\r\n");
      out.write("                                </div>\r\n");
      out.write("                            </div>\r\n");
      out.write("                        </div>\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("        </div>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <form method=\"POST\" action=\"SellerRegistrationForm.jsp\" class=\"row g-3 needs-validation\" novalidate>\r\n");
      out.write("            <div class=\"col-md-4\">\r\n");
      out.write("                <label for=\"validationCustom01\" class=\"form-label\">Full name</label>\r\n");
      out.write("                <input type=\"text\" class=\"form-control\" id=\"validationCustom01\"  name=\"fullName\" required>\r\n");
      out.write("                <div class=\"valid-feedback\">\r\n");
      out.write("                    Looks good!\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"invalid-feedback\">\r\n");
      out.write("                    Please choose a valid Name.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-md-4\">\r\n");
      out.write("                <label for=\"validationCustomUsername\" class=\"form-label\">Email</label>\r\n");
      out.write("                <input type=\"email\" class=\"form-control\" id=\"validationCustomUsername\" aria-describedby=\"inputGroupPrepend\"\r\n");
      out.write("                       name=\"email\" required>\r\n");
      out.write("                <div class=\"valid-feedback\">\r\n");
      out.write("                    Looks good!\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"invalid-feedback\">\r\n");
      out.write("                    Please choose a valid Email.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-md-6\">\r\n");
      out.write("                <label for=\"validationCustom03\" class=\"form-label\">Business Name</label>\r\n");
      out.write("                <input type=\"text\" class=\"form-control\" id=\"validationCustom03\" name=\"businessName\" required>\r\n");
      out.write("                <div class=\"valid-feedback\">\r\n");
      out.write("                    Looks good!\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"invalid-feedback\">\r\n");
      out.write("                    Please provide a valid Business Name.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-md-6\">\r\n");
      out.write("                <label for=\"validationCustom03\" class=\"form-label\">Phone Number</label>\r\n");
      out.write("                <input type=\"tel\" class=\"form-control\" id=\"validationCustom04\" name=\"phoneNumber\" required>\r\n");
      out.write("                <div class=\"valid-feedback\">\r\n");
      out.write("                    Looks good!\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"invalid-feedback\">\r\n");
      out.write("                    Please provide a valid Phone Number.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-md-6\">\r\n");
      out.write("                <label for=\"validationCustom03\" class=\"form-label\">Password</label>\r\n");
      out.write("                <input type=\"password\" class=\"form-control\" id=\"validationCustom05\" name=\"password\" required>\r\n");
      out.write("                <div class=\"valid-feedback\">\r\n");
      out.write("                    Looks good!\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"invalid-feedback\">\r\n");
      out.write("                    Please provide a valid Password.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-md-6\">\r\n");
      out.write("                <label for=\"validationCustom03\" class=\"form-label\">Re-enter Password</label>\r\n");
      out.write("                <input type=\"password\" class=\"form-control\" id=\"validationCustom06\" name=\"confirmPassword\" required>\r\n");
      out.write("                <div class=\"valid-feedback\">\r\n");
      out.write("                    Looks good!\r\n");
      out.write("                </div>\r\n");
      out.write("                <div class=\"invalid-feedback\">\r\n");
      out.write("                    Please provide a valid Password.\r\n");
      out.write("                </div>\r\n");
      out.write("            </div>\r\n");
      out.write("            <div class=\"col-12\">\r\n");
      out.write("                <button class=\"btn btn-primary\" type=\"submit\">Submit form</button>\r\n");
      out.write("            </div>\r\n");
      out.write("        </form>\r\n");
      out.write("        <script>\r\n");
      out.write("            var serverMessage = \"");
      out.print( message);
      out.write("\";\r\n");
      out.write("        </script>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <script src=\"../../JS/formValidation.js\"></script>\r\n");
      out.write("        <script src=\"https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js\"\r\n");
      out.write("        integrity=\"sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz\" crossorigin=\"anonymous\"></script>\r\n");
      out.write("    </body>\r\n");
      out.write("</html>\r\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
