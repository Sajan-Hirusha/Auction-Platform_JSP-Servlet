<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.app.classes.Seller"%>
<%@page import="com.app.classes.Customer"%>
<%@page import="com.app.dbConnection.DbConnection"%>

<%
    String adminId = (String) session.getAttribute("adminId");
    if (adminId == null) {
        response.sendRedirect("../LoginJsp/login.jsp");
        return;
    }
%>

<%
    List<Customer> customers = Customer.getAllCustomers(DbConnection.getConnection());
    List<Seller> sellers = Seller.getAllSellers(DbConnection.getConnection());
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
      
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              crossorigin="anonymous">
        <link rel="stylesheet" href="../../CSS/headerAndFooter.css">
          <link rel="stylesheet" href="../../CSS/AdminStyle.css">
    </head>
    <body>

        <div id="navbar-container">
            <img src="../images/logo.png" alt="logo" class="nav-img" style="width: 100px">
            <div class="nav-menu">
                <a href="../../index.html" class="nav-menu-item">Home</a>
                <a href="../../index.html#about" class="nav-menu-item">About Us</a>
                <a href="../../index.html#services" class="nav-menu-item">Our Services</a>
                <a href="../../index.html#contact" class="nav-menu-item">Contact Us</a>
            </div>

            <div>
                <a id="logout" href="../LoginJsp/logout.jsp">Logout</a>
            </div>
        </div>

        <div class="Details">
            <h3 class="tittle">Seller Details</h3>
            <div class="user-search my-3 text-center" style="margin-top: 20px;">
                <input type="text" placeholder="EX: SEL/1" id="search-seller">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
            <div class="displayDetails">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Phone number</th>
                            <th>Business Name</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="seller-table-body">
                        <%
                            if (sellers != null && !sellers.isEmpty()) {
                                for (Seller seller : sellers) {
                        %>
                        <tr>
                            <td><%= seller.getSellerID()%></td>
                            <td><%= seller.getFullName()%></td>
                            <td><%= seller.getPhoneNumber()%></td>
                            <td><%= seller.getBusinessName()%></td>
                            <td><%= seller.getEmail()%></td>
                            <td><button type="button" class="btn btn-danger" onclick="confirmDelete('<%= seller.getSellerID() %>', 'seller')">Delete</button></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6">Sellers not found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="Details">
            <h3 class="tittle">Customer Details</h3>
            <div class="user-search my-3 text-center" style="margin-top: 20px;">
                <input type="text" placeholder="EX: CUS/1" id="search-customer">
                <i class="fa-solid fa-magnifying-glass"></i>
            </div>
            <div class="displayDetails">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Phone number</th>
                            <th>Address</th>
                            <th>Email</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="customer-table-body">
                        <%
                            if (customers != null && !customers.isEmpty()) {
                                for (Customer customer : customers) {
                        %>
                        <tr>
                            <td><%= customer.getCustomerID()%></td>
                            <td><%= customer.getFullName()%></td>
                            <td><%= customer.getPhoneNumber()%></td>
                            <td><%= customer.getAddress()%></td>
                            <td><%= customer.getEmail()%></td>
                            <td><button type="button" class="btn btn-danger" onclick="confirmDelete('<%= customer.getCustomerID() %>', 'customer')">Delete</button></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="6">Customers not found.</td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div class="modal fade" id="deleteModal" tabindex="-1" aria-labelledby="deleteModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="deleteModalLabel">Confirm Delete</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        Are you sure you want to delete this item?
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        <a id="deleteConfirmBtn" href=""><button type="button" class="btn btn-danger">Delete</button></a>
                    </div>
                </div>
            </div>
        </div>

        <footer class="footer">
            Copyright &#169; <span>AuctionPulse</span>. All rights reserved.
        </footer>

        <script>
            function searchTable(inputId, tableBodyId) {
                var input = document.getElementById(inputId);
                var filter = input.value.toUpperCase();
                var tableBody = document.getElementById(tableBodyId);
                var tr = tableBody.getElementsByTagName("tr");

                for (var i = 0; i < tr.length; i++) {
                    var tdArray = tr[i].getElementsByTagName("td");
                    var found = false;
                    for (var j = 0; j < tdArray.length; j++) {
                        if (tdArray[j]) {
                            var txtValue = tdArray[j].textContent || tdArray[j].innerText;
                            if (txtValue.toUpperCase().indexOf(filter) > -1) {
                                found = true;
                                break;
                            }
                        }
                    }
                    tr[i].style.display = found ? "" : "none";
                }
            }

            document.getElementById('search-seller').addEventListener('keyup', function () {
                searchTable('search-seller', 'seller-table-body');
            });

            document.getElementById('search-customer').addEventListener('keyup', function () {
                searchTable('search-customer', 'customer-table-body');
            });

            function confirmDelete(id, type) {
                var deleteUrl;
                if (type === 'seller') {
                    deleteUrl = 'deleteSeller.jsp?id=' + id;
                } else if (type === 'customer') {
                    deleteUrl = 'deleteCustomer.jsp?id=' + id;
                }
                document.getElementById('deleteConfirmBtn').setAttribute('href', deleteUrl);
                $('#deleteModal').modal('show');
            }
        </script>
        
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
