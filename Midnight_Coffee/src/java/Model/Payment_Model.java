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
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // retrieve the amount of grams that will be subtracted. Set as Subtrahend
    public ResultSet retrieveGrams(int itemCode, Connection conn) {
        try {
            String query = "SELECT * FROM recipes  WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, itemCode);
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

    //update the difference into the database
    public String updateStocks(String ingredientName, String ingredientWeight, Connection conn) {
        String sql = "UPDATE ingredients SET ingredientWeight = ? WHERE ingredientName = ?";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, ingredientWeight);
            stmnt.setString(2, ingredientName);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String getProductClass(int itemCode, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, itemCode);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                return records.getString("itemClass");
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void addProductSold(int itemCode, String itemName, String itemOption, int quantity, Connection conn) {
        int count = retrieveSalesCount(itemCode, conn);
        String query = "";
        if (count == 0) {
            query = "INSERT INTO salescount (count, itemCode, itemOption, itemName, itemClass) VALUES (?, ?, ?, ?, ?)";
        } else {
            query = "UPDATE salescount SET count = ? WHERE itemCode = ? AND itemOption = ? AND itemName = ? AND itemClass = ?";
        }
        try {
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, count + quantity);
            stmnt.setInt(2, itemCode);
            stmnt.setString(3, itemOption);
            stmnt.setString(4, itemName);
            stmnt.setString(5, getProductClass(itemCode, conn));
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int retrieveSalesCount(int itemCode, Connection conn) {
        String query = "SELECT * FROM salescount WHERE itemCode = ?";
        try {
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, itemCode);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.first();
                return records.getInt("count");
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Payment_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }
}
