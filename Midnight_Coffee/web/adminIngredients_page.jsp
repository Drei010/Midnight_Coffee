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
        <link rel='stylesheet' type='text/css' href='styles/adminIngredients.css'>
        <title>Ingredients</title>
    </head>



    <body>
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  
        <%
            if (request.getAttribute("loadedIngredients") == null || request.getAttribute("loadedActive") == null) {
        %>
        <form action="Ingredient_Controller" method="post" name="load">
            <input type="hidden" name="action" value="load">
        </form>
        <script>
            window.onload = function () {
                document.forms['load'].submit();
            };
        </script>
        <%}%>
        <div class="container">
            <div class="left">
                <h1>New Ingredient</h1>
                <form action="Ingredient_Controller" method="POST">
                    <input type="hidden" name="action" value="insertIngredient">
                    <div class="form-group">
                        <label for="ingredient">Ingredient:</label>
                        <input type="text" id="ingredient" name="ingredientName" required>
                        <!-- Warning Message for comma usage-->
                        <br> <a id="warningComma"></a><br>
                    </div>  
                    <div class="form-group">
                        <label for="weight">Weight in Stocks:</label>
                        <input type="number" id="weight" name="weight" min="1" required>
                    </div>
                    <div class="form-group">
                        <label for="weight">Minimum Stocks:</label>
                        <input type="number" id="minimum" name="minimum" min="1" required>
                    </div>
                    <!-- Warning Message for weight limit-->
                    <br> <a id="warningWeight"></a><br>
                    <button id="addBtn" class="btn btn-green">Add Entry</button>
                    <input type="button" id="updateBtn" class="btn btn-blue" onclick="buttonClickPopup()" value="Update Existing">
                </form>
            </div>
            <!-- Ingredients form-->
            <form id="ingredientTable" action="Ingredient_Controller" method="POST">
                <input type="hidden" id="action" name="action" value="">
                <input type="hidden" id="itemCode" name="itemCode" value="">
                <input type="hidden" id="ingredientWeight" name="ingredientWeight" value="">
                <div class="right">
                    <table data-rows-per-page="6" id="table">
                        <thead>
                            <tr>
                                <th>Ingredient</th>
                                <th>Remaining Weight</th>
                                <th>Min Weight</th>
                                <th>Status</th>
                                <th>Deletion Date</th>
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
                                <td><%=ingredients.getString("minimumWeight")%>g</td>

                                <% if (ingredients.getString("deactivationtimestamp") == null) {%>
                                <td><input type="button" class="btn btn-red" onclick="return buttonClick(this)" name="<%=ingredients.getString("itemCode")%>" value="Deactivate"></td>
                                <td></td>
                                <%} else {%>
                                <td><input type="button" class="btn btn-green"  onclick="return buttonClick(this)" name="<%=ingredients.getString("itemCode")%>" value="Reactivate"></td>
                                <td><p class="warningDeactivate"><%=ingredients.getString("deactivationtimestamp")%></p></td>
                                    <%}%>
                            </tr>
                            <%}
                                }%>

                            <!-- Repeat the above row for each item in the table -->
                        </tbody>
                    </table>
                </div>
            </form>
            <div id="popup-overlay"></div>
            <div id="popupModalIngredients">
                <div class="popup-container">
                    <form id="updateIngredientForm" action="Ingredient_Controller" method="POST">
                        <input type="hidden" name="action" value="updateIngredient">
                        <input type="hidden" id="updateIngredientName" name="ingredientName">
                        <h2>Update Ingredient</h2>

                        <div class="update-ingredient-name">
                            <p>Update Name:</p>
                            <input type="text" id="updateName" name="updatedName">     
                            <label for="ingredientSelect">Ingredient:</label>
                            <select id="updateSelectIngredient" name="selectIngredientName" onchange="setUpdateWeights()" required>
                                <option selected disabled hidden>Select Ingredient</option>
                                <%
                                    ResultSet active = (ResultSet) request.getAttribute("active");
                                    if (active != null) {
                                        while (active.next()) {%>

                                <option value="<%=active.getString("minimumWeight")+","+active.getString("ingredientWeight")%>"><%=active.getString("ingredientName")%></option>

                                <%}
                                    }%>
                            </select>
                        </div>  

                        <div class="update-weight">
                            <div class="label-weightText">
                                <div>
                                    <p>Update Weight:</p>
                                    <input type="number" id="updateWeight" name="updateWeightNumber" min="1" >
                                </div>
                                <div>
                                    <p>Current Weight:</p>
                                    <h3 id="currentWeightUpdate"> </h3>
                                </div>
                            </div>
                        </div>

                        <div class="update-min-weight">
                            <div class="label-min-weight">
                                <div>
                                    <p>Update Minimum:</p>
                                    <input type="number" id="updateMinimum" name="updateMinimumNumber" min="1">
                                </div>
                                <div>
                                    <p>Current Minimum:</p>
                                    <h3 id="currentMinimum"> </h3>
                                </div>
                            </div>
                        </div>
                        <input type="submit" id="updateBtn-popup" class="btn btn-green" value="Update">
                    </form>

                    <div class="verticalDivider"></div>

                    <form id="addIngredientStockForm" action="Ingredient_Controller" method="POST">
                        <input type="hidden" id="addIngredientName" name="ingredientName">
                        <input type="hidden" name="action" value="addIngredient">
                        <h2>Add Available Stocks</h2>
                        <div class="add-ingredient-name">
                            <label for="addIngredientSelect">Ingredient:</label>
                            <select id="addSelectIngredient" name="addSelectIngredientName" onchange="setAddWeight()" required >
                                <option selected disabled hidden>Select Ingredient</option>
                                <%
                                    if (active != null) {
                                        active.beforeFirst();
                                        while (active.next()) {%>

                                <option value="<%=active.getString("minimumWeight")+","+active.getString("ingredientWeight")%>"><%=active.getString("ingredientName")%></option>

                                <%}
                                    }%>
                            </select>
                        </div>

                        <div class="add-weight">
                            <div class="label-weightText">
                                <div>
                                    <p>Add Weight:</p>
                                    <input type="number" id="addWeight" name="weight" min="1" required>
                                </div>
                                <div>
                                    <p>Current Weight:</p>
                                    <h3 id="currentWeightAdd"> </h3>
                                </div>
                            </div>
                        </div>
                        <input type="submit"  id="addBtn-popup" class="btn btn-green" value="Add">

                    </form>
                </div>
            </div>
        </div>
    </body>

    <script>

        function setUpdateWeights(){
            let select = document.getElementById("updateSelectIngredient"),
                    current = document.getElementById("currentWeightUpdate"),
                        min = document.getElementById("currentMinimum"),
                            updateIngredientName = document.getElementById("updateIngredientName"),
                                array = select.options[select.selectedIndex].value.split(",");
                
                    min.innerHTML = array[0] + "g";
                    current.innerHTML = array[1] + "g";
                    updateIngredientName.value = select.options[select.selectedIndex].text;
        }
        
        function setAddWeight(){
            let select = document.getElementById("addSelectIngredient"),
                    current = document.getElementById("currentWeightAdd"),
                        addIngredientName = document.getElementById("addIngredientName"),
                            array = select.options[select.selectedIndex].value.split(",");
                
                    current.innerHTML = array[1] + "g";
                    addIngredientName.value = select.options[select.selectedIndex].text;
        }

        function buttonClickPopup() {
            document.getElementById("popupModalIngredients").style.display = 'block';
        }

        window.onclick = function (event) {
            var modal = document.getElementById("popupModalIngredients");
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };

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

        function buttonClick(button) {
            document.getElementById('action').value = button.value;
            document.getElementById('itemCode').value = button.name;
            console.log(document.getElementById('action').value);
            console.log(document.getElementById('itemCode').value);
            document.forms['ingredientTable'].submit();
            return true;
        }



        // Disable comma usage
        const addBtn = document.getElementById('addBtn');
        const ingredient = document.getElementById("ingredient");
        const warningComma = document.getElementById("warningComma");
        // Add an event listener to the input box to check its value
        ingredient.addEventListener("input", function () {
            // Check if the input box value contains a comma
            if (ingredient.value.includes(",")) {
                // Disable the submit button
                addBtn.disabled = true;
                warningComma.innerText = 'The usage of comma (,) is not allowed';
                warningComma.style.color = "red";
            } else {
                // Enable the submit button
                addBtn.disabled = false;
                warningComma.innerText = '';
            }
        });

        //Disable button if min weight is greater than 50% of the remaining weight
        const weightInput = document.getElementById('weight');
        const minimumInput = document.getElementById('minimum');
        const warningWeight = document.getElementById('warningWeight');

        // Attach an event listener to the weight and minimum input fields
        weightInput.addEventListener('input', checkMinimumWeight);
        minimumInput.addEventListener('input', checkMinimumWeight);

        function checkMinimumWeight() {
            const weight = Number(weightInput.value);
            const minimum = Number(minimumInput.value);

            if (minimum > weight * 0.5) {
                addBtn.disabled = true;
                warningWeight.innerText = 'The minimum weight should not exceed 50% of the remaining weight';
                warningWeight.style.color = "red";
            } else {
                addBtn.disabled = false;
                warningWeight.innerText = '';
            }
        }
    </script>
</html>
