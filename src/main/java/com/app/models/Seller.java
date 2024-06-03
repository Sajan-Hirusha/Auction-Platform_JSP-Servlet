package com.app.models;

import com.app.dbConnection.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Seller {

   private String fullName;
   private String email;
   private String businessName;
   private int phoneNumber;
   private String password;

   private final Connection connection;
   public Seller() throws ClassNotFoundException, SQLException {
      this.connection = DbConnection.getInstance().getConnection();
   }

   public Seller(String fullName,String email,String businessName,int phoneNumber,String password) throws SQLException, ClassNotFoundException {
      this();
      this.fullName=fullName;
      this.email=email;
      this.businessName=businessName;
      this.phoneNumber=phoneNumber;
      this.password=password;
   }

   public String getFullName() {
      return fullName;
   }

   public void setFullName(String fullName) {
      this.fullName = fullName;
   }

   public String getEmail() {
      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public String getBusinessName() {
      return businessName;
   }

   public void setBusinessName(String businessName) {
      this.businessName = businessName;
   }

   public int getPhoneNumber() {
      return phoneNumber;
   }

   public void setPhoneNumber(int phoneNumber) {
      this.phoneNumber = phoneNumber;
   }

   public String getPassword() {
      return password;
   }

   public void setPassword(String password) {
      this.password = password;
   }
   public boolean saveSeller() throws SQLException {

      String sql = "Insert Into seller (sellerID, fullName,phoneNo,businessName,email,password)VALUES (?,?,?,?,?,?)";

      String sellerID=generateSellerId();
      PreparedStatement statement = connection.prepareStatement(sql);
      statement.setString(1,sellerID);
      statement.setString(2,this.getFullName());
      statement.setInt(3,this.getPhoneNumber());
      statement.setString(4,this.getBusinessName());
      statement.setString(5,this.getEmail());
      statement.setString(6,this.getPassword());

      return statement.executeUpdate() > 0;
   }

   public String generateSellerId() throws SQLException {
      String sql = "Select sellerNo from seller ORDER BY sellerNo DESC LIMIT 1";
      PreparedStatement statement = connection.prepareStatement(sql);

      ResultSet resultSet = statement.executeQuery();

      if (resultSet.next()) {
                 int sellerNo=resultSet.getInt("sellerNo");

                 String sellerID="SEL/".concat(String.valueOf(sellerNo+1));
                 return sellerID;
      }else{
         int sellerNo=1;
         String sellerID="SEL/".concat(String.valueOf(sellerNo));
         return sellerID;
      }
   }
}
