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
 * @author acer
 */
public class ProductList {

    public ResultSet CustomerProducts(String itemClass, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ? AND itemStock = ? AND deactivated = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, itemClass);
            ps.setString(2, "In Stock");
            ps.setString(3, "No");
            ResultSet records = ps.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet AdminProducts(String itemClass, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, itemClass);
            ResultSet records = ps.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            ps.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    ///Insert menu item Data to the Database
    public String insertData(String itemName, String itemOption, String itemPrice, String itemImage, String itemClass, String itemStock, Connection conn) {
        String sql = "INSERT INTO products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated) VALUES ( ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, itemName);
            stmnt.setString(2, itemOption);
            stmnt.setString(3, itemPrice);
            stmnt.setString(4, itemImage);
            stmnt.setString(5, itemClass);
            stmnt.setString(6, itemStock);
            stmnt.setString(7, "No");

            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet retrieveData(String itemName, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, itemName);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public void setStock(String availability, int itemCode, Connection conn) {
        try {
            String query = "UPDATE products SET itemStock = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, availability);
            stmnt.setInt(2, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeActivation(String instruction, int itemCode, Connection conn) {
        try {
            String query = "UPDATE products SET deactivated = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (instruction.equals("deactivate")) {
                stmnt.setString(1, "Yes");
            } else {
                stmnt.setString(1, "No");  
            }
            stmnt.setInt(2, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}