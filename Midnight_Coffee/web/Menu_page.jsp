<%-- 
    Document   : infiniteCarousel
    Created on : 20 Dec 2022, 11:39:36 am
    Author     : Andrei
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/menu.css'>
    </head>
   
    <body> 
        <jsp:include page="header.jsp" /> <!-- Calls the header for admin-->
        
          <!-- Check if menu is loaded-->
                <%
            if (request.getAttribute("loadedMenu") == null) {
            %>
              <form action="Menu_Controller" method="post" name="loadMenu">
                <input type="hidden" name="instruction" value="loadMenu">
                <input type="hidden" name="page" value="Menu_page.jsp">
              </form>
              <script>
                window.onload = function() {
                  document.forms['loadMenu'].submit();
                };
              </script>
            <%
              }%>
        <table>
            <thead>
                <tr>
                    <th>Quantity</th>
                    <th>Name</th>
                    <th>Classification</th>
                    <th>Price</th>
                    <th></th>
                </tr>
            </thead>
            <tbody>
            </tbody>      
            <tfoot>
                <tr>
                    <th></th>
                    <th></th>
                    <th>Total</th>
                    <th><input type="text" name="total" id="total" value="0" disabled=""/></th>

                </tr>
            </tfoot>
        </table>



        <div class="row">

            <%-- Carousel title and progress bar--%>       
            <div class="header-menu">
                <h3 class="title">Coffee</h3>
                <div class="progress-bar"></div>
            </div>

            <div class="carouselContainer">

                <%-- Left Arrow Button--%>
                <button class="handle left-handle">
                    <div class="text">&#8249;</div>
                </button>

                <%ResultSet coffee = (ResultSet) request.getAttribute("coffee");
                    if (coffee != null) {%>

                <%-- Carousel Items container--%>
                <div class="slider">

                    <%
                        while (coffee.next()) {
                    %>

                    <%-- Slider Item Start--%>      
                    <div class="item">  

                        <%-- Hidden fields for database submission--%>
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=coffee.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=coffee.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=coffee.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=coffee.getString("itemPrice")%>" />

                        <%-- Item Name--%>
                        <h1 class="itemName"><%=coffee.getString("itemName")%></h1>     

                        <%-- Item Image--%>
                        <img
                            class="thumbnail"
                            src="userImages/bg.png"
                            alt="Sample Item Image">

                        <%-- Item Option--%>
                        <h3 class="itemOption"><%=coffee.getString("itemOption")%></h3>

                        <%-- Item PriceTag--%>
                        <h3 class="itemPHPTag">PHP</h3>

                        <%-- Item Price--%> 
                        <h3 class="itemPrice"><%=coffee.getString("itemPrice")%></h3>

                        <%-- Quantity Decrament--%>
                        <div class="dec">-</div>

                        <%-- Quantity input field--%>
                        <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>

                        <%-- Quantity Incrament--%>
                        <div class="inc">+</div>

                    </div>
                    <%-- Slider Item End--%>   

                    <%}
                        }%>

                </div>
                <%-- Right Arrow Button--%>
                <button class="handle right-handle">
                    <div class="text">&#8250;</div>
                </button>
            </div>
        </div>




        <div class="row">

            <%-- Carousel title and progress bar--%>    
            <div class="header-menu">
                <h3 class="title">Non-Coffees</h3>
                <div class="progress-bar"></div>
            </div>

            <div class="carouselContainer">

                <%-- Left Arrow Button--%>
                <button class="handle left-handle">
                    <div class="text">&#8249;</div>
                </button>

                <%ResultSet noncoffee = (ResultSet) request.getAttribute("noncoffee");
                    if (noncoffee != null) {%>

                <%-- Carousel Items container--%>
                <div class="slider">

                    <%
                        while (noncoffee.next()) {
                    %>

                    <%-- Slider Item Start--%>      
                    <div class="item">  

                        <%-- Hidden fields for database submission--%>
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=noncoffee.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=noncoffee.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=noncoffee.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=noncoffee.getString("itemPrice")%>" />

                        <%-- Item Name--%>
                        <h1 class="itemName"><%=noncoffee.getString("itemName")%></h1>     

                        <%-- Item Image--%>
                        <img
                            class="thumbnail"
                            src="userImages/bg.png"
                            alt="Sample Item Image">

                        <%-- Item Option--%>
                        <h3 class="itemOption"><%=noncoffee.getString("itemOption")%></h3>

                        <%-- Item PriceTag--%>
                        <h3 class="itemPHPTag">PHP</h3>

                        <%-- Item Price--%> 
                        <h3 class="itemPrice"><%=noncoffee.getString("itemPrice")%></h3>

                        <%-- Quantity Decrament--%>
                        <div class="dec">-</div>

                        <%-- Quantity input field--%>
                        <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>

                        <%-- Quantity Incrament--%>
                        <div class="inc">+</div>

                    </div>
                    <%-- Slider Item End--%>   

                    <%}
                        }%>

                </div>
                <%-- Right Arrow Button--%>
                <button class="handle right-handle">
                    <div class="text">&#8250;</div>
                </button>
            </div>
        </div>

        <div class="row">

            <%-- Carousel title and progress bar--%>       
            <div class="header-menu">
                <h3 class="title">Snacks</h3>
                <div class="progress-bar"></div>
            </div>

            <div class="carouselContainer">

                <%-- Left Arrow Button--%>
                <button class="handle left-handle">
                    <div class="text">&#8249;</div>
                </button>

                <%ResultSet snack = (ResultSet) request.getAttribute("snack");
                    if (snack != null) {%>

                <%-- Carousel Items container--%>
                <div class="slider">

                    <%
                        while (snack.next()) {
                    %>

                    <%-- Slider Item Start--%>      
                    <div class="item">  

                        <%-- Hidden fields for database submission--%>
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=snack.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=snack.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=snack.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=snack.getString("itemPrice")%>" />

                        <%-- Item Name--%>
                        <h1 class="itemName"><%=snack.getString("itemName")%></h1>     

                        <%-- Item Image--%>
                        <img
                            class="thumbnail"
                            src="userImages/bg.png"
                            alt="Sample Item Image">

                        <%-- Item Option--%>
                        <h3 class="itemOption"><%=snack.getString("itemOption")%></h3>

                        <%-- Item PriceTag--%>
                        <h3 class="itemPHPTag">PHP</h3>

                        <%-- Item Price--%> 
                        <h3 class="itemPrice"><%=snack.getString("itemPrice")%></h3>

                        <%-- Quantity Decrament--%>
                        <div class="dec">-</div>

                        <%-- Quantity input field--%>
                        <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>

                        <%-- Quantity Incrament--%>
                        <div class="inc">+</div>

                    </div>
                    <%-- Slider Item End--%>   

                    <%}
                        }%>

                </div>
                <%-- Right Arrow Button--%>
                <button class="handle right-handle">
                    <div class="text">&#8250;</div>
                </button>
            </div>
        </div>

    </body>
    <script>

        // If the arrow buttons are clicked
        document.addEventListener("click", e => {
            let handle;
            if (e.target.matches(".handle")) {
                handle = e.target;
            } else {
                handle = e.target.closest(".handle");
            }
            if (handle) {
                onHandleClick(handle);
            }
        });

