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

@WebServlet("/addListing")
@MultipartConfig
public class AddListingServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "C:\\Users\\Dilki\\Desktop\\Campus projects\\Online Auction system\\OnlineAuctionPlatform_JSP\\Online-Auction-Platform-JSP-Servlet-\\src\\main\\webapp\\productImages";

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String itemName = req.getParameter("itemName");
        String description = req.getParameter("description");
        String category = req.getParameter("category");
        String condition = req.getParameter("condition");
        String sellerID = "SEL/1";

        String savePath = UPLOAD_DIRECTORY;

        // Create the directory if it does not exist
        File uploadDir = new File(savePath);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        // Get the file part
        Part filePart = req.getPart("productImage");
        // Get the file name
        String fileName = getFileName(filePart);
        // Create the file object
        File file = new File(uploadDir, fileName);

        // Save the file on disk
        filePart.write(file.getAbsolutePath());

        // Save the file path in the database
        String dbFilePath = fileName; // Store relative path

        try {
            Item item = new Item(description, itemName, dbFilePath, category, condition, sellerID);
            if (item.addItem()) {
//                resp.sendRedirect("index.jsp");
                String jspFile = "/JspFiles/sellerJsp/addItem.jsp";
                RequestDispatcher dispatcher = req.getRequestDispatcher(jspFile);
                dispatcher.forward(req, resp);
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



