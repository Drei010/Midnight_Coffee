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

    public ResultSet ingredientItem(String ingredient, Connection conn) {
        try {
            String query = "SELECT * FROM ingredients WHERE ingredientName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, ingredient);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.first();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertIngredient(String ingredient, int weight, Connection conn) {
        if (existIngredient(ingredient, conn)) {
            ResultSet name = ingredientItem(ingredient, conn);
            try {
                String query = "UPDATE ingredients SET ingredientWeight = ? WHERE ingredientName = ?";
                PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmnt.setInt(1, name.getInt("ingredientWeight") + weight);
                stmnt.setString(2, ingredient);
                stmnt.executeUpdate();
                stmnt.close();
            } catch (SQLException ex) {
                Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else{
            try {
                String query = "INSERT INTO ingredients (ingredientName, ingredientWeight) VALUES ( ?, ? )";
                PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmnt.setString(1, ingredient);
                stmnt.setInt(2, weight);
                stmnt.executeUpdate();
                stmnt.close();
            } catch (SQLException ex) {
                Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public boolean existIngredient(String ingredient, Connection conn) {
        try {
            String query = "SELECT * FROM ingredients WHERE ingredientName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, ingredient);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                return true;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
    
    public void deleteIngredient(String ingredient, Connection conn){
        try {
                String query = "DELETE FROM ingredients WHERE ingredientName = ?";
                PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmnt.setString(1, ingredient);
                stmnt.executeUpdate();
                stmnt.close();
            } catch (SQLException ex) {
                Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
            }
    }
}
