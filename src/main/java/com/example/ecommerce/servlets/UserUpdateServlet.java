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

@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            //get user details from the form
            String userName = request.getParameter("userName");
            String userEmail = request.getParameter("userEmail");
            String userPhone = request.getParameter("userPhone");
            String userAddress = request.getParameter("userAddress");

            //get the current user from the session
            HttpSession httpSession = request.getSession();
            User user = (User) httpSession.getAttribute("current-user");

            //update user details
            user.setUserName(userName);
            user.setUserEmail(userEmail);
            user.setUserPhone(userPhone);
            user.setUserAddress(userAddress);

            //update the user in the database
            UserDao userDao = new UserDao(FactoryProvider.getFactory());
            userDao.updateUser(user);

            //redirect back to the normal user page
            response.sendRedirect("normaluser.jsp");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
