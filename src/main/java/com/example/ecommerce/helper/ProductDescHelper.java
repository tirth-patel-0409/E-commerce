package com.example.ecommerce.helper;

public class ProductDescHelper {

    //to get 10 words for description of the product
    public static String get10Words(String desc) {

        String[] strs = desc.split(" ");

        String res = "";
        if (strs.length > 10) {

            for (int i = 0; i < 10; i++) {
                res = res + strs[i] + " ";
            }
            return (res + "...");

        } else {
            return (desc + "...");
        }
    }
}
