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
        <link rel='stylesheet' type='text/css' href='styles/loginSignup.css'>
        <title>Login Page</title>
        <!--Captcha API-->
        <script src="https://www.google.com/recaptcha/api.js"></script>

    </head>
    <jsp:include page="loginSignup.jsp" /> <!-- Calls the header jsp -->
    <body>
        <div class="header"></div>

        <form action="LoginSignup_Controller" id="login-form" method="post">
            <div class="login">
                <h1>Login</h1>
                <h3>Email</h3>
                <input type="email" name="email" required>

                <h3>Password</h3>
                <input type="password" name="password" required><br>


                <!-- Captcha -->
                <div class="center">
                    <div class="g-recaptcha" 
                         data-sitekey="6Lcij1gkAAAAAJC_xpuTXOEqDUzQW3bMyqc9HhPS"
                         style="display: inline-block;"
                            data-callback="enableSubmitButton" 
                             data-expired-callback="disableSubmitButton"></div>
                    <br>

                    <a  href="/Signup">Don’t have an account?</a><br>
                </div>
                <br>
                <button id="submit-btn"  type="submit" disabled>Login</button>
                <br>
                <div class="forgotContainer">
                   <a href="/Forgotpassword_page">Forgot Password</a>
                   </div>
        </form>
  </div>
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
            case 4:
        %><script>alert("Password Reset!");</script><%
              case 5:
        %><script>alert("Please Login to order!");</script><%


                        break;
                    default:
                    // code block
                    }
            }
        %>
        
                <script>      function enableSubmitButton() {
    document.getElementById('submit-btn').disabled = false;
  }
  
  function disableSubmitButton() {
    document.getElementById('submit-btn').disabled = true;
  }
            </script>
           
  
</body>
</html>
