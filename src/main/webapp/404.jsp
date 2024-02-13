<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true" %>
<html>
<head>
    <title>Sorry ! Page not found.</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="components/bootstrap/bootstrap.bundle.min.js"></script>
</head>
<body>
<%@include file="components/navbar.jsp"%>

<div class="container p-3 text-center">
    <img src="images/404_page_cover.jpg" class="img-fluid">
    <h1>Sorry ! Page not found.</h1>
    <a class="btn btn-outline-primary" href="index.jsp">Home Page</a>
</div>
<%@include file="components/footer.jsp"%>
</body>
</html>