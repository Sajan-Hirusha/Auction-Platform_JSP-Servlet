package com.app.classes;

import com.app.dbConnection.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class Item {

    private String description;
    private String itemName;
    private byte[] itemImage;
    private String category;
    private String condition;
    private String sellerID;
    private String base64Image;
    private String itemId;
private String auctionIDForBID;
private String startingDateAndTime;

private String endDateAndTime;

   
    private final Connection connection;

    public Item() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getConnection();
    }

    public Item(String description, String itemName, byte[] itemImage, String condition, String category, String sellerID) throws SQLException, ClassNotFoundException {
        this();
        this.description = description;
        this.itemName = itemName;
        this.itemImage = itemImage;
        this.category = category;
        this.condition = condition;
        this.sellerID = sellerID;
    }

    public Item(String description, String itemName, byte[] itemImage, String itemCondition, String categoryName) throws SQLException, ClassNotFoundException {
        this();
        this.description = description;
        this.itemName = itemName;
        this.itemImage = itemImage;
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

    public byte[] getItemImage() {
        return itemImage;
    }

    public void setItemImage(byte[] itemImage) {
        this.itemImage = itemImage;
    }

    public String getBase64Image() {
        return base64Image;
    }

    public void setBase64Image(String base64Image) {
        this.base64Image = base64Image;
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

     public String getAuctionIDForBID() {
        return auctionIDForBID;
    }

    public void setAuctionIDForBID(String auctionID) {
        this.auctionIDForBID = auctionID;
    }
    
    
    public String getStartingDateAndTime() {
        return startingDateAndTime;
    }

    public void setStartingDateAndTime(String startingDateAndTime) {
        this.startingDateAndTime = startingDateAndTime;
    }

    public String getEndDateAndTime() {
        return endDateAndTime;
    }

    public void setEndDateAndTime(String endDateAndTime) {
        this.endDateAndTime = endDateAndTime;
    }
    public boolean addItem() throws SQLException {
        String sql = "Insert Into item (itemId, description,itemName,itemImage,itemCondition,categoryID,Seller_sellerID)VALUES (?,?,?,?,?,?,?)";

        String nextItemID = generateItemId();
        String categoryID = getCategoryID(category);
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, nextItemID);
        statement.setString(2, this.getDescription());
        statement.setString(3, this.getItemName());
        statement.setBytes(4, this.getItemImage());
        statement.setString(5, this.getCondition());
        statement.setString(6, categoryID);
        statement.setString(7, this.getSellerID());

        return statement.executeUpdate() > 0;
    }

    public boolean updateItem() throws SQLException {

        String sql = "UPDATE item SET description = ?, itemName = ?, itemImage = ?, itemCondition = ?, categoryID = ? WHERE itemId = ?";
        String categoryID = getCategoryID(this.category);
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, this.getDescription());
        statement.setString(2, this.getItemName());
        statement.setBytes(3, this.getItemImage());
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
        List<Item> itemList = new ArrayList<>();

        while (resultSet.next()) {
            String itemId = resultSet.getString("itemId");
            String description = resultSet.getString("description");
            String itemName = resultSet.getString("itemName");
            byte[] itemImage = resultSet.getBytes("itemImage");
            String itemCondition = resultSet.getString("itemCondition");
            String categoryName = getCategoryName(resultSet.getString("categoryID"));

            String base64Image = Base64.getEncoder().encodeToString(itemImage);

            Item item = new Item(description, itemName, itemImage, itemCondition, categoryName);
            item.setItemId(itemId);
            item.setBase64Image(base64Image);

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
            byte[] itemImage = resultSet.getBytes("itemImage");
            String itemCondition = resultSet.getString("itemCondition");
            String categoryName = getCategoryName(resultSet.getString("categoryID"));
            String sellerId = resultSet.getString("Seller_sellerID");

            String base64Image = Base64.getEncoder().encodeToString(itemImage);
            Item item = new Item(description, itemName, itemImage, itemCondition, categoryName);
            item.setItemId(itemId);
            item.setBase64Image(base64Image);

            item.setSellerID(sellerId);
            return item;
        }
        return null;
    }
}
