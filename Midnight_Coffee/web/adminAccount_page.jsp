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
                <form>
                    <label for="old-email">Enter your old Email:</label>
                    <input type="email" id="oldEmail" name="oldEmail"><br>

                    <label for="old-password">Enter your old Password:</label>
                    <input type="password" id="oldPassword" name="oldPassword"><br>

                    <label for="new-email">Enter new Email:</label>
                    <input type="email" id="newEmail" name="newEmail"><br>

                    <label for="new-password">Enter new Password:</label>
                    <input type="password" id="newPassword" name="newPassword"><br>

                    <input type="submit" value="Submit">
                </form>
            </div>
        </div>
    </body>
</html>
