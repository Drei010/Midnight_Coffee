<%-- 
    Document   : adminPayment_page
    Created on : 8 Feb 2023, 1:07:35 pm
    Author     : Andrei
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Payment Page</title>
        <link rel='stylesheet' type='text/css' href='styles/payment_page.css'>
    </head>
    <body>
          <h1>Create</h1>
        <form action="QR_Controller" method="POST" enctype="multipart/form-data">
             <h4><label for="methodName">Payment Method Name</label></h4>
            <input name="methodName" id="methodName" type="text" required/> 

             <h4><label for="QRImage">QR Image</label></h4>
             <input   name="QRImage" id="QRImage" type="file" required/> 

            <br>
             
  <!--destination folder-->
  <!--Baguhin nyo to guys para magrun-->
            <input type="hidden" value="C:\Users\Andrei\Documents\NetBeansProjects\Midnight_Coffee\Midnight_Coffee\web\QRImages" name="destination"/>  
            
   <!--Instruction is to create QR-->         
            <input type="hidden" name="instruction" value="createQR">
            <input type="submit"  value="Add payment method">
 
        </form>
        <br><br><br>
        
        
        
        <h1>Delete</h1>
        <form action="QR_Controller" method="POST" enctype="multipart/form-data">
                    
             <h4><label for="methodName">Payment Method Name</label></h4>
            <input name="methodName" id="methodName" type="text" required/> 


  <!-- destination folder-->
  <!--Baguhin nyo to guys para magrun-->
            <input type="hidden" value="C:\Users\Andrei\Documents\NetBeansProjects\Midnight_Coffee\Midnight_Coffee\web\QRImages" name="destination"/>  
            
   <!--Instruction is to create QR-->         
            <input type="hidden" name="instruction" value="deleteQR">
            <input type="submit"  value="Delete payment method">
 
        </form>
        <h1>QR Codes</h1>
        <%
            if (request.getAttribute("QRTable") == null) {
            %>
              <form action="QR_Controller" method="post" name="loadTable">
                <input type="hidden" name="instruction" value="loadQR">
                <input type="hidden" name="page" value="adminPayment_page.jsp">
              </form>
              <script>
                window.onload = function() {
                  document.forms['loadTable'].submit();
                };
              </script>
            <%
              } else {
                ResultSet QRTable = (ResultSet) request.getAttribute("QRTable");
                 while (QRTable.next()) {
            %>
                 
                 <img
          class="QRImages"
          src="QRImages/<%=QRTable.getString("QRImage")%>"
          alt="The QR Code image">   
   
                 
                 
                     <h1>   <%=QRTable.getString("methodName")%></h1>
                       <a>  <%=QRTable.getInt("methodId")%></a>


             <%
            }
               }
            %>
        
             
        
    </body>
</html>
