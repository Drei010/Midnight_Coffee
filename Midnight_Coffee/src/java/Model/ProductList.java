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

    public ResultSet Coffee(Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, "Coffee");
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
    
    public ResultSet KremaLatte(Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, "Kremalatte");
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
    
    public ResultSet Tea(Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, "Tea");
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
    
    public ResultSet Snack(Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, "tea");
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
        String sql = "INSERT INTO products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock) VALUES ( ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, itemName);
            stmnt.setString(2, itemOption);
            stmnt.setString(3, itemPrice);
            stmnt.setString(4, itemImage);
            stmnt.setString(5, itemClass);
            stmnt.setString(6, itemStock);
     
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
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
