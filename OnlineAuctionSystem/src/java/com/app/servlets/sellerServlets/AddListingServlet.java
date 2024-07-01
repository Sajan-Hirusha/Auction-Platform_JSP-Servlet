package com.app.servlets.sellerServlets;

import com.app.classes.Item;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.io.InputStream;

@MultipartConfig
public class AddListingServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "E:\\2.2 sem\\RAD\\Activity\\OnlineAuctionSystem\\src\\productImages";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String itemName = req.getParameter("itemName");
        String description = req.getParameter("description");
        String category = req.getParameter("category");
        String condition = req.getParameter("condition");
        String sellerID = "SEL/1";

        // Create the directory if it does not exist
        File uploadDir = new File(UPLOAD_DIRECTORY);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the file part
        Part filePart = req.getPart("productImage");
        // Get the file name using the inbuilt method
        String fileName = filePart.getSubmittedFileName();
        // Create the file object
        File file = new File(uploadDir, fileName);

        // Save the file on disk
        try (InputStream inputStream = filePart.getInputStream()) {
            Files.copy(inputStream, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }

        // Save the file path in the database
        String dbFilePath =fileName; // Store absolute path

        try {
            Item item = new Item(description, itemName, dbFilePath, category, condition, sellerID);
            if (item.addItem()) {
                resp.sendRedirect(req.getContextPath() + "/JspFiles/sellerJsp/addItem.jsp");
            } else {
                resp.sendRedirect("error.jsp?message=" + "Incorrect data");
            }
        } catch (Exception e1) {
            resp.sendRedirect("error.jsp?message=" + URLEncoder.encode(e1.toString(), "UTF-8"));
        }
    }
}
