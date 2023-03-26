/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.LoginSignup_Model;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author Andrei
 */
@WebServlet(name = "AdminAccount_Controller", urlPatterns = {"/AdminAccount_Controller"})
public class AdminAccount_Controller extends HttpServlet {
//Encryption
private static byte[] key = {0x41,0x4E,0x44,0x52,0x45,0x49,0x4B,0x59,0x4C,0x45,0x48,0x49,0x44,0x41,0x4C,0x47};

        public static String encrypt(String strToEncrypt) {
            String encryptedString = null;
            try {
                Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding", "SunJCE");
                final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
                IvParameterSpec iv = new IvParameterSpec(new byte[16]);
                cipher.init(Cipher.ENCRYPT_MODE, secretKey, iv);
                encryptedString = Base64.encodeBase64String(cipher.doFinal(strToEncrypt.getBytes()));
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
            return encryptedString;
        }

        public static String decrypt(String codeDecrypt){
            String decryptedString = null;
            try{
                Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING", "SunJCE");
                final SecretKeySpec secretKey = new SecretKeySpec(key, "AES");
                IvParameterSpec iv = new IvParameterSpec(new byte[16]);
                cipher.init(Cipher.DECRYPT_MODE, secretKey, iv);
                decryptedString = new String(cipher.doFinal(Base64.decodeBase64(codeDecrypt)));
            } catch (Exception e) {
                System.err.println(e.getMessage());
            }
            return decryptedString;
        }
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get Connection
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        //Test Connection
        if (conn == null) {
         response.sendRedirect("/Home?noconnection");
        }
        LoginSignup_Model adminAccountProcess = new LoginSignup_Model();
        String instruction = request.getParameter("action");
        switch(instruction){
            
            case "adminLogin":
                // get parameters
         String email = request.getParameter("email");
        String adminkey = request.getParameter("adminkey");
        String password = request.getParameter("password");


        
         ResultSet results = adminAccountProcess.retrieveAdminData(email, adminkey, conn);
         try {
            //check if account exists
            if (results == null|| !results.next()) {
                //Account does not exist
                response.sendRedirect("/AdminLogin?process=2");
                results.close();
            }else{
                
                    //Check if password matches with password in the database
                    String checkPassword = decrypt(results.getString("customerPassword"));
                    if (!checkPassword.equals(password)) {

                        //Password does not match
                        response.sendRedirect("/AdminLogin?process=3");
                        results.close();
                    }
                    else{
                    //Set Attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("adminID", results.getString("customerID"));
                     session.setAttribute("adminkey", results.getString("customerLastName"));
                    session.setAttribute("email", results.getString("customerEmail"));
                    session.setAttribute("adminID", results.getString("customerID"));
                    
                    //go to homepage if login is successful       
               
                    response.sendRedirect("/AdminLogin?LoginSuccess");
                    }
            }
                
            } catch (SQLException ex) {
                Logger.getLogger(LoginSignup_Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
         break;
         
         case "adminUpdate":
                             // get parameters
        String adminID = request.getParameter("customerID");
         String emailOld = request.getParameter("emailOld");
         String passwordOld = request.getParameter("passwordOld");
        
        String emailUpdate = request.getParameter("emailUpdate");
        String adminkeyUpdate = request.getParameter("adminkey");
        String passwordUpdate = request.getParameter("passwordUpdate");
        
        //check old password and old email
                 ResultSet resultsUpdate = adminAccountProcess.retrieveAdminData(emailOld, adminkeyUpdate, conn);
         try {
            //check if account exists
            if (resultsUpdate == null|| !resultsUpdate.next()) {
                //Account does not exist
                response.sendRedirect("/AdminAccount?process=2");
                resultsUpdate.close();
            }else{
                
                    //Check if password matches with password in the database
                    String checkPassword = decrypt(resultsUpdate.getString("customerPassword"));
                    if (!checkPassword.equals(passwordOld)) {

                        //Password does not match
                        response.sendRedirect("/AdminAccount?process=3");
                        resultsUpdate.close();
                    }
                    else{
                        //update admin
             // adminAccountProcess.updateAdminData(adminkeyUpdate,emailUpdate ,encrypt(passwordUpdate) , Integer.parseInt(adminID), conn);

               
                    request.getRequestDispatcher("/AdminAccount?UpdateSuccess").forward(request, response);
                    }
            }
                
            } catch (SQLException ex) {
                Logger.getLogger(LoginSignup_Controller.class.getName()).log(Level.SEVERE, null, ex);
            }

             break;
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
