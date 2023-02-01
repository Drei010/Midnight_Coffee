<%-- 
    Document   : infiniteCarousel
    Created on : 20 Dec 2022, 11:39:36 am
    Author     : Andrei
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
   *, *::after, *::before {
    box-sizing: border-box;
  }

  :root {
    --handle-size: 3rem;
    --div-gap: .25rem;
  }

  body {
    margin: 0;
  }
  
/*carousel container*/
  .carouselContainer {
    display: flex;
    justify-content: center;
    overflow: hidden;
    width: 100%;
    flex-grow: 1;
  }

  .slider {
    --items-per-screen: 4;
    --slider-index: 0;
    display: flex;
    flex-grow: 1;
    margin: 0 var(--div-gap);
    transform: translateX(calc(var(--slider-index) * -100%));
    transition: transform 250ms ease-in-out;   
  }

  
  /*items*/
  .slider > div {
    flex: 0 0 calc(100% / var(--items-per-screen));
    max-width: calc(100% / var(--items-per-screen));
    aspect-ratio: 10/9;
    padding: var(--div-gap);
    border-radius: 1rem;
  }
  
  
  /*item container grid*/
  .item{
  display: grid;
  grid-template-areas:
    'itemName itemName itemName itemName itemName itemName ' 
    'thumbnail thumbnail thumbnail thumbnail thumbnail thumbnail '
    'itemOption itemOption itemOption itemOption itemOption itemOption '
    'itemPHPTag itemPrice itemPrice decrament itemQuantity incrament';
  gap: 5px;
  background-color: #AEB3AF;
  max-width: 400px; 
  max-height: 500px;
  padding:10px;
  border-radius: 10px;
  }
  


  /*item image*/
  .thumbnail{
      grid-area: thumbnail;
      width: 100%; 
      height: 100%;
      margin: 0;
      
  }
  
  
    /*item name*/
  .itemName{
      grid-area: itemName;
      margin: 0;
      color: black;
  }
  
    /*item php*/
  .itemPHPTag{
      grid-area: itemPHPTag;
      margin: 0;
      color: black;
  }
  
   /*item option*/
  .itemOption{
      grid-area: itemOption;
      background-color: #282747;
      border-radius: 10px;
      color: white;
      padding: 10px;
      max-width: 100px;
      
  }
  
      /*item price*/
  .itemPrice{
      grid-area: itemPrice;
      margin: 0;
      color: black;
  }

  
    /*item quantity decrament*/
  .dec{
      grid-area: decrament;
      margin: 0;
      background-color: #282747;
      border-radius: 4px;
      color: white;
      padding: 5px;
      max-width: 20px;
      z-index: 10;
  }
  
      /*item quantity incrament*/
  .inc{
      grid-area: incrament;
      margin: 0;
      background-color: #282747;
      border-radius: 4px;
      color: white;
      padding: 5px;
      max-width: 20px;
      z-index: 10;
  }
  
  /*incrament decrament on hover*/
   .inc:hover,
   .inc:focus, 
   .dec:hover,
   .dec:focus {
      transform: scale(1.2);
   }
        /*item quantity input field*/
  .itemQuantity{
      grid-area: itemQuantity;
      margin: 0;
      max-width: 25px;
      
  }
  /*arrows*/
  .handle {
    border: none;
    border-radius: 1rem;
    flex-grow: 0;
    flex-shrink: 0;
    background-color: #282747;
    z-index: 10;
    margin: var(--div-gap) 0;
    width: var(--handle-size);
    cursor: pointer;
    font-size: 5rem;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    line-height: 0;
    transition: background-color 150ms ease-in-out;
  }

  /*Left arrow*/
  .left-handle {
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
  }

  /*Right arrow*/
  .right-handle {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
  }
  
 /*Arrow Hover*/
  .handle:hover,
  .handle:focus {
    background-color: rgba(255, 255, 255, .5);
  }
  

  .text {
    transition: transform 150ms ease-in-out;
  }

  .handle:hover .text,
  .handle:focus .text {
    transform: scale(1.2);
  }

  /*progress bar location*/
  .header {
    display: flex;
    justify-content: space-between;
    padding: .5rem calc(var(--div-gap) * 2 + var(--handle-size));
    align-items: center;
  }

  .title {
    font-size: 2rem;
    margin: 0;
  }
  
  /* Progress Bar*/
  .progress-bar {
    display: flex;
    gap: .25rem;
  }

  .progress-item {
    flex: 0 0 1.5rem;
    min-width: 1.5rem;
    height: .5rem;
    background-color: rgba(255, 255, 255, .5);
  }

.progress-item.active {
  background-color: rgba(255, 255, 255, .9);
}

@media (max-width: 1000px) {
  .slider {
    --items-per-screen: 3;
  }
    .carouselContainer {
    transform: scale(0.8);
  }
}

