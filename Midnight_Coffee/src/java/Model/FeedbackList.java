package Model;

import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.util.logging.Level;
import java.util.logging.Logger;

public class FeedbackList {

    public ResultSet FeedbackList(Connection conn) {
        try {
            String query = "SELECT * FROM feedbacklist ORDER BY timestamp";
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

    public ResultSet getRandomFeedback(Connection conn) {
        try {
            String query = "SELECT * FROM feedbacklist WHERE displayed = ? ORDER BY RAND() LIMIT 4";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, "Yes");
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String averageRating(Connection conn) {
        ResultSet list = FeedbackList(conn);
        if (list != null) {
            try {
                DecimalFormat df = new DecimalFormat("0.0");
                double totalRating = 0;
                double totalFeedback = 0;
                while (list.next()) {
                    totalRating += list.getInt("rating");
                    totalFeedback++;
                }
                df.setRoundingMode(RoundingMode.UP);
                return df.format(totalRating/totalFeedback);
            } catch (SQLException ex) {
                Logger.getLogger(FeedbackList.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return "";
    }

    public void updateDisplayed(String displayed, int feedbackID, Connection conn) {
        try {
            String query = "UPDATE feedbacklist SET displayed = ? WHERE feedbackID = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, displayed);
            stmnt.setInt(2, feedbackID);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertFeedback(String message, int rating, int id, Connection conn) {
        try {
            LoginSignup_Model db = new LoginSignup_Model();
            ResultSet customerData = db.getCustomerData(id, conn);
            String query = "INSERT INTO feedbacklist (rating, message, customerID, customerFirstName, customerLastName, displayed) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, rating);
            stmnt.setString(2, message);
            stmnt.setInt(3, id);
            stmnt.setString(4, customerData.getString("customerFirstName"));
            stmnt.setString(5, customerData.getString("customerLastName"));
            stmnt.setString(6, "No");
            stmnt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
