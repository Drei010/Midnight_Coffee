package Controller;

import Model.IngredientList;
import Model.ProductList;
import Model.Recipes;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Ingredient_Controller", urlPatterns = {"/Ingredient_Controller"})
public class Ingredient_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Get Connection
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        //Test Connection
        if (conn == null) {
            response.sendRedirect("home.jsp?noconnection");
        }

        // Declare model
        IngredientList ingredientsProcess = new IngredientList();

        String instruction = request.getParameter("action");
        switch (instruction) {
            case "load":
                //Load Ingredients
                request.setAttribute("ingredients", ingredientsProcess.Ingredients(conn));
                request.setAttribute("active", ingredientsProcess.ActiveIngredients(conn));
                request.setAttribute("loadedIngredients", "yes");
                request.setAttribute("loadedActive", "yes");
                request.getRequestDispatcher("adminIngredients_page.jsp").forward(request, response);

                //delete entry after 30 days of deactivation
                // get the current date and time
                Calendar calendar = Calendar.getInstance();
                Date now = calendar.getTime();

                // format the date and time into a string
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String timestamp = dateFormat.format(now);

                //get current time stamp
                Timestamp current = Timestamp.valueOf(timestamp);
                /// loadMenu.deleteProduct(timestamp, conn);

                // retrieve ingredients
                ResultSet resultsLoad = ingredientsProcess.Ingredients(conn);

                try {
                    while (resultsLoad.next()) {

                        if (resultsLoad.getString("deactivationtimestamp") != null) {
                            //get timestamp of the ingredients when it was deactivated
                            Timestamp old = Timestamp.valueOf(resultsLoad.getString("deactivationtimestamp"));

                            //old is before the current
                            if (old.compareTo(current) < 0) {
                                ingredientsProcess.deleteIngredient(Integer.parseInt(resultsLoad.getString("itemCode")), conn);

                            }
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(Ingredient_Controller.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;

            case "insertIngredient":
                //Get Parameters
                String ingredientName = request.getParameter("ingredientName");
                int weight = Integer.parseInt(request.getParameter("weight"));
                int min = Integer.parseInt(request.getParameter("minimum"));

                // Validate Parameters
                if (ingredientName == null || ingredientName.trim().isEmpty()
                        || request.getParameter("weight") == null || request.getParameter("minimum") == null) {
                    response.sendRedirect("adminIngredients_page.jsp?invalidinput");
                    return;
                }
                //Check if Ingredient Exist
                ResultSet results = ingredientsProcess.ingredientItem(ingredientName, conn);

                //Redirect to adminIngredients page if ingredients exist
                if (results != null) {
                    response.sendRedirect("adminIngredients_page.jsp?ingredientalreadyexists");
                } else {
                    //Add Ingredient
                    ingredientsProcess.addIngredient(ingredientName, weight, min, conn);
                    response.sendRedirect("adminIngredients_page.jsp?ingredientadded");
                }

                break;

            case "addIngredient":
                ingredientName = request.getParameter("ingredientName");
                weight = Integer.parseInt(request.getParameter("weight"));

                if (ingredientName == null || ingredientName.trim().isEmpty()) {
                    response.sendRedirect("adminIngredients_page.jsp?invalidinput");
                    return;
                }

                results = ingredientsProcess.ingredientItem(ingredientName, conn);

                //Redirect to adminIngredients page if ingredients exist
                if (results == null) {
                    response.sendRedirect("adminIngredients_page.jsp?ingredientdoesnotexist");
                } else {
                    //Add Ingredient
                    ingredientsProcess.addIngredient(ingredientName, weight, 0, conn);
                    response.sendRedirect("adminIngredients_page.jsp?addedweightsuccess");
                }

                break;

            case "updateIngredient":

                ingredientName = request.getParameter("ingredientName");
                String updateName = request.getParameter("updatedName");
                String weightS = request.getParameter("updateWeightNumber");
                String minS = request.getParameter("updateMinimumNumber");
                weight = 0;
                min = 0;

                if (ingredientName == null || ingredientName.trim().isEmpty()) {
                    response.sendRedirect("adminIngredients_page.jsp?invalidinput");
                    return;
                }

                if (updateName == null || updateName.trim().isEmpty()) {
                    updateName = ingredientName;
                }

                results = ingredientsProcess.ingredientItem(ingredientName, conn);

                if (weightS == null || weightS.trim().isEmpty()) {
                    try {
                        weight = results.getInt("ingredientWeight");
                        System.out.println(results.getInt("ingredientWeight"));
                    } catch (SQLException ex) {
                        Logger.getLogger(Ingredient_Controller.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    weight = Integer.parseInt(weightS);
                }
                
                if (minS == null || minS.trim().isEmpty()) {
                    try {
                        min = results.getInt("minimumWeight");
                    } catch (SQLException ex) {
                        Logger.getLogger(Ingredient_Controller.class.getName()).log(Level.SEVERE, null, ex);
                    }
                } else {
                    min = Integer.parseInt(minS);
                }

                results = ingredientsProcess.ingredientItem(updateName, conn);

                //Redirect to adminIngredients page if ingredients exist
                if (results != null && !updateName.equals(ingredientName)) {
                    response.sendRedirect("adminIngredients_page.jsp?ingredientalreadyexists");
                } else {
                    try {
                        //Update Ingredient
                        ResultSet ingredients = ingredientsProcess.ingredientItem(ingredientName, conn);
                        ingredientsProcess.UpdateIngredient(ingredients.getInt("itemCode"), updateName, weight, min, conn);
                        Recipes recipes = new Recipes();
                        ResultSet list = recipes.RecipeList(conn);
                        while (list.next()) {
                            if (list.getString("ingredientList").contains(ingredientName)) {
                                recipes.UpdateRecipe(list.getInt("itemCode"), list.getString("ingredientList").replace(ingredientName, updateName), conn);
                            }
                        }
                        response.sendRedirect("adminIngredients_page.jsp?ingredientupdated");
                    } catch (SQLException ex) {
                        Logger.getLogger(Ingredient_Controller.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }

                break;

            case "Reactivate":
            case "Deactivate":
                String ingredientDeactivated = request.getParameter("itemCode");

                // get the current date and time
                Calendar calendarDeactivated = Calendar.getInstance();
                Date nowDeactivated = calendarDeactivated.getTime();
                nowDeactivated.setDate(nowDeactivated.getDate() + 30);

                // format the date and time into a string
                SimpleDateFormat dateFormatDeactivated = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String timestampDeactivated = dateFormatDeactivated.format(nowDeactivated);

                ingredientsProcess.changeActivation(instruction, Integer.parseInt(ingredientDeactivated), timestampDeactivated, conn);

                response.sendRedirect("adminIngredients_page.jsp?ingredientdeleted");
                break;
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
