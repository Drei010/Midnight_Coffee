
package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class IngredientList {
    public ResultSet Ingredients(Connection conn) {
        try {
            String query = "SELECT * FROM ingredients";
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
    
    public void insertIngredient(Connection conn){
        
    }
}
