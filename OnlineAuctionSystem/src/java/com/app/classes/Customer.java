package com.app.classes;

import com.app.dbConnection.DbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Customer {

   private String fullName;
   private String email;
   private String address;
   private int phoneNumber;
   private String password;

   private final Connection connection;
   public Customer() throws ClassNotFoundException, SQLException {
      this.connection = DbConnection.getConnection();
   }

   public Customer(String fullName, String email, String address, int phoneNumber, String password) throws SQLException, ClassNotFoundException {
      this();
      this.fullName=fullName;
      this.email=email;
      this.address=address;
      this.phoneNumber=phoneNumber;
      this.password=password;
   }

   public Customer(String email, String password) throws SQLException, ClassNotFoundException {
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

   public String getAddress() {
      return address;
   }

   public void setAddress(String address) {
      this.address = address;
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
   public boolean saveCustomer() throws SQLException {

      String sql = "Insert Into customer (customerID, fullName,phoneNo,address,email,password)VALUES (?,?,?,?,?,?)";

      String customerID=generateCustomerId();
      PreparedStatement statement = connection.prepareStatement(sql);
      statement.setString(1,customerID);
      statement.setString(2,this.getFullName());
      statement.setInt(3,this.getPhoneNumber());
      statement.setString(4,this.getAddress());
      statement.setString(5,this.getEmail());
      statement.setString(6,this.getPassword());

      return statement.executeUpdate() > 0;
   }

   public boolean customerLogin() throws SQLException {
      String sql = "SELECT password FROM customer WHERE email=?";

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

   public String generateCustomerId() throws SQLException {
      String sql = "Select customerID from customer ORDER BY CAST(SUBSTRING(customerID,5) AS UNSIGNED) DESC LIMIT 1";
      PreparedStatement statement = connection.prepareStatement(sql);

      ResultSet resultSet = statement.executeQuery();

      if (resultSet.next()) {
                 String lastCustomerID=resultSet.getString("customerID");
                 String spliData[]=lastCustomerID.split("/");
                 String lastIntegerAsString=spliData[1];
                 int lastIntegerAsInt=Integer.parseInt(lastIntegerAsString);
                 lastIntegerAsInt++;
                 String nextCustomerID="CUS/"+lastIntegerAsInt;
                 return nextCustomerID;
      }else{
         String nextCustomerID="CUS/"+1;
         return nextCustomerID;
      }
   }
}
