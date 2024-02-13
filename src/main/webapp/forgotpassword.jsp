<% String status = (String) request.getAttribute("status");%>
<input type="hidden" id="status" value="<%= status %>">

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Forgot Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="components/bootstrap/bootstrap.bundle.min.js"></script>
    <script src="components/jquery/code.jquery.com_jquery-3.6.0.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_jquery.validate.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_additional-methods.min.js"></script>
</head>
<body>
<%@include file="components/navbar.jsp" %>
<section>
    <div class="container">
        <div class="row d-flex justify-content-center align-items-center">
            <div class="col-lg-12 col-xl-11">
                <div class="card text-black" style="border-radius: 25px;">
                    <div class="card-body p-md-5">
                        <div class="row justify-content-center">
                            <div class="col-md-10 col-lg-6 col-xl-5 order-2 order-lg-1">

                                <p class="text-center h1 fw-bold mb-5 mx-1 mx-md-4 mt-4">Change Password</p>

                                <%-- form for password change--%>
                                <form class="mx-1 mx-md-4" method="post" action="forgotPassword" id="forgot">

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="email" id="form3Example3c" name="email" class="form-control"
                                                   placeholder="Your Email"
                                                   pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="password" id="pass" name="pass" class="form-control"
                                                   placeholder="Enter New Password" minlength="8" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex flex-row align-items-center mb-4">
                                        <div class="form-outline flex-fill mb-0">
                                            <input type="password" id="cpass" name="cpass" class="form-control"
                                                   placeholder="Repeat New Password" minlength="8" required/>
                                        </div>
                                    </div>

                                    <div class="d-flex justify-content-center mx-4">
                                        <button type="submit" class="btn btn-outline-primary btn-lg" href="index.jsp"
                                                style="margin-right: 10px">Save
                                        </button>
                                        <a href="index.jsp" class="btn btn-secondary btn-lg">Cancel</a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<%@include file="components/footer.jsp" %>
<script src="components/SweetAlert/sweetalert.min.js"></script>
<script>
    $(document).ready(function () {
        //validate password confirmation
        $("#forgot").validate({
            rules: {
                cpass: {
                    equalTo: "#pass",
                }
            }
        });

        //handle status messages
        var status = $("#status").val();
        if (status === "success") {
            //display success message if password changed successfully
            swal({
                title: 'Success',
                text: 'Password changed successfully!',
                icon: 'success',
                button: 'Ok',
            }).then(() => {
                //redirect to login page
                window.location.href = 'login.jsp';
            });
        } else if (status === "failed") {
            //display error message if user doesn't exist
            swal({
                title: 'Oops!!',
                text: 'User with this email does not exist.',
                icon: 'error',
                button: 'Ok',
            });
        }
    });
</script>
</body>
</html>