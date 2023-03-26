<%-- 
    Document   : home
    Created on : Feb 7, 2023, 11:46:54 PM
    Author     : Nard PC
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/home.css'>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <title>Home</title>
    </head>

    <jsp:include page="header.jsp" /> <!-- Calls the header for admin-->

    <body>
        <%
            String data = request.getParameter("loaded");
            System.out.println("yes".equals(data));
            if (!"yes".equals(data)) {
        %>
        <form action="Feedback_Controller" method="post" name="load">
            <input type="hidden" name="instruction" value="load">
            <input type="hidden" name="page" value="Home">
            <script>
                window.onload = function () {
                    document.forms['load'].submit();
                };
            </script>
            <%                }%>

            <div class="row">

                <div class="column1">

                    <div class="pic1">
                        <img class="mmc" src="https://i.postimg.cc/m26m4V9R/299640029-197416492628285-2614266720725062472-n.jpg">
                    </div>

                </div>
                <!--Check if customer is logged in -->

                <div class="column2">

                    <div class="admin-home-container">
                        <div class="home-container-contents">
                            <div class="first-line">
                                <p>Welcome <%= session.getAttribute("firstname") == null ? "Guest" : session.getAttribute("firstname")%><br>Midnight Coffee</p>


                            </div>
                            <div class="second-line">
                                <p>It's more than just coffee.</p>

                            </div>
                            <div class="third-line">
                                <p>Order Now!</p>
                            </div>

                            <div class="logos">
                                <a href="https://www.facebook.com/midnightcoffee.philippines" target="_blank">
                                    <div class="button">
                                        <div class="icon">
                                            <i class="fab fa-facebook-f"></i>
                                        </div>
                                        <span>Facebook</span>
                                    </div>
                                </a>
                                <a href="https://www.instagram.com/midnightcoffee.ph/" target="_blank">
                                    <div class="button">
                                        <div class="icon">
                                            <i class="fab fa-instagram"></i>
                                        </div>
                                        <span>Instagram</span>
                                    </div>       
                                </a>
                                <a href="https://www.tiktok.com/@midnightcoffee.ph" target="_blank">    
                                    <div class="button">
                                        <div class="icon">
                                            <i class="fab fa-tiktok"></i>
                                        </div>
                                        <span>Tiktok</span>
                                    </div>
                                </a>
                            </div>

                        </div>

                    </div>
                    <br>
                    <div class="reviews">

                        <div class="fourth-line">
                            <p>Comments from our customers</p>
                        </div>
                        <%ResultSet feedback = (ResultSet) session.getAttribute("feedback");
                            if (feedback != null) {%>
                        <div class="fifth-line">
                            <p><%=session.getAttribute("averageRating")%> &#9733; average rating</p>
                        </div>

                        <div class="review1">
                            <%if (feedback.next()) {%>
                            <div class="stars">
                                <form>
                                    <div class="rate2">
                                        <input type="hidden" id="rating" name="rating" value="<%=feedback.getInt("rating")%>">
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
                            <p><%=feedback.getString("message")%>
                                <br>- <%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></p>
                                <%}%>
                        </div>

                        <div class="review2">
                            <%if (feedback.next()) {%>
                            <div class="stars">
                                <form>
                                    <div class="rate2">
                                        <input type="hidden" id="rating" name="rating" value="<%=feedback.getInt("rating")%>">
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
                            <p><%=feedback.getString("message")%>
                                <br>- <%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></p>
                                <%}%>
                        </div>

                        <div class="review3">
                            <%if (feedback.next()) {%>
                            <div class="stars">
                                <form>
                                    <div class="rate2">
                                        <input type="hidden" id="rating" name="rating" value="<%=feedback.getInt("rating")%>">
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
                            <p><%=feedback.getString("message")%>
                                <br>- <%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></p>
                                <%}%>
                        </div>
                        <%}%>
                    </div>
                </div>

                </body>
                <script>
                    let ratings = document.getElementsByName("rating"),
                            stars = document.getElementsByName("rate");
                    for (var i = 0; i < ratings.length; i++) {
                        stars[(i + 1) * 5 - ratings[i].value].checked = true;
                    }
                </script>
                <jsp:include page="adminFooter.jsp" /> <!-- Calls the footer for admin-->
                </html>
