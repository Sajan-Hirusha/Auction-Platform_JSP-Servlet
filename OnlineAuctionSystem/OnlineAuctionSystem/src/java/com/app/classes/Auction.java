package com.app.classes;

import com.app.dbConnection.DbConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class Auction {

    private Timestamp startingTimeAndDate;
    private Timestamp endTimeAndDate;
    private double startingPrice;
    private String itemId;
    private String sellerId;
    private String auctionID;

    private final Connection connection;

    public Auction() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getConnection();
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

    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
    }

    public boolean placeAuction() throws SQLException, ClassNotFoundException {
        System.out.println(this.getSellerId());
        String sql = "Insert Into auction (auctionID, currentBid,startingDateAndTime,endDateAndTime,itemId,sellerID)VALUES (?,?,?,?,?,?)";

        String AuctionID = generateAuctionId();
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, AuctionID);
        statement.setDouble(2, this.getStartingPrice());
        statement.setTimestamp(3, this.getStartingTimeAndDate());
        statement.setTimestamp(4, this.getEndTimeAndDate());
        statement.setString(5, this.getItemId());
        statement.setString(6, this.getSellerId());

        return statement.executeUpdate() > 0;
    }

    public String generateAuctionId() throws SQLException {
        String sql = "Select auctionID from auction ORDER BY CAST(SUBSTRING(auctionID,5) AS UNSIGNED) DESC LIMIT 1";
        PreparedStatement statement = connection.prepareStatement(sql);

        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String lastAuctionID = resultSet.getString("auctionID");
            String spliData[] = lastAuctionID.split("/");
            String lastIntegerAsString = spliData[1];
            int lastIntegerAsInt = Integer.parseInt(lastIntegerAsString);
            lastIntegerAsInt++;
            String nextAuctionID = "AUC/" + lastIntegerAsInt;
            return nextAuctionID;
        } else {
            String nextAuctionID = "AUC/" + 1;
            return nextAuctionID;
        }
    }

    public List<Item> getSellerAuctionItems(String query) throws SQLException, ClassNotFoundException {
        String sql = query;
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, this.getSellerId());
        ResultSet resultSet = statement.executeQuery();
        List<Item> itemList = new ArrayList<Item>();

        while (resultSet.next()) {
            String itemId = resultSet.getString("itemId");
            String description = resultSet.getString("description");
            String itemName = resultSet.getString("itemName");
            byte[] itemImage = resultSet.getBytes("itemImage");
            String itemCondition = resultSet.getString("itemCondition");
            String startingDateAndTime = resultSet.getString("startingDateAndTime");
            String endDateAndTime = resultSet.getString("endDateAndTime");
            String base64Image = Base64.getEncoder().encodeToString(itemImage);
            Item item = new Item();
            String categoryName = item.getCategoryName(resultSet.getString("categoryID"));
            Item resultItem = new Item(description, itemName, itemImage, itemCondition, categoryName);
            resultItem.setItemId(itemId);
            resultItem.setBase64Image(base64Image);
            resultItem.setEndDateAndTime(endDateAndTime);
            resultItem.setStartingDateAndTime(startingDateAndTime);
            itemList.add(resultItem);
        }
        return itemList;

    }

    public List<Item> getSellerActiveAuctionItems() throws SQLException, ClassNotFoundException {
        List<Item> items = new ArrayList<Item>();
        String query = "SELECT item.*,auction.* FROM item JOIN auction ON item.itemId = auction.itemId WHERE auction.sellerID = ? AND status='active'";
        items = getSellerAuctionItems(query);
        return items;
    }

    public List<Item> getSellerUpcommingAuctionItems() throws SQLException, ClassNotFoundException {
        List<Item> items = new ArrayList<Item>();
        String query = "SELECT item.*,auction.* FROM item JOIN auction ON item.itemId = auction.itemId WHERE auction.sellerID = ? AND status='pending'";
        items = getSellerAuctionItems(query);
        return items;
    }

    public List<Item> getSellerEnedAuctionItems() throws SQLException, ClassNotFoundException {
        List<Item> items = new ArrayList<Item>();
        String query = "SELECT item.*,auction.* FROM item JOIN auction ON item.itemId = auction.itemId WHERE auction.sellerID = ? AND status='ended'";
        items = getSellerAuctionItems(query);
        return items;
    }

    public List<Item> getAllActiveAuctionItems() throws SQLException, ClassNotFoundException {
        String sql = "SELECT item.*,auction.* FROM item JOIN auction ON item.itemId = auction.itemId WHERE auction.status='active' ";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();
        List<Item> itemList = new ArrayList<Item>();

        while (resultSet.next()) {
            String itemId = resultSet.getString("itemId");
            String auctionID = resultSet.getString("auctionID");
            String description = resultSet.getString("description");
            String itemName = resultSet.getString("itemName");
            byte[] itemImage = resultSet.getBytes("itemImage");
            String itemCondition = resultSet.getString("itemCondition");
            String startingDateAndTime = resultSet.getString("startingDateAndTime");
            String endDateAndTime = resultSet.getString("endDateAndTime");
            String base64Image = Base64.getEncoder().encodeToString(itemImage);
            Item item = new Item();
            String categoryName = item.getCategoryName(resultSet.getString("categoryID"));
            Item resultItem = new Item(description, itemName, itemImage, itemCondition, categoryName);
            resultItem.setItemId(itemId);
            resultItem.setBase64Image(base64Image);
            resultItem.setAuctionIDForBID(auctionID);
            resultItem.setEndDateAndTime(endDateAndTime);
            resultItem.setStartingDateAndTime(startingDateAndTime);
            itemList.add(resultItem);
        }
        return itemList;
    }

    public List<ItemWinnerDetails> getItemsCommonFunction(String ID, String query) {
        List<ItemWinnerDetails> itemsWithWinners = new ArrayList<>();
        try (
                PreparedStatement stmt = connection.prepareStatement(query);) {
            stmt.setString(1, ID);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                String itemId = rs.getString("itemId");
                String auctionID = rs.getString("auctionID");
                String sellerId = rs.getString("sellerID");
                String description = rs.getString("description");
                String itemName = rs.getString("itemName");
                byte[] itemImage = rs.getBytes("itemImage");
                String itemCondition = rs.getString("itemCondition");
                String customerID = rs.getString("customerID");
                String fullName = rs.getString("fullName");
                String phoneNo = rs.getString("phoneNo");
                String address = rs.getString("address");
                String email = rs.getString("email");
                String bidID = rs.getString("bidID");
                String bidDateAndTime = rs.getString("bidDateAndTime");
                double bidAmount = rs.getDouble("bidAmount");
                String base64Image = Base64.getEncoder().encodeToString(itemImage);
                ItemWinnerDetails itemWinner = new ItemWinnerDetails(itemId, description, itemName, base64Image, itemCondition,
                        customerID, fullName, phoneNo, address, email,
                        bidID, bidDateAndTime, bidAmount, auctionID, sellerId);

                itemsWithWinners.add(itemWinner);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return itemsWithWinners;

    }

    public List<ItemWinnerDetails> getEndItemsAndWinners(String sellerID) {

        List<ItemWinnerDetails> itemsWithWinners = new ArrayList<>();

        String query = "SELECT i.itemId, i.description, i.itemName, i.itemImage, i.itemCondition, "
                + "c.customerID, c.fullName, c.phoneNo, c.address, c.email, "
                + "b.bidID, b.bidDateAndTime, b.bidAmount , a.auctionID ,a.sellerID "
                + "FROM auction a "
                + "JOIN bid b ON a.auctionID = b.auctionID "
                + "JOIN item i ON a.itemId = i.itemId "
                + "JOIN customer c ON b.customerID = c.customerID "
                + "WHERE a.status = 'ended' "
                + "AND a.currentBid = b.bidAmount "
                + "AND a.sellerID=?";

        itemsWithWinners = getItemsCommonFunction(sellerID, query);
        return itemsWithWinners;
    }

    public List<ItemWinnerDetails> getCustomerWonItems(String customerID) {

        List<ItemWinnerDetails> itemsWithWinners = new ArrayList<>();

        String query = "SELECT i.itemId, i.description, i.itemName, i.itemImage, i.itemCondition, "
                + "c.customerID, c.fullName, c.phoneNo, c.address, c.email, "
                + "b.bidID, b.bidDateAndTime, b.bidAmount, a.auctionID ,a.sellerID "
                + "FROM auction a "
                + "JOIN bid b ON a.auctionID = b.auctionID "
                + "JOIN item i ON a.itemId = i.itemId "
                + "JOIN customer c ON b.customerID = c.customerID "
                + "WHERE a.status = 'ended' "
                + "AND a.currentBid = b.bidAmount "
                + "AND b.customerID = ?";

        itemsWithWinners = getItemsCommonFunction(customerID, query);
        return itemsWithWinners;
    }

    public List<ItemWinnerDetails> itemToBeShiped(String sellerID) {

        List<ItemWinnerDetails> itemsWithWinners = new ArrayList<>();

        String query = "SELECT i.itemId, i.description, i.itemName, i.itemImage, i.itemCondition, "
                + "c.customerID, c.fullName, c.phoneNo, c.address, c.email, "
                + "b.bidID, b.bidDateAndTime, b.bidAmount, a.auctionID ,a.sellerID "
                + "FROM auction a "
                + "JOIN bid b ON a.auctionID = b.auctionID "
                + "JOIN item i ON a.itemId = i.itemId "
                + "JOIN customer c ON b.customerID = c.customerID "
                + "AND a.currentBid = b.bidAmount "
                + "AND a.status = 'paid' "
                + "AND a.sellerID = ? ";

        itemsWithWinners = getItemsCommonFunction(sellerID, query);
        return itemsWithWinners;
    }

    public boolean itemShiped(String auctionID) throws SQLException {
        String query = "UPDATE auction SET status='shiped' WHERE auctionID=?";
        PreparedStatement statement = connection.prepareStatement(query);
        statement.setString(1, auctionID);

        return statement.executeUpdate() > 0;
    }

//    public static void main(String[] args) throws ClassNotFoundException, SQLException {
//        Auction auction=new Auction();
//        auction.getEndItemsAndWinners();
//    }
//   public String getAuctionIdFromItemID(String itemId) throws SQLException {
//      String sql = "SELECT auctionID FROM auction WHERE itemId=?";
//      PreparedStatement statement = connection.prepareStatement(sql);
//      statement.setString(1, itemId);
//      ResultSet resultSet = statement.executeQuery();
//      while (resultSet.next()) {
//         String auctionId = resultSet.getString("auctionID");
//        return auctionId;
//      }
//      return null;
//   }
}


//DELIMITER //
//
//CREATE EVENT update_auction_status
//ON SCHEDULE EVERY 1 SECOND
//STARTS CURRENT_TIMESTAMP
//DO
//BEGIN
//    UPDATE auction
//    SET status = CASE
//        WHEN startingDateAndTime <= NOW() AND endDateAndTime > NOW() THEN 'active'
//        WHEN endDateAndTime <= NOW() AND status = 'active' THEN 'ended'
//        ELSE status
//    END
//    WHERE status != 'ended';
//END//
//
//DELIMITER ;
