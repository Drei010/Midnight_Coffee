<%-- 
    Document   : adminAccount
    Created on : 5 Feb 2023, 6:13:15 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/adminAccount.css'>

        <title>Admin Account</title>

    </head>

    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->

    <body>
        <div class="outer-container">
            <h2>Update Admin Account</h2>
            <div class="inner-container">
                <h3> Your ID is <%=session.getAttribute("adminID")%></h3>
                <form action="AdminAccount_Controller" method="POST">
                    <input type="hidden" name="action" value="adminUpdate">    
                     <input type="hidden" name="adminID" value="<%=session.getAttribute("adminID")%>">    
                    <label for="old-adminKeyOld">Enter your old Admin Key</label>
                    <input type="password" id="adminKeyOld" name="adminKeyOld" required><br>

                    <label for="old-passwordOld">Enter your old Password:</label>
                    <input type="password" id="passwordOld" name="passwordOld" required><br>

                    <label for="adminKeyNew-email">Enter Admin Key:</label>
                    <input type="password" id="adminKeyNew" name="adminKeyNew" required><br>

                    <label for="new-passwordNew">Enter new Password:</label>
                    <input type="password" id="passwordNew" name="passwordNew" required><br>

                    <input type="submit" value="Submit">
                </form>
            </div>
        </div>
                    
                    
                                 <form method="POST" action="AdminAccount_Controller">
                    <!-- Delete deactivated Products -->  
                     <input type="hidden" name="action" value="deleteDeactivatedProducts">
                    <button>Permanently delete deactivated Products</button>
                </form>

                 <!-- Delete deactivated Ingredients -->   
                <form method="POST" action="AdminAccount_Controller">
                      <input type="hidden" name="action" value="deleteDeactivatedIngredients">
                    <button>Permanently delete deactivated ingredients</button>
                </form>
    </body>
</html>
