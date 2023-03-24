<%-- 
    Document   : adminAccount
    Created on : 5 Feb 2023, 6:13:15 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/adminAccount.css'>

        <title>Admin Account</title>

    </head>

    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->

    <body>
        <div class="outer-container">
            <h2>Update Admin Account</h2>
            <div class="inner-container">
                <form action="AdminAccount_Controllera" method="GET">
                    <input type="hidden" name="adminkey" value=<%=session.getAttribute("adminkey")%>>  
                    <input type="hidden" name="action" value="adminUpdate">    
                    <label for="old-email">Enter your old Email:</label>
                    <input type="email" id="emailOld" name="emailOld"><br>

                    <label for="old-password">Enter your old Password:</label>
                    <input type="password" id="passwordOld" name="passwordOld"><br>

                    <label for="new-email">Enter new Email:</label>
                    <input type="email" id="emailUpdate" name="emailUpdate"><br>

                    <label for="new-password">Enter new Password:</label>
                    <input type="password" id="emailUpdate" name="emailUpdate"><br>

                    <input type="submit" value="Submit">
                </form>
            </div>
        </div>
    </body>
</html>
