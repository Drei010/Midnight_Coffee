<%-- 
    Document   : Signup_Page
    Created on : 4 Feb 2023, 6:00:38 pm
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up Page</title>
    </head>
    <body>
          <h1>Sign up</h1>
          <form action="#" method="post">
         <h3>First Name</h3>
        <input type="text" placeholder="firstname" name="firstname" required>
        
        <h3>Last Name</h3>
        <input type="text" placeholder="lastname" name="lastname" required>
        
        <h3>Password</h3>
        <input type="password" placeholder="password" name="password" required>
        
         <h3>Confirm Password</h3>
        <input type="password" placeholder="confirm password" name="confirmpassword" required>
        
        <h3>Email</h3>
        <input type="email" placeholder="email" name="email" required>
        
        <h3>Mobile Number</h3>
        <input type="number" placeholder="mobile number" name="mobilenumber" required>
        <a  href="Login_page.jsp">Already have an account</a><br>
        
        <button type="submit">Login</button>
        </form>
    </body>
</html>