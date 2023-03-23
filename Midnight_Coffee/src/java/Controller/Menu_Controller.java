/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.IngredientList;
import Model.ProductList;
import Model.Recipes;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Andrei
 */
@MultipartConfig
@WebServlet(name = "Menu_Controller", urlPatterns = {"/Menu_Controller"})
public class Menu_Controller extends HttpServlet {

    //For image upload
    private final static Logger LOGGER
            = Logger.getLogger(QR_Controller.class.getCanonicalName());

    // getFileName() method to get the file name from the part  
    private String getFileName(final Part part) {
        // get header(content-disposition) from the part  
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);

        // code to get file name from the header  
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        // it will return null when it doesn't get file name in the header   
        return null;
    }

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
            
            //Get the destination file path of the MENUImage folder
            String destination = (String) getServletContext().getAttribute("destination") + "/MENUImages";
            
            switch (instruction) {
                
                //load adminPayment_page
                case "loadMenu":
                    
                    //Get page location
                    String page = request.getParameter("page");
                    
                    //go to menupage
                    request.setAttribute("loadedMenu", "yes");
                    ProductList loadMenu = new ProductList();
                    IngredientList loadIngredients = new IngredientList();
                    
                    if (page.equals("adminMenu_page.jsp")) {
                        request.setAttribute("ingredients", loadIngredients.Ingredients(conn));
                        request.setAttribute("allcoffee", loadMenu.AdminProducts("Coffee", conn));
                        request.setAttribute("allkremalatte", loadMenu.AdminProducts("Kremalatte", conn));
                        request.setAttribute("alltea", loadMenu.AdminProducts("Tea", conn));
                    } else {
                        request.setAttribute("coffee", loadMenu.CustomerProducts("Coffee", conn));
                        request.setAttribute("kremalatte", loadMenu.CustomerProducts("Kremalatte", conn));
                        request.setAttribute("tea", loadMenu.CustomerProducts("Tea", conn));
                    }
                    
                    HttpSession session = request.getSession();
                    
                    if (session.getAttribute("isGuest") != "yes" && session.getAttribute("isGuest") != "no") {
                        session.setAttribute("isGuest", "yes");
                    }
                    if (session.getAttribute("isGuest").equals("yes")) {
                        session.setAttribute("role", "guest");
                    } else if(session.getAttribute("isGuest").equals("no")){
                        session.setAttribute("role", "customer");
                    } else{
                        session.setAttribute("role", "admin");
                    }
                    
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
                    
                    // retrieve products
                    ResultSet results = loadMenu.retrieveProducts(conn);
                   
                try {
                    while (results.next()) {
                        
                        if(results.getString("deactivationtimestamp")!=null){
                            //get timestamp of the item when it was deactivated
                            Timestamp old = Timestamp.valueOf(results.getString("deactivationtimestamp"));
                            
                            //old is before the current
                            if(old.compareTo(current) < 0){
                                loadMenu.deleteProduct(Integer.parseInt(results.getString("itemCode")), conn);
                                
                            }
                        }
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(Menu_Controller.class.getName()).log(Level.SEVERE, null, ex);
                }

                    //go to either menu page or adminMenu page
                    request.getRequestDispatcher(page).forward(request, response);
                    break;
                    
                    // Check if instruction is to add menu item
                case "addItemMenu":
                    //desitantion
                    
                    // get parameters
                    String itemAddName = request.getParameter("itemAddName");
                    String itemAddImage = getFileName(request.getPart("itemAddImage"));
                    String itemAddOption = request.getParameter("itemAddOption");
                    String itemAddPrice = request.getParameter("itemAddPrice");
                    String itemAddClassification = request.getParameter("itemAddClassification");
                    String itemAvailability = request.getParameter("itemAvailability");
                    
                    String ingredientList = request.getParameter("ingredientList");
                    String weightList = request.getParameter("GramList");
                    
                    Path source = Paths.get(destination + File.separator + itemAddImage);
                    
                    // Check if the payment method already exists
                    ProductList checkEntry = new ProductList();
                    if (checkEntry.retrieveData(itemAddName, conn) != null) {
                        response.sendRedirect("adminMenu_page.jsp?imageexist");
                        return;
                    }
                    
                    // Store the image file
                    try (InputStream iptStream = request.getPart("itemAddImage").getInputStream();
                            OutputStream otpStream = new FileOutputStream(new File(destination + File.separator + itemAddImage))) {
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
                        Files.move(source, source.resolveSibling(itemAddImage));
                    } catch (IOException e) {
                        response.sendRedirect("adminPayment_page.jsp?failedtoupload");
                        return;
                    }
                    
                    // Insert the payment method into the database
                    ProductList insertEntry = new ProductList();
                    String insertSuccess = insertEntry.insertData(itemAddName, itemAddOption, itemAddPrice, itemAddImage, itemAddClassification, itemAvailability, conn);
                    Recipes insertRecipe = new Recipes();
                    insertRecipe.insertRecipe(itemAddName, itemAddOption, ingredientList.replaceAll("\\[|\\]|\"", ""), weightList.replaceAll("\\[|\\]|\"", ""), conn);
                    if ("Yes".equals(insertSuccess)) {
                        response.sendRedirect("adminMenu_page.jsp?success");
                        
                    } else {
                        response.sendRedirect("adminMenu_page.jsp?failedtouploaddatabase");
                    }
                    break;
                    
                    //delete after 30 days
                case "deactivate":
                case "reactivate":
                    
                    //Declare new ProductList for deactivation/reactivation
                    ProductList change = new ProductList();
                    
                    // get the current date and time
                    Calendar calendarDeactivated = Calendar.getInstance();
                    Date nowDeactivated = calendarDeactivated.getTime();
                    nowDeactivated.setDate(nowDeactivated.getDate() + 30);
                    
                    // format the date and time into a string
                    SimpleDateFormat dateFormatDeactivated = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String timestampDeactivated = dateFormatDeactivated.format(nowDeactivated);
                    
                    int productDeactivate = Integer.parseInt(request.getParameter("product"));
                    change.changeActivation(instruction, productDeactivate, timestampDeactivated, conn);
                    
                    response.sendRedirect("adminMenu_page.jsp?changeActivation");
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