//Throttle progress bar update
        const throttleProgressBar = throttle((delay = 1000) => {
            document.querySelectorAll(".progress-bar").forEach(calculateProgressBar);
        });
        window.addEventListener("resize", throttleProgressBar);

        document.querySelectorAll(".progress-bar").forEach(calculateProgressBar);


//Progress bar computation
        function calculateProgressBar(progressBar) {
            progressBar.innerHTML = "";
            const slider = progressBar.closest(".row").querySelector(".slider");
            if (!slider) {
                return;
            }
            const itemCount = slider.children.length;
            const itemsPerScreen = parseInt(
                    getComputedStyle(slider).getPropertyValue("--items-per-screen")
                    );
            let sliderIndex = parseInt(
                    getComputedStyle(slider).getPropertyValue("--slider-index")
                    );
            const progressBarItemCount = Math.ceil(itemCount / itemsPerScreen);

            if (sliderIndex >= progressBarItemCount) {
                slider.style.setProperty("--slider-index", progressBarItemCount - 1);
                sliderIndex = progressBarItemCount - 1;
            }

            for (let i = 0; i < progressBarItemCount; i++) {
                const barItem = document.createElement("div");
                barItem.classList.add("progress-item");
                if (i === sliderIndex) {
                    barItem.classList.add("active");
                }
                progressBar.append(barItem);
            }
        }


