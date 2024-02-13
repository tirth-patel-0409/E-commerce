<%@ page import="com.example.ecommerce.entities.User" %>
<%@ page import="com.example.ecommerce.dao.CategoryDao" %>
<%@ page import="com.example.ecommerce.helper.FactoryProvider" %>
<%@ page import="com.example.ecommerce.entities.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.ecommerce.helper.UserAndProductCount" %>
<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("current-user");

    if (user == null || user.getUserType().equals("normal")) {

%>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEase</title>
    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<script src="components/SweetAlert/sweetalert.min.js"></script>
<script>
    // Display the SweetAlert message
    swal({
        title: 'Oops!',
        text: 'You are not logged in or you are not authorized to access this page.',
        icon: 'error',
        button: 'Ok',
    }).then(() => {
        <%-- Redirect based on user type --%>
        <% if (user == null) { %>
        window.location.href = 'login.jsp';
        <% } else if (user.getUserType().equals("normal")) { %>
        window.location.href = 'normaluser.jsp';
        <% } %>
    });
</script>

</body>
</html>
<%
        return; // Stop processing the JSP
    }
%>

<%

    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
    List<Category> list = cdao.getCategories();

    //getting count

    Map<String,Long> m = UserAndProductCount.getCounts(FactoryProvider.getFactory());

    // Set cache control headers to prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

%>

<!DOCTYPE html>
<html>
<head>
    <title>ShopEase - Admin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link rel="stylesheet" href="components/bootstrap/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <script src="components/jquery/code.jquery.com_jquery-3.6.0.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_jquery.validate.min.js"></script>
    <script src="components/jquery/cdn.jsdelivr.net_npm_jquery-validation@1.19.5_dist_additional-methods.min.js"></script>
</head>
<body>
<%@ include file="components/navbar.jsp" %>

<div class="container admin">

    <%--    First row starts here--%>

    <div class="row mt-4">

        <%--        First card--%>

        <div class="col-md-4">
            <div class="card" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Number of users in this website.">
                <img src="images/user-profile.png" style="max-width: 125px;" class="card-img-top container mt-2"
                     alt="user-icon">
                <div class="card-body text-center">
                    <h1><%= m.get("userCount") %></h1>
                    <h2 class="card-title text-uppercase text-muted">Users</h2>
                </div>
            </div>
        </div>

        <%--        Second card--%>

        <div class="col-md-4">
            <div class="card" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Total Categories.">
                <img src="images/list-items.png" style="max-width: 125px;" class="card-img-top container mt-2"
                     alt="category-icon">
                <div class="card-body text-center">
                    <h1><%= list.size() %></h1>
                    <h2 class="card-title text-uppercase text-muted">Categories</h2>
                </div>
            </div>
        </div>

        <%--        Third card--%>

        <div class="col-md-4">
            <div class="card" data-bs-toggle="tooltip" data-bs-placement="bottom" data-bs-title="Total number of products.">
                <img src="images/product-management.png" style="max-width: 125px;" class="card-img-top container mt-2"
                     alt="product-icon">
                <div class="card-body text-center">
                    <h1><%= m.get("productCount") %></h1>
                    <h2 class="card-title text-uppercase text-muted">Product</h2>
                </div>
            </div>
        </div>

    </div>

    <%--    First row ends here--%>

    <%--    Second row starts here--%>

    <div class="row mt-3 mb-2">

        <%--        First card--%>

        <div class="col-md-6">
            <div class="card" data-bs-toggle="modal" data-bs-target="#add-category-modal">
                <img src="images/plus.png" style="max-width: 125px;" class="card-img-top container mt-2"
                     alt="user-icon">
                <div class="card-body text-center">
                    <h2 class="card-title text-uppercase text-muted">Add Category</h2>
                </div>
            </div>
        </div>

        <%--        Second card--%>

        <div class="col-md-6">
            <div class="card" data-bs-toggle="modal" data-bs-target="#add-product-modal">
                <img src="images/plus-button.png" style="max-width: 125px;" class="card-img-top container mt-2"
                     alt="user-icon">
                <div class="card-body text-center">
                    <h2 class="card-title text-uppercase text-muted">Add Product</h2>
                </div>
            </div>
        </div>

    </div>

    <%--    Second row ends here--%>

<%--        Third row starts here--%>
<%--        view products --%>

    <div class="row mt-3 mb-2">
        <div class="col-md-12">
            <div class="card" onclick="window.location='view_products.jsp'" data-bs-toggle="tooltip" data-bs-placement="top" data-bs-title="Click here to view all products.">
                <img src="images/view.png" style="max-width: 125px;" class="card-img-top container mt-2"
                     alt="user-icon">
                <div class="card-body text-center">
                    <h2 class="card-title text-uppercase text-muted">View Products</h2>
                </div>
            </div>
        </div>
    </div>
