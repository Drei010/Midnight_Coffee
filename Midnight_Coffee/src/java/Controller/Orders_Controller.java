package Controller;

import Model.Orders_Model;
import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Andrei
 */
@WebServlet(name = "Orders_Controller", urlPatterns = {"/Orders_Controller"})
public class Orders_Controller extends HttpServlet {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get Connection
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        //Test Connection
        if (conn == null) {
            response.sendRedirect("/Home?noconnection");
        }

        // Get the current date
        LocalDateTime now = LocalDateTime.now();

        // Format the date
        String dateString = now.format(DATE_FORMATTER);

        String instruction = request.getParameter("action");

        HttpSession session = request.getSession();
        Orders_Model processOrders = new Orders_Model();
        switch (instruction) {
            case "load":
                session.setAttribute("customerOrders", processOrders.Orders(dateString, conn));
                session.setAttribute("loadedOrders", "yes");
                session.setAttribute("ordersDate", dateString);
                response.sendRedirect("/AdminOrders");
                break;
            case "changeDate":
                String inputDate = request.getParameter("inputDate");
                session.setAttribute("customerOrders", processOrders.Orders(inputDate, conn));
                session.setAttribute("loadedOrders", "yes");
                session.setAttribute("ordersDate", inputDate);
                response.sendRedirect("/AdminOrders");
                break;
            case "instruction":
                session.setAttribute("orderStep","instruction");
                response.sendRedirect("/Instruction");
                break;
            case "rating":
                session.setAttribute("orderStep","rating");
                response.sendRedirect("/Rating");
                break;
            default:
                response.sendRedirect("/Error");
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
