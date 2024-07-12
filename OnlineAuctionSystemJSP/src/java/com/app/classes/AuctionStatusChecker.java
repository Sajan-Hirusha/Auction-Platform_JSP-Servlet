package com.app.classes;

import com.app.dbConnection.DbConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.TimerTask;

public class AuctionStatusChecker extends TimerTask {

    private final Connection connection;

    public AuctionStatusChecker() throws ClassNotFoundException, SQLException {
        this.connection = DbConnection.getConnection();
    }

    @Override
    public void run() {
        PreparedStatement stmt = null;

        try {


            // Update auction status
            String updateStatusSql = "UPDATE auction SET status = CASE " +
                    "WHEN startingDateAndTime <= NOW() AND endDateAndTime > NOW() THEN 'active' " +
                    "WHEN endDateAndTime <= NOW() THEN 'ended' " +
                    "ELSE status END";
            stmt = connection.prepareStatement(updateStatusSql);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}