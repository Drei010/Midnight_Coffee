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
                <div class="flex">
                    <a href="/AdminAccount"> Account </a>
                    <a href="/adminCustomerManagement_page.jsp"> Customer Accounts </a>
                </div>
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
            <div class="bottomButtons">
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
            </div>
        </div>


        <footer>
            <jsp:include page="adminFooter.jsp" /> <!-- Calls the footer for admin-->
        </footer>
    </body>
            <!--Alerts -->	
        <%
            if (request.getParameter("process") != null) {
                int process = Integer.parseInt(request.getParameter("process"));
                switch (process) {
                    case 1:
        %><script>alert("Deactivated products are now permanently deleted!");</script><%
                break;
            case 2:
        %><script>alert("Deactivated ingredients are now permanently deleted!");</script><%
                break;
            case 3:
        %><script>alert("Admin Account updated!");</script><%
                break;
            case 4:
        %><script>alert("Password does not match!");</script><%
                break;
                    default:
                    // code block
                    }
            }
        %>

</html>
