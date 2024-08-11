package com.app.classes;

import com.app.dbConnection.DbConnection;

import java.sql.*;

public class Bid {

//    public static void main(String[] args) throws SQLException, ClassNotFoundException {
//        Bid bid= new Bid(3.12,"ITEM/1");
//        String bidID=bid.generateBidId();
//        System.out.println(bidID);
//    }
    private String bidId;
    private Timestamp bidDateAndTime;
    private double bidAmount;
    private String customerID;
    private String auctionID;
    private String itemId;

    private final Connection connection;

    public Bid() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getConnection();
    }
//    public Bid(String auctionID, String customerID, double bidAmount, Timestamp bidDateAndTime, String bidId) throws SQLException, ClassNotFoundException {
//        this();
//        this.auctionID = auctionID;
//        this.customerID = customerID;
//        this.bidAmount = bidAmount;
//        this.bidDateAndTime = bidDateAndTime;
//        this.bidId = bidId;
//    }
    public Bid(double bidAmount, String itemId,Timestamp bidDateAndTim,String customerID) throws SQLException, ClassNotFoundException {
        this();
        this.bidAmount = bidAmount;
        this.itemId = itemId;
        this.bidDateAndTime = bidDateAndTim;
        this.customerID = customerID;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }
    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
    }

    public String getBidId() {
        return bidId;
    }

    public void setBidId(String bidId) {
        this.bidId = bidId;
    }

    public Timestamp getBidDateAndTime() {
        return bidDateAndTime;
    }

    public void setBidDateAndTime(Timestamp bidDateAndTime) {
        this.bidDateAndTime = bidDateAndTime;
    }

    public double getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public boolean placeBid() throws SQLException, ClassNotFoundException {
        String sql = "Insert Into bid (bidID, bidDateAndTime,bidAmount,customerID,auctionID)VALUES (?,?,?,?,?)";
        String bidID = generateBidId();
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, bidID);
        statement.setTimestamp(2, this.getBidDateAndTime());
        statement.setDouble(3, this.getBidAmount());
        statement.setString(4, this.getCustomerID());
        statement.setString(5, this.getAuctionID());

        String sqlUpdate = "UPDATE auction SET currentBid=? WHERE auctionID =?";
        PreparedStatement statementUpdate = connection.prepareStatement(sqlUpdate);
        statementUpdate.setDouble(1, this.getBidAmount());
        statementUpdate.setString(2, this.getAuctionID());
        return statement.executeUpdate() > 0  &&  statementUpdate.executeUpdate()>0;
    }

    public String generateBidId() throws SQLException, ClassNotFoundException {
       
        int auctionIdLength= this.getAuctionID().length();
        String sql = "SELECT bidID FROM bid WHERE auctionId = ? ORDER BY CAST(SUBSTRING(bidID,?) AS UNSIGNED) DESC LIMIT 1";

        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, this.getAuctionID());
        statement.setInt(2, 6+auctionIdLength);
        ResultSet resultSet = statement.executeQuery();

        if (resultSet.next()) {
            String lastBidID = resultSet.getString("bidID");
            String spliData[] = lastBidID .split("-");
            String lastIntegerAsString = spliData[1];
            int lastIntegerAsInt = Integer.parseInt(lastIntegerAsString);
            lastIntegerAsInt++;
            String nextBidID = "BID/" +this.getAuctionID()+"-"+ lastIntegerAsInt;
            return nextBidID;
        } else {
            String nextBidID = "BID/" +this.getAuctionID()+"-"+ + 1;
            return nextBidID;
        }

    }
    
    public double maxBid(String auctionID) throws SQLException{
        String sql = "SELECT currentBid FROM auction WHERE auctionId = ? ";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, auctionID);
          ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                double bidAmount=resultSet.getDouble("currentBid");
                System.out.println(bidAmount);
                return bidAmount;
            }
           return 0.0;
    }

}