@media (max-width: 500px) {
  .slider {
    --items-per-screen: 2;
  }
    .carouselContainer {
    transform: scale(0.6);
  }
}

body {
  background-color: #333;
  color: white;
}
        </style>
    <body>
        <%-- Total--%>
<h1>Total</h1> <input type="text" name="total" id="total" value="0" disabled=""/>
        <div class="row">
            
     <%-- Carousel title and progress bar--%>       
    <div class="header">
      <h3 class="title">Title</h3>
      <div class="progress-bar"></div>
    </div>
            
            
    <div class="carouselContainer">
        
         <%-- Left Arrow Button--%>
      <button class="handle left-handle">
        <div class="text">&#8249;</div>
      </button>
        
        <%-- Carousel Items container--%>
      <div class="slider">
          
          
          
      <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
     
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
         
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>   
            
        <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>

            
            
             <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>
            
            
            
            
             <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>
            
             <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>
            
            
      </div>
       <%-- Right Arrow Button--%>
      <button class="handle right-handle">
        <div class="text">&#8250;</div>
      </button>
    </div>
  </div>
      
      
      
              <div class="row">
            
     <%-- Carousel title and progress bar--%>       
    <div class="header">
      <h3 class="title">Title</h3>
      <div class="progress-bar"></div>
    </div>
            
            
    <div class="carouselContainer">
        
         <%-- Left Arrow Button--%>
      <button class="handle left-handle">
        <div class="text">&#8249;</div>
      </button>
        
        <%-- Carousel Items container--%>
      <div class="slider">
          
          
          
      <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
     
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
         
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>   
            
        <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>

            
            
             <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>
            
            
            
            
             <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>
            
             <%-- Slider Item Start--%>   
  <div class="itemContainer">
  <form action="AppController" method="post">
      
   <%-- Hidden fields for database submission--%>
      <input type="hidden" id="menu_form" name="instruction" value="menupage">
      <input type="hidden" name="itemId" value="sample">
      <input type="hidden" class="hiddenPrice" name="hiddenPrice" value="500" />
   <div class="item">  
       
        <%-- Item Name--%>
        <h1 class="itemName">New york Cheesecake </h1>     
        
      <%-- Item Image--%>
        <img
          class="thumbnail"
          src="userImages/bg.png"
          alt="Sample Item Image">
        
       <%-- Item Option--%>
         <h3 class="itemOption">Classic </h3>
      
         <%-- Item PriceTag--%>
         <h3 class="itemPHPTag">PHP</h3>
         
        <%-- Item Price--%> 
        <h3 class="itemPrice">500.00</h3>
         
            <%-- Quantity Decrament--%>
            <div class="dec">-</div>
            
            <%-- Quantity input field--%>
            <input type="text"  name="itemQuantity" class="itemQuantity" disabled="" value="0"/>
            
            <%-- Quantity Incrament--%>
            <div class="inc">+</div>
      
   </div>     
  </form>
            </div><%-- Slider Item End--%>
            
            
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
      requestAnimationFrame (timeoutFunc, delay);
    }
  };

  return (...args) => {
    if (shouldWait) {
      waitingArgs = args;
      return;
    }

    cb(...args);
    shouldWait = true;
    requestAnimationFrame (timeoutFunc, delay);
  };
}



///////////////////////////// Total orders computation////////////////

// incrament decrament buttons
var incramentButton = document.getElementsByClassName('inc');
var decramentButton = document.getElementsByClassName('dec');

for(var i =0; i< incramentButton.length; i++){
    var button = incramentButton[i];
    button.addEventListener('click',function(event){
        
        var buttonClicked = event.target;
        // get reference to input field
        var input = buttonClicked.parentElement.children[6];
         // get current value of input field
        var inputValue = input.value;
        // increment value by 1
        var newValue = parseInt(inputValue) + 1;
          // update value of input field         
        input.value = newValue;
        findTotal();
    });
}
for(var i =0; i< decramentButton.length; i++){
    var button = decramentButton[i];
    button.addEventListener('click',function(event){
        
        var buttonClicked = event.target;
        // get reference to input field
        var input = buttonClicked.parentElement.children[6];
        // get current value of input field
        var inputValue = input.value;
         // decrement value by 1
        var newValue = parseInt(inputValue) - 1;
        // update value of input field  
        if(newValue >= 0){
            input.value = newValue;
            
        }
        else{
            input.value = 0;
            
        }
        findTotal();
    });
}


//// Total Price added to cart
   function findTotal(){

    var arr = document.querySelectorAll('.itemQuantity');
    var price = document.querySelectorAll('.hiddenPrice');
    var total=0;
    for(var i=0;i<arr.length;i++){
        if(parseInt(arr[i].value))
            total += parseInt(price[i].value)*parseInt(arr[i].value);
    }
     document.getElementById('total').value = total;

}




        </script>
</html>
