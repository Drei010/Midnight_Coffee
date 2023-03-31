<%-- 
    Document   : Resetpassword_page
    Created on : 31 Mar 2023, 12:10:07 pm
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/loginSignup.css'>
 
        <title>Reset Password Page</title>


    </head>
 
    <body>
        <jsp:include page="loginSignup.jsp" /> <!-- Calls the header jsp -->
        

      
        <div class="header"></div>

        <form action="CustomerAccount_Controller" id="login-form" method="post">
            <input type="hidden" name="action" value="Resetpassword">
            <div class="login">
                <h1>Reset your Password  <%=session.getAttribute("customerRetrievedID")%></h1>
                <a>Type in your new password</a>
                <h3>New Password</h3>
               
                <input type="password" name="newPassword" required>

                <input type="hidden" name="customerIDPassword"  value="<%=session.getAttribute("customerRetrievedID")%>"><br>
        <button type="submit">Submit</button>
        
       <a href="/Forgotpassword_page" id="backBtn"><< Back</a>
                </div>
             
               
        </form>

     
    </div>
            
           <%
            if (session.getAttribute("customerRetrievedID") == null) {
        %>
        <script>
            document.getElementById('backBtn').click();
        </script>
        <%   }%>
    </body>
</html>
