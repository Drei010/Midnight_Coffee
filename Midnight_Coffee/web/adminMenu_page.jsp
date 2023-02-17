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
    <body>
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
                window.onload = function() {
                  document.forms['loadMenu'].submit();
                };
              </script>
            <%
              }%>
              
              
              <%-- Open popup for all add buttons of Coffee, Tea, and Latte. No need to repeat for their lines --%>
                <div id="popupModal">

                    <div class="container-popup">
                        
                            
                            
                            <form id="newProductForm" action="Menu_Controllera" method="POST" enctype="multipart/form-data">
                            <h2>Add New Coffee</h2>
                            <label for="itemAddName">Product Name:</label>
                            <input type="text" placeholder="Name" name="itemAddName" class="itemAddName" required>
                            <label for="itemAddImage">Image:</label>
                            <input type="file" name="itemAddImage" class="itemAddImage" required>
                            <label for="itemAddOption">Option:</label>
                            <input type="text" placeholder="Item Option" name="itemAddOption" class="itemAddOption" required>
                            <label for="itemAddPrice">Product Price:</label>
                            <input type="number" placeholder="Php" name="itemAddPrice" class="itemAddPrice"  required>
                            </form>
                            <button type="submit" class="addProductBtn" >Add new product</button>
                              
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

               

           <%-- Add Coffee Item Button --%>
                <button id="addCoffeeItem"></button>
                <%ResultSet coffee = (ResultSet) request.getAttribute("coffee");
                    if (coffee != null) {%>
            
                <%-- Carousel Items container--%>
                <div class="slider">
                    
            
                    <%
                        while (coffee.next()) {
                    %>

                    <%-- Slider Item Start--%>      
                    <div class="item">  

                        <%-- Hidden fields for update database submission--%>
                        <form action="updateddadsa" method="POST" enctype="multipart/form-data">
                        <input type="hidden" id="menu_form" name="instruction" value="menupage"/>
                        <input type="hidden" id="itemId" name="itemId" value="<%=coffee.getString("itemCode")%>"/>
                        <input type="hidden" id="hiddenName" name="hiddenName" value="<%=coffee.getString("itemName")%>"/>
                        <input type="hidden" id="hiddenClassification" name="hiddenClassification" value="<%=coffee.getString("itemOption")%>"/>
                        <input type="hidden" id="hiddenPrice" class="hiddenPrice" name="hiddenPrice" value="<%=coffee.getString("itemPrice")%>" />
                         </form>
                        <%-- Item Name--%>
                        <h1 class="itemName"><%=coffee.getString("itemName")%></h1>     

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
                    <%-- Slider Item End--%>   

                    <%}
                        }%>

                    <%-- Right Arrow Button--%>
                    <button class="handle right-handle">
                        <div class="text">&#8250;</div>
                    </button>

                </div>
            </div>
        </div>
