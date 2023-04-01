/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.LoginSignup_Model;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.crypto.spec.IvParameterSpec;
import org.apache.commons.codec.binary.Base64;

/**
 *
 * @author Andrei
 */
@WebServlet(name = "LoginSignup_Controller", urlPatterns = {"/LoginSignup_Controller"})
public class LoginSignup_Controller extends HttpServlet {

//Encryption
    private static byte[] key = {0x41, 0x4E, 0x44, 0x52, 0x45, 0x49, 0x4B, 0x59, 0x4C, 0x45, 0x48, 0x49, 0x44, 0x41, 0x4C, 0x47};

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

    public static String decrypt(String codeDecrypt) {
        String decryptedString = null;
        try {
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

        // get parameters
        String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String mobilenumber = request.getParameter("mobilenumber");

        //check if login or signup
        if (firstname != null) {
            //sign up
            LoginSignup_Model signUp = new LoginSignup_Model();

            //check if Account already exist! Before Sign up
            if (signUp.retrieveData(email, conn) != null) {
                response.sendRedirect("/Signup?process=1");

            }
            if (!firstname.equalsIgnoreCase("admin")) {
            String Yes = signUp.insertData(firstname, lastname, encrypt(password), email, mobilenumber, conn);
            
            if ("Yes".equals(Yes)) {
                //Account Creation Successful data inserted to the database
                response.sendRedirect("/Login?process=1");
            } else {
                //Account Creation Failed
                response.sendRedirect("/Signup?process=2");
            }
             }else{
            //the name admin can't be used as a first name error
            response.sendRedirect("/Signup?process=3");
            }
        } else {
            LoginSignup_Model logIn = new LoginSignup_Model();
            ResultSet results = logIn.retrieveData(email, conn);
            try {
                //check if account exists
                if (results == null|| !results.next()) {
                    //Account does not exist
                    response.sendRedirect("/Login?process=2");
                   
                } else {

                    //Check if password matches with password in the database
                    String checkPassword = decrypt(results.getString("customerPassword"));
                    if (!checkPassword.equals(password)) {

                        //Password does not match
                        response.sendRedirect("/Login?process=3");
                      
                    } else {
                        //Set Attributes
                        HttpSession session = request.getSession();
                        session.setAttribute("firstname", results.getString("customerFirstname"));
                        session.setAttribute("lastname", results.getString("customerLastname"));
                        session.setAttribute("mobilenumber", results.getString("customerMobileNumber"));
                        session.setAttribute("email", results.getString("customerEmail"));
                        session.setAttribute("customerID", results.getString("customerID"));
                        session.setAttribute("role", "customer");
                        session.setAttribute("isGuest", "no");
                        session.setAttribute("loadedFeedback", null);

                        //go to homepage if login is successful       
                        response.sendRedirect("/Home");
                    }
                }

            } catch (SQLException ex) {
                Logger.getLogger(LoginSignup_Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
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
