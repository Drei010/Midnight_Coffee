/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.ProductList;
import java.io.IOException;
import java.sql.Connection;
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
@WebServlet(name = "Menu_Controller", urlPatterns = {"/Menu_Controller"})
public class Menu_Controller extends HttpServlet {

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

        
        switch(instruction){
           
        //load adminPayment_page
         case "loadMenu" : {

            //Get page location
            String page = request.getParameter("page");

            //go to menupage                
            request.setAttribute("loadedMenu", "yes");
            ProductList loadMenu = new ProductList();
            request.setAttribute("coffee", loadMenu.Coffee(conn));
            request.setAttribute("kremalatte", loadMenu.KremaLatte(conn));
            request.setAttribute("tea", loadMenu.Tea(conn));
            request.setAttribute("snack", loadMenu.Snack(conn));
            HttpSession session = request.getSession();

            if (session.getAttribute("isGuest") != "yes" && session.getAttribute("isGuest") != "no") {
                session.setAttribute("isGuest", "yes");
            }
            if (session.getAttribute("isGuest").equals("yes")) {
                session.setAttribute("role", "guest");
            } else {
                session.setAttribute("role", "customer");
            }

            //go to either menu page or adminMenu page
            request.getRequestDispatcher(page).forward(request, response);
            break;
        }
        
             // Check if instruction is to add menu item
              case "addItemMenu" : {
                // get parameters
                String itemAddName = request.getParameter("itemAddName");
                String itemAddImage = request.getParameter("itemAddImage"); 
                String itemAddOption = request.getParameter("itemAddOption"); 
                String itemAddPrice = request.getParameter("itemAddPrice"); 
                String itemAddClassification = request.getParameter("itemAddClassification"); 
                String itemAvailability = request.getParameter("itemAvailability"); 
                /*
                String fileName = getFileName(request.getPart("QRImage"));
                Path source = Paths.get(destination + File.separator + fileName);

                // Only Supports png or jpg
                String filetype = fileName.substring(fileName.length() - 3).toLowerCase();
                if (!("jpg".equals(filetype) || "png".equals(filetype))) {
                    response.sendRedirect("adminPayment_page.jsp?errorimage");
                    return;
                }

                String newImagename = methodName + "." + filetype;
                 */
                // Check if the payment method already exists
                ProductList checkEntry = new ProductList();
                if (checkEntry.retrieveData(itemAddName, conn) != null) {
                    response.sendRedirect("adminMenu_page.jsp?imageexist");
                    return;
                }
                 /*
                // Store the image file
                try (InputStream iptStream = request.getPart("QRImage").getInputStream();
                     OutputStream otpStream = new FileOutputStream(new File(destination + File.separator + fileName))) {
                    int read;
                    byte[] bytes = new byte[1024];
                    while ((read = iptStream.read(bytes)) != -1) {
                        otpStream.write(bytes, 0, read);
                    }
                } catch (IOException e) {
                    response.sendRedirect("adminPayment_page.jsp?failedtoupload");
                    return;
                }

                // Rename the file in the same directory
                try {
                    Files.move(source, source.resolveSibling(newImagename));
                } catch (IOException e) {
                    response.sendRedirect("adminPayment_page.jsp?failedtoupload");
                    return;
                }
                    */
                // Insert the payment method into the database
                ProductList insertEntry = new ProductList();
                String insertSuccess = insertEntry.insertData(itemAddName, itemAddOption, itemAddPrice, itemAddImage, itemAddClassification, conn);
                if ("Yes".equals(insertSuccess)) {
                    response.sendRedirect("adminMenu_page.jsp?success");
                } else {
                    response.sendRedirect("adminMenu_page.jsp?failedtouploaddatabase");
                }
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
