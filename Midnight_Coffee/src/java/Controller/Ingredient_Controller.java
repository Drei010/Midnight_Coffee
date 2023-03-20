
package Controller;

import Model.IngredientList;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
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
        switch(instruction){
            case "load":
                //Load Ingredients
                request.setAttribute("ingredients", ingredientsProcess.Ingredients(conn));
                request.setAttribute("loadedIngredients", "yes");
                request.getRequestDispatcher("adminIngredients_page.jsp").forward(request, response);
                break;
                
            case "addIngredient": 
                 //Get Parameters
                String ingredientName = request.getParameter("ingredientName");
                int weight = Integer.parseInt(request.getParameter("weight"));
                int min = Integer.parseInt(request.getParameter("minimum"));
                
                //Check if Ingredient Exist
                ResultSet results = ingredientsProcess.ingredientItem(ingredientName, conn);
                
                //Redirect to adminIngredients page if ingredients exist
                 if (results != null) {
                response.sendRedirect("adminIngredients_page.jsp?ingredientalreadyexists");
                }
                 else{
                //Add Ingredient
                ingredientsProcess.addIngredient(ingredientName, weight, min, conn);
                response.sendRedirect("adminIngredients_page.jsp?ingredientadded");
                 }
                break;
                
            case "Delete":
                String ingredientNameDeleted = request.getParameter("ingredientName");
                //Delete Ingredient
                ingredientsProcess.deleteIngredient(ingredientNameDeleted, conn);
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
