<%-- 
    Document   : instruction_page
    Created on : Mar 24, 2023, 5:19:32 AM
    Author     : Acer Predator Helios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/instruction_page.css'>
        <title>Instructions Page</title>
    </head>
    
    <body>
        <jsp:include page="loginSignup.jsp" />
        <div class="container">
            <div class ="orderId">
                <h1> Your order id is: </h1>
                <h1> 126 </h1>
            </div>
            <div class ="instructions">
                <h1>Follow these instructions:</h1>
                <p>1. Send the gcash receipt with the order number to <a href="https://www.instagram.com/midnightcoffee.ph">instagram.com/midnightcoffee.ph</a></p>
                <p>2. Wait for the notification message for pickup</p>
                <p>For Delivery, it will be 3rd party delivery (via Grab, Angkas Padala, etc.) and will be booked by the customer</p>
                <p>Store Address:</p>
                <p>1039 G. Tolentino St., Sampaloc Manila</p>
            </div>
            <button type="submit" class="doneBtn">DONE</button>
        </div>
        
</body>
</html>
