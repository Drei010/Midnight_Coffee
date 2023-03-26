package Controller;

import Model.FeedbackList;
import java.io.IOException;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "Feedback_Controller", urlPatterns = {"/Feedback_Controller"})
public class Feedback_Controller extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Get Connection
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        //Test Connection
        if (conn == null) {
            response.sendRedirect("home.jsp?noconnection");
        }

        //Get Instruction
        String instruction = request.getParameter("instruction");

        switch (instruction) {
            case "load":
                HttpSession session = request.getSession();
                String page = request.getParameter("page");
                String url = "";
                FeedbackList feedbackList = new FeedbackList();
                if (page.equals("Home")) {
                    session.setAttribute("feedback", feedbackList.getRandomFeedback(conn));
                    url = "/Home";
                } else if(page.equals("AdminFeedback")){
                    session.setAttribute("feedback", feedbackList.FeedbackList(conn));
                    url = "/AdminFeedback";
                } else{
                    url = "/Error";
                }
                session.setAttribute("averageRating", feedbackList.averageRating(conn));
                response.sendRedirect(url+"?loaded=yes");
                break;
            case "update":
                String update[] = request.getParameter("update").replaceAll("\\[|\\]", "").split(",");
                String updateId[] = request.getParameter("updateId").replaceAll("\\[|\\]|\"", "").split(",");
                FeedbackList updateList = new FeedbackList();
                for (int i = 0; i < update.length; i++) {

                    System.out.println(updateId[i]);
                    if (update[i].equals("true")) {
                        updateList.updateDisplayed("Yes", Integer.parseInt(updateId[i]), conn);
                    } else {
                        updateList.updateDisplayed("No", Integer.parseInt(updateId[i]), conn);
                    }
                }

                response.sendRedirect("adminFeedback_page.jsp?updated");
                break;
            case "add":
                session = request.getSession();
                FeedbackList add = new FeedbackList();
                String idString = (String) session.getAttribute("customerID");
                String message = request.getParameter("message");
                int rating = Integer.parseInt(request.getParameter("rating"));
                int id = Integer.parseInt(idString);

                add.insertFeedback(message, rating, id, conn);
                response.sendRedirect("home.jsp?addedfeedback");
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
