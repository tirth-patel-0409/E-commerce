package com.example.ecommerce.servlets;

import com.example.ecommerce.dao.UserDao;
import com.example.ecommerce.entities.User;
import com.example.ecommerce.helper.FactoryProvider;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            //authenticating user
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            User user = userDao.getUserByEmailAndPassword(email, password);

            HttpSession httpSession = req.getSession();
            if (user == null) {

                //invalid email or password
                req.setAttribute("status", "failed");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            } else {

                httpSession.setAttribute("current-user", user);
                if (user.getUserType().equals("admin")) {
                    resp.sendRedirect("admin.jsp");
                } else if (user.getUserType().equals("normal")) {
                    resp.sendRedirect("normaluser.jsp");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}