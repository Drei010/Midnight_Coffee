<%-- 
    Document   : adminCustomerManagement_page
    Created on : 29 Mar 2023, 6:52:07 pm
    Author     : Andrei
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Customer Account Management Page</title>
        <link rel='stylesheet' type='text/css' href='styles/adminCustomerManagement.css'>
    </head>
    <body>
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  
        <%
            if (!"yes".equals(session.getAttribute("loadedCustomerAccounts"))) {
        %>
        <form action="CustomerAccount_Controller" method="POST" name="load">
            <input type="hidden" name="action" value="load">
        </form>
        <script>
            window.onload = function () {
                document.forms['load'].submit();
            };
        </script>
        <%} else {
                session.setAttribute("loadedCustomerAccounts", "no");
            }%>
        <div class="AccountContainer">
            <div class="AccountBody">      

                <div class="updateAccountItem">
                    <h1 class="updateAccountItemTitle"> Customer Account List</h1>


          
                        <table data-rows-per-page="6" id="table">
                            <thead>
                                <tr>
                                    <th>Customer ID</th>
                                    <th>Customer First Name</th>
                                    <th>Customer Last Name</th>
                                    <th>Customer Password</th>
                                    <th>Customer Email</th>
                                    <th>Customer Mobile Number</th>
                                    <th>Customer Birthday</th>
                                     <th>Last Login</th>
                               
                                </tr>
                            </thead>
                            <tbody data-page="1">
                            <%
                                ResultSet customerAccounts = (ResultSet) session.getAttribute("customerAccounts");
                                if (customerAccounts != null) {
                                    while (customerAccounts.next()) {%>
                            <tr>
                                <td><%=customerAccounts.getString("customerID")%></td>
                                <td><%=customerAccounts.getString("customerFirstName")%></td>
                                <td><%=customerAccounts.getString("customerLastName")%></td>
                                <td><%=customerAccounts.getString("customerPassword")%></td>
                                <td><%=customerAccounts.getString("customerEmail")%></td>
                                <td><%=customerAccounts.getString("customerMobileNumber")%></td>
                                <td><%=customerAccounts.getString("customerBirthday")%></td>
                                 <td><%=customerAccounts.getString("lastLoginTimestamp")%></td>


                            </tr>
                            <% }
                   }%>

                            <!-- Repeat the above row for each item in the table -->

                            </tbody>
                        </table>
                     <h1 class="updateAccountItemTitle"> Deactivated Customer Account List</h1>
                        <form name="CustomerAccountTable" action="CustomerAccount_Controller" method="POST">
                        <table data-rows-per-page="6" id="table">
                            <thead>
                                <tr>
                                    <th>Customer ID</th>
                                    <th>Customer First Name</th>
                                    <th>Customer Last Name</th>
                                    <th>Customer Password</th>
                                    <th>Customer Email</th>
                                    <th>Customer Mobile Number</th>
                                    <th>Customer Birthday</th>
                                    <th>Last Login</th>
                                    <th>Reactivate</th>
                                </tr>
                            </thead>
                            <tbody data-page="1">
                             <input type="hidden" id="action" name="action" value="">
                            <input type="hidden" id="customerID" name="customerID" value="">
  <%
                                ResultSet customerDeactivatedAccounts = (ResultSet) session.getAttribute("customerDeactivatedAccounts");
                                if (customerDeactivatedAccounts != null) {
                                    while (customerDeactivatedAccounts.next()) {%>
                            <tr>
                                <td><%=customerDeactivatedAccounts.getString("customerID")%></td>
                                <td><%=customerDeactivatedAccounts.getString("customerFirstName")%></td>
                                <td><%=customerDeactivatedAccounts.getString("customerLastName")%></td>
                                <td><%=customerDeactivatedAccounts.getString("customerPassword")%></td>
                                <td><%=customerDeactivatedAccounts.getString("customerEmail")%></td>
                                <td><%=customerDeactivatedAccounts.getString("customerMobileNumber")%></td>
                                <td><%=customerDeactivatedAccounts.getString("customerBirthday")%></td>
                                <td><%=customerDeactivatedAccounts.getString("lastLoginTimestamp")%></td>
                                <td><input type="button" class="btn btn-blue" onclick="return buttonClick(this)" name="<%=customerDeactivatedAccounts.getString("customerID")%>" value="Reactivate"></td>
                           

                            </tr>
                            <% }
                   }%>

                            <!-- Repeat the above row for each item in the table -->

                            </tbody>
                        </table>
     </form>
                </div>


            </div>
        </div>
    </body>
    <script>
        var $table = document.getElementById("table"),
                $n = 5,
                $rowCount = $table.rows.length,
                $firstRow = $table.rows[0].firstElementChild.tagName,
                $hasHead = ($firstRow === "TH"),
                $tr = [],
                $i, $ii, $j = ($hasHead) ? 1 : 0,
                $th = ($hasHead ? $table.rows[(0)].outerHTML : "");
        var $pageCount = Math.ceil($rowCount / $n);
        if ($pageCount > 1) {
            for ($i = $j, $ii = 0; $i < $rowCount; $i++, $ii++)
                $tr[$ii] = $table.rows[$i].outerHTML;
            $table.insertAdjacentHTML("afterend", "<div id='buttons'></div");
            sort(1);
        }

        function sort($p) {
            var $rows = $th, $s = (($n * $p) - $n);
            for ($i = $s; $i < ($s + $n) && $i < $tr.length; $i++)
                $rows += $tr[$i];

            $table.innerHTML = $rows;
            document.getElementById("buttons").innerHTML = pageButtons($pageCount, $p);
            document.getElementById("id" + $p).setAttribute("class", "active");
        }


        function pageButtons($pCount, $cur) {
            var $prevDis = ($cur === 1) ? "enabled" : "",
                    $nextDis = ($cur === $pCount) ? "enabled" : "",
                    $buttons = "<input type='button' class='prev' value='<< Prev' onclick='sort(" + ($cur - 1) + ")' " + $prevDis + ">";
            for ($i = 1; $i <= $pCount; $i++)
                $buttons += "<input type='button' id='id" + $i + "'value='" + $i + "' onclick='sort(" + $i + ")'>";
            $buttons += "<input type='button' class='next' value='Next >>' onclick='sort(" + ($cur + 1) + ")' " + $nextDis + ">";
            return $buttons;
        }


        function buttonClick(button) {
            document.getElementById('action').value = button.value;
            document.getElementById('customerID').value = button.name;
            document.forms['CustomerAccountTable'].submit();
        }

    </script>
</html>
