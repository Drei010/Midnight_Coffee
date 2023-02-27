/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.IngredientList;
import Model.Payment_Model;
import Model.Recipes;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.logging.Level;
import java.util.logging.Logger;
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
        String summaryQuantity =request.getParameter("summaryQuantity");
        String summaryName = request.getParameter("summaryName");
        String summaryOption = request.getParameter("summaryOption");
        String summaryPrice = request.getParameter("summaryPrice");
         String orderTotal = request.getParameter("orderTotal");
        
            // Get the current date and time
            LocalDateTime now = LocalDateTime.now();

            // Format the date and time as strings
            String dateString = now.format(DATE_FORMATTER);
            String timeString = now.format(TIME_FORMATTER);
            
            //Convert string to array 
            String[] summaryQuantityArray = summaryQuantity.split(",");
            String[] summaryNameArray = summaryName.split(",");
           
            //Get array length the item menu
            int ordersArrayLength = summaryNameArray.length;
            
            // object for stocks computaton
            Payment_Model stocksComputation = new Payment_Model();
       
            //get menu item name
            for(int i=0;i<ordersArrayLength;i++ ){
                
                //Remove whitespaces
                String trimmedItemName = summaryNameArray[i].trim();
                
                //Convert Item Quantity into int
                int itemQuantityInt =  Integer.parseInt(summaryQuantityArray[i].trim());
                
                // retrieve the amount of grams that will be subtracted. Set as Subtrahend
                        ResultSet ingredientResult = stocksComputation.retrieveGrams(trimmedItemName, conn);
                                              
                        try {
                            String ingredientsList = ingredientResult.getString("ingredientsList");
                            String weightList =ingredientResult.getString("weightList");


                                //Convert string to array 
                                        String[] ingredientsListArray = ingredientsList.split(",");
                                        String[] weightListArray = weightList.split(",");

                                             //Get array length
                                           int ingredientsArrayLength = ingredientsListArray.length;

                                    for(int j=0;j<ingredientsArrayLength;j++ ){
                                        
                                        //Remove whitespaces
                                       String trimmedIngredientsName = ingredientsListArray[i].trim();
                                        
                                    String stockWeight = stocksComputation.getingredientWeight(trimmedIngredientsName, conn);

                                        //Subtract weight to the total stocks
                                         int newStockWeight =  Integer.parseInt(stockWeight) - (Integer.parseInt(weightListArray[j]) *itemQuantityInt);
                                         
                                         //set the int to string
                                         String newStockWeightStr = Integer.toString(newStockWeight);
                        
                                         //update the difference into the database
                                       String updateSuccess = stocksComputation.updateStocks(trimmedIngredientsName, newStockWeightStr, conn);
                        
                    }
            } catch (SQLException ex) {
                Logger.getLogger(Payment_Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
                        

        
            }

            
        
            //Insert into customer orders database
                      Payment_Model orderinsert = new Payment_Model();
                        String Yes = orderinsert.insertOrder(customerID, summaryQuantity, summaryName, summaryOption, summaryPrice, orderTotal, dateString, timeString, conn);
                        if ("Yes".equals(Yes)) {
                            //Order Submited
                            response.sendRedirect("Customer_Paymentpage.jsp?");
                        } else {
                            //Order Failed
                            response.sendRedirect("Menu_page.jsp?orderFailed");
                        }
        
        //Subtract grams from the recipes table
          //Payment_Model loadIngredientsTable = new Payment_Model();
                    ///set data
                   // ResultSet IngredientsTable = loadIngredientsTable.retrieveIngredients(conn);
        
        //
        
        
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

