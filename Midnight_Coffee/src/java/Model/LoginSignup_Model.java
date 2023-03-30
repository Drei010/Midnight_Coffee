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
public class LoginSignup_Model {
///Get the data from the database

    public ResultSet retrieveData(String email, Connection conn) {
        try {
            String query = "SELECT * FROM customer_credentials WHERE customerEmail = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, email);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            else{
                //records dont exist;
                       }
            stmnt.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    ///Insert signup Data to the Database
    public String insertData(String firstname, String lastname, String password, String email, String mobilenumber, Connection conn) {
        String sql = "INSERT INTO customer_credentials (customerFirstName, customerLastName, customerPassword, customerEmail, customerMobileNumber) VALUES ( ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, firstname);
            stmnt.setString(2, lastname);
            stmnt.setString(3, password);
            stmnt.setString(4, email);
            stmnt.setString(5, mobilenumber);

            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
        public ResultSet retrieveAdminData(String adminkey, Connection conn) {
        try {
            String query = "SELECT * FROM customer_credentials WHERE customerLastName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, adminkey);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            else{
                //records dont exist;
                       }
            stmnt.close();
            
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    
       
    public String updateAdminData(String adminkeyUpdate,  String passwordUpdate, int customerID, Connection conn) {
        String sql = "UPDATE customer_credentials SET customerLastName = ?, customerPassword = ?  WHERE customerID = ?";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, adminkeyUpdate);
            stmnt.setString(2, passwordUpdate);
            stmnt.setInt(3, customerID);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public ResultSet getCustomerData(int id, Connection conn){
        try {
            String query = "SELECT * FROM customer_credentials WHERE customerID = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, id);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.first();
                return records;
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
        public ResultSet getCustomerAccounts( Connection conn){
        try {
            String query = "SELECT * FROM customer_credentials";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.first();
                return records;
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
        
            ///Deletes Customer Account from database
    public String deleteCustomerAccount(int customerID, Connection conn){
             String sql ="DELETE FROM customer_credentials WHERE customerID = ?";
              try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setInt(1,customerID);
            stmnt.executeUpdate();
            stmnt.close();
    return "Yes";
                }catch (SQLException ex){
                    Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE,null,ex);
                }
        return null;
          }
    
    
        public String updateCustomerAccount(int CustomerIDinfo, String newCustomerFirstName,  String newCustomerLastName, String newCustomerEmail, String newCustomerMobileNumber, Connection conn) {
        String sql = "UPDATE customer_credentials SET customerFirstName = ?, customerLastName = ?, customerEmail = ?, customerMobileNumber = ?  WHERE customerID = ?";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, newCustomerFirstName);
            stmnt.setString(2, newCustomerLastName);
            stmnt.setString(3, newCustomerEmail);
            stmnt.setString(4, newCustomerMobileNumber);
            stmnt.setInt(5, CustomerIDinfo);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
        
        public String updatePassword(int CustomerIDinfo,  String customerPassword, Connection conn) {
        String sql = "UPDATE customer_credentials SET customerPassword = ?  WHERE customerID = ?";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, customerPassword);
            stmnt.setInt(2, CustomerIDinfo);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
        public String getCustomerPassword(int id, Connection conn) {
            try {
                String query = "SELECT customerPassword FROM customer_credentials WHERE customerID = ?";
                PreparedStatement stmnt = conn.prepareStatement(query);
                stmnt.setInt(1, id);
                ResultSet records = stmnt.executeQuery();
                if (records.next()) {
                    return records.getString("customerPassword");
                }
            } catch (SQLException ex) {
                Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
            }
            return null;
        }
}
