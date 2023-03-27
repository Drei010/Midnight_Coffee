<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/payment_page.css'>
        <title>Customer Payment Page</title>
    </head>
    <body>
        <%
            if (!"customer".equals(session.getAttribute("role")) || !"payment".equals(session.getAttribute("orderStep"))) {
                response.sendRedirect("/Login");
            }%>
        <jsp:include page="loginSignup.jsp" />

        <div class="payment-message">
            <h1>Your order will be processed once payment is completed</h1>
        </div>
        <div class="container">
            <div class="carousel-container">
                <div class="arrow left-arrow">
                    <button class="prev-button" onclick="changeSlide(-1)">&#10094;</button>
                </div>
                <div class="carousel">
                    <%
                        if (!"yes".equals(session.getAttribute("loadedQRTable"))) {

                    %>
                    <form action="QR_Controller" method="post" name="loadTable">
                        <input type="hidden" name="instruction" value="loadQR">
                        <input type="hidden" name="page" value="Payment">
                    </form>
                    <script>
                        window.onload = function () {
                            document.forms['loadTable'].submit();
                        };
                    </script>
                    <%                    } else {
                        session.setAttribute("loadedQRTable", "no");
                        if (request.getAttribute("QRTableEmpty") == null) {
                            ResultSet QRTable = (ResultSet) session.getAttribute("QRTable");
                            while (QRTable.next()) {%>

                    <div class="carousel-item">
                        <img class="QRImages" src="QRImages/<%=QRTable.getString("QRImage")%>" alt="The QR Code image">
                        <h1><%=QRTable.getString("methodName")%></h1>
                    </div>

                    <% }
                            }
                        }%>
                </div>
                <div class="arrow right-arrow">
                    <button class="next-button" onclick="changeSlide(1)">&#10095;</button>
                </div>           
            </div>

            <div class ="instructions">
                <p>Amount to pay: PHP </p>
                <p>Please take a screenshot of your receipt</p>
            </div>

            <form action="Orders_Controller" method="post">
                <input type="hidden" name="action" value="instruction">
                <button type="submit" class="nextBtn"> Next</button>
            </form>
        </div>

        <script>
            let slideIndex = 1;
            showSlide(slideIndex);

            function changeSlide(n) {
                showSlide(slideIndex += n);
            }

            function showSlide(n) {
                let slides = document.getElementsByClassName("carousel-item");
                if (n > slides.length) {
                    slideIndex = 1;
                }
                if (n < 1) {
                    slideIndex = slides.length;
                }
                for (let i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";
                }
                slides[slideIndex - 1].style.display = "block";
            }
        </script>
    </body>
</html>