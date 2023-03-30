<%-- 
    Document   : Account_page
    Created on : 30 Mar 2023, 2:14:47 pm
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Account Page</title>
        <!--Icons import-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel='stylesheet' type='text/css' href='styles/Account_page.css'>

    </head>
    <body  onload="openAccount()">
        <jsp:include page="header.jsp" /> <!-- Calls the header for admin-->    

        <%
            if (session.getAttribute("customerID") == null) {
        %>
        <script>
            document.getElementById('logoutBtn').click();
        </script>
        <%   }%>
        <div class="headerContainer">
            <h1>Account Settings</h1>
            <h3>Change your profile and account settings</h3>
        </div>
        <div class="container">
            <div class="side-menu">
                <ul class="ul">
                    <li class="li" id="Account"><a href="#" onclick="openAccount()"><i class="fas fa-user-alt"></i>  Account</a></li>
                    <li class="li" id="Password"><a href="#" onclick="openPassword()"><i class="fas fa-lock"></i>  Password</a></li>
                    <li class="li" id="Deactivate"><a href="#" onclick="openDeactivate()"><i class="fas fa-trash"></i>  Deactivate</a></li>
                </ul>
            </div>

            <div class="containerTabs">
                <div class="main-content">
                    <div class="GeneralInfo" id="GeneralInfo">
                        <h1>General Info</h1>
                        <form action="CustomerAccount_Controller" method="POST">
                            <input type="hidden" name="action" value="updateInfo">
                            <input type="hidden" name="customerID" value="<%=session.getAttribute("customerID")%>">
                            <div class="fullname">
                                <label id="First-Name" >First name<input type="text" id="newCustomerFirstName" name="newCustomerFirstName" value="<%=session.getAttribute("firstname")%>">
                                </label>         
                                &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <label id="First-Last" >Last name <input type="text"  id="newCustomerLastName" name="newCustomerLastName" value="<%=session.getAttribute("lastname")%>">
                                </label>
                            </div>
                            <label for="newCustomerEmail">Email Address  </label>     
                            <input type="email" id="newCustomerEmail" name="newCustomerEmail" value="<%=session.getAttribute("email")%>"><br>
                            <label for="newCustomerMobileNumber">Mobile Number  </label>     
                            <input type="number" id="newCustomerMobileNumber" name="newCustomerMobileNumber" value="<%=session.getAttribute("mobilenumber")%>"><br>
                            <a>Note: Clicking this button will Log you out </a>
                            <input class="updateBtn" type="submit"  value="Update Info">
                        </form>
                    </div>

                    <div class="PasswordInfo" id="PasswordInfo">
                        <h1>Change Password</h1>
                        <form action="CustomerAccount_Controller" method="POST">
                            <input type="hidden" name="action" value="updatePassword">
                            <input type="hidden" name="customerID" value="<%=session.getAttribute("customerID")%>">
                            <label for="oldCustomerPassword">Old Password</label>
                            <input type="password" id="oldCustomerPassword" name="oldCustomerPassword"><br>
                            <label for="newCustomerPassword">New Password</label>
                            <input type="password" id="newCustomerPassword" name="newCustomerPassword"><br>
                            <input class="updateBtn" type="submit"  value="Update Password">
                        </form>
                    </div>


                    <div class="DeactivateAccount" id="DeactivateAccount">
                        <h1>Deactivate Account</h1>
                        <a> Warning: Clicking this button will permanently </a><br>
                        <a>  delete your account do you wish to proceed?</a>
                        <form action="CustomerAccount_Controller" method="POST">
                            <input type="hidden" name="action" value="Delete">
                            <input type="hidden"  name="customerID" value="<%=session.getAttribute("customerID")%>">
                            <input class="deleteBtn" id="deleteBtn" type="submit"  value="Deactivate Account">
                        </form>

                    </div>

                </div>
            </div>
        </div>

        <script>
            function openAccount() {
                // Open GeneralInfo
                document.getElementById("GeneralInfo").style.display = "block";
                document.getElementById("PasswordInfo").style.display = "none";
                document.getElementById("DeactivateAccount").style.display = "none";
            }
            function openPassword() {
                // Open PasswordInfo
                document.getElementById("GeneralInfo").style.display = "none";
                document.getElementById("PasswordInfo").style.display = "block";
                document.getElementById("DeactivateAccount").style.display = "none";
            }
            function openDeactivate() {
                // Open DeactivateAccount
                document.getElementById("GeneralInfo").style.display = "none";
                document.getElementById("PasswordInfo").style.display = "none";
                document.getElementById("DeactivateAccount").style.display = "block";
            }

        </script>

    </body>
</html>
