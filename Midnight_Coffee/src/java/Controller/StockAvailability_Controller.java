package Controller;

import Model.IngredientList;
import Model.ProductList;
import Model.Recipes;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet(name = "StockAvailability_Controller", urlPatterns = {"/StockAvailability_Controller"})
public class StockAvailability_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        
        String name = request.getParameter("names");
        String weight = request.getParameter("weights");

        String ingredientArray[] = name.split(", ");
        String weightArray[] = weight.split(", ");

        IngredientList ingredientListMethod = new IngredientList();
        Recipes recipesMethod = new Recipes();
        ProductList productListMethod = new ProductList();

        //loop through ingredients needed for order
        for (int i = 0; i < ingredientArray.length; i++) {
            try {

                //subtract number of ingredients used for order 
                ingredientListMethod.minusIngredient(ingredientArray[i], Integer.parseInt(weightArray[i]), conn);
                ResultSet productList = recipesMethod.RecipeList(conn);

                //loop through all products
                while (productList.next()) {

                    //check if product uses the ingredient
                    if (productList.getString("ingredientList").contains(ingredientArray[i])) {

                        //puts ingredient list in array for looping
                        String recipeArray[] = productList.getString("ingredientList").split(",");

                        //loops through product's recipe
                        for (String currIngredient : recipeArray) {

                            //check if recipe array is on ingredient being checked
                            if (currIngredient.equals(ingredientArray[i])) {

                                //get current weights
                                int remaining = ingredientListMethod.ingredientItem(ingredientArray[i], conn).getInt("ingredientWeight");
                                int minimum = ingredientListMethod.ingredientItem(ingredientArray[i], conn).getInt("MinimumWeight");

                                //check if remaining stock is more than minimum requirement
                                if (remaining <= minimum) {

                                    //remaining stock is not more than minimum requirement so current product selected is set to out of stock
                                    productListMethod.setStock("Out of Stock", productList.getString("itemName"), conn);
                                }
                            }
                        }
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(StockAvailability_Controller.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
