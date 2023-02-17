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
         <jsp:include page="adminHeader.jsp" /> <!-- Calls the header for admin-->
         <br> <br><br>
        <div class="QRBody">      
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
              } else {%>
              <h1 class="updateQRItemTitle"> Update QR Codes</h1>
              <div class="updateQRItem">
                
              <%
                 
                  if (request.getAttribute("QRTableEmpty") == null){
                ResultSet QRTable = (ResultSet) request.getAttribute("QRTable");
                               while (QRTable.next()) {
            %>
                 <div class="QRItem">
                     
            <div class="oldQRItem">
                 <img
          class="QRImages"
          src="QRImages/<%=QRTable.getString("QRImage")%>"
          alt="The QR Code image">   
          <h1 class="methodName"> <%=QRTable.getString("methodName")%></h1>
          </div>
          
          <div class="newQRItem">

                 <form action="QR_Controller" method="POST" enctype="multipart/form-data">
                 <input type="hidden" name="methodID" value="<%=QRTable.getInt("methodId")%>">
                 <input type="hidden" name="OldMethodName" value="<%=QRTable.getString("methodName")%>">
                 
                    <h4 class="newMethodNameLabel"><label for="methodName">New Payment Method Name</label></h4>
                    <input class="NewMethodName" name="NewMethodName" type="text" required/> 

                    <h4 class="newQRLabel"><label for="QRImage"> New QR Image</label></h4>
                     <input class="newQRImage" name="newQRImage"  type="file" required/> 
                     
                      <!--Instruction is to update QR--> 
                     <input type="hidden" name="instruction" value="updateQR">
                     <input class="updateBtn" id="updateBtn" type="submit"  value="Update payment method">
                  
                  </form>
                 
           <form action="QR_Controller" method="POST" enctype="multipart/form-data">
            <input type="hidden" name="methodName" id="methodName" value="<%=QRTable.getString("methodName")%>"/> 

                   <!--Instruction is to create QR-->         
                    <input type="hidden" name="instruction" value="deleteQR">
                    <input class="deleteBtn" type="submit"  value="Delete payment method">
 
        </form>
          </div>
                 </div>
          <br>
             <%
            }
               }
                    }
            %>
        </div>
        <h1 class="createQRItemTitle">Add New QR code</h1>
               <div class="createQRItem">
                  <form action="QR_Controller" method="POST" enctype="multipart/form-data">
             <h4><label for="methodName">Payment Method Name</label></h4>
            <input name="methodName" id="methodName" type="text" required/> 

             <h4><label for="QRImage">QR Image</label></h4>
             <input name="QRImage" id="QRImage" type="file" required/> 

            <br>
                 
           <!--Instruction is to create QR-->         
            <input type="hidden" name="instruction" value="createQR">
            <input class="addBtn" id="addBtn" type="submit"  value="Add payment method">
 
        </form>
       </div>
        </div>
        <script>
            //Disable buttons if the file type is not .png or .jpg
            const addBtn = document.getElementById('addBtn');
            const updateBtn = document.getElementById('updateBtn');
            const fileInput = document.getElementById('QRImage');


            fileInput.addEventListener('change', function() {
              const file = fileInput.files[0];
              const fileName = file.name;
              const fileType = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();

              if (fileType === 'jpg' || fileType === 'png') {
                addBtn.disabled = false;
                updateBtn.disabled = false;
              } else {
                addBtn.disabled = true;
                updateBtn.disabled = true;
              }
            });
</script>
                 
    </body>
</html>
