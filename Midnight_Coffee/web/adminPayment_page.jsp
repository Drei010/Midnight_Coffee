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
            <input type="hidden" value="C:\Users\Andrei\Documents\NetBeansProjects\Midnight_Coffee\Midnight_Coffee\web\QRImages" name="destination"/>  
            
   <!--Instruction is to create QR-->         
            <input type="hidden" name="instruction" value="deleteQR">
            <input type="submit"  value="Delete payment method">
 
        </form>
        
        
    </body>
</html>