///Move progress bar and containers
        function onHandleClick(handle) {
            const progressBar = handle.closest(".row").querySelector(".progress-bar");
            const slider = handle.closest(".carouselContainer").querySelector(".slider");
            const sliderIndex = parseInt(
                    getComputedStyle(slider).getPropertyValue("--slider-index")
                    );
            const progressBarItemCount = progressBar.children.length;
            if (handle.classList.contains("left-handle")) {
                if (sliderIndex - 1 < 0) {
                    slider.style.setProperty("--slider-index", progressBarItemCount - 1);
                    progressBar.children[sliderIndex].classList.remove("active");
                    progressBar.children[progressBarItemCount - 1].classList.add("active");
                } else {
                    slider.style.setProperty("--slider-index", sliderIndex - 1);
                    progressBar.children[sliderIndex].classList.remove("active");
                    progressBar.children[sliderIndex - 1].classList.add("active");
                }
            }

            if (handle.classList.contains("right-handle")) {
                if (sliderIndex + 1 >= progressBarItemCount) {
                    slider.style.setProperty("--slider-index", 0);
                    progressBar.children[sliderIndex].classList.remove("active");
                    progressBar.children[0].classList.add("active");
                } else {
                    slider.style.setProperty("--slider-index", sliderIndex + 1);
                    progressBar.children[sliderIndex].classList.remove("active");
                    progressBar.children[sliderIndex + 1].classList.add("active");
                }
            }
        }

        function throttle(cb, delay = 1000) {
            let shouldWait = false;
            let waitingArgs;
            const timeoutFunc = () => {
                if (waitingArgs === null) {
                    shouldWait = false;
                } else {
                    cb(...waitingArgs);
                    waitingArgs = null;
                    requestAnimationFrame(timeoutFunc, delay);
                }
            };

            return (...args) => {
                if (shouldWait) {
                    waitingArgs = args;
                    return;
                }

                cb(...args);
                shouldWait = true;
                requestAnimationFrame(timeoutFunc, delay);
            };
        }

/////////////////////////////// Total orders computation//////////////////////

// incrament decrament buttons
        var incramentButton = document.getElementsByClassName('inc');
        var decramentButton = document.getElementsByClassName('dec');

        for (var i = 0; i < incramentButton.length; i++) {
            var button = incramentButton[i];
            button.addEventListener('click', function (event) {

                var buttonClicked = event.target;

                // get reference to input field
                var input = buttonClicked.parentElement.children[11];

                // get current value of input field
                var inputValue = input.value;

                // increment value by 1
                var newValue = parseInt(inputValue) + 1;

                // update value of input field         
                input.value = newValue;

                //get table body
                const tbodyEl = document.querySelector("tbody");

                //Get id of current item
                var itemID = buttonClicked.parentElement.children[1].value;

                //Create new row if quantity is equal to 1
                if (newValue === 1) {

                    tbodyEl.innerHTML +=
                            //set row id as row + itemId
                            //set quantity id as quantity + itemId
                            `<tr id="row` + itemID + `">
                <td id="quantity` + itemID + `">`

                            //Quantity
                            + newValue +
                            `</td>            
                <td>`

                            //Item Name
                            + buttonClicked.parentElement.children[2].value +
                            `</td>
                <td>`

                            //Item Classification  
                            + buttonClicked.parentElement.children[3].value +
                            //set price id as price + itemId
                            `</td>
                <td id="price` + itemID + `">`

                            //Item Price  
                            + buttonClicked.parentElement.children[4].value +
                            `</td>
            </tr>`;
                } else {

                    //get old price
                    var oldPrice = buttonClicked.parentElement.children[4].value;

                    //Compute for the new price (Quantity * old price)
                    var newPrice = parseInt(oldPrice) * newValue;

                    //set id of quantity and price
                    var quantityID = "quantity" + itemID;
                    var priceID = "price" + itemID;

                    //incrament quantity
                    document.getElementById(quantityID).innerHTML = newValue;

                    //set new price
                    document.getElementById(priceID).innerHTML = newPrice;
                }
                findTotal();

            });
        }
        for (var i = 0; i < decramentButton.length; i++) {
            var button = decramentButton[i];
            button.addEventListener('click', function (event) {

                var buttonClicked = event.target;

                // get reference to input field
                var input = buttonClicked.parentElement.children[11];

                // get current value of input field
                var inputValue = input.value;

                // decrement value by 1
                var newValue = parseInt(inputValue) - 1;

                //Get id of current item 
                var itemID = buttonClicked.parentElement.children[1].value;

                // update value of input field  
                if (newValue > 0) {
                    input.value = newValue;

                    //get old price
                    var oldPrice = buttonClicked.parentElement.children[4].value;

                    //Compute for the new price (Quantity * old price)
                    var newPrice = parseInt(oldPrice) * newValue;

                    //set id of quantity and price
                    var quantityID = "quantity" + itemID;
                    var priceID = "price" + itemID;

                    //decrament quantity
                    document.getElementById(quantityID).innerHTML = newValue;

                    //set new price
                    document.getElementById(priceID).innerHTML = newPrice;
                } else {
                    input.value = 0;

                    //set id of row
                    var rowID = "row" + itemID;

                    //remove row
                    document.getElementById(rowID).remove();
                }
                findTotal();
            });
        }

//// Total Price added to cart
        function findTotal() {

            var arr = document.getElementsByClassName('itemQuantity');
            var price = document.getElementsByClassName('hiddenPrice');
            var total = 0;
            for (var i = 0; i < arr.length; i++) {
                if (parseInt(arr[i].value))
                    total += parseInt(price[i].value) * parseInt(arr[i].value);
            }
            document.getElementById('total').value = total;

        }
    </script>
</html>
