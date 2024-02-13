<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>ShopEase Register</title>
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
    <div class="container h-100">
        <div class="row d-flex justify-content-center align-items-center h-100">
            <div class="col-lg-12 col-xl-11">
                <div class="card text-black" style="border-radius: 25px;">
                    <div class="card-body p-md-5">
                        <div class="row justify-content-center">
                            <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4">Sign up</p>

                                <form class="mx-1 mx-md-4" action="register" method="post">

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="text" id="name" class="form-control" placeholder="Your Name"
                                                   name="user_name" minlength="3" maxlength="15" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="email" id="email" class="form-control" placeholder="Your Email"
                                                   name="user_email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
                                                   required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="password" id="password" class="form-control"
                                                   placeholder="Enter Password" name="user_password" minlength="8"
                                                   required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="text" id="phone" class="form-control"
                                                   placeholder="Enter Phone Number" name="user_phone" pattern="[0-9]+"
                                                   minlength="10" maxlength="10" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <textarea id="address" class="form-control"
                                                      placeholder="Enter Address" name="user_address"
                                                      required></textarea>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <p class="text-center text-muted mt-2 mb-0">Have already an account?
                                                <a href="login.jsp" class="fw-bold text-body"><u>Login here</u></a></p>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                                        <input type="submit" class="btn btn-outline-primary btn-lg" value="Register"
                                               style="margin-right: 10px">
                                        <input type="reset" class="btn btn-secondary btn-lg" value="Reset">
                                    </div>
                                </form>
                            </div>

                            <div class="col-md-10 col-lg-6 col-xl-7 d-flex align-items-center order-1 order-lg-2">
                                <img src="images/image.png"
                                     class="img-fluid" alt="Sample image">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="components/SweetAlert/sweetalert.min.js"></script>

<script>
    $(document).ready(function () {
        var status = $("#status").val();

        //display the SweetAlert message
        if (status === "success") {
            swal({
                title: 'Congratulations!',
                text: 'User Registered Successfully.',
                icon: 'success',
                button: 'Ok',
            });
        } else if (status === "failed") {
            swal({
                title: 'Oops!!',
                text: 'User is already registered.Please Login.',
                icon: 'error',
                button: 'Ok',
            });
        }
    });
</script>
<%@include file="components/footer.jsp"%>

</body>
</html>