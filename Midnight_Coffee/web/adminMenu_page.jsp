<%-- 
    Document   : adminMenu_page
    Created on : 5 Feb 2023, 6:12:38 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='general.css'>
        <link rel='stylesheet' type='text/css' href='adminMenu.css'>
        <title>Menu</title>
    </head>

    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->

    <body>
        <div class="admin-menu-label">
            <h1>Admin Menu</h1>
        </div>
        <div class="menu-container">

            <div class="Non-Coffees">
                <div class="scroll-button" id="scroll-left">&lt;</div>
                <div class="noncoffee-items">
                    <div class="noncoffee-add-entry">add button</div>
                    <div class="product">1</div>
                    <div class="product">2</div>
                    <div class="product">3</div>
                    <div class="product">4</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">9</div>
                    <div class="product">5</div>
                    <div class="product">5</div>
                    <div class="product">11</div>
                </div>
                <div class="scroll-button" id="scroll-right">&gt;</div>
            </div>
        </div>

        <!--          <div class="Coffees">
                      <div class="scroll-button" id="scroll-left">&lt;</div>
                      <h2>Coffees</h2>
                      <div class="scroll-button" id="scroll-right">&gt;</div>
                  </div>
      
                  <div class="Midnight-Snacks">
                      <div class="scroll-button" id="scroll-left">&lt;</div>
                      <h2>Midnight Snacks</h2>
                      <div class="scroll-button" id="scroll-right">&gt;</div>
                  </div>
        -->

        <script>
            const nonCoffees = document.querySelector(".Non-Coffees");
            const nonCoffeeItems = document.querySelector(".noncoffee-items");
            const scrollLeftBtn = document.querySelector("#scroll-left");
            const scrollRightBtn = document.querySelector("#scroll-right");

            scrollLeftBtn.addEventListener("click", () => {
                nonCoffeeItems.scrollLeft -= 100;
            });

            scrollRightBtn.addEventListener("click", () => {
                nonCoffeeItems.scrollLeft += 100;
            });
        </script>
    </body>
</html>
