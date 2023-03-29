package PDF;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
import Model.Orders_Model;
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
import java.io.FileOutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;


/**
 *
 * @author Agleos
 */
@WebServlet(name = "GeneratePDF", urlPatterns = {"/GeneratePDF"})
public class GeneratePDF extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException, DocumentException{
       
        Connection conn = (Connection) getServletContext().getAttribute("conn");

        String ordersDate = request.getParameter("ordersDate");
              
        Rectangle pageSize = new Rectangle(PageSize.A4.getWidth(), PageSize.A4.getHeight());
        Document document = new Document(pageSize);
        response.setContentType("application/pdf;charset=UTF-8");
        
        
        // Set the page size of the document
        String file_name = System.getProperty("user.home") + "/Downloads/"+ordersDate+"Transaction_report.pdf";

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
        Paragraph dateParagraph = new Paragraph("Date: " + ordersDate);
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

        table.getDefaultCell().setBorderWidth(2f);
        
      
        PdfPCell headerCell1 = new PdfPCell(new Phrase("Order number", tableFont));
        headerCell1.setBackgroundColor(new BaseColor(40, 39, 71));
        PdfPCell headerCell2 = new PdfPCell(new Phrase("Name", tableFont));
        headerCell2.setBackgroundColor(new BaseColor(40, 39, 71));
        PdfPCell headerCell3 = new PdfPCell(new Phrase("Email", tableFont));
        headerCell3.setBackgroundColor(new BaseColor(40, 39, 71));
        PdfPCell headerCell4 = new PdfPCell(new Phrase("Total", tableFont));
        headerCell4.setBackgroundColor(new BaseColor(40, 39, 71));
        PdfPCell headerCell5 = new PdfPCell(new Phrase("Time", tableFont));
        headerCell5.setBackgroundColor(new BaseColor(40, 39, 71));
    
        table.addCell(headerCell1);
        table.addCell(headerCell2);
        table.addCell(headerCell3);
        table.addCell(headerCell4);
        table.addCell(headerCell5);
        table.setSkipFirstHeader(true);
        
        Orders_Model newPDF = new Orders_Model();
        ResultSet results = newPDF.Orders(ordersDate, conn);

        try {
                    if (!results.next()) {
                    // ResultSet is empty
               response.sendRedirect("/adminOrders_page?Noordersforthatday");
                } 
            while(results.next()){
                PdfPCell cell1 = new PdfPCell(new Phrase(results.getString("orderID"), tableFont));
                cell1.setBackgroundColor(new BaseColor(40, 39, 71));
                PdfPCell cell2 = new PdfPCell(new Phrase(results.getString("customerFirstName"), tableFont));
                cell2.setBackgroundColor(new BaseColor(40, 39, 71));
                PdfPCell cell3 = new PdfPCell(new Phrase(results.getString("customerEmail"), tableFont));
                cell3.setBackgroundColor(new BaseColor(40, 39, 71));
                PdfPCell cell4 = new PdfPCell(new Phrase(results.getString("orderTotal"), tableFont));
                cell4.setBackgroundColor(new BaseColor(40, 39, 71));
                PdfPCell cell5 = new PdfPCell(new Phrase(results.getString("orderTime"), tableFont));
                cell5.setBackgroundColor(new BaseColor(40, 39, 71));
                
                
                // Add the cells to the table
                table.addCell(cell1);
                table.addCell(cell2);
                table.addCell(cell3);
                table.addCell(cell4);
                table.addCell(cell5);
                // Add cells with the custom font and background color
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(GeneratePDF.class.getName()).log(Level.SEVERE, null, ex);
        }
        // Add the table to the document
        document.add(table);
        // Add more line breaks after the table to create space at the bottom of the document
        document.add(new Paragraph("\n\n\n\n\n\n\n\n"));
        // Close the document & the results
        document.close();
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
