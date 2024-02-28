package com.example.ecommerce.dao;

import com.example.ecommerce.entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import java.util.List;

public class ProductDao {

    private SessionFactory factory;

    public ProductDao(SessionFactory factory) {
        this.factory = factory;
    }

    //save product to db
    public boolean saveProduct(Product product) {

        boolean f = false;
        try {

            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            session.save(product);

            tx.commit();
            session.close();
            f = true;

        } catch (Exception e) {
            e.printStackTrace();
            f = false;
        }
        return f;
    }

    //remove product
    public void removeProduct(int productId) {
        try {
            Session session = this.factory.openSession();
            Transaction tx = session.beginTransaction();

            //load the product by ID
            Product product = session.get(Product.class, productId);

            //delete the product if it exists
            if (product != null) {
                session.delete(product);
                tx.commit();
            }

            session.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    //get all products with pagination
    public List<Product> getAllProducts(int pageNo, int pageSize) {
        Session session = this.factory.openSession();
        Query query = session.createQuery("from Product");
        query.setFirstResult((pageNo - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Product> list = query.list();
        session.close();
        return list;
    }

    //get all products of given category with pagination
    public List<Product> getAllProductsById(int cid, int pageNo, int pageSize) {
        Session session = this.factory.openSession();
        Query query = session.createQuery("from Product as p where p.category.categoryId =: id");
        query.setParameter("id", cid);
        query.setFirstResult((pageNo - 1) * pageSize);
        query.setMaxResults(pageSize);
        List<Product> list = query.list();
        session.close();
        return list;
    }

    //get total number of pages for pagination
    public long getTotalPages(String cat, int pageSize) {
        Session session = this.factory.openSession();
        Query query;
        if (cat == null || cat.trim().equals("all")) {
            query = session.createQuery("select count(*) from Product");
        } else {
            query = session.createQuery("select count(*) from Product as p where p.category.categoryId =: id");
            query.setParameter("id", Integer.parseInt(cat.trim()));
        }
        long count = (long) query.uniqueResult();
        session.close();
        return (count % pageSize == 0) ? count / pageSize : (count / pageSize) + 1;
    }
}