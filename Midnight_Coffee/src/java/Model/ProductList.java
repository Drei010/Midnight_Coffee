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

    public ResultSet NonCoffee(Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, "Non-Coffee");
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
            ps.setString(1, "Snack");
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
}
