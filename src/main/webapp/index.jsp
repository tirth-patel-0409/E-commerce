<%@ page import="com.example.ecommerce.helper.FactoryProvider" %>
<%@ page import="com.example.ecommerce.dao.ProductDao" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.ecommerce.entities.Product" %>
<%@ page import="com.example.ecommerce.dao.CategoryDao" %>
<%@ page import="com.example.ecommerce.entities.Category" %>
<%@ page import="com.example.ecommerce.helper.ProductDescHelper" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>ShopEase - Home</title>
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
    <div class="row mt-3 mx-2">

        <%
            String cat = request.getParameter("category");

            // Set category to "all" if it's null
            if (cat == null) {
                cat = "all";
            }

            //initialize ProductDao to fetch products
            ProductDao dao = new ProductDao(FactoryProvider.getFactory());

            int pageNo = 1;
            int pageSize = 6;

            if (request.getParameter("page") != null) {
                pageNo = Integer.parseInt(request.getParameter("page"));
            }

            List<Product> list;
            //check if category is specified or not
            if (cat.equals("all")) {
                //fetch all products if no category is specified
                list = dao.getAllProducts(pageNo, pageSize);
            } else {
                //fetch products by category if category is specified
                int cid = Integer.parseInt(cat.trim());
                list = dao.getAllProductsById(cid, pageNo, pageSize);
            }

            //initialize CategoryDao to fetch categories
            CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
            List<Category> clist = cdao.getCategories();
        %>

        <%-- show categories--%>
        <div class="col-md-2 mb-3">

            <div class="list-group">
                <a href="index.jsp?category=all" class="list-group-item list-group-item-action <%= (cat.equals("all")) ? "active" : "" %>"
                   aria-current="true">
                    All Products
                </a>
                <%
                    //loop through categories and display them as links
                    for (Category c : clist) {

                %>
                <a href="index.jsp?category=<%= c.getCategoryId() %>"
                   class="list-group-item list-group-item-action <%= (cat.equals(String.valueOf(c.getCategoryId()))) ? "active" : "" %>"><%= c.getCategoryTitle() %>
                </a>

                <%
                    }
                %>
            </div>

        </div>

        <%-- show products--%>
        <div class="col-md-10">

            <div class="row d-flex flex-wrap">
                <%
                    //loop through products and display them
                    for (Product p : list) {

                %>

                <%-- product card--%>
                <div class="col-md-4 mb-3">
                    <div class="card h-100 product-card">
                        <div class="container text-center">
                            <img src="images/Product/<%= p.getpPhoto() %>"
                                 style="max-width: 100%; max-height: 200px; width: auto;" class="card-img-top m-2"
                                 alt="Product Image">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title"><%= p.getpName() %>
                            </h5>
                            <p class="card-text"><%= ProductDescHelper.get10Words(p.getpDesc()) %>
                            </p>
                        </div>

                        <div class="card-footer">
                            <button class="btn custom-bg text-white" onclick="add_to_cart(<%= p.getpId() %>, '<%= p.getpName() %>', <%= p.getPriceAfterDiscount() %>)">Add To Cart</button>
                            <span class="fw-bold"> &#8377;<%= p.getPriceAfterDiscount() %></span> <span class="text-secondary discount-label original-price"> &#8377;<%= p.getpPrice()%></span> <span class="discount-label fw-bold text-secondary">(<%= p.getpDiscount() %>% off)</span>
                        </div>
                    </div>
                </div>
                <%
                    }

                    //display message if no items found in the category
                    if (list.size() == 0) {
                        out.print("<h2>No item in this category.</h2>");
                    }
                %>

            </div>

            <!-- Pagination -->
            <div class="row">
                <div class="col-md-12">
                    <nav aria-label="Page navigation example">
                        <ul class="pagination justify-content-center">
                            <%-- Previous page link --%>
                            <% if (pageNo > 1) { %>
                            <li class="page-item">
                                <a class="page-link" href="index.jsp?category=<%= cat %>&page=<%= pageNo - 1 %>" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <% } %>

                            <%-- Pagination links --%>
                            <% for (int i = 1; i <= dao.getTotalPages(cat, pageSize); i++) { %>
                            <li class="page-item <%= (i == pageNo) ? "active" : "" %>">
                                <a class="page-link" href="index.jsp?category=<%= cat %>&page=<%= i %>"><%= i %></a>
                            </li>
                            <% } %>

                            <%-- Next page link --%>
                            <% if (pageNo < dao.getTotalPages(cat, pageSize)) { %>
                            <li class="page-item">
                                <a class="page-link" href="index.jsp?category=<%= cat %>&page=<%= pageNo + 1 %>" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                            <% } %>
                        </ul>
                    </nav>
                </div>
            </div>
            <!-- End Pagination -->

        </div>
    </div>
</div>
<%@include file="components/common_modal.jsp"%>
<script src="js/style.js"></script>
<%@include file="components/footer.jsp" %>
</body>
</html>
