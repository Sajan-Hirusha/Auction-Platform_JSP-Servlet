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

public class Admin {

    private String adminId;
    private String email;
    private String password;

    private final Connection connection;

    public Admin() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getConnection();
    }

    public Admin(String email, String password) throws ClassNotFoundException, SQLException {
         this();
        this.email = email;
        this.password = password;
    }

    

    public String getAdminId() {
        return adminId;
    }

    public String getEmail() {
        return email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public boolean adminLogin() throws SQLException {
        String sql = "SELECT password,adminID FROM admin WHERE email= ?";
        PreparedStatement statement = connection.prepareStatement(sql);
        statement.setString(1, getEmail());
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {

            String resultPass = resultSet.getString("password");
            System.out.println(resultPass);
            if (this.getPassword().equals(resultPass)) {
                this.adminId = resultSet.getString("adminID");
                return true;
            }
        }
        return false;
    }
}
