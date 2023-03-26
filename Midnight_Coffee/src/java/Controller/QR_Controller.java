/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.QR_Model;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Andrei
 */
@MultipartConfig
@WebServlet(name = "QR_Controller", urlPatterns = {"/QR_Controller"})
public class QR_Controller extends HttpServlet {

    //For image upload
    private final static Logger LOGGER
            = Logger.getLogger(QR_Controller.class.getCanonicalName());

    // getFileName() method to get the file name from the part  
    private String getFileName(final Part part) {
        // get header(content-disposition) from the part  
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);

        // code to get file name from the header  
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        // it will return null when it doesn't get file name in the header   
        return null;
    }

    void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = (Connection) getServletContext().getAttribute("conn");

        //Test Connection
        if (conn == null) {
            response.sendRedirect("/Home?noconnection");
        }

        //Get the destination file path of the QRimage folder
        String destination = (String) getServletContext().getAttribute("destination") + "/QRImages";

        //Get Instruction
        String instruction = request.getParameter("instruction");
        HttpSession session = request.getSession();

        //load adminPayment_page
        if ("loadQR".equals(instruction)) {

            ///Get page location
            String page = request.getParameter("page");
            String url = "/" + page;
            QR_Model loadQRTable = new QR_Model();
            ///set data
            ResultSet QRTable = loadQRTable.retrieveQRTable(conn);
            if (QRTable == null) {
                // please put data in the database
                session.setAttribute("QRTableEmpty", "yes");
                session.setAttribute("QRTable", "noTable");
            } else {
                session.setAttribute("QRTable", QRTable);
            }
            //go to either adminPayment or payment page
            response.sendRedirect(url);

        }

        // Check if instruction is to add payment method QR
        if ("createQR".equals(instruction)) {
            // get parameters
            String methodName = request.getParameter("methodName");
            String fileName = getFileName(request.getPart("QRImage"));
            Path source = Paths.get(destination + File.separator + fileName);

            // Only Supports png or jpg
            String filetype = fileName.substring(fileName.length() - 3).toLowerCase();
            if (!("jpg".equals(filetype) || "png".equals(filetype))) {
                response.sendRedirect("/AdminPayment?errorimage");
                return;
            }

            String newImagename = methodName + "." + filetype;

            // Check if the payment method already exists
            QR_Model checkEntry = new QR_Model();
            if (checkEntry.retrieveData(methodName, conn) != null) {
                response.sendRedirect("/AdminPayment?imageexist");
                return;
            }

            // Store the image file
            try (InputStream iptStream = request.getPart("QRImage").getInputStream();
                    OutputStream otpStream = new FileOutputStream(new File(destination + File.separator + fileName))) {
                int read;
                byte[] bytes = new byte[1024];
                while ((read = iptStream.read(bytes)) != -1) {
                    otpStream.write(bytes, 0, read);
                }
            } catch (IOException e) {
                response.sendRedirect("/AdminPayment?failedtoupload");
                return;
            }

            // Rename the file in the same directory
            try {
                Files.move(source, source.resolveSibling(newImagename));
            } catch (IOException e) {
                response.sendRedirect("/AdminPayment?failedtoupload");
                return;
            }

            // Insert the payment method into the database
            QR_Model insertEntry = new QR_Model();
            String insertSuccess = insertEntry.insertData(methodName, newImagename, conn);
            if ("Yes".equals(insertSuccess)) {
                response.sendRedirect("/AdminPayment?success");
            } else {
                response.sendRedirect("/AdminPayment?failedtouploaddatabase");
            }
        }

        /*
                        // Check if instruction is to add payment method QR
            if ("createQR".equals(instruction)) {
                // get parameters
                String methodName = request.getParameter("methodName"); 
                String fileName = getFileName(request.getPart("QRImage"));

                String newImagename = methodName + "." + filetype;

                // Check if the payment method already exists
                QR_Model checkEntry = new QR_Model();
                if (checkEntry.retrieveData(methodName, conn) != null) {
                    response.sendRedirect("adminPayment_page.jsp?imageexist");
                    return;
                }

                // Store the image file to Google Drive
                try {
                    // Authenticate and initialize the Google Drive API client
                    Credential credential = authorize();
                    Drive driveService = new Drive.Builder(HTTP_TRANSPORT, JSON_FACTORY, credential)
                            .setApplicationName("Your Application Name")
                            .build();

                    // Create a new Google Drive file
                    File fileMetadata = new File();
                    fileMetadata.setName(newImagename);
                    java.io.File filePath = new java.io.File("temp");
                    InputStream iptStream = request.getPart("QRImage").getInputStream();
                    FileUtils.copyInputStreamToFile(iptStream, filePath);
                    FileContent mediaContent = new FileContent(filetype, filePath);
                    File file = driveService.files().create(fileMetadata, mediaContent)
                            .setFields("id")
                            .execute();
                    System.out.println("File ID: " + file.getId());
                } catch (IOException e) {
                    response.sendRedirect("adminPayment_page.jsp?failedtoupload");
                    return;
                }

                // Insert the payment method into the database
                QR_Model insertEntry = new QR_Model();
                String insertSuccess = insertEntry.insertData(methodName, newImagename, conn);
                if ("Yes".equals(insertSuccess)) {
                    response.sendRedirect("adminPayment_page.jsp?success");
                } else {
                    response.sendRedirect("adminPayment_page.jsp?failedtouploaddatabase");
                }
            }        
         */
        //update QR entry
        if ("updateQR".equals(instruction)) {
            // Get parameters
            int methodID = Integer.parseInt(request.getParameter("methodID"));
            String methodName = request.getParameter("NewMethodName");
            String OldMethodName = request.getParameter("OldMethodName");

            // Delete old image in folder
            Path file = Paths.get(destination, OldMethodName + ".png");
            if (Files.exists(file)) {
                Files.delete(file);
            } else {
                file = Paths.get(destination, OldMethodName + ".jpg");
                if (Files.exists(file)) {
                    Files.delete(file);
                }
            }

            // Image upload
            Part filePart = request.getPart("newQRImage");
            String fileName = getFileName(filePart);
            Path source = Paths.get(destination, fileName);

            // Check if the file is in .png or .jpg format
            String fileType = fileName.substring(fileName.length() - 3).toLowerCase();
            if (!"jpg".equals(fileType) && !"png".equals(fileType)) {
                response.sendRedirect("/AdminPayment?errorimage");
                return;
            }

            // Save the image to the destination directory
            try (InputStream iptStream = filePart.getInputStream();
                    OutputStream otpStream = new FileOutputStream(source.toFile())) {

                int read;
                final byte[] bytes = new byte[1024];
                while ((read = iptStream.read(bytes)) != -1) {
                    otpStream.write(bytes, 0, read);
                }
            } catch (FileNotFoundException e) {
                response.sendRedirect("/AdminPayment?failedtoupload");
                return;
            } catch (IOException e) {
                response.sendRedirect("/AdminPayment?failedtoupload");
                return;
            }

            // Rename the file in the same directory
            String newImagename = methodName + "." + fileType;
            Path target = Paths.get(destination, newImagename);
            try {
                Files.move(source, target);
            } catch (IOException e) {
                response.sendRedirect("/AdminPayment?failedtoupload");
                return;
            }

            // Update the QR information in the database
            QR_Model updateQR = new QR_Model();
            try {
                String updateSuccess = updateQR.updateQR(methodID, methodName, newImagename, conn);
                if ("Yes".equals(updateSuccess)) {
                    response.sendRedirect("/AdminPayment?success");
                } else {
                    response.sendRedirect("/AdminPayment?failedtoupload");
                }
            } catch (SQLException ex) {
                Logger.getLogger(QR_Controller.class.getName()).log(Level.SEVERE, null, ex);
                response.sendRedirect("/AdminPayment?failedtoupload");
            }

        }

        if ("deleteQR".equals(instruction)) {
            // get parameters
            String methodName = request.getParameter("methodName");

            //delete entry in the database
            QR_Model deleteEntry = new QR_Model();
            deleteEntry.deleteQR(methodName, conn);

            //delete image in folder
            File file = new File(destination + File.separator + methodName + ".png");
            if (!file.delete()) {
                file = new File(destination + File.separator + methodName + ".jpg");
                file.delete();
            }

            //delete image successful
            response.sendRedirect("/AdminPayment?imagedeleted");

        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
