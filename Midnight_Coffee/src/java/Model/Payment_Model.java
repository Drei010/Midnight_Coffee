/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Andrei
 */
public class Payment_Model {
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
}
