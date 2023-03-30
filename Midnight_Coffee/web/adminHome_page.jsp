<%-- 
    Document   : adminHome_page
    Created on : 5 Feb 2023, 5:31:37 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/adminHome.css'>
        <title>Admin</title>
    </head>

    <body>
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header for admin-->
            <div class="admin-home-container">
                <div class="home-container-contents">
                    <div class="first-line">
                        <p>Midnight Coffee</p>
                    </div>
                    <div class="second-line">
                        <p>It's more than just coffee</p>
                    </div>
                    <div class="third-line">
                        <p>Thank you for your great service!</p>
                    </div>
                </div>
            </div>
    </body>

    <jsp:include page="adminFooter.jsp" /> <!-- Calls the footer for admin-->
</html>
