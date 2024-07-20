package com.app.classes;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.SQLException;
import java.util.Timer;

@WebListener
public class AuctionScheduler implements ServletContextListener {
    private Timer timer;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        timer = new Timer(true);
        try {
            timer.scheduleAtFixedRate(new AuctionStatusChecker(), 0, 2000); 
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (timer != null) {
            timer.cancel();
        }
    }
}