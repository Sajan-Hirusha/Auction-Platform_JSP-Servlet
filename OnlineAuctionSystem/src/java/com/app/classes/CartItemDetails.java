/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.app.classes;

public class CartItemDetails {
    private int cartID;
    private String customerID;
    private String itemId;
    private String sellerID;
    private String auctionID;
    private String description;
    private String itemName;
    private String base64Image;
    private String itemCondition;
   

    public int getCartID() {
        return cartID;
    }

    public void setCartID(int cartID) {
        this.cartID = cartID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getItemId() {
        return itemId;
    }

    public void setItemId(String itemId) {
        this.itemId = itemId;
    }

    public String getSellerID() {
        return sellerID;
    }

    public void setSellerID(String sellerID) {
        this.sellerID = sellerID;
    }

    public String getAuctionID() {
        return auctionID;
    }

    public void setAuctionID(String auctionID) {
        this.auctionID = auctionID;
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
        return base64Image;
    }

    public void setBase64Image(String itemImage) {
        this.base64Image = itemImage;
    }

    public String getItemCondition() {
        return itemCondition;
    }

    public void setItemCondition(String itemCondition) {
        this.itemCondition = itemCondition;
    }

  

    public CartItemDetails(int cartID, String customerID, String itemId, String sellerID, String auctionID, 
                           String description, String itemName, String itemImage, String itemCondition) {
        this.cartID = cartID;
        this.customerID = customerID;
        this.itemId = itemId;
        this.sellerID = sellerID;
        this.auctionID = auctionID;
        this.description = description;
        this.itemName = itemName;
        this.base64Image = itemImage;
        this.itemCondition = itemCondition;
       
    }

}
