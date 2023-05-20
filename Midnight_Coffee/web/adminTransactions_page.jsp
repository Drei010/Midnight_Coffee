<%-- 
    Document   : adminTransactions_page
    Created on : 20 May 2023, 5:22:53 pm
    Author     : Andrei
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Transactions Page</title>
        <link rel='stylesheet' type='text/css' href='styles/adminCustomerManagement.css'>
    </head>
    <body>
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  
        <%
            if (!"yes".equals(session.getAttribute("loadedTransactions"))) {
        %>
        <form action="Admin_Transactions" method="POST" name="load">
            <input type="hidden" name="action" value="load">
        </form>
        <script>
            window.onload = function () {
                document.forms['load'].submit();
            };
        </script>
        <%} else {
                session.setAttribute("loadedTransactions", "no");
            }%>
        <div class="AccountContainer">
            <div class="AccountBody">      

                <div class="updateAccountItem">
                    <h1 class="updateAccountItemTitle"  style="color: black;"> Admin Transactions Timestamp</h1>


          
                        <table data-rows-per-page="6" id="table">
                            <thead>
                                <tr>
                                    <th>Transaction</th>
                                    <th>Item Name</th>
                                    <th>Timestamp</th>

                                </tr>
                            </thead>
                            <tbody data-page="1">
                            <%
                                ResultSet adminTransactions = (ResultSet) session.getAttribute("adminTransactions");
                                if (adminTransactions != null) {
                                    while (adminTransactions.next()) {%>
                            <tr>
                                <td><%=adminTransactions.getString("itemTransaction")%></td>
                                <td><%=adminTransactions.getString("itemName")%></td>
                                <td><%=adminTransactions.getString("transactionTimestamp")%></td>
                            </tr>
                            <% }
                   }%>

                            <!-- Repeat the above row for each item in the table -->

                            </tbody>
                        </table>
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
