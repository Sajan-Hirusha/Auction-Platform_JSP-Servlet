package com.app.models;

import com.app.dbConnection.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Item {
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
    private String description;
    private String itemName;
    private String itemImageUrl;
    private String category;
    private String condition;
    private String sellerID;

    private String itemId;

    private final Connection connection;

    public Item() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getInstance().getConnection();
    }

    public Item(String description, String itemName, String itemImageUrl, String category, String condition, String sellerID) throws SQLException, ClassNotFoundException {
        this();
        this.description = description;
        this.itemName = itemName;
        this.itemImageUrl = itemImageUrl;
        this.category = category;
        this.condition = condition;
        this.sellerID = sellerID;
    }

    public Item(String description, String itemName, String itemImageUrl, String itemCondition, String categoryName) throws SQLException, ClassNotFoundException {
        this();
        this.description = description;
        this.itemName = itemName;
        this.itemImageUrl = itemImageUrl;
        this.category = categoryName;
        this.condition = itemCondition;

    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemImageUrl() {
        return itemImageUrl;
    }

    public void setItemImageUrl(String itemImageUrl) {
        this.itemImageUrl = itemImageUrl;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
    }


    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public boolean addItem() throws SQLException {
        String sql = "Insert Into item (itemId, description,itemName,itemImageUrl,itemCondition,categoryID,Seller_sellerID)VALUES (?,?,?,?,?,?,?)";

        String nextItemID = generateItemId();
        String categoryID = getCategoryID(category);
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nextItemID);
        statement.setString(2, this.getDescription());
        statement.setString(3, this.getItemName());
        statement.setString(4, this.getItemImageUrl());
        statement.setString(5, this.getCondition());
        statement.setString(6, categoryID);
        statement.setString(7, this.getSellerID());

        return statement.executeUpdate() > 0;
    }

    public boolean updateItem() throws SQLException {


        String sql = "UPDATE item SET description = ?, itemName = ?, itemImageUrl = ?, itemCondition = ?, categoryID = ? WHERE itemId = ?";
        String categoryID = getCategoryID(this.category);
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, this.getDescription());
        statement.setString(2, this.getItemName());
        statement.setString(3, this.getItemImageUrl());
        statement.setString(4, this.getCondition());
        statement.setString(5, categoryID);
        statement.setString(6, this.getItemId());

        return statement.executeUpdate() > 0;
    }
    public boolean deleteItem(String id) throws SQLException {

        String sql = "DELETE FROM item WHERE itemId = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, id);

        return statement.executeUpdate() > 0;
    }

    public String generateItemId() throws SQLException {
        String sql = "Select itemId from item ORDER BY CAST(SUBSTRING(itemId,6) AS UNSIGNED) DESC LIMIT 1";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String lastItemID = resultSet.getString("itemId");
            String spliData[] = lastItemID.split("/");
            String lastIntegerAsString = spliData[1];
            int lastIntegerAsInt = Integer.parseInt(lastIntegerAsString);
            lastIntegerAsInt++;
            String nextItemID = "ITEM/" + lastIntegerAsInt;
            return nextItemID;
        } else {
            String nextItemID = "ITEM/" + 1;
            return nextItemID;
        }
    }

    public String getCategoryID(String category) throws SQLException {
        String sql = "Select categoryID from category WHERE categoryName= ? ";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, category);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            String categoryID = resultSet.getString("categoryID");
            return categoryID;
        } else {
            return null;
        }
    }

    public String getCategoryName(String categoryID) throws SQLException {
        String sql = "Select categoryName from category WHERE categoryID= ? ";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, categoryID);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            String categoryName = resultSet.getString("categoryName");
            return categoryName;
        } else {
            return null;
        }
    }

    public List<Item> getItemList() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM item WHERE Seller_sellerID = ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, this.getSellerID());
        ResultSet resultSet = statement.executeQuery();
        List<Item> itemList = new ArrayList<Item>();

        while (resultSet.next()) {
            String itemId = resultSet.getString("itemId");
            String description = resultSet.getString("description");
            String itemName = resultSet.getString("itemName");
            String itemImageUrl = resultSet.getString("itemImageUrl");
            String itemCondition = resultSet.getString("itemCondition");
            String categoryName = getCategoryName(resultSet.getString("categoryID"));

            Item item = new Item(description, itemName, itemImageUrl, itemCondition, categoryName);
            item.setItemId(itemId);
            itemList.add(item);
        }
        return itemList;
    }


    public Item getItem(String itemID) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM item WHERE  itemId= ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, itemID);
        ResultSet resultSet = statement.executeQuery();

        while (resultSet.next()) {
            String itemId = resultSet.getString("itemId");
            String description = resultSet.getString("description");
            String itemName = resultSet.getString("itemName");
            String itemImageUrl = resultSet.getString("itemImageUrl");
            String itemCondition = resultSet.getString("itemCondition");
            String categoryName = getCategoryName(resultSet.getString("categoryID"));
            String sellerId = resultSet.getString("Seller_sellerID");

            Item item = new Item(description, itemName, itemImageUrl, itemCondition, categoryName);
            item.setItemId(itemId);
            item.setSellerID(sellerId);
            return item;
        }
        return null;
    }
}
