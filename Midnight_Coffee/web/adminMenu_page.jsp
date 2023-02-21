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



                <form id="newProductForm" action="Menu_Controller" method="POST" enctype="multipart/form-data">
                    <h2 id="popupTitleID" value=""></h2>
                    <label for="itemAddName">Product Name:</label>
                    <input type="text" placeholder="Name" name="itemAddName" class="itemAddName" required>
                    <label for="itemAddImage">Image:</label>
                    <input type="file" name="itemAddImage" class="itemAddImage" required>
                    <label for="itemAddOption">Option:</label>
                    <input type="text" placeholder="Item Option" name="itemAddOption" class="itemAddOption" required>
                    <label for="itemAddPrice">Product Price:</label>
                    <input type="number" placeholder="Php" name="itemAddPrice" class="itemAddPrice"  required>
                    <input type="hidden" id="itemAddClassification" name="itemAddClassification" value="">
                    <input type="hidden" name="itemAvailability" value="Out_of_Stock">
                    <input type="hidden" name="instruction" value="addItemMenu">
                    <button type="submit" class="addProductBtn" >Add new product</button>
                </form>
                <div class="verticalDivider"></div>


                <!-- Ingredients div start-->
                <form id="ingredientForm" action="Menu_Controllera2" method="POST" enctype="multipart/form-data">
                    <h1><label for="itemIngredient">Add Ingredients:</label></h1>
                    <input type="text" name="itemIngredient" placeholder="Ingredient" class="itemIngredient" required>
                    <input type="number" placeholder="grams" name="ingredientGrams" class="ingredientGrams"  required>
                    <button class="add-ingredient-btn">+</button>
                    <button class="clearIngredientsBtn">CLEAR</button>
                    <h1><label for="added-ingredients">Ingredients:</label></h1>
                    <div name="added-ingredients" class="added-ingredients">
                        <h3>testeng</h3>
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




                <%ResultSet coffee = (ResultSet) request.getAttribute("coffee");
                    if (coffee != null) {%>

                <%-- Carousel Items Slider--%>
                <div class="slider">

                    <%-- Add Coffee Item Button --%>
                    <div class="item"> <button class="addItem" id="addCoffeeItem"></button></div>
                        <%
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
                    <div class="itemContainer"> 
                        <%-- Slider Item Start--%>      
                        <div class="item">  

                            <%-- Item Name--%>
                            <a class="itemName"><%=coffee.getString("itemName")%></a>     

                            <%-- Item Image--%>
                            <img
                                class="thumbnail"
                                src="QRImages/test.png"
                                alt="Sample Item Image">

                            <%-- Item Option--%>
                            <a class="itemOption"><%=coffee.getString("itemOption")%></a>

                            <%-- Item PriceTag--%>
                            <h3 class="itemPHPTag">PHP</h3>

                            <%-- Item Price--%> 
                            <h3 class="itemPrice"><%=coffee.getString("itemPrice")%></h3>

                            <!--Update Menu Item-->
                            <button class="updateItemBtn">Update</button>


                            <!--Update Availability-->
                            <button class="availabilityItemBtn">
                                <a id="inStock">In Stock</a>
                                <a id="outOfStock">Out of Stock</a>
                            </button>


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




                <%ResultSet kremalatte = (ResultSet) request.getAttribute("kremalatte");
                    if (kremalatte != null) {%>

                <%-- Carousel Items Slider--%>
                <div class="slider">

                    <%-- Add Coffee Item Button --%>
                    <div class="item"> <button class="addItem" id="addLatteItem"></button></div>
                        <%
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
                                src="QRImages/test.png"
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
                                <a id="inStock">In Stock</a>
                                <a id="outOfStock">Out of Stock</a>
                            </button>


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




                <%ResultSet tea = (ResultSet) request.getAttribute("tea");
                    if (tea != null) {%>

                <%-- Carousel Items Slider--%>
                <div class="slider">

                    <%-- Add Coffee Item Button --%>
                    <div class="item"> <button class="addItem" id="addTeaItem"></button></div>
                        <%
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
                                src="QRImages/test.png"
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
                                <a id="inStock">In Stock</a>
                                <a id="outOfStock">Out of Stock</a>
                            </button>


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
    </script>
</html>