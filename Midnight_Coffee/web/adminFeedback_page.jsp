<%-- 
    Document   : adminFeedback_page
    Created on : 5 Feb 2023, 6:14:21 pm
    Author     : rvhin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/AdminFeedback.css'>
        <title>Feedback</title>
    </head>

    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->

    <body>

        <%
            if (!"yes".equals(session.getAttribute("loaded"))) {
        %>
        <form action="Feedback_Controller" method="post" name="load">
            <input type="hidden" name="instruction" value="load">
            <input type="hidden" name="page" value="AdminFeedback">
            <script>
                window.onload = function () {
                    document.forms['load'].submit();
                };
            </script>
            <%} else {
                    session.setAttribute("loaded", "no");
                }%>

            <div class="container1">

                <table data-rows-per-page="6" id="table">
                    <tr>
                        <th colspan="3">

                            <div class="LC">Latest Comments
                            </div>


                        </th>
                    </tr>

                    <%ResultSet feedbackList = (ResultSet) session.getAttribute("feedback");
                        if (feedbackList != null) {
                            while (feedbackList.next()) {%>
                    <tr>
                        <td class="CDetails"> 
                            <div class="Cname">                             
                                <%=feedbackList.getString("customerFirstname")%> <%=feedbackList.getString("customerLastname")%>
                            </div>
                            <div class="stars">
                                <form>
                                    <div class="rate2">
                                        <input type="hidden" id="rating" name="rating" value="<%=feedbackList.getInt("rating")%>">
                                        <input type="radio" id="star5" name="rate" value="5" disabled/>
                                        <label for="star5">5 stars</label>
                                        <input type="radio" id="star4" name="rate" value="4" disabled/>
                                        <label for="star4"">4 stars</label>
                                        <input type="radio" id="star3" name="rate" value="3" disabled/>
                                        <label for="star3">3 stars</label>
                                        <input type="radio" id="star2" name="rate" value="2" disabled/>
                                        <label for="star2">2 stars</label>
                                        <input type="radio" id="star1" name="rate" value="1" disabled/>
                                        <label for="star1">1 star</label>
                                    </div>
                                </form>
                            </div>
                            <div class="Comment">
                                <%=feedbackList.getString("message")%>
                            </div>
                        </td>

                        <td>
                            <div class="TS">
                                <%=feedbackList.getString("timestamp")%>


                            </div>
                        </td>
                        <td class="box">
                            <label class="Cbox">
                                <input type="hidden" name="feedbackid" value="<%=feedbackList.getInt("feedbackID")%>">
                                <input type="hidden" name="checked" value="<%=feedbackList.getString("displayed")%>">
                                <input type="checkbox" class="Cbox" name="Cbox">
                                <span class="checkmark"></span>
                            </label>
                        </td>

                    </tr>
                    <%}
                        }%>
                </table>
                <div class="upBtn">
                    <form action="Feedback_Controller" method="post" onclick="compareDiff()">
                        <input type="hidden" name ="update" id="update">
                        <input type="hidden" name ="updateId" id="updateId">
                        <input type="hidden" name="instruction" value="update">
                        <input class="update" type="submit" name="action" value="Update">
                    </form>
                </div>
            </div>
            <p id="demo"></p>
    </body>
    <script>
        let ratings = document.getElementsByName("rating"),
                stars = document.getElementsByName("rate"),
                id = document.getElementsByName("feedbackid"),
                isChecked = document.getElementsByName("checked"),
                cbox = document.getElementsByName("Cbox");
        var cboxValues = [];
        var cboxValues = [],
                originalCboxValues = [],
                updateCboxValues = [],
                idValues = [],
                updateIdValues = [];
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
        } else {
            checkItems();
            pushItems(1);
            for (i = 0; i < cbox.length; i++) {
                (function (protectedIndex) {
                    cbox[i].onclick = function () {
                        cboxValues[($p - 1) * 5 + protectedIndex] = [$p, cbox[protectedIndex].checked ? true : false];
                    };
                    cbox[i].checked = cboxValues[($p - 1) * 5 + i][1];
                })(i);
            }
        }
        function sort($p) {
            var $rows = $th, $s = (($n * $p) - $n);
            for ($i = $s; $i < ($s + $n) && $i < $tr.length; $i++)
                $rows += $tr[$i];
            $table.innerHTML = $rows;
            document.getElementById("buttons").innerHTML = pageButtons($pageCount, $p);
            document.getElementById("id" + $p).setAttribute("class", "active");
            checkItems();
            pushItems($p);
            for (i = 0; i < cbox.length; i++) {
                (function (protectedIndex) {
                    cbox[i].onclick = function () {
                        cboxValues[($p - 1) * 5 + protectedIndex] = [$p, cbox[protectedIndex].checked ? true : false];
                    };
                    cbox[i].checked = cboxValues[($p - 1) * 5 + protectedIndex][1];
                })(i);
            }
        }
        function pageButtons($pCount, $cur) {
            var $prevDis = ($cur === 1) ? "disabled" : "",
                    $nextDis = ($cur === $pCount) ? "disabled" : "",
                    $buttons = "<div class='nextP'><input type='button' value='<< Prev' onclick='sort(" + ($cur - 1) + ")' " + $prevDis + ">";
            for ($i = 1; $i <= $pCount; $i++)
                $buttons += "<input type='button' id='id" + $i + "'value='" + $i + "' onclick='sort(" + $i + ")'>";
            $buttons += "<input type='button' value='Next >>' onclick='sort(" + ($cur + 1) + ")' " + $nextDis + "></div>";
            return $buttons;
        }
        function checkItems() {
            for (var i = 0; i < ratings.length; i++) {
                stars[(i + 1) * 5 - ratings[i].value].checked = true;
                if (isChecked[i].value === "Yes") {
                    cbox[i].checked = true;
                } else {
                    cbox[i].checked = false;
                }
            }
        }
        function pushItems($p) {
            for (var i = 0; i < cbox.length; i++) {
                if (cboxValues.length < ($p - 1) * 5 + cbox.length) {
                    cboxValues.push([$p, cbox[i].checked]);
                    originalCboxValues.push([$p, cbox[i].checked]);
                    idValues.push([$p, id[i].value]);
                    console.log(id[i].value);
                }
            }
                console.log(idValues);
        }
        function compareDiff() {
            var update = document.getElementById("update"),
                    updateId = document.getElementById("updateId");

            for (var i = 0; i < originalCboxValues.length; i++) {
                if (cboxValues[i][1] !== originalCboxValues[i][1]) {
                    updateCboxValues.push(cboxValues[i][1]);
                    updateIdValues.push(idValues[i][1]);
                }
            }
            update.value = JSON.stringify(updateCboxValues);
            updateId.value = JSON.stringify(updateIdValues);
            console.log(update.value);
            console.log(updateId.value);
        }
    </script>
</html>
