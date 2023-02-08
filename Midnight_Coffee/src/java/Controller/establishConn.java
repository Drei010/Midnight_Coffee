/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author acer
 */
@WebServlet(name = "establishConn", urlPatterns = {"/establishConn"}, loadOnStartup=0)
public class establishConn extends HttpServlet {

    Connection conn;

    public void init(ServletConfig config) throws ServletException {
        super.init(config);

        try {
            //get class name
            String classname = "com.mysql.cj.jdbc.Driver";//config.getInitParameter("jdbcClassName"); 
            Class.forName(classname);
            
            
            String driver = "jdbc:mysql";//config.getInitParameter("jdbcDriverURL"); 
            String username = "root";//config.getInitParameter("dbUserName");
            String password = "heatlifer03";//config.getInitParameter("dbPassword");
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
        
        getServletContext().setAttribute("conn",conn);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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