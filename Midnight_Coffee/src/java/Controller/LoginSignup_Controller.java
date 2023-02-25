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
/**
 *
 * @author Andrei
 */
@WebServlet(name = "LoginSignup_Controller", urlPatterns = {"/LoginSignup_Controller"})
public class LoginSignup_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get Connection
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        //Test Connection
        if (conn == null) {
         response.sendRedirect("home.jsp?noconnection");
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
                response.sendRedirect("Signup_page.jsp?process=1");
              
            }

            String Yes = signUp.insertData(firstname, lastname, password, email, mobilenumber, conn);
            if ("Yes".equals(Yes)) {
                //Account Creation Successful data inserted to the database
                response.sendRedirect("Login_page.jsp?process=1");
            } else {
                //Account Creation Failed
                response.sendRedirect("Signup_page.jsp?process=2");
            }

        } else {
            LoginSignup_Model logIn = new LoginSignup_Model();
            ResultSet results = logIn.retrieveData(email, conn);
              try {
            //check if account exists
            if (results == null|| !results.next()) {
                //Account does not exist
                response.sendRedirect("Login_page.jsp?process=2");
                results.close();
            }else{
                
                    //Check if password matches with password in the database
                    String checkPassword = results.getString("customerPassword");
                    if (!checkPassword.equals(password)) {

                        //Password does not match
                        response.sendRedirect("Login_page.jsp?process=3");
                        results.close();
                    }
                    else{
                    //Set Attributes
                    HttpSession session = request.getSession();
                    session.setAttribute("firstname", results.getString("customerFirstname"));
                    session.setAttribute("lastname", results.getString("customerLastname"));
                    session.setAttribute("customerID", results.getString("customerID"));
                    session.setAttribute("isGuest","no");

                    //go to homepage if login is successful       
               
                    request.getRequestDispatcher("home.jsp?LoginSuccess").forward(request, response);
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
