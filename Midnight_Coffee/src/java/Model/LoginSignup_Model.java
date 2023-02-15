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
            if (!records.next()) {
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
}
