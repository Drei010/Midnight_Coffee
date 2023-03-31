<%-- 
    Document   : Forgotpassword_page
    Created on : 30 Mar 2023, 8:30:48 pm
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/loginSignup.css'>
 
        <title>Forgot Password Page</title>


    </head>

    <body>
     <jsp:include page="loginSignup.jsp" /> <!-- Calls the header jsp -->
     
     
        <div class="header"></div>

        <form action="CustomerAccount_Controller" id="login-form" method="post">
            <input type="hidden" name="action" value="Forgotpassword">
            <div class="login">
                <h1>Forgot Password?</h1>
                <a>We just need your registered email and mobile number to confirm that your account exist</a>
                <h3>Email</h3>
                <input type="email" name="email" required>
                <h3>Mobile number</h3>
                <input type="number" name="mobileNumber" required><br>
        <button type="submit">Submit</button>
        
        <a>Do you remember you password </a><a href="/Login">Try logging in</a>
                </div>
             
               
        </form>

    </div>
            <!--Alerts -->	
        <%
            if (request.getParameter("process") != null) {
                int process = Integer.parseInt(request.getParameter("process"));
                switch (process) {

            case 1:
        %><script>alert("Account Does not Exist!");</script><%
                break;

                    default:
                    // code block
                    }
            }
        %>
</body>
</html>
