<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>ShopEase Sign-In</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="components/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="components/jquery/code.jquery.com_jquery-3.6.0.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_jquery.validate.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_additional-methods.min.js"></script>

</head>
<body>
<%@ include file="components/navbar.jsp" %>
<% String status = (String) request.getAttribute("status"); %>
<input type="hidden" id="status" value="<%= status %>">

<section>
    <div class="container">
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-lg-12 col-xl-11">
                <div class="card text-black" style="border-radius: 25px;">
                    <div class="card-body p-md-5">
                        <div class="row justify-content-center">
                            <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Sign in</p>

                                <%-- sign-in form--%>
                                <form class="mx-1 mx-md-4" method="post" action="login">

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="email" id="form3Example3c" name="email" class="form-control"
                                                   placeholder="Your Email"
                                                   pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="password" id="form3Example4c" name="password"
                                                   class="form-control" placeholder="Enter Password" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4">
                                        <button type="submit" class="btn btn-outline-primary btn-lg">Login</button>
                                    </div>

                                    <%-- forgot password link--%>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0 text-center text-muted mt-2 mb-0">
                                            <a href="forgotpassword.jsp" class="fw-bold text-body"><u>Forgot
                                                Password?</u>
                                            </a>
                                        </div>
                                    </div>

                                    <%-- register link--%>
                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <p class="text-center text-muted mt-3 mb-0">Don't have an account?
                                                <a href="register.jsp" class="fw-bold text-body"><u>Register
                                                    here</u>
                                                </a>
                                            </p>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                <img src="images/image.png" class="img-fluid" alt="Sample image">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%@include file="components/common_modal.jsp" %>
<script src="js/style.js"></script>
<%@include file="components/footer.jsp" %>
<script src="components/SweetAlert/sweetalert.min.js"></script>

<script>
    $(document).ready(function () {
        var status = $("#status").val();
        if (status === "failed") {
            //display the SweetAlert message
            swal({
                title: 'Oops!',
                text: 'Invalid email or password. Please try again.',
                icon: 'error',
                button: 'Ok',
            });
        }
    });
</script>
</body>
</html>