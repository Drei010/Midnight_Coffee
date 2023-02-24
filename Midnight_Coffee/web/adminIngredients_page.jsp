<%-- 
    Document   : adminIngredients_page
    Created on : 5 Feb 2023, 6:14:36 pm
    Author     : rvhin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/adminIngredients.css'>
        <title>Orders</title>
    </head>



    <body>
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  
        <%
            if (request.getAttribute("loadedIngredients") == null) {
        %>
        <form action="Ingredient_Controller" method="post" name="load">
            <input type="hidden" name="action" value="load">
        </form>
        <script>
            window.onload = function () {
                document.forms['load'].submit();
            };
        </script>
        <%
        }%>
        <div class="container">
            <div class="left">
                <h2>New Ingredient</h2>
                <form action="Ingredient_Controller" method="POST">
                    <input type="hidden" name="action" value="addIngredient">
                    <div class="form-group">
                        <label for="ingredient">Ingredient:</label>
                        <input type="text" id="ingredient" name="ingredient" required>
                    </div>  
                    <div class="form-group">
                        <label for="weight">Weight in Stocks:</label>
                        <input type="number" id="weight" name="weight" required>
                    </div>
                    <button class="btn btn-green">Add Ingredient</button>
                </form>
            </div>
            <div class="right">
                <table data-rows-per-page="6" id="table">
                    <thead>
                        <tr>
                            <th>Ingredient</th>
                            <th>Weight of Remaining Stocks</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody data-page="1">
                        <%
                            ResultSet ingredients = (ResultSet) request.getAttribute("ingredients");
                            if (ingredients != null) {
                                while (ingredients.next()) {%>
                        <tr>
                            <td><%=ingredients.getString("ingredientName")%></td>
                            <td><%=ingredients.getString("ingredientWeight")%>g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>

                        <%}
                            }%>

                        <!-- Repeat the above row for each item in the table -->
                    </tbody>
                </table>
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
            var $prevDis = ($cur === 1) ? "disabled" : "",
                    $nextDis = ($cur === $pCount) ? "disabled" : "",
                    $buttons = "<input type='button' value='<< Prev' onclick='sort(" + ($cur - 1) + ")' " + $prevDis + ">";
            for ($i = 1; $i <= $pCount; $i++)
                $buttons += "<input type='button' id='id" + $i + "'value='" + $i + "' onclick='sort(" + $i + ")'>";
            $buttons += "<input type='button' value='Next >>' onclick='sort(" + ($cur + 1) + ")' " + $nextDis + ">";
            return $buttons;
        }
    </script>
</html>
