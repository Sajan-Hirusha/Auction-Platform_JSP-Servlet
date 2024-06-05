package com.app.controllers.sellerServlets;

import com.app.models.Item;
import com.app.models.Seller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/updateListing")
@MultipartConfig
public class UpdateListingServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "C:\\Users\\Dilki\\Desktop\\Campus projects\\Online Auction system\\OnlineAuctionPlatform_JSP\\Online-Auction-Platform-JSP-Servlet-\\src\\main\\webapp\\productImages";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String itemId = req.getParameter("itemID");
        String itemName = req.getParameter("updateItemName");
        String description = req.getParameter("updateDescription");
        String category = req.getParameter("updateCategory");
        String condition = req.getParameter("updateCondition");
        String previousImageName = req.getParameter("previousImageName");
        String sellerID = "SEL/1";

        String savePath = UPLOAD_DIRECTORY;

        // Create the directory if it does not exist
        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the file part
        Part filePart = req.getPart("updateProductImage");
        // Get the file name

        String dbFilePath=null;
        if (filePart != null) {
            String fileName = getFileName(filePart);
            File file = new File(uploadDir, fileName);
            filePart.write(file.getAbsolutePath());
            dbFilePath = fileName;
        }else {
            dbFilePath = previousImageName;
        }

        try {
            Item item = new Item(description, itemName, dbFilePath,condition, category);
            item.setItemId(itemId);
            if (item.updateItem()) {
                resp.sendRedirect("../../viewListingsForUpdate");
            } else {
                resp.sendRedirect("error.jsp?message=" + "Incorrect data");
            }
        } catch (Exception e1) {
            resp.sendRedirect("error.jsp?message=" + URLEncoder.encode(e1.toString(), "UTF-8"));
        }
    }

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }
}



