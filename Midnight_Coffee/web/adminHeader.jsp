<%-- 
    Document   : adminHeader
    Created on : 5 Feb 2023, 5:40:44 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/header.css'>
        <title>Header</title>
    </head>
    <header>
        <nav class="header">
            <div class="header-left">
                <div class="logo-container">
                    <img src="https://i.postimg.cc/X7LBNhbz/MNC-Updated-Logo-White-Transparent.png" alt="MNC_Logo" width="100px" height="100px">
                </div>
                <h1 class="header-title">MIDNIGHT COFFEE</h1>
            </div>
            <ul class="header-nav header-right">
                <li class="header-nav-item">
                    <a href="/AdminHome"> Home </a>
                </li>
                <li class="header-nav-item">
                    <a href="/AdminMenu"> Menu </a>
                </li>
                <li class="header-nav-item">
                    <a href="/AdminOrders"> Orders </a>
                </li>
                <li class="header-nav-item">
                    <a href="/AdminAccount"> Account </a>
                </li>
                <li class="header-nav-item">
                    <a href="/AdminFeedback"> Feedback </a>
                </li>
                <li class="header-nav-item">
                    <a href="/AdminPayment"> QR </a>
                </li>
                <li class="header-nav-item">
                    <a href="/AdminIngredients"> Ingredients </a>
                </li>
                 <li class="header-nav-item">
                    <!-- If logged in -->
                    <a  id="logoutBtn" href="Logout">Log Out</a>
                    <!-- If logged out -->
                    <a id="loginBtn" href="/Login">Log in</a>
                </li>
            </ul>
        </nav>
    </header>
              <%
           ///Check if user is logged in
            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
            if("admin".equals(session.getAttribute("role"))){  
            %>
                 <script>
                   // Hide the login button and show the logout button 
                    document.getElementById("logoutBtn").style.display = "block";
                    document.getElementById("loginBtn").style.display = "none";
                    </script>
                    <%
            }   else{
                    %>
                    <script>
                    // Hide the logout button and show the login button
                    document.getElementById("logoutBtn").style.display = "none";
                    document.getElementById("loginBtn").style.display = "block";
                 </script>
            <%}%>
</html>
