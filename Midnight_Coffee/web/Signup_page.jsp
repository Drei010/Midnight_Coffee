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
        <link rel='stylesheet' type='text/css' href='Signup_page.css'>
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
        <input type="password" id="pass1" placeholder="password" name="password" required>
        
        <!-- Password does not match -->
        <h4 style="color:red;"></h4>
        
        <h3>Confirm Password</h3>
        <input type="password" id="pass2" placeholder="confirm password" name="confirmpassword" required>
        
        <h3>Email</h3>
        <input type="email" placeholder="email" name="email" required>
        
        <h3>Mobile Number</h3>
        <input type="number" placeholder="mobile number" name="mobilenumber" required>
            
                <!-- Captcha -->
        <div class="g-recaptcha" data-sitekey="6Lcij1gkAAAAAJC_xpuTXOEqDUzQW3bMyqc9HhPS"></div>
        
       
        <!-- Terms and conditions -->
         <input type="checkbox" id="checkbox" required><a>Agree to our</a> <a href="#" id="termsLink">Terms and conditions</a><br>
         
        <button type="submit" id="btnSignup">Sign up</button>
        </form>
            <a  href="Login_page.jsp">Already have an account</a><br>
            
            
             <!-- Terms and conditions Popup Modal-->
            <div id="modal">
                <h1>Terms and Conditions</h1>
                <p>These are the terms and conditions</p>
                <button id="acceptBtn">Accept Terms and conditions</button>
                </div>
            
            
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
                <script>

            ///Password checker
            let pass1 = document.querySelector('#pass1');
            let pass2 = document.querySelector('#pass2');
            let result = document.querySelector('h4');
            let btnSignup = document.querySelector('#btnSignup');
            function checkPassword() {
                if (pass1.value === pass2.value) {
                    result.innerText = '';
                    btnSignup.disabled = false;
                } else {
                    result.innerText = 'Password does not match!';
                    btnSignup.disabled = true;
                }

            }
            pass1.addEventListener('keyup', () => {
                if (pass2.value.length !== 0)
                    checkPassword();
            });
            pass2.addEventListener('keyup', checkPassword);




           /////Terms and conditions Popup
           
           ///Open Modal by clicking link
            document.getElementById("termsLink").onclick = function(e) {
              e.preventDefault();
              document.getElementById("modal").style.visibility = 'visible';
            };
            
            
            ///Close modal by pressing accept button
                        document.getElementById("acceptBtn").onclick = function(e) {
              e.preventDefault();
              document.getElementById("modal").style.visibility = 'hidden';
              
              ///Check checkbox by pressing accept button
               document.getElementById("checkbox").checked = true;
            };
            
        </script>
    </body>
</html>
