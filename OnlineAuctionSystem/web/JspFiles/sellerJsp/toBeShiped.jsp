<%@page import="com.app.classes.EmailSender"%>
<%@page import="com.app.classes.ItemWinnerDetails"%>
<%@page import="com.app.classes.Auction"%>
<%@ page import="java.util.List" %>

<%
    String message = "";
    String sellerID = (String) session.getAttribute("sellerID");
    if (sellerID == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
         String auctionID = request.getParameter("auctionID");
        String mailMessage = "Your Item Shiped Now.";
        String subject = "Confirmation of item shiped";
        EmailSender.sendEmail(email, subject, mailMessage);
      
        if(new Auction().itemShiped(auctionID)){
            message="Item Shiped Successfully";
        }
    }
    message = message == null ? "" : message;
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Item and Winner Details</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid black;
            }
            th, td {
                padding: 15px;
                text-align: left;
            }
        </style>
         <link rel="stylesheet" href="../../CSS/alertBox.css">
    </head>
    <body>
        <div id="alertContainer1"></div>
        
        <h2>Item and Winner Details</h2>
        <table>
            <thead>
                <tr>
                    <th>Item ID</th>
                    <th>Item Name</th>
                    <th>Item Image</th>
                    <th>Winning Price</th>
                    <th>Winner Name</th>
                    <th>Winner address</th>
                    <th>Winner Phone Number</th>
                </tr>
            </thead>
            <tbody>
                <%
                    Auction dataFetcher = new Auction();
                    List<ItemWinnerDetails> itemsWithWinners = dataFetcher.itemToBeShiped(sellerID);
                    System.out.println(sellerID);
                    for (ItemWinnerDetails item : itemsWithWinners) {
                        System.out.println(item.getItemId());
                %>
                <tr>
                    <td><%= item.getItemId()%></td>
                    <td><%= item.getItemName()%></td>
                    <td> <% if (item.getBase64Image() != null && !item.getBase64Image().isEmpty()) {%>
                        <img alt="Item Image" width="100" height="100" src="data:image/jpeg;base64,<%= item.getBase64Image()%>">
                        <% } else { %>
                        No Image
                        <% }%> </td>
                    <td><%= item.getBidAmount()%></td>
                    <td><%= item.getFullName()%></td>
                    <td><%= item.getAddress()%></td>
                    <td><%= item.getPhoneNo()%></td>
                    <td>
                        <form method="post">
                            <input type="hidden" name="email" value="<%= item.getEmail()%>">
                            <input type="hidden" name="auctionID" value="<%= item.getAuctionID() %>">
                            <button type="submit" class="btn btn-success" name="buyNow">Shiped Now</button>
                        </form>
                    </td> 
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
            
            
             <script>
            var serverMessage = "<%= message%>";
        </script>
      <script src="../../JS/formvalidationWithSuccessAlert.js"></script>
    </body>
</html>
