<%-- 
    Document   : adminPayment_page
    Created on : 8 Feb 2023, 1:07:35 pm
    Author     : Andrei
--%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Payment Page</title>
        <link rel='stylesheet' type='text/css' href='styles/adminPayment.css'>
    </head>
    <body>
        <jsp:include page="adminHeader.jsp" /> <!-- Calls the header for admin-->
        <!-- Check if QR is loaded-->
            <% 
              if (!"yes".equals(session.getAttribute("loadedQRTable"))) {
                   
                %>
                <form action="QR_Controller" method="post" name="loadTable">
                    <input type="hidden" name="instruction" value="loadQR">
                    <input type="hidden" name="page" value="AdminPayment">
                </form>
                <script>
                    window.onload = function () {
                        document.forms['loadTable'].submit();
                    };
                </script>
                <%
                } else {
                session.setAttribute("loadedQRTable", "no");
            }
                %>
        <div class="QRContainer">
            <div class="QRBody">      

                <div class="updateQRItem">
                    <h1 class="updateQRItemTitle"> Update QR Codes</h1>

                    <%
                            ResultSet QRTable = (ResultSet) session.getAttribute("QRTable");
                            if (QRTable != null){
                         while (QRTable.next()) {%>
                  <div class="QRItem">

                        <div class="oldQRItem">
                            <img
                                class="QRImages"
                                src="QRImages/<%=QRTable.getString("QRImage")%>"
                                alt="The QR Code image">   
                            <h1 class="methodName"> <%=QRTable.getString("methodName")%></h1>
                        </div>

                        <div class="newQRItem">

                            <form action="QR_Controller" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="methodID" value="<%=QRTable.getInt("methodId")%>">
                                <input type="hidden" name="OldMethodName" value="<%=QRTable.getString("methodName")%>">

                                <h4 class="newMethodNameLabel"><label for="methodName">New Payment Method Name</label></h4>
                                <input class="NewMethodName" name="NewMethodName" type="text" required/> 

                                <h4 class="newQRLabel"><label for="QRImage"> New QR Image</label></h4>
                                <input class="newQRImage" name="newQRImage" id="QRImageUpdate" type="file" required/> 
                                <a id="warningUpdate"></a>

                                <!--Instruction is to update QR--> 
                                <input type="hidden" name="instruction" value="updateQR">
                                <input class="updateBtn" id="updateBtn" type="submit"  value="Update payment method">

                            </form>

                            <form action="QR_Controller" method="POST" enctype="multipart/form-data">
                                <input type="hidden" name="methodName" id="methodName" value="<%=QRTable.getString("methodName")%>"/> 

                                <!--Instruction is to create QR-->         
                                <input type="hidden" name="instruction" value="deleteQR">
                                <input class="deleteBtn" type="submit"  value="Delete payment method">

                            </form>
                        </div>
                    </div>
                    <div class="horizontalDivider"></div>

                        


                    <%
                        }   
                            }
                        
                    %>
                </div>

                <div class="createQRItem">
                    <h1 class="createQRItemTitle">Add New QR code</h1>
                    <form action="QR_Controller" method="POST" enctype="multipart/form-data">
                        <h4><label for="methodName">Payment Method Name</label></h4>
                        <input name="methodName" id="methodName" type="text" required/> 

                        <h4><label for="QRImage">QR Image</label></h4>
                        <input name="QRImage" id="QRImageAdd" type="file" required/> 
                        <br>
                        <a id="warningAdd"></a>
                        <br>

                        <!--Instruction is to create QR-->         
                        <input type="hidden" name="instruction" value="createQR">
                        <input class="addBtn" id="addBtn" type="submit"  value="Add payment method">

                    </form>
                </div>
            </div>
        </div>
        <script>
            //Disable buttons if the file type is not .png or .jpg
            const addBtn = document.getElementById('addBtn');
            const fileInputAdd = document.getElementById('QRImageAdd');
            const warningAdd = document.getElementById("warningAdd");

            fileInputAdd.addEventListener('change', function () {
                const file = fileInputAdd.files[0];
                const fileName = file.name;
                const fileType = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();

                if (fileType === 'jpg' || fileType === 'png') {
                    warningAdd.innerText = '';
                    addBtn.disabled = false;
                } else {
                    warningAdd.innerText = 'Incompatible file types. Please use ethier .jpg or .png';
                    warningAdd.style.color = "red";
                    addBtn.disabled = true;
                }
            });


            const updateBtn = document.getElementById('updateBtn');
            const fileInputUpdate = document.getElementById('QRImageUpdate');
            const warningUpdate = document.getElementById("warningUpdate");

            fileInputUpdate.addEventListener('change', function () {
                const file = fileInputUpdate.files[0];
                const fileName = file.name;
                const fileType = fileName.substr(fileName.lastIndexOf('.') + 1).toLowerCase();

                if (fileType === 'jpg' || fileType === 'png') {
                    updateBtn.innerText = '';
                    updateBtn.disabled = false;
                } else {
                    warningUpdate.innerText = 'Incompatible file types. Please use ethier .jpg or .png';
                    warningUpdate.style.color = "red";
                    updateBtn.disabled = true;
                }
            });
        </script>

    </body>
</html>
