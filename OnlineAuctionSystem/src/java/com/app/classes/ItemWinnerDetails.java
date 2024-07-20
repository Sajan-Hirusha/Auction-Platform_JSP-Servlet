/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.app.classes;


public class ItemWinnerDetails {
private String description;
    private String itemName;
    private String auctionID;
    private String sellrID;
    private String itemImage;
    private String itemCondition;
    private String customerID;
    private String fullName;
    private String phoneNo;
    private String address;
    private String email;
    private String bidID;
    private String bidDateAndTime;
    private double bidAmount;

   
    public ItemWinnerDetails(String itemId, String description, String itemName, String itemImage, String itemCondition,
            String customerID, String fullName, String phoneNo, String address, String email,
            String bidID, String bidDateAndTime, double bidAmount,String auctionID,String sellrID) {
        this.itemId = itemId;
        this.auctionID = auctionID;
        this.sellrID = sellrID;
        this.description = description;
        this.itemName = itemName;
        this.itemImage = itemImage;
        this.itemCondition = itemCondition;
        this.customerID = customerID;
        this.fullName = fullName;
        this.phoneNo = phoneNo;
        this.address = address;
        this.email = email;
        this.bidID = bidID;
        this.bidDateAndTime = bidDateAndTime;
        this.bidAmount = bidAmount;
        
        System.out.println( customerID);
    }
    
    private String itemId;

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

    public String getSellrID() {
        return sellrID;
    }

    public void setSellrID(String sellrID) {
        this.sellrID = sellrID;
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

    public String getBase64Image() {
        return itemImage;
    }

    public void setBase64Image(String itemImage) {
        this.itemImage = itemImage;
    }

    public String getItemCondition() {
        return itemCondition;
    }

    public void setItemCondition(String itemCondition) {
        this.itemCondition = itemCondition;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNo() {
        return phoneNo;
    }

    public void setPhoneNo(String phoneNo) {
        this.phoneNo = phoneNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getBidID() {
        return bidID;
    }

    public void setBidID(String bidID) {
        this.bidID = bidID;
    }

    public String getBidDateAndTime() {
        return bidDateAndTime;
    }

    public void setBidDateAndTime(String bidDateAndTime) {
        this.bidDateAndTime = bidDateAndTime;
    }

    public double getBidAmount() {
        return bidAmount;
    }

    public void setBidAmount(double bidAmount) {
        this.bidAmount = bidAmount;
    }
    

    // Getters (and possibly setters if needed)
    // Implement as per your requirements
}
