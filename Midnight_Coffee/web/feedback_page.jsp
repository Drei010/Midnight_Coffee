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
        <link rel='stylesheet' type='text/css' href='styles/feedback.css'>
        <title>Feedback</title>
    </head>

    <jsp:include page="header.jsp" /> <!-- Calls the header jsp -->

    <body>

        <%
            if (request.getAttribute("loadedFeedback") == null) {
        %>
        <form action="Feedback_Controller" method="post" name="load">
            <input type="hidden" name="instruction" value="load">
            <input type="hidden" name="page" value="feedback_page.jsp">
            <script>
                window.onload = function () {
                    document.forms['load'].submit();
                };
            </script>
            <%
                }%>

            <div class="container1">

                <table data-rows-per-page="6" id="table">
                    <tr>
                        <th colspan="3">

                            <div class="LC">Latest Comments
                            </div>


                        </th>
                    </tr>

                    <%ResultSet feedbackList = (ResultSet) request.getAttribute("feedback");
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

                    </tr>
                    <%}
                        }%>
                </table>

            </div>
            <p id="demo"></p>
    </body>
    <script>
        let ratings = document.getElementsByName("rating"),
                stars = document.getElementsByName("rate"),
                id = document.getElementsByName("customerid"),
                cbox = document.getElementsByName("Cbox");
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



        }

        function sort($p) {
            var $rows = $th, $s = (($n * $p) - $n);
            for ($i = $s; $i < ($s + $n) && $i < $tr.length; $i++)
                $rows += $tr[$i];

            $table.innerHTML = $rows;
            document.getElementById("buttons").innerHTML = pageButtons($pageCount, $p);
            document.getElementById("id" + $p).setAttribute("class", "active");

            checkItems();



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

            }
        }
    </script>
</html>
