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
            if (request.getAttribute("loadedFeedback") == null) {
        %>
        <form action="Feedback_Controller" method="post" name="load">
            <input type="hidden" name="instruction" value="load">
            <input type="hidden" name="page" value="adminFeedback_page.jsp">
            <script>
                window.onload = function () {
                    document.forms['load'].submit();
                };
            </script>
            <%
                }%>

            <div class="container1">
                <table>
                    <tr>
                        <th colspan="3">Latest Comments</th>
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

                        <td class="Cbox">
                            <%=feedbackList.getString("timestamp")%>
                            <input type="checkbox" checked="checked">
                            <span class="checkmark"></span>
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
                stars = document.getElementsByName("rate");

        for (var i = 0; i < ratings.length; i++) {
            stars[(i + 1) * 5 - ratings[i].value].checked = true;
        }

    </script>
</html>
