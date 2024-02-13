package com.example.ecommerce.entities;

import jakarta.persistence.*;

@Entity
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(length = 10, name = "p_id")
    private int pId;
    @Column(length = 100, name = "p_name")
    private String pName;
    @Column(length = 3000, name = "p_desc")
    private String pDesc;
    @Column(length = 1500, name = "p_photo")
    private String pPhoto;
    @Column(length = 100, name = "p_price")
    private int pPrice;
    @Column(length = 100, name = "p_discount")
    private int pDiscount;
    @Column(length = 100, name = "p_quantity")
    private int pQuantity;

    @ManyToOne
    private Category category;

    public Product(String pName, String pDesc, String pPhoto, int pPrice, int pDiscount, int pQuantity, Category category) {
        this.pName = pName;
        this.pDesc = pDesc;
        this.pPhoto = pPhoto;
        this.pPrice = pPrice;
        this.pDiscount = pDiscount;
        this.pQuantity = pQuantity;
        this.category = category;
    }


    public Product() {
    }

    public int getpId() {
        return pId;
    }

    public void setpId(int pId) {
        this.pId = pId;
    }

    public String getpName() {
        return pName;
    }

    public void setpName(String pName) {
        this.pName = pName;
    }

    public String getpDesc() {
        return pDesc;
    }

    public void setpDesc(String pDesc) {
        this.pDesc = pDesc;
    }

    public String getpPhoto() {
        return pPhoto;
    }

    public void setpPhoto(String pPhoto) {
        this.pPhoto = pPhoto;
    }

    public int getpPrice() {
        return pPrice;
    }

    public void setpPrice(int pPrice) {
        this.pPrice = pPrice;
    }

    public int getpDiscount() {
        return pDiscount;
    }

    public void setpDiscount(int pDiscount) {
        this.pDiscount = pDiscount;
    }

    public int getpQuantity() {
        return pQuantity;
    }

    public void setpQuantity(int pQuantity) {
        this.pQuantity = pQuantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    @Override
    public String toString() {
        return "Product{" +
                "pId=" + pId +
                ", pName='" + pName + '\'' +
                ", pDesc='" + pDesc + '\'' +
                ", pPhoto='" + pPhoto + '\'' +
                ", pPrice=" + pPrice +
                ", pDiscount=" + pDiscount +
                ", pQuantity=" + pQuantity +
                '}';
    }

    //calculate price after discount
    public int getPriceAfterDiscount() {

        int d = (int) ((this.getpDiscount() / 100.0) * this.getpPrice());
        return this.getpPrice() - d;
    }
}

