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

   public Seller(String email,String password) throws SQLException, ClassNotFoundException {
      this();
      this.email=email;
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

      String nextSellerID=generateSellerId();
      PreparedStatement statement = connection.prepareStatement(sql);
      statement.setString(1,nextSellerID);
      statement.setString(2,this.getFullName());
      statement.setInt(3,this.getPhoneNumber());
      statement.setString(4,this.getBusinessName());
      statement.setString(5,this.getEmail());
      statement.setString(6,this.getPassword());

      return statement.executeUpdate() > 0;
   }

   public boolean sellerLogin() throws SQLException {
      String sql = "SELECT password FROM seller WHERE email=?";

      PreparedStatement statement = connection.prepareStatement(sql);
      statement.setString(1,getEmail());

      ResultSet resultSet = statement.executeQuery();
      if (resultSet.next()) {
         String resultPass=resultSet.getString("password");
         System.out.println(resultPass);
         if (this.getPassword().equals(resultPass)) {
            return true;
         }
      }
     return false;
   }

   public String generateSellerId() throws SQLException {
      String sql = "Select sellerID from seller ORDER BY CAST(SUBSTRING(sellerID,5) AS UNSIGNED) DESC LIMIT 1";
      PreparedStatement statement = connection.prepareStatement(sql);

      ResultSet resultSet = statement.executeQuery();

      if (resultSet.next()) {
                 String lastSellerID=resultSet.getString("sellerID");
                 String spliData[]=lastSellerID.split("/");
                 String lastIntegerAsString=spliData[1];
                 int lastIntegerAsInt=Integer.parseInt(lastIntegerAsString);
                 lastIntegerAsInt++;
                 String nextSellerID="SEL/"+lastIntegerAsInt;
                 return nextSellerID;
      }else{
         String nextSellerID="SEL/"+1;
         return nextSellerID;
      }
   }
}
