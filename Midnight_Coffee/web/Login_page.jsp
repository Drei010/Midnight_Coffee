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
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <title>Login Page</title>
        <!--Captcha API-->
        <script src="https://www.google.com/recaptcha/api.js"></script>

    </head>
    <jsp:include page="header.jsp" /> <!-- Calls the header jsp -->
    <body>
        <h1>Login</h1>
          <form action="LoginSignup_Controller" id="login-form" method="post">
              
        <h3>Email</h3>
        <input type="email" placeholder="email" name="email" required>
        
        <h3>Password</h3>
        <input type="password" placeholder="password" name="password" required><br>
        
        
        <!-- Captcha -->
        <div class="g-recaptcha" data-sitekey="6Lcij1gkAAAAAJC_xpuTXOEqDUzQW3bMyqc9HhPS"></div>


        <a  href="Signup_page.jsp">Don’t have an account?</a><br>
        
        <button type="submit">Login</button>
        </form>

            <!--Alerts -->	
        <%
            if (request.getParameter("process") != null) {
                int process = Integer.parseInt(request.getParameter("process"));
                switch (process) {
                case 1:
        %><script>alert("Account Created!");</script><%
                break;
                case 2:
        %><script>alert("Account Does not Exist!");</script><%
                break;
            case 3:
        %><script>alert("Wrong Password!");</script><%
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
