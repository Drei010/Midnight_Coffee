<%-- 
    Document   : adminOrders
    Created on : 5 Feb 2023, 6:13:04 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/adminOrders.css'>
        <title>Orders</title>
    </head>

    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  

    <body>
        <div class="container">
            <div class="left">
                <h2>New Ingredient</h2>
                <div class="form-group">
                    <label for="ingredient">Ingredient:</label>
                    <input type="text" id="ingredient" name="ingredient" required>
                </div>
                <div class="form-group">
                    <label for="weight">Weight in Stocks:</label>
                    <input type="number" id="weight" name="weight" required>
                </div>
                <button class="btn btn-green">Add Ingredient</button>
            </div>
            <div class="right">
                <table data-rows-per-page="5" id="table">
                    <thead>
                        <tr>
                            <th>Ingredient</th>
                            <th>Weight of Remaining Stocks</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody data-page="1">
                        <tr>
                            <td>1</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>3</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>4</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>5</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>6</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>7</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>8</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>9</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>10</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>11</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>12</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>13</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>14</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <!-- Repeat the above row for each item in the table -->
                    </tbody>
                </table>
                <div class="pagination"></div>
            </div>
        </div>
    </body>

    <script>
        // get the table element
        var $table = document.getElementById("table"),
// number of rows per page
                $n = 5,
// number of rows of the table
                $rowCount = $table.rows.length,
// get the first cell's tag name (in the first row)
                $firstRow = $table.rows[0].firstElementChild.tagName,
// boolean var to check if table has a head row
                $hasHead = ($firstRow === "TH"),
// an array to hold each row
                $tr = [],
// loop counters, to start count from rows[1] (2nd row) if the first row has a head tag
                $i, $ii, $j = ($hasHead) ? 1 : 0,
// holds the first row if it has a (<TH>) & nothing if (<TD>)
                $th = ($hasHead ? $table.rows[(0)].outerHTML : "");
// count the number of pages
        var $pageCount = Math.ceil($rowCount / $n);
// if we had one page only, then we have nothing to do ..
        if ($pageCount > 1) {
            // assign each row outHTML (tag name & innerHTML) to the array
            for ($i = $j, $ii = 0; $i < $rowCount; $i++, $ii++)
                $tr[$ii] = $table.rows[$i].outerHTML;
            // create a div block to hold the buttons
            $table.insertAdjacentHTML("afterend", "<div id='buttons'></div");
            // the first sort, default page is the first one
            sort(1);
        }

// ($p) is the selected page number. it will be generated when a user clicks a button
        function sort($p) {
            /* create ($rows) a variable to hold the group of rows
             ** to be displayed on the selected page,
             ** ($s) the start point .. the first row in each page, Do The Math
             */
            var $rows = $th, $s = (($n * $p) - $n);
            for ($i = $s; $i < ($s + $n) && $i < $tr.length; $i++)
                $rows += $tr[$i];

            // now the table has a processed group of rows ..
            $table.innerHTML = $rows;
            // create the pagination buttons
            document.getElementById("buttons").innerHTML = pageButtons($pageCount, $p);
            // CSS Stuff
            document.getElementById("id" + $p).setAttribute("class", "active");
        }


// ($pCount) : number of pages,($cur) : current page, the selected one ..
        function pageButtons($pCount, $cur) {
            /* this variables will disable the "Prev" button on 1st page
             and "next" button on the last one */
            var $prevDis = ($cur === 1) ? "disabled" : "",
                    $nextDis = ($cur === $pCount) ? "disabled" : "",
                    /* this ($buttons) will hold every single button needed
                     ** it will creates each button and sets the onclick attribute
                     ** to the "sort" function with a special ($p) number..
                     */
                    $buttons = "<input type='button' value='<< Prev' onclick='sort(" + ($cur - 1) + ")' " + $prevDis + ">";
            for ($i = 1; $i <= $pCount; $i++)
                $buttons += "<input type='button' id='id" + $i + "'value='" + $i + "' onclick='sort(" + $i + ")'>";
            $buttons += "<input type='button' value='Next >>' onclick='sort(" + ($cur + 1) + ")' " + $nextDis + ">";
            return $buttons;
        }
    </script>

</html>