<!--
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

                <%-- Add Tea Item Button --%>
                <button id="addTeaItem"></button>

                <%-- Open popup for all add buttons of Coffee, Tea, and Latte. No need to repeat for their lines --%>
                <div id="popupAddTea" class="hidden">

                    <div class="container-popup">
                        <div class="first-side">
                            <h2>Add New Tea</h2>
                            <p>Product Name:</p>
                            <input type="text" placeholder="Tea Name" name="teaName" id="teaName" required>
                            <p>Image:</p>
                            <input type="file" name="teaImage" id="teaImage" required>
                            <p>Option:</p>
                            <form>
                                <input type="radio" id="hot" name="coffee-type" value="hot-drink">
                                <label for="hot">Hot</label><br>
                                <input type="radio" id="icedRegular" name="coffee-type" value="iced-regular-drink">
                                <label for="icedRegular">Iced Regular</label><br>
                                <input type="radio" id="icedLofty" name="coffee-type" value="iced-lofty-drink">
                                <label for="icedLofty">Iced Lofty</label><br>
                            </form>
                            <p>Product Price:</p>
                            <input type="text" placeholder="Php" name="teaPrice" id="teaPrice" pattern="[0-9]+(\.[0-9][0-9]?)?" required>

                        </div>
                        <div class="second-side">
                            <button id="clearIngredients">CLEAR</button>
                            <p>Add Ingredients: </p>
                            <select name="tea-types" id="tea-types">
                                <option value="Tea">Tea</option>
                                <option value="Sugar">Sugar</option>
                                <option value="Milk">Milk</option>
                            </select>
                            <input type="text" placeholder="grams" name="ingredientGrams" id="ingredientGrams" pattern="[0-9]+(\.[0-9][0-9]?)?" required>
                            <button class="add-ingredient-btn">+</button>
                            <h2>Ingredients Needed: </h2>
                            <div class="added-ingredients">
                                <div class="ingredient-item">
                                    <h2>Sugar</h2>
                                    <h3>50g</h3>
                                </div>
                                <div class="ingredient-item">
                                    <h2>Tea</h2>
                                    <h3>50g</h3>
                                </div>
                                <div class="ingredient-item">
                                    <h2>Milk</h2>
                                    <h3>50g</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="popup-buttons">
                        <button id="close-button2">CLOSE</button>
                        <button id="submit-button2">SUBMIT</button>
                    </div>
                    
                </div>

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



                    </div>
                    <%-- Slider Item End--%>   

                    <%}
                        }%>

                    <%-- Right Arrow Button--%>
                    <button class="handle right-handle">
                        <div class="text">&#8250;</div>
                    </button>

                </div>
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

                <%-- Add Latte Item Button --%>
                <button id="addLatteItem"></button>

                <%-- Open popup for all add buttons of Coffee, Tea, and Latte. No need to repeat for their lines --%>
                <div id="popupAddLatte" class="hidden">

                    <div class="container-popup">
                        <div class="first-side">
                            <h2>Add New Latte</h2>
                            <p>Product Name:</p>
                            <input type="text" placeholder="Latte Name" name="latteName" id="latteName" required>
                            <p>Image:</p>
                            <input type="file" name="latteImage" id="latteImage" required>
                            <p>Option:</p>
                            <form>
                                <input type="radio" id="hot" name="coffee-type" value="hot-drink">
                                <label for="hot">Hot</label><br>
                                <input type="radio" id="icedRegular" name="coffee-type" value="iced-regular-drink">
                                <label for="icedRegular">Iced Regular</label><br>
                                <input type="radio" id="icedLofty" name="coffee-type" value="iced-lofty-drink">
                                <label for="icedLofty">Iced Lofty</label><br>
                            </form>
                            <p>Product Price:</p>
                            <input type="text" placeholder="Php" name="lattePrice" id="lattePrice" pattern="[0-9]+(\.[0-9][0-9]?)?" required>

                        </div>
                        <div class="second-side">
                            <button id="clearIngredients">CLEAR</button>
                            <p>Add Ingredients: </p>
                            <select name="latte-types" id="latte-types">
                                <option value="Tea">Latte</option>
                                <option value="Sugar">Sugar</option>
                                <option value="Milk">Milk</option>
                            </select>
                            <input type="text" placeholder="grams" name="ingredientGrams" id="ingredientGrams" pattern="[0-9]+(\.[0-9][0-9]?)?" required>
                            <button class="add-ingredient-btn">+</button>
                            <h2>Ingredients Needed: </h2>
                            <div class="added-ingredients">
                                <div class="ingredient-item">
                                    <h2>Sugar</h2>
                                    <h3>50g</h3>
                                </div>
                                <div class="ingredient-item">
                                    <h2>Latte</h2>
                                    <h3>50g</h3>
                                </div>
                                <div class="ingredient-item">
                                    <h2>Milk</h2>
                                    <h3>50g</h3>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="popup-buttons">
                        <button id="close-button3">CLOSE</button>
                        <button id="submit-button3">SUBMIT</button>
                    </div>
                </div>

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

                    <%-- Right Arrow Button--%>
                    <button class="handle right-handle">
                        <div class="text">&#8250;</div>
                    </button>

                </div>
            </div>
        </div>-->
                    
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
        
        
        
                //For pop up when adding
        document.getElementById("addCoffeeItem").onclick = function(e) {
        e.preventDefault();
        document.getElementById("popupModal").style.display = 'block';
    
            };
            // When the user clicks anywhere outside of the modal, close it
            window.onclick = function(event) {
              var modal =  document.getElementById("popupModal");
              if (event.target === modal) {
                modal.style.display = "none";
              }
            };
    </script>
</html>