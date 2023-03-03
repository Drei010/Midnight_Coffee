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
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
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
            
            <!-- Header with download pdf buttons -->  
            <div class="customerOrders">
            <h1>Customer Orders</h1>
            
            <!-- download transactions pdf onclick -->  
            <button class="transactionBtn">Transaction Report</button>
            
            <!-- download products pdf onclick -->  
            <button class="productBtn">Product Report</button>
            </div>
            
             <!-- Table of orders -->  
            <div class="ordersTable">
                         
                           <%
                ResultSet customerOrders = (ResultSet) request.getAttribute("customerOrders");
                if (customerOrders != null) {
                    while (customerOrders.next()) {%>
                    
                    <div class="ordersTableContents">
                        
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
                  
                      <!--1--> <input class="hiddenOrderID" type="text" value="<%=customerOrders.getString("orderId")%>">
                       <!--2--><input class="hiddenOrderTotal" type="text" value="<%=customerOrders.getString("orderTotal")%>">
                       <!--3--><input class="hiddensummaryName" type="text" value="<%=customerOrders.getString("summaryName")%>">
                       <!--4--><input class="hiddensummaryPrice" type="text" value="<%=customerOrders.getString("summaryPrice")%>">
                     
                   
                   </div>
                      <%}
                                }%>
               
               
           
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
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>      

                </table>
             
            </div>
            
            <script>
         //getbtn       
        var openSummaryBtn = document.getElementsByClassName('openSummaryBtn');
        
           for (var i = 0; i < openSummaryBtn.length; i++) {
              
            var button = openSummaryBtn[i];
            button.addEventListener('click', function (event) {
                 var buttonClicked = event.target;
                 

                // orderID 
                var hiddenOrderID = buttonClicked.parentElement.children[1];
                document.getElementById('orderNumberValue').innerHTML = hiddenOrderID.value;
                
               // OrderTotal 
                var hiddenOrderTotal = buttonClicked.parentElement.children[2];
                document.getElementById('priceTotalValue').innerHTML = hiddenOrderTotal.value;
                
               // Name Array 
                var hiddensummaryName = buttonClicked.parentElement.children[3];
                var itemsArray = hiddensummaryName.value.split(",");
       

               // Price array 
                var hiddensummaryPrice = buttonClicked.parentElement.children[4];
                 var priceArray = hiddensummaryPrice.value.split(",");
                
              var tableBody = document.getElementById("summaryTable").getElementsByTagName('tbody')[0];

              // clear the table body
              tableBody.innerHTML = '';

              // loop through the arrays and add rows to the table
              for (var i = 0; i < itemsArray.length; i++) {
                var row = tableBody.insertRow(i);
                var itemCell = row.insertCell(0);
                var priceCell = row.insertCell(1);
                itemCell.innerHTML = itemsArray[i];
                priceCell.innerHTML = priceArray[i];
              }

                
           });
    }


                </script>
    </body>
</html>
