/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.app.classes;

import com.app.dbConnection.DbConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class Cart {

    private final Connection connection;

    public Cart() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getConnection();

    }

    public boolean addToCart(String customerID, String itemId, String sellerID, String auctionID) throws SQLException {
        String query = "INSERT INTO cart (customerID ,itemId,sellerID,auctionID) VALUES (?,?,?,?)";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, customerID);
        statement.setString(2, itemId);
        statement.setString(3, sellerID);
        statement.setString(4, auctionID);

        String updateQuery = "UPDATE auction SET status = 'Accepted' WHERE auctionID=?";
        PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
        updateStatement.setString(1, auctionID);
        return statement.executeUpdate() > 0 && updateStatement.executeUpdate() > 0;

    }

    public List<CartItemDetails> getCartItemsForSeller(String customerID) throws SQLException {
        String query = "SELECT c.cartID, c.customerID, c.itemId, c.sellerID, c.auctionID, "
                + "i.description, i.itemName, i.itemImage, i.itemCondition, i.categoryID "
                + "FROM cart c "
                + "JOIN item i ON c.itemId = i.itemId "
                + "WHERE c.customerID  = ?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, customerID);
        ResultSet resultSet = statement.executeQuery();

        List<CartItemDetails> cartItems = new ArrayList<>();
        while (resultSet.next()) {
            byte[] itemImage = resultSet.getBytes("itemImage");
            String base64Image = Base64.getEncoder().encodeToString(itemImage);
            CartItemDetails item = new CartItemDetails(
                    resultSet.getInt("cartID"),
                    resultSet.getString("customerID"),
                    resultSet.getString("itemId"),
                    resultSet.getString("sellerID"),
                    resultSet.getString("auctionID"),
                    resultSet.getString("description"),
                    resultSet.getString("itemName"),
                    base64Image,
                    resultSet.getString("itemCondition")
            );
            cartItems.add(item);
        }
        return cartItems;
    }

    public boolean buyNow(String auctionID) throws SQLException {
        String updateQuery = "UPDATE auction SET status = 'paid' WHERE auctionID=?";
        PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
        updateStatement.setString(1, auctionID);

        String deleteQuery = "DELETE FROM cart WHERE auctionID=?";
        PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery);
        deleteStatement.setString(1, auctionID);
        return deleteStatement.executeUpdate() > 0 && updateStatement.executeUpdate() > 0;
    }
}
