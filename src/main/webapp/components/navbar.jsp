<%@ page import="com.example.ecommerce.entities.User" %>
<%
    User user1 = (User) session.getAttribute("current-user");

%>

<html>
<head>
    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
          integrity="sha512-DTOQO9RWCH3ppGqcWaEA1BIZOC6xxalwEsw9c2QQeAIftl+Vegovlnee1c9QX4TctnWMn13TZye+giMm8e2LwA=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <script src="components/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="components/jquery/code.jquery.com_jquery-3.6.0.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_jquery.validate.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_additional-methods.min.js"></script>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark custom-bg">
    <div class="container-fluid">
        <a class="navbar-brand" href="index.jsp">
            <img src="images/logo.png" alt="Logo" width="90"
                 height="74" class="d-inline-block align-text-top">
        </a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active text-dark" aria-current="page" href="index.jsp">Home</a>
                </li>

            </ul>

            <ul class="navbar-nav ml-auto">

                <li class="nav-item active">
                    <a class="nav-link active text-dark" href="#!" data-bs-toggle="modal" data-bs-target="#cart"> <i
                            class="fa-solid fa-cart-plus" style="font-size: 26px"></i> <span
                            class="cart-items">(0)</span> </a>
                </li>

                <%-- if user is not logged in--%>
                <%
                    if (user1 == null) {
                %>
                <li class="nav-item active">
                    <a class="nav-link active text-dark" href="login.jsp">Login</a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link active text-dark" href="register.jsp">Register</a>
                </li>

                <% } else {
                %>

                <%-- if user is logged in--%>
                <li class="nav-item active">
                    <a class="nav-link active text-dark"
                       href="<%= user1.getUserType().equals("admin") ? "admin.jsp" : "normaluser.jsp" %>"><%= user1.getUserName()%>
                    </a>
                </li>

                <li class="nav-item active">
                    <a class="nav-link active text-dark" href="logout">Logout</a>
                </li>

                <% }
                %>

            </ul>
        </div>
    </div>
</nav>
</body>
</html>