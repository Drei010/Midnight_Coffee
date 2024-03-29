<%-- 
    Document   : header
    Created on : 5 Feb 2023, 2:27:46 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/header.css'>
    </head>
    <header>
        <nav class="header">
            <div class="header-left">
                <div class="logo-container">
                    <img src="https://i.postimg.cc/X7LBNhbz/MNC-Updated-Logo-White-Transparent.png" alt="MNC_Logo" width="100px" height="100px" onclick="window.location.href='home.jsp'">
                </div>
                <h1 class="header-title" onclick="window.location.href='/Home'">MIDNIGHT COFFEE</h1>
            </div>
            <ul class="header-nav header-right">
                <li class="header-nav-item">
                    <a href="/Home"> Home </a>
                </li>
                <li class="header-nav-item">
                    <a href="/Menu"> Menu </a>
                </li>
                <li  id="accountBtn" class="header-nav-item">
                    <a href="/Account_page"> Account Settings </a>
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
            if("customer".equals(session.getAttribute("role"))){  
            %>
                 <script>
                   // Hide the login button and show the logout button 
                    document.getElementById("logoutBtn").style.display = "block";
                    document.getElementById("loginBtn").style.display = "none";
                    
                    //show the account settings tab
                      document.getElementById("accountBtn").style.display = "block";
                    </script>
                    <%
            }   else{
                    %>
                    <script>
                    // Hide the logout button and show the login button
                    document.getElementById("logoutBtn").style.display = "none";
                    document.getElementById("loginBtn").style.display = "block";
                    
                      //hide the account settings tab
                      document.getElementById("accountBtn").style.display = "none";
                 </script>
            <%}%>
   
</html>
