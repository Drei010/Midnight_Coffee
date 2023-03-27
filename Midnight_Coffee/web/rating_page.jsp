<%-- 
    Document   : rating_page
    Created on : Mar 24, 2023, 4:14:56 PM
    Author     : Acer Predator Helios
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/rating_page.css'>
        <title>Rating Page</title>
    </head>

    <body>
        <%
            if (!"customer".equals(session.getAttribute("role"))||!"rating".equals(session.getAttribute("orderStep"))) {
                response.sendRedirect("/Login");
            }%>
        <header>
            <nav class="header">
                <div class="header-left">
                    <div class="logo-container">
                        <img src="https://i.postimg.cc/X7LBNhbz/MNC-Updated-Logo-White-Transparent.png" alt="MNC_Logo" width="100px" height="100px">
                    </div>
                </div>
            </nav>
        </header>
        <div class="container">
            <form action ="Feedback_Controller" method="POST" name="ratingForm">
                <input type="hidden" id="rating" name="rating">
                <input type="hidden" id="add" name="instruction" value="add">
                <div class ="rateText">
                    <h1>Please rate our service!</h1>
                </div>

                <div class="stars">
                    <div class="rate2">
                        <input type="radio" id="star5" name="rate" value="5"/>
                        <label for="star5">5 stars</label>
                        <input type="radio" id="star4" name="rate" value="4"/>
                        <label for="star4"">4 stars</label>
                        <input type="radio" id="star3" name="rate" value="3"/>
                        <label for="star3">3 stars</label>
                        <input type="radio" id="star2" name="rate" value="2"/>
                        <label for="star2">2 stars</label>
                        <input type="radio" id="star1" name="rate" value="1"/>
                        <label for="star1">1 star</label>
                    </div>
                </div>    

                <div class ="commentText">
                    <h1>Your comment</h1>
                </div>

                <div class="commentInput">
                    <textarea class="squareInputField" placeholder="Add your comment here..." required maxlength="500" name="message"></textarea>
                </div>


                <input type="button" class="submitBtn" value="SUBMIT" onclick="setRating()">
            </form>
        </div>

        <div class="container2">
            <div class ="container2Text">
                <p>Thank you for rating, this will help us know what to improve in our service.</p>
                <p>Happy Sippin'!</p>
            </div>
        </div>

    </body>
    <script>
        function setRating() {
            var radioSelected = document.querySelector('input[name="rate"]:checked'),
                    rating = document.getElementById('rating');

            if (radioSelected === null) {
                rating.value = "0";
            } else {
                rating.value = radioSelected.value;
            }

            document.forms['ratingForm'].submit();
        }
    </script>
</html>