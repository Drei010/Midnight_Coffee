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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
@WebServlet(name = "CustomerAccount_Controller", urlPatterns = {"/CustomerAccount_Controller"})
public class CustomerAccount_Controller extends HttpServlet {
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

        // Declare model
        LoginSignup_Model processAccounts = new LoginSignup_Model();
        HttpSession session = request.getSession();
        String instruction = request.getParameter("action");
        switch (instruction) {
            case "load":               
                 //deactivate account 365 days since last login
                // get the current date and time
                Calendar calendar = Calendar.getInstance();
                Date now = calendar.getTime();

                // format the date and time into a string
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String timestamp = dateFormat.format(now);

                //get current time stamp
              Timestamp current = Timestamp.valueOf(timestamp);

               

                // retrieve accounts
                ResultSet results = processAccounts.getCustomerAccounts(conn);

                if (results == null) {
                    response.sendRedirect("/adminCustomerManagement_page");
                }
                try {

                    while (results.next()) {

                        if (results.getString("lastLoginTimestamp") != null) {
                            //get date of the last login
                            Timestamp old = Timestamp.valueOf(results.getString("lastLoginTimestamp"));
                            
                            Calendar cal = Calendar.getInstance();
                            cal.setTime(old);
                            cal.add(Calendar.DAY_OF_YEAR, 365);
                             old = new Timestamp(cal.getTimeInMillis());
                            //old is before the current
                                if (old.compareTo(current) < 0) {
                                
                                //deactivate account
                                processAccounts.deactivateAccount(results.getString("customerID"), "Yes", conn);

                            }
                            else{
                            //deactivate account
                                processAccounts.deactivateAccount(results.getString("customerID"), "No", conn);
                            }
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(CustomerAccount_Controller.class.getName()).log(Level.SEVERE, null, ex);
                }
                
                                //Load customer Accounts
                session.setAttribute("customerAccounts", processAccounts.getCustomerAccounts(conn));
                
                              //Load Deactivated customer Accounts
                session.setAttribute("customerDeactivatedAccounts", processAccounts.getDeactivatedAccounts(conn));
                
                session.setAttribute("loadedCustomerAccounts", "yes");
                
                 response.sendRedirect("/adminCustomerManagement_page");
                break;
            case "Reactivate":
                
                             // get the current date and time
                Calendar calendarNew = Calendar.getInstance();
                Date present = calendarNew.getTime();

                // format the date and time into a string
                SimpleDateFormat dateFormatNew = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String timestampNew = dateFormatNew.format(present);
                //Delete customer Accounts admin side
               String customerIDadmin = request.getParameter("customerID");
                //processAccounts.deleteCustomerAccount(customerIDadmin,conn);
                
               String Yes = processAccounts.insertTimestamp(timestampNew, customerIDadmin, conn);
               session.setAttribute("loadedCustomerAccounts", "");
                 response.sendRedirect("/adminCustomerManagement_page");
                 
                break;
                
                
                
            case "DeleteCustomer":
                //Customer side delete
                int customerID = Integer.parseInt(request.getParameter("customerID"));
                processAccounts.deleteCustomerAccount(customerID,conn);
                response.sendRedirect("/Account_page");
                break;
            case  "updatePassword":
                int CustomerIDpassword= Integer.parseInt(request.getParameter("customerID"));
                String oldCustomerPassword = request.getParameter("oldCustomerPassword");
                String newCustomerPassword = request.getParameter("newCustomerPassword");
                
                //get old password
                String encryptedOldPassword = processAccounts.getCustomerPassword(CustomerIDpassword, conn);
                
                
                if (oldCustomerPassword.equals(decrypt(encryptedOldPassword))) {
                    
                //Update Password
                processAccounts.updatePassword(CustomerIDpassword, encrypt(newCustomerPassword), conn);
                response.sendRedirect("/Account_page?passwordupdated"); 
                
                } else {
                    response.sendRedirect("/Account_page?oldpasswordisincorrect"); 
                }

                break;
            case  "updateInfo":
                 int CustomerIDinfo = Integer.parseInt(request.getParameter("customerID"));
                 String newCustomerFirstName = request.getParameter("newCustomerFirstName");
                 String newCustomerLastName = request.getParameter("newCustomerLastName");
                 String newCustomerEmail = request.getParameter("newCustomerEmail");
                 String newCustomerMobileNumber = request.getParameter("newCustomerMobileNumber");
                 
                 //Update General Info
                 processAccounts.updateCustomerAccount(CustomerIDinfo, newCustomerFirstName, newCustomerLastName, newCustomerEmail, newCustomerMobileNumber, conn);

                response.sendRedirect("/Logout"); 
                break;
                
                
            case  "Forgotpassword":
                
                 String email = request.getParameter("email");
                 String mobileNumber = request.getParameter("mobileNumber");

                 //Retrieve customer ID
                 String customerRetrievedID = processAccounts.getCustomerID(email, mobileNumber, conn);
                 if(customerRetrievedID!=null){
                     //Account retrieved
                 session.setAttribute("customerRetrievedID", customerRetrievedID);
                  response.sendRedirect("/Resetpassword_page.jsp"); 
                 }else{
                 //Account does not exist
                  response.sendRedirect("/Forgotpassword_page?process=1"); 
                 }
                     
                break;
                
            case  "Resetpassword":
                
                 String newPassword = request.getParameter("newPassword");
                 int customerIDPassword = Integer.parseInt(request.getParameter("customerIDPassword"));

                 //Update Password
                 String yes = processAccounts.updatePassword(customerIDPassword, encrypt(newPassword), conn);
                 if(yes.equals("Yes")){
                     //login Success
                  session.removeAttribute("customerRetrievedID");
                  response.sendRedirect("/Login?process=4");
                 
               }else{
                 //login Failed
                  response.sendRedirect("/Forgotpassword_page?process=1");
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
