/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Payment_Model;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrei
 */
@WebServlet(name = "Payment_Controller", urlPatterns = {"/Payment_Controller"})
public class Payment_Controller extends HttpServlet {
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm:ss");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        
        //Test Connection
        if (conn == null) {
         response.sendRedirect("home.jsp?noconnection");
        }
                // get parameters
        String customerID = request.getParameter("customerID");
        String summaryQuantity = request.getParameter("summaryQuantity");
        String summaryName = request.getParameter("summaryName");
        String summaryOption = request.getParameter("summaryOption");
        String summaryPrice = request.getParameter("summaryPrice");
         String total = request.getParameter("total");
        
            // Get the current date and time
            LocalDateTime now = LocalDateTime.now();

            // Format the date and time as strings
            String dateString = now.format(DATE_FORMATTER);
            String timeString = now.format(TIME_FORMATTER);
       
            
            //Insert into customer orders database
                      Payment_Model orderinsert = new Payment_Model();
                        String Yes = orderinsert.insertOrder(customerID, summaryQuantity, summaryName, summaryOption, summaryPrice, total, dateString, timeString, conn);
                        if ("Yes".equals(Yes)) {
                            //Order Submited
                            response.sendRedirect("Customer_Paymentpage.jsp?process=1");
                        } else {
                            //Order Failed
                            response.sendRedirect("Customer_Paymentpage.jsp?process=2");
                        }
        
        //Subtract grams from the recipes table
          //Payment_Model loadIngredientsTable = new Payment_Model();
                    ///set data
                   // ResultSet IngredientsTable = loadIngredientsTable.retrieveIngredients(conn);
        
        //
        
        
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
