<%@ page import="com.example.ecommerce.entities.User" %>

<%

    //retrieve the current user from the session
    User user = (User) session.getAttribute("current-user");

    //if the user is not logged in, redirect to the login page
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

%>

<%
    //set cache control headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
%>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Checkout</title>
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


<div class="container-fluid">
    <div class="row mb-3">

        <div class="col-md-6 mt-3">
            <%-- display selected items in cart --%>
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mb-5">Your Selected Items.</h3>
                    <div class="cart-body">

                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6 mt-3">
            <%-- form for user details--%>
            <div class="card">
                <div class="card-body">
                    <h3 class="text-center mb-5">Your Details For Order.</h3>
                    <form action="">

                        <div class="d-flex flex-row align-items-center mb-4">
                            <div class="form-outline flex-fill mb-0">
                                <input value="<%= user.getUserEmail() %>" type="email" id="email" class="form-control"
                                       placeholder="Your Email"
                                       name="user_email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$"
                                       required/>
                            </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-4">
                            <div class="form-outline flex-fill mb-0">
                                <input value="<%= user.getUserName() %>" type="text" id="name" class="form-control"
                                       placeholder="Your Name"
                                       name="user_name" minlength="3" maxlength="15" required/>
                            </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-4">
                            <div class="form-outline flex-fill mb-0">
                                <input value="<%= user.getUserPhone() %>" type="text" id="phone" class="form-control"
                                       placeholder="Enter Phone Number" name="user_phone" pattern="[0-9]+"
                                       minlength="10" maxlength="10" required/>
                            </div>
                        </div>

                        <div class="d-flex flex-row align-items-center mb-4">
                            <div class="form-outline flex-fill mb-0">
                                            <textarea style="height: 150px" id="address" class="form-control"
                                                      placeholder="Enter Your Shipping Address" name="user_address"
                                                      required>
                                                <%= user.getUserAddress() %>
                                            </textarea>
                            </div>
                        </div>

                        <div class="d-flex justify-content-center mx-4 mb-3 mb-lg-4">
                            <input type="submit" class="btn btn-outline-success place-order" value="Place Order">
                        </div>
                    </form>

                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="components/common_modal.jsp" %>
<script src="js/style.js"></script>
<script src="components/SweetAlert/sweetalert.min.js"></script>

<script>
    $(document).ready(function () {
        $('form').submit(function (event) {
            event.preventDefault(); // Prevent the default form submission

            //display SweetAlert message
            swal({
                title: 'Congratulations!',
                text: 'Your order placed successfully. Thank you for shopping with us.',
                icon: 'success',
                button: 'Ok'
            }).then((result) => {
                if (result) {
                    window.location.href = 'index.jsp'; // Redirect to index.jsp
                    //clear the cart and update display
                    clearCartAndDisplay();
                }
            });
        });
    });

    function clearCartAndDisplay() {
        //clear the cart from localStorage
        localStorage.removeItem("cart");

        //update the cart display to show that it's empty
        updateCart();
    }
</script>
<%@include file="components/footer.jsp" %>

</body>
</html>