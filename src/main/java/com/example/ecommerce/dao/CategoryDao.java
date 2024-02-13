package com.example.ecommerce.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import com.example.ecommerce.entities.Category;
import org.hibernate.Transaction;
import org.hibernate.query.Query;


import java.util.List;

public class CategoryDao {

    private SessionFactory factory;

    public CategoryDao(SessionFactory factory) {
        this.factory = factory;
    }

    //save the category to db
    public int saveCategory(Category cat) {

        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();

        int catId = (int) session.save(cat);

        tx.commit();
        session.close();

        return catId;
    }

    //to show dynamic categories in product dropdown menu
    public List<Category> getCategories() {

        Session s = this.factory.openSession();
        Query query = s.createQuery("from Category");
        List<Category> list = query.list();
        return list;
    }

    //to add product to a particular category
    public Category getCategoryById(int cid) {

        Category cat = null;
        try {

            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return cat;
    }
}