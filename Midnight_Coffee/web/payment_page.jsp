<%-- 
    Document   : payment_page
    Created on : 8 Feb 2023, 1:06:36 pm
    Author     : Andrei
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/payment_page.css'>
        <title>Customer Payment Page</title>
    </head>
    <body>
         <jsp:include page="header.jsp" /> <!-- Calls the header for admin-->
        <h1>QR Codes</h1>
        <%
            if (request.getAttribute("QRTable") == null) {
            %>
              <form action="QR_Controller" method="post" name="loadTable">
                <input type="hidden" name="instruction" value="loadQR">
                <input type="hidden" name="page" value="payment_page.jsp">
              </form>
              <script>
                window.onload = function() {
                  document.forms['loadTable'].submit();
                };
              </script>
            <%
              } else {
             if (request.getAttribute("QRTableEmpty") == null){
                ResultSet QRTable = (ResultSet) request.getAttribute("QRTable");
                 while (QRTable.next()) {%>
                 
                 <img
          class="QRImages"
          src="QRImages/<%=QRTable.getString("QRImage")%>"
          alt="The QR Code image">   
   
                 
                 
                     <h1>   <%=QRTable.getString("methodName")%></h1>
                       <a>  <%=QRTable.getInt("methodId")%></a>


             <%
            }
               }
                    }
            %>
  </body>
</html>
