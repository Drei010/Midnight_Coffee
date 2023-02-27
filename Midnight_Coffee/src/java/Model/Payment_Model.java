/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Andrei
 */
public class Payment_Model {
        ///Insert QR Payment method Data to the Database
    public String insertOrder(String customerID, String summaryQuantity, String summaryName, String summaryOption, String summaryPrice, String orderTotal, String orderDate, String orderTime, Connection conn) {
        String sql = "INSERT INTO customer_orders (customerID, summaryQuantity, summaryName, summaryOption, summaryPrice, orderTotal, orderDate, orderTime) VALUES ( ?, ?, ?, ?, ?, ?, ?, ? )";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, customerID);
            stmnt.setString(2, summaryQuantity);
            stmnt.setString(3, summaryName);
            stmnt.setString(4, summaryOption);
            stmnt.setString(5, summaryPrice);
            stmnt.setString(6, orderTotal);
            stmnt.setString(7, orderDate);
            stmnt.setString(8, orderTime);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
    
    
        public ResultSet retrieveIngredients(Connection conn) {
        try {
            String query = "SELECT * FROM recipes";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
        
            
    
    public String getingredientWeight(String ingredient, Connection conn) {
    try {
        String query = "SELECT * FROM ingredients WHERE ingredientName = ?";
        PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
        stmnt.setString(1, ingredient);
        ResultSet records = stmnt.executeQuery();
        if (records.next()) {
            String ingredientWeight = records.getString("ingredientWeight");
            stmnt.close();
            return ingredientWeight;
        }
        stmnt.close();
    } catch (SQLException ex) {
        Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
    }
    return null;
    
    
}
          ///Retrieve grams of an ingredient  
            public ResultSet retrieveGrams(String itemName, Connection conn) {
        try {
            String query = "SELECT * FROM recipes  WHERE itemName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
            
            
                     public String updateStocks(String ingredientName, String ingredientWeight, Connection conn) throws SQLException {
              String sql = "UPDATE ingredients SET ingredientWeight = ? WHERE ingredientName = ?";
            PreparedStatement stmnt = conn.prepareStatement(sql);
             try {
             stmnt.setString(1, ingredientWeight);  
             stmnt.setString(2, ingredientName); 
             stmnt.executeUpdate();
             stmnt.close();
             return "Yes";
    }catch (SQLException ex){
                    Logger.getLogger(QR_Model.class.getName()).log(Level.SEVERE,null,ex);
                }
            return null;

    }
}
