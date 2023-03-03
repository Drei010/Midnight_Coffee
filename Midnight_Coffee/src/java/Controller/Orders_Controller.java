package Controller;

import Model.IngredientList;
import Model.Orders_Model;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Andrei
 */
@WebServlet(name = "Orders_Controller", urlPatterns = {"/Orders_Controller"})
public class Orders_Controller extends HttpServlet {


    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get Connection
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        //Test Connection
        if (conn == null) {
            response.sendRedirect("home.jsp?noconnection");
        }
        
        String instruction = request.getParameter("action");
        
        Orders_Model processOrders = new Orders_Model();
        switch(instruction){
            case "load":
                request.setAttribute("customerOrders", processOrders.Orders(conn));
                request.setAttribute("loadedOrders", "yes");
                request.getRequestDispatcher("adminOrders_page.jsp").forward(request, response);
                break;
            case "addIngredient":
                String ingredient = request.getParameter("ingredient");
                int weight = Integer.parseInt(request.getParameter("weight"));
                int min = Integer.parseInt(request.getParameter("minimum"));
                
                IngredientList addIngredient = new IngredientList();
                addIngredient.addIngredient(ingredient, weight, min, conn);
                response.sendRedirect("adminOrders_page.jsp?ingredientadded");
                break;
            case "changeDate":
                String ingredientName = request.getParameter("inputDate");
                IngredientList delIngredient = new IngredientList();
                delIngredient.deleteIngredient(ingredientName, conn);
                response.sendRedirect("adminOrders_page.jsp?ingredientdeleted");
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
