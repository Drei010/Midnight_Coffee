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
            if (!"yes".equals(session.getAttribute("loadedOrders"))) {
        %>
        <form action="Orders_Controller" method="post" name="load">
            <input type="hidden" name="action" value="load">
        </form>
        <script>
            window.onload = function () {
                document.forms['load'].submit();
            };
        </script>
        <%} else {
                session.setAttribute("loadedOrders", "no");
            }%>

        <div class="ordersBody">
            <!-- Table of orders -->  
            <div class="ordersContainers">
                <div class="ordersPanel">
                    <!-- Header with download pdf buttons -->
                    <h1 class="title">Customer Orders</h1>
                    <div class="ordersBtn">
                        <form method="POST" action="GeneratePDF" target="_blank">
                            <!-- download transactions pdf onclick -->  
                            <input type="hidden" name="ordersDate" value="<%=session.getAttribute("ordersDate")%>">
                            <button class="transactionBtn" ><i class='fa fa-print'></i> Transaction Report</button>
                        </form>

                        <!-- download products pdf onclick -->  
                        <form method="POST" action="GenerateProduct" target="_blank">
                            <input type="hidden" name="ordersDate" value="<%=session.getAttribute("ordersDate")%>">
                            <button class="productBtn" ><i class='fa fa-print'></i> Product Report</button>
                        </form>
                    </div>
                    <div class="horizontalDivider"></div>
                    <p class="orderDate">Orders for <%= session.getAttribute("ordersDate")%></p>
                    <%
                        ResultSet customerOrders = (ResultSet) session.getAttribute("customerOrders");
                        if (customerOrders != null) {
                            while (customerOrders.next()) {%>

                    <div class="ordersPanelContents">

                        <!-- Onclick change order Summary panel-->  
                 <!--0-->  <button  class="openSummaryBtn">
                            <h2>Order Number:  <%=customerOrders.getString("orderId")%> </h2>
                            <p>Customer Name:  <%=customerOrders.getString("customerFirstName")%> <%=customerOrders.getString("customerLastName")%> </p>
                            <p>Mobile Number: <%=customerOrders.getString("customerMobileNumber")%></p>
                            <p>Email: <%=customerOrders.getString("customerEmail")%></p>
                            <p>Time Ordered: <%=customerOrders.getString("orderTime")%></p>
                        </button>

                        <div class="horizontalDivider"></div>

                        <!-- Hidden fields for summary panel-->  

                        <input class="hiddenOrderID" type="hidden" name="orderID" value="<%=customerOrders.getString("orderId")%>">
                        <input class="hiddenOrderTotal" type="hidden" value="<%=customerOrders.getString("orderTotal")%>">
                        <input class="hiddensummaryName" type="hidden" value="<%=customerOrders.getString("summaryName")%>">
                        <input class="hiddenOption" type="hidden" value="<%=customerOrders.getString("summaryOption")%>">
                        <input class="hiddenQuantity" type="hidden" value="<%=customerOrders.getString("summaryQuantity")%>">
                        <input class="hiddensummaryPrice" type="hidden" value="<%=customerOrders.getString("summaryPrice")%>">
                    </div>
                    <%}
                    } else {%>

                    <h1>Looks Like there are no orders for this day.</h1>
                    <%}%>
                </div>

                <div class="dateAndSummary">
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
            </div>
        </div>
        <script>
            //getbtn       
            var openSummaryBtn = document.getElementsByClassName('openSummaryBtn');

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

