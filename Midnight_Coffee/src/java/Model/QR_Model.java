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
public class QR_Model {
    ///Get the data from the database

    public ResultSet retrieveData(String methodName, Connection conn) {
        try {
            String query = "SELECT * FROM payment_method WHERE methodName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, methodName);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;

            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(LoginSignup_Model.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    ///Insert QR Payment method Data to the Database
    public String insertData(String methodName, String QRImage, Connection conn) {
        String sql = "INSERT INTO payment_method (methodName, QRImage) VALUES ( ?, ?)";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, methodName);
            stmnt.setString(2, QRImage);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(QR_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }
    
         public String updateQR( int methodId, String methodName, String QRImage, Connection conn) throws SQLException {
              String sql = "UPDATE payment_method SET methodName = ?, QRImage = ? WHERE methodId = ?";
            PreparedStatement stmnt = conn.prepareStatement(sql);
             try {
             stmnt.setString(1, methodName);  
             stmnt.setString(2, QRImage); 
             stmnt.setInt(3, methodId);
             stmnt.executeUpdate();
             stmnt.close();
             return "Yes";
    }catch (SQLException ex){
                    Logger.getLogger(QR_Model.class.getName()).log(Level.SEVERE,null,ex);
                }
            return null;

    }
    
    ///Deletes QR Image from database
    public String deleteQR(String methodName, Connection conn){
             String sql ="DELETE FROM payment_method WHERE methodName = ?";
              try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1,methodName);
            stmnt.executeUpdate();
            stmnt.close();
    return "Yes";
                }catch (SQLException ex){
                    Logger.getLogger(QR_Model.class.getName()).log(Level.SEVERE,null,ex);
                }
        return null;
          }
    
    
}
