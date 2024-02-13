package com.example.ecommerce.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.example.ecommerce.dao.UserDao;
import com.example.ecommerce.entities.User;
import com.example.ecommerce.helper.FactoryProvider;

@WebServlet("/forgotPassword")
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String email = req.getParameter("email");
            String password = req.getParameter("pass");

            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmail(email);
            if (user != null) {
                //update user's password with the new password
                user.setUserPassword(password);
                userDao.updateUser(user);

                //set an attribute to check status
                req.setAttribute("status", "success");
                req.getRequestDispatcher("forgotpassword.jsp").forward(req, resp);
            } else {
                req.setAttribute("status", "failed");
                req.getRequestDispatcher("forgotpassword.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
