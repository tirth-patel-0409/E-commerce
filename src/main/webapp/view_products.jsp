<%@ page import="com.example.ecommerce.entities.Product" %>
<%@ page import="com.example.ecommerce.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.ecommerce.helper.ProductDescHelper" %>
<%@ page import="com.example.ecommerce.helper.FactoryProvider" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<% String status = (String) request.getAttribute("status");%>
<input type="hidden" id="status" value="<%= status %>">

<%
    // Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.

    // Pagination parameters
    int pageSize = 6; // Number of products per page
    int pageNo = 1; // Default page number

    if (request.getParameter("page") != null) {
        pageNo = Integer.parseInt(request.getParameter("page"));
    }

    // Retrieve products for the current page
    ProductDao dao = new ProductDao(FactoryProvider.getFactory());
    List<Product> productList = dao.getAllProducts(pageNo, pageSize);
%>

<!DOCTYPE html>
<html>
<head>
    <title>ShopEase - View Products</title>
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

<div class="container">
    <h1 class="text-center mt-3">All Products</h1>
    <table class="table">
        <thead>
        <tr>
            <th>Product Name</th>
            <th>Description</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Display each product in the table
            for (Product product : productList) {
        %>
        <tr>
            <td><%= product.getpName() %>
            </td>
            <td><%= ProductDescHelper.get10Words(product.getpDesc()) %>
            </td>
            <td>&#8377;<%= product.getPriceAfterDiscount() %>
            </td>
            <td>
                <form method="post" action="RemoveProductServlet">
                    <input type="hidden" name="productId" value="<%= product.getpId() %>">
                    <button type="submit" class="btn btn-danger">Remove</button>
                </form>
            </td>
        </tr>
        <%
            }

            // Display a message if no products are available
            if (productList.isEmpty()) {
        %>
        <tr>
            <td colspan="4" class="text-center">No products available.</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- Pagination script -->
<script>
    function goToPage(page) {
        window.location.href = 'view_products.jsp?page=' + page;
    }
</script>

<div class="container text-center">
    <ul class="pagination justify-content-center">
        <%-- Previous Page Button --%>
        <li class="page-item <%= (pageNo == 1) ? "disabled" : "" %>">
            <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%= (pageNo - 1) %>)" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>

        <%-- Page Numbers --%>
        <% for (int i = 1; i <= dao.getTotalPages(null, pageSize); i++) { %>
        <li class="page-item <%= (i == pageNo) ? "active" : "" %>">
            <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%= i %>)"><%= i %></a>
        </li>
        <% } %>

        <%-- Next Page Button --%>
        <li class="page-item <%= (pageNo == dao.getTotalPages(null, pageSize)) ? "disabled" : "" %>">
            <a class="page-link" href="javascript:void(0);" onclick="goToPage(<%= (pageNo + 1) %>)" aria-label="Next">
                <span aria-hidden="true">&raquo;</span>
            </a>
        </li>
    </ul>
</div>

<%@ include file="components/common_modal.jsp" %>
<script src="js/style.js"></script>
<%@ include file="components/footer.jsp" %>

<script src="components/SweetAlert/sweetalert.min.js"></script>
<script>
    $(document).ready(function () {
        var status = $("#status").val();
        if (status === "success") {
            swal({
                title: 'Congratulations!',
                text: 'Product Removed Successfully.',
                icon: 'success',
                button: 'Ok',
            }).then(() => {
                // Redirect to the view_products.jsp page
                window.location.href = 'view_products.jsp';
            });
        }
    });
</script>
</body>
</html>