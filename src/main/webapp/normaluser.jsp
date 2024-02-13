<%@ page import="com.example.ecommerce.entities.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("current-user");

    //check if the user is not logged in or if the user is not of type 'normal'
    if (user == null || !user.getUserType().equals("normal")) {
        //redirect the user to the login page with a SweetAlert message
%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEase</title>
    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="css/style.css">
    <script src="components/SweetAlert/sweetalert.min.js"></script>
</head>
<body>
<script>
    //display the SweetAlert message
    swal({
        title: 'Oops!',
        text: 'You are not logged in or you are not authorized to access this page.',
        icon: 'error',
        button: 'Ok',
    }).then(() => {
        <%-- redirect based on user type --%>
        <% if (user == null) { %>
        window.location.href = 'login.jsp';
        <% } else if (user.getUserType().equals("admin")) { %>
        window.location.href = 'admin.jsp';
        <% } %>
    });
</script>
</body>
</html>
<%
        //stop processing the JSP
        return;
    }
%>

<%
    //set cache control headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.
%>

<!DOCTYPE html>
<html>
<head>
    <title>ShopEase</title>
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

<div class="container mt-5 mb-5">
    <h2>Welcome, <%= user.getUserName() %>!</h2>
    <div class="card mt-3">
        <div class="card-body">
            <h5 class="card-title">User Details</h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Name:</strong> <%= user.getUserName() %>
                </li>
                <li class="list-group-item"><strong>Email:</strong> <%= user.getUserEmail() %>
                </li>
                <li class="list-group-item"><strong>Phone:</strong> <%= user.getUserPhone() %>
                </li>
                <li class="list-group-item"><strong>Address:</strong> <%= user.getUserAddress() %>
                </li>
            </ul>
            <button type="button" class="btn btn-outline-primary text-center" data-bs-toggle="modal"
                    data-bs-target="#editDetailsModal">
                Edit Details
            </button>


            <!-- edit Details Modal -->
            <div class="modal fade" id="editDetailsModal" tabindex="-1" role="dialog"
                 aria-labelledby="editDetailsModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editDetailsModalLabel">Edit Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form action="UserUpdateServlet" method="post">
                                <div class="form-group">
                                    <label for="userName">Name:</label>
                                    <input type="text" class="form-control" id="userName" name="userName"
                                           value="<%= user.getUserName() %>" minlength="3" maxlength="15" required>
                                </div>
                                <div class="form-group">
                                    <label for="userEmail">Email:</label>
                                    <input type="email" class="form-control" id="userEmail" name="userEmail"
                                           value="<%= user.getUserEmail() %>"
                                           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,3}$" required>
                                </div>

                                <div class="form-group">
                                    <label for="userPhone">Phone:</label>
                                    <input type="text" class="form-control" id="userPhone" name="userPhone"
                                           value="<%= user.getUserPhone() %>" minlength="10" maxlength="10" required>
                                </div>

                                <div class="form-group">
                                    <label for="userAddress">Address:</label>
                                    <textarea class="form-control" id="userAddress" name="userAddress" required>
                                        <%= user.getUserAddress() %>
                                    </textarea>
                                </div>

                                <div class="modal-footer">
                                    <button type="submit" class="btn btn-primary">Update Details</button>
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="components/common_modal.jsp" %>
<script src="js/style.js"></script>
<%@include file="components/footer.jsp" %>

</body>
</html>