<%-- 
    Document   : home
    Created on : Feb 7, 2023, 11:46:54 PM
    Author     : Nard PC
--%>

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
                    <div class="fifth-line">
                        <p>4 &#9733; average rating</p>
                    </div>

                    <div class="review1">
                        <p>Good coffee, freshly brewed and roasted beans
                            <br>- R-vhin Picadizo</p>
                    </div>
                    <div class="review2">
                        <p>I like the interior of the store, very elegant

                            <br>- Clark Mansibang</p>
                    </div>
                    <div class="review3">
                        <p>Coffee is delicious, same as their pastries

                            <br>- Kevin Ruiz</p>
                    </div>
                </div>
            </div>

    </body>

    <jsp:include page="adminFooter.jsp" /> <!-- Calls the footer for admin-->
</html>
