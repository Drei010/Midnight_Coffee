<%-- 
    Document   : adminMenu_page
    Created on : 5 Feb 2023, 6:12:38 pm
    Author     : rvhin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">    
        <link rel='stylesheet' type='text/css' href='styles/adminMenu.css'>

        <title>Admin Menu</title>
    </head>
    <body style="padding-bottom: 20px;">
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->
        <!-- Check if menu is loaded-->
        <%
            if (request.getAttribute("loadedMenu") == null) {
        %>
        <form action="Menu_Controller" method="post" name="loadMenu">
            <input type="hidden" name="instruction" value="loadMenu">
            <input type="hidden" name="page" value="adminMenu_page.jsp">
        </form>
        <script>
            window.onload = function () {
                document.forms['loadMenu'].submit();
            };
        </script>
        <%
            }%>


        <%-- Open popup for all add buttons of Coffee, Tea, and Latte. No need to repeat for their lines --%>
        <div id="popupModal">

            <div class="container-popup">



                <form onsubmit="stringify()" id="newProductForm" action="Menu_Controller" method="POST" enctype="multipart/form-data">
                    <h2 id="popupTitleID" value=""></h2>
                    <input type="hidden" name="ingredientList" id="hiddenIngredient">
                    <input type="hidden" name="GramList" id="hiddenGram">
                    <label for="itemAddName">Product Name:</label>
                    <input type="text" placeholder="Name" name="itemAddName" id="itemAddName" class="itemAddName" required>
                    <!-- Warning Message for comma usage-->
                    <a id="warningComma"></a><br>
                    <label for="itemAddImage">Image:</label>
                    <input type="file" name="itemAddImage" class="itemAddImage" id="itemAddImage" required>
                    <!-- Warning Message for incompatible file types-->
                    <a id="warningAdd"></a><br>
                    <label for="itemAddOption">Option:</label>
                    <input type="text" placeholder="Item Option" name="itemAddOption" class="itemAddOption" required>
                    <label for="itemAddPrice">Product Price:</label>
                    <input type="number" placeholder="Php" name="itemAddPrice" class="itemAddPrice"  required>
                    <input type="hidden" id="itemAddClassification" name="itemAddClassification" value="">
                    <input type="hidden" name="itemAvailability" value="In Stock">
                    <input type="hidden" name="instruction" value="addItemMenu">
                    <button type="submit"  class="addProductBtn" id="addProductBtn" >Add new product</button>
                </form>
                <div class="verticalDivider"></div>

                <!-- Ingredients div start-->
                <form id="ingredientForm" action="Menu_Controller" method="POST" enctype="multipart/form-data">
                    <h1><label for="itemIngredient">Add Ingredients:</label></h1>
                    <select name="itemIngredient" id="ingredientName" class="itemIngredient">
                        <%ResultSet ingredients = (ResultSet) request.getAttribute("ingredients");
                            if (ingredients != null) {
                                while (ingredients.next()) {%>

                        <option><%=ingredients.getString("ingredientName")%></option>

                        <%}
                            }%>
                    </select>
                    <input type="number" placeholder="grams" name="ingredientGrams"  id="ingredientGrams" class="ingredientGrams" min="1" required>
                    <input type="button" class="add-ingredient-btn" onclick="addIngredient()" value="+">
                    <input type="button" class="clearIngredientsBtn" onclick="clearIngredient()" value="CLEAR">
                    <h1><label for="added-ingredients">Ingredients:</label></h1>
                    <div name="added-ingredients" class="added-ingredients" id="added-ingredients">
                        <h3><div class="ingredient-names" id="ingredient-names">
                            </div>
                            <div class="ingredient-grams" id="ingredient-grams">
                            </div>
                        </h3>
                    </div>
                </form>
                <!-- Ingredients div end-->

            </div>
        </div>

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


                <%-- Carousel Items Slider--%>
                <div class="slider">

                    <%-- Add Coffee Item Button --%>
                    <div class="item"> <button class="addItem" id="addCoffeeItem"></button></div>

                    <%ResultSet coffee = (ResultSet) request.getAttribute("allcoffee");
                        if (coffee != null) {
                            while (coffee.next()) {
                    %>

                    <%-- Hidden fields for update database submission--%>
                    <form action="updateddadsa" method="POST" enctype="multipart/form-data">
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=coffee.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=coffee.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=coffee.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=coffee.getString("itemPrice")%>" />
                    </form>


                    <!-- Set Availability form-->
                    <form action="Menu_Controller" method="post" id="setStockClass1">
                        <% if (coffee.getString("itemStock").equals("Out of Stock")) { %>
                        <input type="hidden" name="itemStock" value="In Stock">
                        <% } else { %>
                        <input type="hidden" name="itemStock" value="Out of Stock">
                        <% }%>
                        <input type="hidden" name="itemAddClassification" value="Coffee">
                        <input type="hidden" name="instruction" value="setStock">
                    </form>


                    <div class="itemContainer"> 
                        <%-- Slider Item Start--%>      
                        <div class="item">  

                            <%-- Item Name--%>
                            <a class="itemName"><%=coffee.getString("itemName")%></a>     

                            <%-- Item Image--%>
                            <img
                                class="thumbnail"
                                src="MENUImages/<%=coffee.getString("itemImage")%>"
                                alt="Sample Item Image">

                            <%-- Item Option--%>
                            <a class="itemOption"><%=coffee.getString("itemOption")%></a>

                            <%-- Item PriceTag--%>
                            <h3 class="itemPHPTag">PHP</h3>

                            <%-- Item Price--%> 
                            <h3 class="itemPrice"><%=coffee.getString("itemPrice")%></h3>

                            <!--Update Menu Item-->
                            <form>
                            <button class="updateItemBtn">Update</button>
                            </form>

                            <!--Update Availability-->
                            <button class="availabilityItemBtn">
                                <a> <%=coffee.getString("itemStock")%> </a>                       
                            </button>

                            <!--Deactivate Availability-->
                            <form action="Menu_Controller" method="post">
                                <input type="hidden" name="product" value="<%=coffee.getString("itemCode")%>">
                                <%if(coffee.getString("deactivated").equals("No")){%>
                                <input type="hidden" name="instruction" value="deactivate">
                                <button type="submit" class="deactivateItemBtn">Deactivate</button>
                                <%}else{%>
                                <input type="hidden" name="instruction" value="reactivate">
                                <button type="submit" class="reactivateItemBtn">Reactivate</button>
                                <%}%>
                            </form>
                        </div>
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
                <h3 class="title">Kremalatte</h3>
                <div class="progress-bar"></div>
            </div>

            <div class="carouselContainer">

                <%-- Left Arrow Button--%>
                <button class="handle left-handle">
                    <div class="text">&#8249;</div>
                </button>

                <%-- Carousel Items Slider--%>
                <div class="slider">

                    <%-- Add Coffee Item Button --%>
                    <div class="item"> <button class="addItem" id="addLatteItem"></button></div>
                        <%ResultSet kremalatte = (ResultSet) request.getAttribute("allkremalatte");
                            if (kremalatte != null) {
                                while (kremalatte.next()) {
                        %>

                    <%-- Hidden fields for update database submission--%>
                    <form action="updateddadsa" method="POST" enctype="multipart/form-data">
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=kremalatte.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=kremalatte.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=kremalatte.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=kremalatte.getString("itemPrice")%>" />
                    </form>
                    <div class="itemContainer"> 
                        <%-- Slider Item Start--%>      
                        <div class="item">  

                            <%-- Item Name--%>
                            <a class="itemName"><%=kremalatte.getString("itemName")%></a>     

                            <%-- Item Image--%>
                            <img
                                class="thumbnail"
                                src="MENUImages/<%=kremalatte.getString("itemImage")%>"
                                alt="Sample Item Image">

                            <%-- Item Option--%>
                            <a class="itemOption"><%=kremalatte.getString("itemOption")%></a>

                            <%-- Item PriceTag--%>
                            <h3 class="itemPHPTag">PHP</h3>

                            <%-- Item Price--%> 
                            <h3 class="itemPrice"><%=kremalatte.getString("itemPrice")%></h3>

                            <!--Update Menu Item-->
                            <button class="updateItemBtn">Update</button>


                            <!--Update Availability-->
                            <button class="availabilityItemBtn">
                                <a> <%=kremalatte.getString("itemStock")%> </a>                       
                            </button>

                            <!--Deactivate Availability-->
                            <form action="Menu_Controller" method="post">
                                <input type="hidden" name="product" value="<%=coffee.getString("itemCode")%>">
                                <%if(coffee.getString("deactivated").equals("No")){%>
                                <input type="hidden" name="instruction" value="deactivate">
                                <button type="submit" class="deactivateItemBtn">Deactivate</button>
                                <%}else{%>
                                <input type="hidden" name="instruction" value="reactivate">
                                <button type="submit" class="reactivateItemBtn">Reactivate</button>
                                <%}%>
                            </form>
                        </div>
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
                <h3 class="title">Tea</h3>
                <div class="progress-bar"></div>
            </div>

            <div class="carouselContainer">

                <%-- Left Arrow Button--%>
                <button class="handle left-handle">
                    <div class="text">&#8249;</div>
                </button>

                <%-- Carousel Items Slider--%>
                <div class="slider">

                    <%-- Add Coffee Item Button --%>
                    <div class="item"> <button class="addItem" id="addTeaItem"></button></div>
                        <%ResultSet tea = (ResultSet) request.getAttribute("alltea");
                            if (tea != null) {
                                while (tea.next()) {
                        %>

                    <%-- Hidden fields for update database submission--%>
                    <form action="updateddadsa" method="POST" enctype="multipart/form-data">
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=tea.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=tea.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=tea.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=tea.getString("itemPrice")%>" />
                    </form>
                    <div class="itemContainer"> 
                        <%-- Slider Item Start--%>      
                        <div class="item">  

                            <%-- Item Name--%>
                            <a class="itemName"><%=tea.getString("itemName")%></a>     

                            <%-- Item Image--%>
                            <img
                                class="thumbnail"
                                src="MENUImages/<%=tea.getString("itemImage")%>"
                                alt="Sample Item Image">

                            <%-- Item Option--%>
                            <a class="itemOption"><%=tea.getString("itemOption")%></a>

                            <%-- Item PriceTag--%>
                            <h3 class="itemPHPTag">PHP</h3>

                            <%-- Item Price--%> 
                            <h3 class="itemPrice"><%=tea.getString("itemPrice")%></h3>

                            <!--Update Menu Item-->
                            <button class="updateItemBtn">Update</button>


                            <!--Update Availability-->
                            <button class="availabilityItemBtn">
                                <a> <%=tea.getString("itemStock")%> </a>                       
                            </button>

                            <!--Deactivate Availability-->
                            <form action="Menu_Controller" method="post">
                                <input type="hidden" name="product" value="<%=coffee.getString("itemCode")%>">
                                <%if(coffee.getString("deactivated").equals("No")){%>
                                <input type="hidden" name="instruction" value="deactivate">
                                <button type="submit" class="deactivateItemBtn">Deactivate</button>
                                <%}else{%>
                                <input type="hidden" name="instruction" value="reactivate">
                                <button type="submit" class="reactivateItemBtn">Reactivate</button>
                                <%}%>
                            </form>
                        </div>
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
    <jsp:include page="adminFooter.jsp" /> <!-- Calls the footer for admin-->
    <script>
        // Add click event listener to document and invoke onHandleClick function if handle is clicked
        document.addEventListener("click", e => {
            let handle;

            // Check if the clicked element is a handle or a child of a handle
            if (e.target.matches(".handle")) {
                handle = e.target;
            } else {
                handle = e.target.closest(".handle");
            }

            // If handle is found, invoke onHandleClick function with the handle as argument
            if (handle) {
                onHandleClick(handle);
            }
        });

        // Throttle the progress bar update function to prevent too many updates
        const throttleProgressBar = throttle((delay = 1000) => {
            document.querySelectorAll(".progress-bar").forEach(calculateProgressBar);
        });
        // Add a resize event listener to window that invokes the throttled progress bar update function
        window.addEventListener("resize", throttleProgressBar);
        // Invoke the progress bar update function on page load
        document.querySelectorAll(".progress-bar").forEach(calculateProgressBar);

        // Compute the progress bar items and update the progress bar
        function calculateProgressBar(progressBar) {
            // Clear the progress bar
            progressBar.innerHTML = "";

            // Get the slider element and number of items per screen from its computed style
            const slider = progressBar.closest(".row").querySelector(".slider");
            if (!slider) {
                return;
            }
            const itemCount = slider.children.length;
            const itemsPerScreen = (parseInt(
                    getComputedStyle(slider).getPropertyValue("--items-per-screen")
                    ) * 2);

            // Get the slider index and number of progress bar items
            let sliderIndex = parseInt(
                    getComputedStyle(slider).getPropertyValue("--slider-index")
                    );
            const progressBarItemCount = Math.ceil(itemCount / itemsPerScreen);

            // If the slider index is out of bounds, adjust it to the correct value
            if (sliderIndex >= progressBarItemCount) {
                slider.style.setProperty("--slider-index", progressBarItemCount - 1);
                sliderIndex = progressBarItemCount - 1;
            }

            // Add progress bar items to the progress bar and highlight the active item
            for (let i = 0; i < progressBarItemCount; i++) {
                const barItem = document.createElement("div");
                barItem.classList.add("progress-item");
                if (i === sliderIndex) {
                    barItem.classList.add("active");
                }
                progressBar.append(barItem);
            }
        }

        // Update the progress bar and slider position based on which handle was clicked
        function onHandleClick(handle) {
            const progressBar = handle.closest(".row").querySelector(".progress-bar");
            const slider = handle.closest(".carouselContainer").querySelector(".slider");
            const sliderIndex = parseInt(
                    getComputedStyle(slider).getPropertyValue("--slider-index")
                    );
            const progressBarItemCount = progressBar.children.length;

            // Move the slider left
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

        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            var modal = document.getElementById("popupModal");
            if (event.target === modal) {
                modal.style.display = "none";
            }
        };



        //Add item button
        const buttons = document.querySelectorAll('.addItem');
        for (let i = 0; i < buttons.length; i++) {
            buttons[i].addEventListener('click', function () {
                document.getElementById("popupModal").style.display = 'block';
                const buttonId = this.getAttribute('id');

                //Content depends on button pressed
                if (buttonId === 'addCoffeeItem') {
                    //Change title of popup
                    document.getElementById("popupTitleID").innerHTML = "Add new Coffee";
                    //change classification of item in popup
                    document.getElementById("itemAddClassification").value = "Coffee";
                } else if (buttonId === 'addLatteItem') {
                    //Change title of popup
                    document.getElementById("popupTitleID").innerHTML = "Add new Kremalatte";
                    //change classification of item in popup
                    document.getElementById("itemAddClassification").value = "Kremalatte";
                } else if (buttonId === 'addTeaItem') {
                    //Change title of popup
                    document.getElementById("popupTitleID").innerHTML = "Add new Tea";
                    //change classification of item in popup
                    document.getElementById("itemAddClassification").value = "Tea";
                }
            });
        }





        //Disable buttons if the file type is not .png or .jpg
        const addBtn = document.getElementById('addProductBtn');
        const fileInput = document.getElementById('itemAddImage');
        const warningAdd = document.getElementById("warningAdd");

        fileInput.addEventListener('change', function () {
            const file = fileInput.files[0];
            const fileName = file.name;
            const fileType = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();

            if (fileType === 'jpg' || fileType === 'png') {
                addBtn.disabled = false;
                warningAdd.innerText = '';
            } else {
                addBtn.disabled = true;
                warningAdd.innerText = 'Incompatible file types. Please use ethier .jpg or .png';
                warningAdd.style.color = "red";
            }
        });

        // Disable comma usage
        const itemAddName = document.getElementById("itemAddName");
        const warningComma = document.getElementById("warningComma");
        // Add an event listener to the input box to check its value
        itemAddName.addEventListener("input", function () {
            // Check if the input box value contains a comma
            if (itemAddName.value.includes(",")) {
                // Disable the submit button
                addBtn.disabled = true;
                warningComma.innerText = 'The usage of comma (,) is not allowed';
                warningComma.style.color = "red";
            } else {
                // Enable the submit button
                addBtn.disabled = false;
                warningComma.innerText = '';
            }
        });

        //Update Availability
        function updateAvailabilityClass1() {
            document.getElementById("setStockClass1").submit();
        }

        var ingredients = [];
        var grams = [];

        function addIngredient() {
            var ingredientName = document.getElementById(`ingredientName`).value;
            var ingredientGram = document.getElementById(`ingredientGrams`).value;


            if (ingredientGram < 1) {
                ingredientGram = 1;
            }

            var exist = "no";

            for (i = 0; i < ingredients.length; i++) {
                if (ingredients[i] === ingredientName) {
                    grams[i] = parseInt(grams[i], 10) + parseInt(ingredientGram, 10);
                    i = ingredients.length;
                    exist = "yes";
                }
            }

            if (exist === "no") {
                ingredients.push(ingredientName);
                grams.push(ingredientGram);
            }

            updateIngredient();
        }

        function clearIngredient() {
            ingredients = [];
            grams = [];

            updateIngredient();
        }

        function updateIngredient() {
            var ingredientNameList = document.getElementById(`ingredient-names`);
            var ingredientGramList = document.getElementById(`ingredient-grams`);

            ingredientNameList.innerHTML = "";
            ingredientGramList.innerHTML = "";

            for (i = 0; i < ingredients.length; i++) {
                ingredientNameList.innerHTML += ingredients[i] + "<br>";
                ingredientGramList.innerHTML += grams[i] + "<br>";
            }

        }

        function stringify() {
            var hiddenIngredient = document.getElementById(`hiddenIngredient`);
            var hiddenGram = document.getElementById(`hiddenGram`);

            hiddenIngredient.value = JSON.stringify(ingredients);
            hiddenGram.value = JSON.stringify(grams);
        }

    </script>
</html>