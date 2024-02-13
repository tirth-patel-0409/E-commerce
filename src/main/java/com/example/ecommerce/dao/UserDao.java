package com.example.ecommerce.dao;

import com.example.ecommerce.entities.User;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.hibernate.Transaction;

public class UserDao {

    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }

    //get user by email and password for login
    public User getUserByEmailAndPassword(String email, String password) throws Exception {

        User user = null;

        try {

            String query = "from User where userEmail =: e and userPassword =: p";

            Session session = this.factory.openSession();
            Query q = session.createQuery(query);

            q.setParameter("e", email);
            q.setParameter("p", password);

            user = (User) q.uniqueResult();

            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    //get user by email to reset password
    public User getUserByEmail(String email) {
        User user = null;
        try {
            String query = "from User where userEmail =: e";
            Session session = this.factory.openSession();

            Query q = session.createQuery(query);
            q.setParameter("e", email);

            user = (User) q.uniqueResult();
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    //update user details
    public void updateUser(User user) {
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.update(user);

            tx.commit();
            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}