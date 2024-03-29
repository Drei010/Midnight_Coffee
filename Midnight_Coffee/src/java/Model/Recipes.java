package Model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Recipes {

    public ResultSet RecipeList(Connection conn) {
        try {
            String query = "SELECT * FROM recipes";
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

    public void insertRecipe(String itemName, String itemOption, String ingredientList, String weightList, Connection conn) {
        try {
            String query = "INSERT INTO recipes (itemName, itemOption, ingredientList, weightList) VALUES ( ?, ?, ?, ? )";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, itemName);
            stmnt.setString(2, itemOption);
            stmnt.setString(3, ingredientList);
            stmnt.setString(4, weightList);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Recipes.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void UpdateRecipe(int itemCode, String list, Connection conn) {
        try {
            String query = "UPDATE recipes SET ingredientList = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, list);
            stmnt.setInt(2, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Recipes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void UpdateProduct(String name, String option, int code, Connection conn){
        try {
            String query = "UPDATE recipes SET itemName = ?, itemOption = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, name);
            stmnt.setString(2, option);
            stmnt.setInt(3, code);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(Recipes.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
