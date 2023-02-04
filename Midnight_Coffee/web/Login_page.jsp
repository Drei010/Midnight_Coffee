<%-- 
    Document   : Login_page
    Created on : 4 Feb 2023, 5:36:05 pm
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
        <h1>Login</h1>
          <form action="index.html" method="post">
              
        <h3>Email</h3>
        <input type="email" placeholder="email" name="email" required>
        
        <h3>Password</h3>
        <input type="password" placeholder="password" name="password" required><br>
        
        
        <a  href="Signup_page.jsp">Don’t have an account?</a><br>
        
        <button type="submit">Login</button>
        </form>
    </body>
</html>
