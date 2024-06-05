package com.app.controllers.sellerServlets;

import com.app.models.Item;

import java.sql.SQLException;
import java.util.List;

public class ItemService {
//    public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        List<Item> allItems = null;
//        Item item = new Item();
//        item.setSellerID("sellerID1");
//        allItems = item.getItemList();
//
//        for (Item item1 : allItems) {
//            // Assuming Item class has getters for its properties
//            System.out.println("Item ID: " + item1.getItemId());
//            System.out.println("Item Name: " + item1.getItemName());
//            System.out.println("Seller ID: " + item1.getSellerID());
//            // Add more properties as needed
//            System.out.println(); // Optional: Adds a blank line between each item
//        }
//    }
    public List<Item> findAllItems() throws SQLException, ClassNotFoundException {
             List<Item> allItems = null;
        Item item = new Item();
        item.setSellerID("sellerID1");
        allItems = item.getItemList();
        return allItems;
    }

}
