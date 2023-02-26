
package Controller;

import Model.IngredientList;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "Ingredient_Controller", urlPatterns = {"/Ingredient_Controller"})
public class Ingredient_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        
        String instruction = request.getParameter("action");
        switch(instruction){
            case "load":
                IngredientList loadIngredients = new IngredientList();
                request.setAttribute("ingredients", loadIngredients.Ingredients(conn));
                request.setAttribute("loadedIngredients", "yes");
                request.getRequestDispatcher("adminIngredients_page.jsp").forward(request, response);
                break;
            case "addIngredient":
                String ingredient = request.getParameter("ingredient");
                int weight = Integer.parseInt(request.getParameter("weight"));
                int min = Integer.parseInt(request.getParameter("minimum"));
                
                IngredientList addIngredient = new IngredientList();
                addIngredient.addIngredient(ingredient, weight, min, conn);
                response.sendRedirect("adminIngredients_page.jsp?ingredientadded");
                break;
            case "Delete":
                String ingredientName = request.getParameter("ingredientName");
                System.out.println(ingredientName);
                IngredientList delIngredient = new IngredientList();
                delIngredient.deleteIngredient(ingredientName, conn);
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
