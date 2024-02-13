package com.example.ecommerce.servlets;

import com.example.ecommerce.dao.CategoryDao;
import com.example.ecommerce.dao.ProductDao;
import com.example.ecommerce.entities.Category;
import com.example.ecommerce.entities.Product;
import com.example.ecommerce.helper.FactoryProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

@WebServlet("/ProductOperationServlet")
@MultipartConfig
public class ProductOperationServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {

            String op = req.getParameter("operation");

            if (op.trim().equals("addcategory")) {

                //add category
                //fetching category data
                String title = req.getParameter("catTitle");
                String Description = req.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(Description);

                //save category to db
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);

                //set a flag in the session to indicate category addition
                req.getSession().setAttribute("categoryAdded", true);

                //redirect back to the admin.jsp page
                resp.sendRedirect("admin.jsp");

            } else if (op.trim().equals("addproduct")) {

                //add product
                //fetching product data
                String pName = req.getParameter("pName");
                String pDescription = req.getParameter("pDescription");
                int pPrice = Integer.parseInt(req.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(req.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(req.getParameter("pQuantity"));
                int catId = Integer.parseInt(req.getParameter("catId"));
                Part part = req.getPart("pPhoto");

                Product p = new Product();

                p.setpName(pName);
                p.setpDesc(pDescription);
                p.setpPrice(pPrice);
                p.setpDiscount(pDiscount);
                p.setpQuantity(pQuantity);
                p.setpPhoto(part.getSubmittedFileName());

                //get category by id
                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdao.getCategoryById(catId);

                p.setCategory(category);

                //save product to db
                ProductDao productDao = new ProductDao(FactoryProvider.getFactory());
                productDao.saveProduct(p);

                //photo upload
                //find out the path to upload photo
                String path = req.getRealPath("images") + File.separator + "Product" + File.separator + part.getSubmittedFileName();
                System.out.println(path);

                try {
                    // uploading photo
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();

                    //reading data
                    byte[] data = new byte[is.available()];
                    is.read(data);

                    //writing the data
                    fos.write(data);
                    fos.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

                //set a flag in the session to indicate product addition
                req.getSession().setAttribute("productAdded", true);

                //redirect back to the admin.jsp page
                resp.sendRedirect("admin.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }
}