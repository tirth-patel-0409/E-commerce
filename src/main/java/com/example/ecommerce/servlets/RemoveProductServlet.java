package com.example.ecommerce.servlets;

import com.example.ecommerce.dao.ProductDao;
import com.example.ecommerce.helper.FactoryProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/RemoveProductServlet")
public class RemoveProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            //get product ID from the request parameter
            int productId = Integer.parseInt(req.getParameter("productId"));

            //delete the product from the database
            ProductDao dao = new ProductDao(FactoryProvider.getFactory());
            dao.removeProduct(productId);

            //set the status attribute
            req.setAttribute("status", "success");

            //forward the request to the view products page
            req.getRequestDispatcher("view_products.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
