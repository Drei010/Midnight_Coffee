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


public class ProductList {

    public ResultSet CustomerProducts(String itemClass, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ? AND itemStock = ? AND deactivated = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, itemClass);
            ps.setString(2, "In Stock");
            ps.setString(3, "No");
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

    public ResultSet AdminProducts(String itemClass, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemClass = ?";
            PreparedStatement ps = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
            ps.setString(1, itemClass);
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

    ///Insert menu item Data to the Database
    public String insertData(String itemName, String itemOption, String itemPrice, String itemImage, String itemClass, String itemStock, Connection conn) {
        String sql = "INSERT INTO products (itemName, itemOption, itemPrice, itemImage, itemClass, itemStock, deactivated) VALUES ( ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setString(1, itemName);
            stmnt.setString(2, itemOption);
            stmnt.setString(3, itemPrice);
            stmnt.setString(4, itemImage);
            stmnt.setString(5, itemClass);
            stmnt.setString(6, itemStock);
            stmnt.setString(7, "No");

            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet retrieveData(String itemName, Connection conn) {
        try {
            String query = "SELECT * FROM products WHERE itemName = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, itemName);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }

    public void setStock(String availability, int itemCode, Connection conn) {
        try {
            String query = "UPDATE products SET itemStock = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, availability);
            stmnt.setInt(2, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void changeActivation(String instruction, int itemCode, String timestamp, Connection conn) {
        try {
            String query = "UPDATE products SET deactivated = ?, deactivationtimestamp = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            if (instruction.equals("deactivate")) {
                stmnt.setString(1, "Yes");
                stmnt.setString(2, timestamp);
            } else {
                stmnt.setString(1, "No");
                stmnt.setString(2, null);
            }
            stmnt.setInt(3, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(IngredientList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    ///Deletes product from database
    public String deleteProduct(int itemCode, Connection conn) {
        String sql = "DELETE FROM products WHERE itemCode = ?";
        try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.setInt(1, itemCode);
            stmnt.executeUpdate();
            stmnt.close();
            return "Yes";
        } catch (SQLException ex) {
            Logger.getLogger(QR_Model.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet retrieveProducts(Connection conn) {
        try {
            String query = "SELECT * FROM products";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void UpdateProduct(String name, String option, String price, String image, String category, int code, Connection conn) {
        try {
            String query = "UPDATE products SET itemName = ?, itemOption = ?, itemPrice = ?, itemImage = ?, itemClass = ? WHERE itemCode = ?";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            stmnt.setString(1, name);
            stmnt.setString(2, option);
            stmnt.setString(3, price);
            stmnt.setString(4, image);
            stmnt.setString(5, category);
            stmnt.setInt(6, code);
            stmnt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void UpdateSalescountProduct(String name, String option, int code, Connection conn) {
        try {
            String query = "UPDATE salescount SET itemName = ?, itemOption = ? WHERE itemCode = ?";
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

    public ResultSet getBestSellers(Connection conn) {
        try {
            String query = "SELECT s1.* FROM salescount s1 LEFT JOIN salescount s2 ON s1.itemClass = s2.itemClass AND s1.count < s2.count WHERE s2.count IS NULL;";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet getProductBySales(Connection conn) {
        try {
            String query = "SELECT p.*, IFNULL(s.count, 0) as count FROM products p LEFT JOIN salescount s ON p.itemCode = s.itemCode ORDER BY s.count DESC, p.itemCode ASC";
            PreparedStatement stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
            ResultSet records = stmnt.executeQuery();
            if (records.next()) {
                records.beforeFirst();
                return records;
            }
            stmnt.close();
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ResultSet bestSellers(Connection conn) {
        try {
            ResultSet top = getBestSellers(conn);
            int count = 0;
            String query = "";
            PreparedStatement stmnt = null;
            if (top != null) {
                while (top.next()) {
                    count++;
                }
                top.beforeFirst();
                switch (count) {
                    case 1:
                        query = "SELECT * FROM products WHERE itemCode IN (?)";
                        stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        if (top.next()) {
                            stmnt.setInt(1, top.getInt("itemCode"));
                        }
                        break;
                    case 2:
                        query = "SELECT * FROM products WHERE itemCode IN (?, ?)";
                        stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        if (top.next()) {
                            stmnt.setInt(1, top.getInt("itemCode"));
                        }
                        if (top.next()) {
                            stmnt.setInt(2, top.getInt("itemCode"));
                        }
                        break;
                    case 3:
                        query = "SELECT * FROM products WHERE itemCode IN (?, ?, ?)";
                        stmnt = conn.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
                        if (top.next()) {
                            stmnt.setInt(1, top.getInt("itemCode"));
                        }
                        if (top.next()) {
                            stmnt.setInt(2, top.getInt("itemCode"));
                        }
                        if (top.next()) {
                            stmnt.setInt(3, top.getInt("itemCode"));
                        }
                        break;
                }
                if (count != 0) {
                    ResultSet records = stmnt.executeQuery();
                    if (records.next()) {
                        records.beforeFirst();
                        return records;
                    }
                    stmnt.close();
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductList.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    

        ///Deletes deactivated products from database
    public String deleteDeactivated(Connection conn){
             String sql ="DELETE FROM products WHERE deactivationtimestamp  IS NOT NULL";
              try {
            PreparedStatement stmnt = conn.prepareStatement(sql);
            stmnt.executeUpdate();
            stmnt.close();
    return "Yes";
                }catch (SQLException ex){
                    Logger.getLogger(QR_Model.class.getName()).log(Level.SEVERE,null,ex);
                }
        return null;
          }

}
