package com.app.models;

import com.app.dbConnection.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Auction {
   private  Timestamp startingTimeAndDate;
   private Timestamp endTimeAndDate;
   private double startingPrice;
   private String itemId;
   private String sellerId;

   private final Connection connection;
   public Auction() throws ClassNotFoundException, SQLException {
      this.connection = DbConnection.getInstance().getConnection();
   }

   public Auction(Timestamp startingTimeAndDate, Timestamp endTimeAndDate, double startingPrice, String itemId, String sellerId) throws SQLException, ClassNotFoundException {
      this();
      this.startingTimeAndDate = startingTimeAndDate;
      this.endTimeAndDate = endTimeAndDate;
      this.startingPrice = startingPrice;
      this.itemId = itemId;
      this.sellerId = sellerId;
   }



   public String getSellerId() {
      return sellerId;
   }

   public void setSellerId(String sellerId) {
      this.sellerId = sellerId;
   }

   public String getItemId() {
      return itemId;
   }

   public void setItemId(String itemId) {
      this.itemId = itemId;
   }

   public double getStartingPrice() {
      return startingPrice;
   }

   public void setStartingPrice(double startingPrice) {
      this.startingPrice = startingPrice;
   }

   public Timestamp getEndTimeAndDate() {
      return endTimeAndDate;
   }

   public void setEndTimeAndDate(Timestamp endTimeAndDate) {
      this.endTimeAndDate = endTimeAndDate;
   }

   public Timestamp getStartingTimeAndDate() {
      return startingTimeAndDate;
   }

   public void setStartingTimeAndDate(Timestamp startingTimeAndDate) {
      this.startingTimeAndDate = startingTimeAndDate;
   }

   public boolean placeAuction() throws SQLException, ClassNotFoundException {
      System.out.println(this.getSellerId());
      String sql = "Insert Into auction (auctionID, currentBid,startingDateAndTime,endDateAndTime,itemId,sellerID)VALUES (?,?,?,?,?,?)";

      String AuctionID=generateAuctionId();
      PreparedStatement statement = connection.prepareStatement(sql);
      statement.setString(1,AuctionID);
      statement.setDouble(2,this.getStartingPrice());
      statement.setTimestamp(3,this.getStartingTimeAndDate());
      statement.setTimestamp(4,this.getEndTimeAndDate());
      statement.setString(5,this.getItemId());
      statement.setString(6,this.getSellerId());

      return statement.executeUpdate() > 0;
   }


   public String generateAuctionId() throws SQLException {
      String sql = "Select auctionID from auction ORDER BY CAST(SUBSTRING(auctionID,5) AS UNSIGNED) DESC LIMIT 1";
      PreparedStatement statement = connection.prepareStatement(sql);

      ResultSet resultSet = statement.executeQuery();

      if (resultSet.next()) {
         String lastAuctionID=resultSet.getString("auctionID");
         String spliData[]=lastAuctionID.split("/");
         String lastIntegerAsString=spliData[1];
         int lastIntegerAsInt=Integer.parseInt(lastIntegerAsString);
         lastIntegerAsInt++;
         String nextAuctionID="AUC/"+lastIntegerAsInt;
         return nextAuctionID;
      }else{
         String nextAuctionID="AUC/"+1;
         return nextAuctionID;
      }
   }


   public List<Item> getSellerActiveAuctionItems() throws SQLException, ClassNotFoundException {
      String sql="SELECT item.* FROM item JOIN auction ON item.itemId = auction.itemId WHERE auction.sellerID = ?";
      PreparedStatement statement = connection.prepareStatement(sql);
      statement.setString(1, this.getSellerId());
      ResultSet resultSet = statement.executeQuery();
      List<Item> itemList = new ArrayList<Item>();

      while (resultSet.next()) {
         String itemId = resultSet.getString("itemId");
         String description = resultSet.getString("description");
         String itemName = resultSet.getString("itemName");
         String itemImageUrl = resultSet.getString("itemImageUrl");
         String itemCondition = resultSet.getString("itemCondition");
         Item item=new Item();
         String categoryName = item.getCategoryName(resultSet.getString("categoryID"));
         Item resultItem = new Item(description, itemName, itemImageUrl, itemCondition, categoryName);
         item.setItemId(itemId);
         itemList.add(resultItem);
      }
      return itemList;

   }
}
