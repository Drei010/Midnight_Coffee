<%-- 
    Document   : loginSignup
    Created on : Feb 11, 2023, 8:26:03 PM
    Author     : Aron
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/loginSignup.css'>
    </head>
    <header>
        <nav class="header">
            <div class="header-left">
                <div class="logo-container">
                    <img src="https://i.postimg.cc/X7LBNhbz/MNC-Updated-Logo-White-Transparent.png" alt="MNC_Logo" width="100px" height="100px">
                </div>
            </div>
            <form action="Feedback_Controller" method="post" name="load">
            <input type="hidden" name="instruction" value="load">
            <input type="hidden" name="page" value="Home">
               <a class="close" onclick="document.forms['load'].submit()"></a>
            </form>
        </nav>
    </header>
</html>
