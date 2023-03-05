<%-- 
    Document   : adminOrders
    Created on : 5 Feb 2023, 6:13:04 pm
    Author     : rvhin
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/><!--Icon Import -->  
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
         <link rel='stylesheet' type='text/css' href='styles/adminOrders.css'>
        <title>Orders</title>
    </head>
    <body>
            <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  
     
                <%
            if (request.getAttribute("loadedOrders") == null) {
        %>
        <form action="Orders_Controller" method="post" name="load">
            <input type="hidden" name="action" value="load">
        </form>
        <script>
            window.onload = function () {
                document.forms['load'].submit();
            };
        </script>
        <%
            }%>
            
            <div class="ordersBody">
            <!-- Header with download pdf buttons -->  
            <div class="ordersBtn">
            <h1>Customer Orders</h1>
            
            <!-- download transactions pdf onclick -->  
            <button class="transactionBtn"><i class='fa fa-print'></i> Transaction Report</button>
            
            <!-- download products pdf onclick -->  
            <button class="productBtn"><i class='fa fa-print'></i> Product Report</button>
            </div>
            
             <!-- Table of orders -->  
            <div class="ordersPanel">
                         
                <h1>Orders for <%= session.getAttribute("ordersDate")%></h1>
                           <%
                ResultSet customerOrders = (ResultSet) request.getAttribute("customerOrders");
                if (customerOrders != null) {
                    while (customerOrders.next()) {%>
                    
                    <div class="ordersPanelContents">
                        
                      <!-- Onclick change order Summary panel-->  
                  <!--0-->  <button  class="openSummaryBtn">
                        
                  <h2>Order Number:  <%=customerOrders.getString("orderId")%> </h2>
                  <a>Customer Name:  <%=customerOrders.getString("customerFirstName")%> <%=customerOrders.getString("customerLastName")%> </a>
                  <br>
                   <a>Mobile Number: <%=customerOrders.getString("customerMobileNumber")%></a>
                   <br>
                   <a>Email: <%=customerOrders.getString("customerEmail")%></a>
                   <br>
                   <a>Time Ordered: <%=customerOrders.getString("orderTime")%></a>
                   </button>
                   
                   <!-- Hidden fields for summary panel-->  
                  
                        <input class="hiddenOrderID" type="hidden" value="<%=customerOrders.getString("orderId")%>">
                        <input class="hiddenOrderTotal" type="hidden" value="<%=customerOrders.getString("orderTotal")%>">
                        <input class="hiddensummaryName" type="hidden" value="<%=customerOrders.getString("summaryName")%>">
                        <input class="hiddenOption" type="hidden" value="<%=customerOrders.getString("summaryOption")%>">
                        <input class="hiddenQuantity" type="hidden" value="<%=customerOrders.getString("summaryQuantity")%>">
                        <input class="hiddensummaryPrice" type="hidden" value="<%=customerOrders.getString("summaryPrice")%>">
                     
                   
                   </div>
                      <%}
                                }
                else{%>
                     
                 <h1>Looks Like there are no orders for this day.</h1>
                <%}%>
               
               
           
            </div>
             
             <!-- Select Date -->  
            <div class="selectDate">
            <h1>Select Date</h1>
            
             <form  action="Orders_Controller" method="POST">
            <input class="inputDate" type="date"  name="inputDate">
            <input type="hidden" name="action" value="changeDate">
            <button class="dateBtn">Submit Date</button>
            </form>
            </div>
             
            <!-- Order Summary -->  
            <div class="orderSummary">
            <h1>Order Summary</h1>
             <h3>Order Number: <a id="orderNumberValue"></a></h3>
             <h3>Total PHP: <a id="priceTotalValue"></a> </h3>
             
              <table id="summaryTable">
                    <thead>
                        <tr>
                            <th>Items</th>
                            <th>Option</th>
                            <th>Quantity</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>      

                </table>
             
            </div>
            </div>
            <script>
         //getbtn       
        var openSummaryBtn =  document.querySelector('.openSummaryBtn');
        
           for (var i = 0; i < openSummaryBtn.length; i++) {
              
            var button = openSummaryBtn[i];
            button.addEventListener('click', function (event) {
                 var buttonClicked = event.target;
                 

                // orderID 
                var hiddenOrderID = buttonClicked.parentElement.querySelector('.hiddenOrderID');
                document.getElementById('orderNumberValue').innerHTML = hiddenOrderID.value;
                
               // OrderTotal 
                var hiddenOrderTotal = buttonClicked.parentElement.querySelector('.hiddenOrderTotal');
                document.getElementById('priceTotalValue').innerHTML = hiddenOrderTotal.value;
                
               // Name Array 
                var hiddensummaryName = buttonClicked.parentElement.querySelector('.hiddensummaryName');
                var itemsArray = hiddensummaryName.value.split(",");
                              
               // Option Array 
                var hiddenOption = buttonClicked.parentElement.querySelector('.hiddenOption');
                var optionArray = hiddenOption.value.split(",");
       

               // Quantity array 
                var hiddenQuantity = buttonClicked.parentElement.querySelector('.hiddenQuantity');
                 var quantityArray = hiddenQuantity.value.split(",");
       

               // Price array 
                var hiddensummaryPrice = buttonClicked.parentElement.querySelector('.hiddensummaryPrice');
                 var priceArray = hiddensummaryPrice.value.split(",");
                
              var tableBody = document.getElementById("summaryTable").getElementsByTagName('tbody')[0];

              // clear the table body
              tableBody.innerHTML = '';

              // loop through the arrays and add rows to the table
              for (var i = 0; i < itemsArray.length; i++) {
                var row = tableBody.insertRow(i);
                var itemCell = row.insertCell(0);
                var optionCell = row.insertCell(1);
                var quantityCell = row.insertCell(2);
                var priceCell = row.insertCell(3);
                itemCell.innerHTML = itemsArray[i];
                optionCell.innerHTML = optionArray[i];
                quantityCell.innerHTML = quantityArray[i];
                priceCell.innerHTML = priceArray[i];
              }

                
           });
    }


                </script>
    </body>
</html>
