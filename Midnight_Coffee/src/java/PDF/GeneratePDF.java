package PDF;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import PDF.*;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.sql.PreparedStatement;
import java.io.FileOutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Agleos
 */
@WebServlet(name = "GeneratePDF", urlPatterns = {"/GeneratePDF"})
public class GeneratePDF extends HttpServlet {
    
    
public static ResultSet viewTable(Connection con, String ordersDate) throws SQLException {
    String query = "SELECT * FROM customer_orders WHERE orderDate = ?";
    PreparedStatement ps = con.prepareStatement(query);
    ps.setString(1, ordersDate);
    ResultSet rs = ps.executeQuery();
    return rs;
}
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, DocumentException{
        HttpSession session = request.getSession();
        Connection conn = (Connection) getServletContext().getAttribute("conn");
        request.setAttribute("loadedActive", "yes");
        

        String orderID = String.valueOf(session.getAttribute("orderIDs"));
        String ordersDate = String.valueOf(session.getAttribute("ordersDate"));
        String customerFirstName = String.valueOf(session.getAttribute("customerFirstName"));
        String customerLastName = String.valueOf(session.getAttribute("customerLastName"));
        String customerMobileNumber = String.valueOf(session.getAttribute("customerMobileNumber"));
        String orderTotal = String.valueOf(session.getAttribute("orderTotal"));
        String ordertime = String.valueOf(session.getAttribute("ordertime"));
        String customerEmail = String.valueOf(session.getAttribute("customerEmail"));
        
        /*String firstname = request.getParameter("firstname");
        String lastname = request.getParameter("lastname");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String mobilenumber = request.getParameter("mobilenumber");
        session.setAttribute("firstname", results.getString("customerFirstname"));
        session.setAttribute("lastname", results.getString("customerLastname"));
        session.setAttribute("customerID", results.getString("customerID"));*/


        

        Rectangle pageSize = new Rectangle(PageSize.A4.getWidth(), PageSize.A4.getHeight());

        // Create a document object
        Document document = new Document(pageSize);


        response.setContentType("application/pdf;charset=UTF-8");
        if (conn != null){   
            // Set the page size of the document

            String file_name = "C:\\Reports\\" + ordersDate + ".pdf";
            // String file_name = "C:\\Reports\\" + orderID + ".pdf";
            // Create a PdfWriter object
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            PdfWriter.getInstance(document, new FileOutputStream(file_name));
            
            // Open the document
            document.open();
    
            // Insert the image at the top of the document
            
            Image image = Image.getInstance("https://blogger.googleusercontent.com/img/a/AVvXsEh16JQK44lDLuMXn8xvg8uD78rB8xzV2wjm6yQ5rdlJsZqUE-fGZQ1vnyvm4iAhAMERrfmw_9ZOA4zTlrpn7HLK_2Ijaag1psnID9UqCkXzWES45U75CAsUcclVuNKdYpzZU5px74SZ082RkTzAdu1Sg7TJ5Z2IxeFzjfDOxVZiiCyB88qIgD3POBAi");
            image.setAlignment(Element.ALIGN_CENTER);
            image.scalePercent(55);
            image.setAbsolutePosition(0, PageSize.A4.getHeight() - image.getScaledHeight());
            document.add(image);
            
            // Add some space below the image
            Paragraph paragraph = new Paragraph();
            paragraph.setSpacingAfter(image.getScaledHeight());
            document.add(paragraph);
            
            // Add multiple line breaks to create space before the table
            document.add(new Paragraph("\n\n\n\n\n\n\n\n"));
            
            // Add "Report" paragraph
            Paragraph reportParagraph = new Paragraph("Transaction Report");
            reportParagraph.setSpacingBefore(10f);
            document.add(reportParagraph);
            
            // Add "Date" paragraph
            Paragraph dateParagraph = new Paragraph("Date: "+ ordersDate);
            dateParagraph.setSpacingBefore(10f);
            document.add(dateParagraph);
            document.add(new Paragraph("\n\n"));
            
            // Set the background color of the document
            PdfContentByte canvas = writer.getDirectContentUnder();
            Rectangle rect = new Rectangle(0, 0, PageSize.A4.getWidth(), PageSize.A4.getHeight());
            rect.setBackgroundColor(new BaseColor(207, 203, 194));
            canvas.rectangle(rect);
            
            // Create a font object for the table
            Font tableFont = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL, BaseColor.WHITE);
            
            // Create a PdfPTable object with 3 columns
            PdfPTable table = new PdfPTable(5);
            
            // Set the border color of the table
            table.getDefaultCell().setBorderColor(new BaseColor(250, 128, 114));
            
            // Set the border width of the table
            table.getDefaultCell().setBorderWidth(2f);
            
            // Add cells with the custom font and background color
            PdfPCell cell1 = new PdfPCell(new Phrase(orderID, tableFont));
            cell1.setBackgroundColor(new BaseColor(40, 39, 71));
            PdfPCell cell2 = new PdfPCell(new Phrase("Name", tableFont));
            cell2.setBackgroundColor(new BaseColor(40, 39, 71));
            PdfPCell cell3 = new PdfPCell(new Phrase("Email", tableFont));
            cell3.setBackgroundColor(new BaseColor(40, 39, 71));
            PdfPCell cell4 = new PdfPCell(new Phrase(orderTotal, tableFont));
            cell4.setBackgroundColor(new BaseColor(40, 39, 71));
            PdfPCell cell5 = new PdfPCell(new Phrase("Time Ordered", tableFont));
            cell5.setBackgroundColor(new BaseColor(40, 39, 71));
            
            // Add the cells to the table
            table.addCell(cell1);
            table.addCell(cell2);
            table.addCell(cell3);
            table.addCell(cell4);
            table.addCell(cell5);
            
            // Add the table to the document
            document.add(table);
            
            // Add more line breaks after the table to create space at the bottom of the document
            document.add(new Paragraph("\n\n\n\n\n\n\n\n"));
            
        // Close the document
        document.close();
        }else{
            request.getRequestDispatcher("error_page.jsp").forward(request, response);
        }
    }
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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
  try{
        processRequest(request, response);
    }
catch (DocumentException | IOException ex) {
         Logger.getLogger(GeneratePDF.class.getName()).log(Level.SEVERE, null, ex);
        } 
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
