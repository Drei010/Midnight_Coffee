<%-- 
    Document   : Signup_Page
    Created on : 4 Feb 2023, 6:00:38 pm
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head class>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/loginSignup.css'>
        <title>Sign up Page</title>
        <!--Captcha API-->
        <script src="https://www.google.com/recaptcha/api.js"></script>
    </head>

    <body>
        <div class="header"> 
            <jsp:include page="loginSignup.jsp" /> <!-- Calls the header jsp -->
        </div>
        <form action="LoginSignup_Controller" method="post">  
            <div class="outsideLogin">
                <div class="login">
                    <div class="signup">
                        <h1>Sign up</h1>  
                        <div class="fullname">
                            <label id="First-Name" for="one">First name<input type="text" name="firstname" required>
                            </label>         
                            &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <label id="First-Last" for="one">Last name <input type="text" name="lastname" required>
                            </label>
                        </div>
                        <h3>Password</h3>
                        <input type="password" id="pass1" name="password" required>

                        <!-- Password does not match -->
                        <h4 style="color:red;"></h4>

                        <h3>Confirm Password</h3>
                        <input type="password" id="pass2" name="confirmpassword" required>

                        <h3>Email</h3>
                        <input type="email" name="email" required>

                        <h3>Mobile Number</h3>
                        <input type="tel" id="phone" placeholder="+63" name="mobilenumber"

                               required>

                        <!-- Captcha -->
                        <div class="center">
                            <div class="g-recaptcha" data-sitekey="6Lcij1gkAAAAAJC_xpuTXOEqDUzQW3bMyqc9HhPS" 
                                 style="display: inline-block;"
                                  data-callback="enableSubmitButton" 
                                    data-expired-callback="disableSubmitButton">             
                            </div>


                            <!-- Terms and conditions -->    
                            <div class="checkbox">
                                <input type="checkbox" id="checkbox" required><a>Agree to our</a> <a href="#" id="termsLink">Terms and conditions</a><br>
                            </div>
                        </div>
                        <button type="submit" id="btnSignup" disabled>Sign up</button>
                        <div class="center">
                            <a  href="/Login">Already have an account?</a><br>
                        </div>
                    </div>
                </div>
            </div>
        </form>

        <!-- Terms and conditions Popup Modal-->
        <div id="modal">
            <h2>Terms and Conditions</h2>
            <div class="termsAndConditions">
                <h3>Section 1 - Account Information</h3>
                <!-- <p>By signing up, you agree to give us the information that you will input on the page.
                    included information such as First Name, Last Name, Password, Email, and Mobile Number will be stored and will
                    only be used for legitimacy of a customer, security of the store, and communication details to reach you.</p> --> 
                <h3>Section 2 - Products</h3>
                <h3>Section 3 - Prices</h3>
                <h3>Section 4 - Ordering for Pickup</h3>
                <h3>Section 5 - Ordering for Deliveries</h3>
            </div>
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
            
             function enableSubmitButton() {
    document.getElementById('btnSignup').disabled = false;
  }
  
  function disableSubmitButton() {
    document.getElementById('btnSignup').disabled = true;
  }

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
            document.getElementById("termsLink").onclick = function (e) {
                e.preventDefault();
                document.getElementById("modal").style.visibility = 'visible';
            };


            ///Close modal by pressing accept button
            document.getElementById("acceptBtn").onclick = function (e) {
                e.preventDefault();
                document.getElementById("modal").style.visibility = 'hidden';

                ///Check checkbox by pressing accept button
                document.getElementById("checkbox").checked = true;
            };

        </script>
    </div>
</body>
</html>
