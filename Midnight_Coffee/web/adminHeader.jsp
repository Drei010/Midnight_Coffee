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
        <link rel='stylesheet' type='text/css' href='header.css'>
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
                    <a href="adminHome_page.jsp"> Home </a>
                </li>
                <li class="header-nav-item">
                    <a href="adminMenu_page.jsp"> Menu </a>
                </li>
                <li class="header-nav-item">
                    <a href="adminOrders_page.jsp"> Orders </a>
                </li>
                <li class="header-nav-item">
                    <a href="adminAccount_page.jsp"> Account </a>
                </li>
                <li class="header-nav-item">
                    <a href="adminFeedback_page.jsp"> Feedback </a>
                </li>
                  <li class="header-nav-item">
                    <a href="adminPayment_page.jsp"> QR Code </a>
                </li>
                <li class="header-nav-item">
                    <a href="adminIngredients_page.jsp"> Ingredients </a>
                </li>
            </ul>
        </nav>
    </header>
</html>
