<%@page import="com.app.classes.EmailSender"%>
<!DOCTYPE html>
<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String name = request.getParameter("MsgName");
        String message = request.getParameter("Message");
        String senderEmail = request.getParameter("MsgEmail");
        message = " Name: " + name + "\n From: " + senderEmail + "\n message: " + message;
        String subject = "Contact Form";
        if (EmailSender.sendEmail("sajanhirusha12@gmail.com", subject, message)) {
%>
<script>
    alert("Your Message Sent Successfully.");
    window.location.href = "index.html";
</script>
<%
        }
    }
%>
