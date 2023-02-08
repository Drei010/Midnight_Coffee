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
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Andrei
 */
@MultipartConfig 
@WebServlet(name = "QR_Controller", urlPatterns = {"/QR_Controller"})
public class QR_Controller extends HttpServlet {
   
    
 //For image upload
    private final static Logger LOGGER =   
            Logger.getLogger(QR_Controller.class.getCanonicalName());

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
    }void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = (Connection) getServletContext().getAttribute("conn");
   //Get Instruction
        String instruction = request.getParameter("instruction");
        
        
        // Check if instruction is to add payment method QR
         if ("createQR".equals(instruction)) {
             
                  // get parameters
                String methodName = request.getParameter("methodName"); 
                String destination = request.getParameter("destination");//"C:/Users/Andrei/Documents/NetBeansProjects/Midnight_Coffee/Midnight_Coffee/web/QRImages";               

                //image name to be uploaded to the database
                String newImagename = "";


                ///image upload

                         // creating path components for saving the file  
                        final String path = destination;  
                        final Part filePart = request.getPart("QRImage");  
                        final String fileName = getFileName(filePart);  
                        Path source = Paths.get(path+ File.separator + fileName);


                /// Only Suports png or jpg
                String filetype = fileName.substring(fileName.length() - 3).toLowerCase();
                if("jpg".equals(filetype) ||"png".equals(filetype))
                {      
                    // declare instances of OutputStream, InputStream, and PrintWriter classes  
                    OutputStream otpStream = null;  
                    InputStream iptStream = null;  
                    final PrintWriter writer = response.getWriter();  

        // try section handles the code for storing file into the specified location  
        try {  
            // initialize instances of OutputStream and InputStream classes  
            otpStream = new FileOutputStream(new File(path + File.separator + fileName));  
            iptStream = filePart.getInputStream();  
  
            int read = 0;  
              
            // initialize bytes array for storing file data  
            final byte[] bytes = new byte[1024];  
              
            // use while loop to read data from the file using iptStream and write into  the desination folder using writer and otpStream  
            while ((read = iptStream.read(bytes)) != -1) {  
                otpStream.write(bytes, 0, read);  
                }  
                if("jpg".equals(filetype)){
                newImagename = methodName+".jpg";
                }
                else{
                 newImagename = methodName+".png";
                }
                
             //check if Account already exist! Before Sign up
             QR_Model checkEntry = new QR_Model();
            if (checkEntry.retrieveData(methodName, conn) != null) {
                
                 // Image Already Exist
                    response.sendRedirect("adminPayment_page.jsp?imageexist");
                return;
                 }
            else{
                
                 QR_Model insertEntry = new QR_Model();
                 String insertSuccess  = insertEntry.insertData(methodName, newImagename, conn);
                    if("Yes".equals(insertSuccess)){
                    response.sendRedirect("adminPayment_page.jsp?success");

                    }else
                    {
                     // Unable to upload to database
                    response.sendRedirect("adminPayment_page.jsp?failedtouploaddatabase");
                    }
            }


             }  
        // catch section handles the errors   
        catch (FileNotFoundException fne){  
          response.sendRedirect("adminPayment_page.jsp?failedtoupload");
        }  
        // finally section will close all the open classes  
        finally {  
            if (otpStream != null) {  
                otpStream.close();  
            }  
            if (iptStream != null) {  
                iptStream.close();  
            }  
            if (writer != null) {  
                writer.close();  
            }  

        } 
                 // rename a file in the same directory
            if("jpg".equals(filetype)){
              Files.move(source, source.resolveSibling(methodName+".jpg"));

            }
            else{
              Files.move(source, source.resolveSibling(methodName+".png"));

            }

            }   else{
            //image is not in .png or .jpg
            response.sendRedirect("adminPayment_page.jsp?errorimage");}

                    

            return;
         
         }
         
         
         //To follow yung Update mahirap eh :(
         /*
         
         if("updateQR".equals(instruction)){
                // get parameters
                int methodID = Integer.parseInt(request.getParameter("methodID")); 
                String methodName = request.getParameter("methodName"); 
                String destination = request.getParameter("destination");

                //image name to be uploaded to the database
                String newImagename = "";
                
                           //check if Account already exist! Before Sign up
                         QR_Model checkEntry = new QR_Model();
                        checkEntry.retrieveData(methodName, conn);


                
                        //delete image in folder
                        File file  = new File(destination + "//" + methodName +".png");
                               if (file.delete()!=true) {
                                   file  = new File(destination + "//" + methodName +".jpg");
                                   file.delete();
                                }

                ///image upload

                         // creating path components for saving the file  
                        final String path = destination;  
                        final Part filePart = request.getPart("QRImage");  
                        final String fileName = getFileName(filePart);  
                        Path source = Paths.get(path+ File.separator + fileName);


                /// Only Suports png or jpg
                String filetype = fileName.substring(fileName.length() - 3).toLowerCase();
                if("jpg".equals(filetype) ||"png".equals(filetype))
                {      
                        // declare instances of OutputStream, InputStream, and PrintWriter classes  
                        OutputStream otpStream = null;  
                        InputStream iptStream = null;  
                        final PrintWriter writer = response.getWriter();  

                        // try section handles the code for storing file into the specified location  
                        try {  
                            // initialize instances of OutputStream and InputStream classes  
                            otpStream = new FileOutputStream(new File(path + File.separator + fileName));  
                            iptStream = filePart.getInputStream();  

                            int read = 0;  

                            // initialize bytes array for storing file data  
                            final byte[] bytes = new byte[1024];  

                            // use while loop to read data from the file using iptStream and write into  the desination folder using writer and otpStream  
                            while ((read = iptStream.read(bytes)) != -1) {  
                                otpStream.write(bytes, 0, read);  
                                }  
                                if("jpg".equals(filetype)){
                                newImagename = methodName+".jpg";
                                }
                                else{
                                 newImagename = methodName+".png";
                                }
                                 QR_Model UpdateQR = new QR_Model();
                                try{
                 String updateSuccess= UpdateQR.updateQR(methodID, methodName,newImagename,conn);
                                    if("Yes".equals(updateSuccess)){
                                    response.sendRedirect("index.jsp?success");

                                    }else
                                    {
                                     // Unable to upload to database
                                    response.sendRedirect("index.jsp?failedtoupload");
                                    }

                                }
                                catch (SQLException ex) {
                                                Logger.getLogger(QR_Controller.class.getName()).log(Level.SEVERE,null,ex);
                                            }
                             }  
                        // catch section handles the errors   
                        catch (FileNotFoundException fne){  
                          response.sendRedirect("index.jsp?failedtoupload");
                        }  
                        // finally section will close all the open classes  
                        finally {  
                            if (otpStream != null) {  
                                otpStream.close();  
                            }  
                            if (iptStream != null) {  
                                iptStream.close();  
                            }  
                            if (writer != null) {  
                                writer.close();  
                            }  

                        } 
                     // rename a file in the same directory
                if("jpg".equals(filetype)){
                  Files.move(source, source.resolveSibling(methodName+".jpg"));

                }
                else{
                  Files.move(source, source.resolveSibling(methodName+".png"));

                }

                }   else{
                //image is not in .png or .jpg
                response.sendRedirect("index.jsp?errorimage");}


                return;
                }
         
         */
         
         
                if("deleteQR".equals(instruction)){
                        // get parameters
                        String methodName = request.getParameter("methodName");
                        String destination = request.getParameter("destination");
                        
                        //delete entry in the database
                       QR_Model deleteEntry = new QR_Model();
                        deleteEntry.deleteQR(methodName, conn);

                        //delete image in folder
                        File file  = new File(destination + "//" + methodName +".png");
                               if (file.delete()!=true) {
                                   file  = new File(destination + "//" + methodName +".jpg");
                                   file.delete();
                                }


                       //delete image successful
                        response.sendRedirect("adminPayment_page.jsp?imagedeleted");
                        return;
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