</div>

<%--        Third row ends here--%>

<%--        add category modal starts here--%>

<!-- Modal -->
<div class="modal fade" id="add-category-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header custom-bg text-white">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Fill Category Details</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form class="mx-1 mx-md-4" action="ProductOperationServlet" method="post">

                    <input type="hidden" name="operation" value="addcategory">

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <input type="text" id="catTitle" name="catTitle" class="form-control"
                                   placeholder="Enter Category Title" required/>
                        </div>
                    </div>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <textarea style="height: 100px" id="catDescription" class="form-control"
                                      placeholder="Enter Category Description" name="catDescription"
                                      required></textarea>
                        </div>
                    </div>

                    <div class="d-flex justify-content-center mx-4">
                        <button type="submit" class="btn btn-outline-success btn-lg" style="margin-right: 10px">Add
                            Category
                        </button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<%--            add category modal ends here--%>



<%--            add product modal starts here--%>

<!-- Modal -->
<div class="modal fade" id="add-product-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header custom-bg text-white">
                <h1 class="modal-title fs-5" id="exampleModalLabel1">Fill Product Details</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">

                <form class="mx-1 mx-md-4" action="ProductOperationServlet" method="post" enctype="multipart/form-data">

                    <input type="hidden" name="operation" value="addproduct">

<%--                    Product Title--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <input type="text" id="pName" name="pName" class="form-control"
                                   placeholder="Enter Product Title" required/>
                        </div>
                    </div>

<%--                    Product Description--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <textarea style="height: 100px" id="pDescription" class="form-control"
                                      placeholder="Enter Product Description" name="pDescription"
                                      required></textarea>
                        </div>
                    </div>

<%--                    Product Price--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <input type="number" id="pPrice" name="pPrice" class="form-control"
                                   placeholder="Enter The Price Of The Product" required/>
                        </div>
                    </div>

<%--                    Product Discount--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <input type="number" id="pDiscount" name="pDiscount" class="form-control"
                                   placeholder="Enter Product Discount" required/>
                        </div>
                    </div>

<%--                    Product Quantity--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <input type="number" id="pQuantity" name="pQuantity" class="form-control"
                                   placeholder="Enter Product Quantity" required/>
                        </div>
                    </div>

<%--                    Product Category--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <select name="catId" id="" class="form-select">

                                <%
                                    for (Category c : list){
                                %>

                                <option value="<%= c.getCategoryId() %>"> <%= c.getCategoryTitle()%> </option>

                                <%
                                    }
                                %>

                            </select>
                        </div>
                    </div>

<%--                    Product File/Photo--%>

                    <div class="d-flex flex-row align-items-center mb-4">
                        <div class="form-outline flex-fill mb-0">
                            <label for="pPhoto">Select Product Photo</label>
                            <input type="file" id="pPhoto" class="form-control" placeholder="Your Profile Picture" name="pPhoto" required />
                        </div>
                    </div>

                    <div class="d-flex justify-content-center mx-4">
                        <button type="submit" class="btn btn-outline-success btn-lg" style="margin-right: 10px">Add
                            Product
                        </button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>

                </form>

            </div>
        </div>
    </div>
</div>

<%--        add product modal ends here--%>

<%@include file="components/common_modal.jsp" %>
<script src="js/style.js"></script>
<script>
    const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]')
    const tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl))
</script>

<%-- SweetAlert message for category addition --%>
<script src="components/SweetAlert/sweetalert.min.js"></script>
<script>
    // Check if the category was added successfully
    <% Boolean categoryAdded = (Boolean) session.getAttribute("categoryAdded");
    if (categoryAdded != null) { %>
    // Display SweetAlert for category addition
    swal({
        title: 'Congratulations!',
        text: 'Category added successfully.',
        icon: 'success',
        button: 'Ok',
    });
    <% // Reset the session attribute
       session.removeAttribute("categoryAdded");
    } %>


    // Check if the product was added successfully
    <% Boolean productAdded = (Boolean) session.getAttribute("productAdded");
    if (productAdded != null) { %>
    // Display SweetAlert for product addition
    swal({
        title: 'Congratulations!',
        text: 'Product added successfully.',
        icon: 'success',
        button: 'Ok',
    });
    <% // Reset the session attribute
       session.removeAttribute("productAdded");
    } %>
</script>

<%@include file="components/footer.jsp" %>
<script src="components/bootstrap/bootstrap.bundle.min.js"></script>
</body>
</html>