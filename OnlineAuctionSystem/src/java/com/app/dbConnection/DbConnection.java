package com.app.dbConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DbConnection {
 final static String URL = "jdbc:mysql://localhost:3306/auctionsystem";
    final static String USER = "root";
    final static String PASSWORD = "";
    final static String DRIVER = "com.mysql.jdbc.Driver";
    
    public static Connection getConnection(){
    Connection connection = null;
    
        try {
            Class.forName(DRIVER);
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(DbConnection.class.getName()).log(Level.SEVERE, null, ex);
        }
    
    return connection;    
    }
}
  
