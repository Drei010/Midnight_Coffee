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
        <link rel='stylesheet' type='text/css' href='general.css'>
        <title>Sign up Page</title>
                <!--Captcha API-->
        <script src="https://www.google.com/recaptcha/api.js"></script>
    </head>
    <jsp:include page="header.jsp" /> <!-- Calls the header jsp -->
    <body>
          <h1>Sign up</h1>
          <form action="LoginSignup_Controller" method="post">
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
            
                <!-- Captcha -->
        <div class="g-recaptcha" data-sitekey="6Lcij1gkAAAAAJC_xpuTXOEqDUzQW3bMyqc9HhPS"></div>
        
        <a  href="Login_page.jsp">Already have an account</a><br>
        
        <button type="submit">Sign up</button>
        </form>
                      <%--Alerts --%>	
        <%
            if (request.getParameter("process") != null) {
                int process = Integer.parseInt(request.getParameter("process"));
                switch (process) {
                    case 1:
        %><script>alert("Account Already Exist!");</script><%
                break;
            case 2:
        %><script>alert("Account Creation Failed!");</script><%
                break;
            case 6:
        %><script>alert("Connection Failed!");</script><%
                break;
            case 7:
        %><script>alert("Captcha is Incorrect!");</script><%
                        break;
                    default:
                    // code block
                    }
            }
        %>
    </body>
</html>
