package com.example.ecommerce.servlets;

import com.example.ecommerce.entities.User;
import com.example.ecommerce.helper.FactoryProvider;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String userName = req.getParameter("user_name");
            String userEmail = req.getParameter("user_email");
            String userPassword = req.getParameter("user_password");
            String userPhone = req.getParameter("user_phone");
            String userAddress = req.getParameter("user_address");

            //check if a user with the same email already exists
            if (isUserAlreadyRegistered(userEmail)) {
                req.setAttribute("status", "failed");
                RequestDispatcher dispatcher = req.getRequestDispatcher("/register.jsp");
                dispatcher.forward(req, resp);
                return;
            }

            //creating user object to store data
            User user = new User(userName, userEmail, userPassword, userPhone, "default.jpg", userAddress, "normal");

            Session hibernateSession = FactoryProvider.getFactory().openSession();
            Transaction tx = hibernateSession.beginTransaction();

            int userId = (int) hibernateSession.save(user);

            tx.commit();
            hibernateSession.close();

            RequestDispatcher dispatcher;
            if (userId > 0) {
                req.setAttribute("status", "success");
            } else {
                req.setAttribute("status", "failed");
            }
            dispatcher = req.getRequestDispatcher("/register.jsp");

            dispatcher.forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //check if a user with the given email already exists in the database
    private boolean isUserAlreadyRegistered(String userEmail) {
        Session hibernateSession = FactoryProvider.getFactory().openSession();
        try {
            Query<User> query = hibernateSession.createQuery("FROM User WHERE userEmail = :email", User.class);
            query.setParameter("email", userEmail);

            return query.uniqueResult() != null;
        } finally {
            hibernateSession.close();
        }
    }
}