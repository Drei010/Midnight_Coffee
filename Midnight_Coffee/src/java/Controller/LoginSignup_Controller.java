/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;
import Model.LoginSignup_Model;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.annotation.WebServlet;

/**
 *
 * @author Andrei
 */

@WebServlet(name = "LoginSignup_Controller", urlPatterns = {"/LoginSignup_Controller"})
public class LoginSignup_Controller extends HttpServlet {
Connection conn;



    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        try {
            //get class name
            String classname = "com.mysql.cj.jdbc.Driver";//config.getInitParameter("jdbcClassName"); 
            Class.forName(classname);
            
            
            String driver = "jdbc:mysql";//config.getInitParameter("jdbcDriverURL"); 
            String username = "root";//config.getInitParameter("dbUserName");
            String password = "rootpassword";//config.getInitParameter("dbPassword");
            String hostname = "localhost";//config.getInitParameter("dbHostName");
            String dbport = "3306";//config.getInitParameter("dbPort"); 
            String databaseName = "midnightcoffeedb";//config.getInitParameter("databaseName"); 
            String useSSL = "?useSSL=false";//config.getInitParameter("useSSL"); 
            
             //get url name
           String url = driver + "://" + hostname + ":" + dbport + "/"  + databaseName   + useSSL;
            conn = DriverManager.getConnection(url, username, password); 
            
        } catch (SQLException sqle) {
            System.out.println("SQLException error occured - "
                    + sqle.getMessage());
        } catch (ClassNotFoundException nfe) {
            System.out.println("ClassNotFoundException error occured - "
                    + nfe.getMessage());
        }
    }
    
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
            if(signUp.retrieveData(email, conn) != null){
             response.sendRedirect("Signup_page.jsp?process=1");
            return;
            }


            String Yes = signUp.insertData(firstname, lastname, password, email, mobilenumber, conn);
                  if("Yes".equals(Yes)){
            //Account Creation Successful data inserted to the database
             response.sendRedirect("Login_page.jsp?process=1");
                             }
            else{
            //Account Creation Failed
             response.sendRedirect("Signup_page.jsp?process=2");
            }  

            }
            else{
            LoginSignup_Model logIn = new LoginSignup_Model();
            ResultSet results = logIn.retrieveData(email, conn);

            //check if account exists
                            if (results == null){
            //Account does not exist
            response.sendRedirect("Login_page.jsp?process=2");
            }
                            
              try{
                    while (results.next()){
            //Check if passwor matches with password in the database
            if(results.getString("customerPassword").equals(password)!=true){
                
                //Password does not match
            response.sendRedirect("Login_page.jsp?process=3");
            return;
             }              
                                                        
            //go to menupage if login is successful                
            response.sendRedirect("Menu_page.jsp?LoginSuccess");


    }}          catch (SQLException ex) {
                    Logger.getLogger(LoginSignup_Controller.class.getName()).log(Level.SEVERE, null, ex);
                }}}

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
