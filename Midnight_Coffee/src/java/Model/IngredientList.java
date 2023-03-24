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
            String query = "SELECT * FROM ingredients ORDER BY ingredientName";
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

    public ResultSet ActiveIngredients(Connection conn) {
        try {
            String query = "SELECT * FROM ingredients WHERE deactivationtimestamp IS NULL ORDER BY ingredientName";
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

    public void addIngredient(String ingredient, int weight, int min, Connection conn) {
        ResultSet name = ingredientItem(ingredient, conn);
        try {
            if (existIngredient(ingredient, conn)) {
                String query = "UPDATE ingredients SET ingredientWeight = ? WHERE ingredientName = ?";
                PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmnt.setInt(1, name.getInt("ingredientWeight") + weight);
                stmnt.setString(2, ingredient);
                stmnt.executeUpdate();
                stmnt.close();
            } else {
                String query = "INSERT INTO ingredients (ingredientName, ingredientWeight, minimumWeight) VALUES ( ?, ?, ? )";
                PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                stmnt.setString(1, ingredient);
                stmnt.setInt(2, weight);
                stmnt.setInt(3, min);
                stmnt.executeUpdate();
                stmnt.close();
            }

            setInStock(ingredient, conn);

        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean existIngredient(String ingredient, Connection conn) {
        ResultSet records = ingredientItem(ingredient, conn);
        return records != null;
    }

    public void changeActivation(String instruction, int itemCode, String timestamp, Connection conn) {
        try {
            String query = "UPDATE ingredients SET deactivationtimestamp = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (instruction.equals("Deactivate")) {
                stmnt.setString(1, timestamp);
            } else {
                stmnt.setString(1, null);
            }
            stmnt.setInt(2, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteIngredient(int itemCode, Connection conn) {
        try {
            String query = "DELETE FROM ingredients WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void minusIngredient(String ingredient, int weight, Connection conn) {
        ResultSet name = ingredientItem(ingredient, conn);
        try {
            String query = "UPDATE ingredients SET ingredientWeight = ? WHERE ingredientName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setInt(1, name.getInt("ingredientWeight") - weight);
            stmnt.setString(2, ingredient);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void setInStock(String ingredient, Connection conn) {
        try {
            ResultSet name = ingredientItem(ingredient, conn);
            ProductList productListMethod = new ProductList();
            Recipes recipesMethod = new Recipes();
            ResultSet productList = recipesMethod.RecipeList(conn);

            System.out.println("AAAAAAAAAA " + (name.getInt("ingredientWeight") > name.getInt("minimumWeight")));
            if (name.getInt("ingredientWeight") > name.getInt("minimumWeight")) {
                if (productList != null) {
                    while (productList.next()) {
                        if (productList.getString("ingredientList").contains(ingredient)) {
                            String recipeArray[] = productList.getString("ingredientList").split(",");
                            if (recipeArray.length <= 1) {
                                productListMethod.setStock("In Stock", productList.getInt("itemCode"), conn);
                            }
                            for (String currIngredient : recipeArray) {
                                if (!currIngredient.equals(ingredient)) {
                                    ResultSet otherIngredient = ingredientItem(currIngredient, conn);
                                    if (otherIngredient != null) {
                                        if (otherIngredient.getInt("ingredientWeight") > otherIngredient.getInt("minimumWeight")) {
                                            productListMethod.setStock("In Stock", productList.getInt("itemCode"), conn);
                                        }
                                    } else {
                                        productListMethod.setStock("In Stock", productList.getInt("itemCode"), conn);
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                while (productList.next()) {
                    if (productList.getString("ingredientList").contains(ingredient)) {
                        String recipeArray[] = productList.getString("ingredientList").split(",");
                        if (recipeArray.length <= 1) {
                            productListMethod.setStock("Out of Stock", productList.getInt("itemCode"), conn);
                        }
                        for (String currIngredient : recipeArray) {
                            if (!currIngredient.equals(ingredient)) {
                                ResultSet otherIngredient = ingredientItem(currIngredient, conn);
                                if (otherIngredient != null) {
                                    if (otherIngredient.getInt("ingredientWeight") < otherIngredient.getInt("minimumWeight")) {
                                        productListMethod.setStock("Out of Stock", productList.getInt("itemCode"), conn);
                                    }
                                } else {
                                    productListMethod.setStock("Out of Stock", productList.getInt("itemCode"), conn);
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void UpdateIngredient(int itemCode, String updateName, int weight, int min, Connection conn) {
        try {
            String query = "UPDATE ingredients SET ingredientName = ?, ingredientWeight = ?, minimumWeight = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, updateName);
            stmnt.setInt(2, weight);
            stmnt.setInt(3, min);
            stmnt.setInt(4, itemCode);
            stmnt.executeUpdate();
            stmnt.close();

            setInStock(updateName, conn);
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
