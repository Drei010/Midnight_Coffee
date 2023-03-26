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
        <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css">

        <title>Home</title>
    </head>

    <jsp:include page="header.jsp" /> <!-- Calls the header for admin-->

    <body>
        <%
            if (!"yes".equals(session.getAttribute("loaded"))) {
        %>
        <form action="Feedback_Controller" method="post" name="load">
            <input type="hidden" name="instruction" value="load">
            <input type="hidden" name="page" value="Home">
            <script>
                window.onload = function () {
                    document.forms['load'].submit();
                };
            </script>
            <%} else {
                    session.setAttribute("loaded", "no");
                }%>

            <div class="websiteContainer">
                <section class="one">
                    <div class="oneContent">
                        <p>Your neighborhood specialty coffee</p>
                        <p>shop in downtown Manila</p>
                        <button class="cta-button" onclick="location.href = 'Menu_page.jsp';">View Menu</button>
                    </div>
                </section>

                <section class="two">
                    <h1>Our products</h1>
                    <div class="container">
                        <div class="box">
                            <div class="imgbox">
                                <img src="https://i.postimg.cc/sxZgvnHZ/coffee1.png" alt="">
                            </div>
                            <h1>Coffee</h1>
                            <p>Our high-quality coffee beans are carefully sourced and roasted in-house to create a rich, flavorful cup that will awaken your senses and leave you craving for more. We take pride in every cup of coffee we serve.</p>
                        </div>
                        <div class="box">
                            <div class="imgbox">
                                <img src="https://i.postimg.cc/3wy7kjx0/kremalatte1.png" alt="">
                            </div>
                            <h1>Kremalatte</h1>
                            <p>Our signature Kremalatte is made with only the freshest ingredients, including locally-sourced milk and our house-made vanilla syrup, ensuring a creamy and indulgent treat every time.</p>
                        </div>
                        <div class="box">
                            <div class="imgbox">
                                <img src="https://i.postimg.cc/fyJJYc5Y/tea1.png" alt="">
                            </div>
                            <h1>Tea</h1>
                            <p>Our teas are crafted with utmost care and attention to detail. Each cup is a perfect balance of flavor and aroma, bringing a sense of calm and relaxation to your day.</p>
                        </div>
                    </div>
                </section>

                <section class ="three">
                    <%ResultSet feedback = (ResultSet) session.getAttribute("feedback");
                        if (feedback != null) {%>

                    <div class="testimonial-heading">
                        <span>Comments from our customers</span>
                        <h1><%=session.getAttribute("averageRating")%> &#9733; average rating</h1>
                    </div>

                    <div class="testimonial-box-container">
                        <div class="testimonial-box">
                            <div class="box-top">
                                <%if (feedback.next()) {%>

                                <div class="name-user">
                                    <strong><%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></strong>

                                </div>

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

                            </div>          
                            <div class="client-comment">
                                <p><%=feedback.getString("message")%></p>
                            </div>
                            <%}%>

                        </div>

                        <div class="testimonial-box">
                            <div class="box-top">
                                <%if (feedback.next()) {%>

                                <div class="name-user">
                                    <strong><%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></strong>

                                </div>

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

                            </div>          
                            <div class="client-comment">
                                <p><%=feedback.getString("message")%></p>
                            </div>
                            <%}%>

                        </div>

                        <div class="testimonial-box">
                            <div class="box-top">
                                <%if (feedback.next()) {%>

                                <div class="name-user">
                                    <strong><%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></strong>

                                </div>

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

                            </div>          
                            <div class="client-comment">
                                <p><%=feedback.getString("message")%></p>
                            </div>
                            <%}%>

                        </div>
                            

                        <div class="testimonial-box">
                            <div class="box-top">
                                <%if (feedback.next()) {%>

                                <div class="name-user">
                                    <strong><%=feedback.getString("customerFirstName") + " " + feedback.getString("customerLastName")%></strong>

                                </div>

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

                            </div>          
                            <div class="client-comment">
                                <p><%=feedback.getString("message")%></p>
                            </div>
                            <%}%>

                        </div>
                        <%}%>



                    </div>


                </section>

                <section class ="four" class="footer-section">
                    <footer class="footer-distributed">

                        <div class="footer-left">
                            <h3>Midnight Coffee</h3>
                            <p>It's more than just coffee.</p>

                            <p class="footer-company-name">Copyright © 2023 <strong>Midnight Coffee</strong> All rights reserved</p>
                        </div>

                        <div class="footer-center">
                            <div>
                                <a href="https://www.google.com/maps/place/Midnight+Coffee/@14.6077876,120.987625,20z/data=!4m6!3m5!1s0x3397cb18d9f44a99:0xf2041232630d0711!8m2!3d14.6076822!4d120.9873617!16s%2Fg%2F11swzb1fxv" target="_blank"><i class="fa fa-map-marker"></i></a>
                                <p><span>Sampaloc, Philippines</span>
                                    1039 Lotus de Cataluña bldg.</p>
                            </div>

                            <div>
                                <i class="fa fa-phone"></i>
                                <p>0995 761 9531</p>
                            </div>

                            <div>
                                <a href="mailto:business.midnightcoffee@gmail.com" target="_blank"><i class="fa fa-envelope"></i></a>
                                <p>business.midnightcoffee@gmail.com</a></p>
                            </div>
                        </div>

                        <div class="footer-right">
                            <p class="footer-company-about">
                                <span>Follow us</span>
                                Coffee is what empowers us to wake up every morning <br> and pushes us to go beyond midnight.
                            </p>
                            <div class="footer-icons">
                                <a href="https://www.facebook.com/midnightcoffee.philippines" target="_blank"><i class="fa fa-facebook"></i></a>
                                <a href="https://www.instagram.com/midnightcoffee.ph/?hl=en" target="_blank"><i class="fa fa-instagram"></i></a>
                                <a href="https://www.tiktok.com/@midnightcoffee.ph" target="_blank"><i class="fab fa-tiktok"></i></a>
                            </div>
                        </div>
                    </footer>
                </section>
            </div>

    </body>
    <script>
        let ratings = document.getElementsByName("rating"),
                stars = document.getElementsByName("rate");
        for (var i = 0; i < ratings.length; i++) {
            stars[(i + 1) * 5 - ratings[i].value].checked = true;
        }
    </script>
</html>
