<%-- 
    Document   : adminOrders
    Created on : 5 Feb 2023, 6:13:04 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/adminOrders.css'>
        <title>Orders</title>
    </head>

    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->  

    <body>
        <div class="container">
            <div class="left">
                <h2>New Ingredient</h2>
                <div class="form-group">
                    <label for="ingredient">Ingredient:</label>
                    <input type="text" id="ingredient" name="ingredient" required>
                </div>
                <div class="form-group">
                    <label for="weight">Weight in Stocks:</label>
                    <input type="number" id="weight" name="weight" required>
                </div>
                <button class="btn btn-green">Add Ingredient</button>
            </div>
            <div class="right">
                <table data-rows-per-page="5">
                    <thead>
                        <tr>
                            <th>Ingredient</th>
                            <th>Weight of Remaining Stocks</th>
                            <th>Update</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody data-page="1">
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Sample Ingredient</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <tr>
                            <td>Pang 6</td>
                            <td>1000g</td>
                            <td><button class="btn btn-blue">Update</button></td>
                            <td><button class="btn btn-red">Delete</button></td>
                        </tr>
                        <!-- Repeat the above row for each item in the table -->
                    </tbody>
                </table>
                <div class="pagination"></div>
            </div>
        </div>
    </body>

    <script>
        function renderPagination(tbody) {
            const rowsPerPage = parseInt(tbody.parentNode.getAttribute('data-rows-per-page'));
            const currentPage = parseInt(tbody.getAttribute('data-page'));
            const rows = tbody.getElementsByTagName('tr');
            const numPages = Math.ceil(rows.length / rowsPerPage);
            const paginationDiv = tbody.parentNode.querySelector('.pagination');
            paginationDiv.innerHTML = '';
            for (let i = 1; i <= numPages; i++) {
                const button = document.createElement('button');
                button.textContent = i;
                button.addEventListener('click', () => {
                    tbody.setAttribute('data-page', i);
                    renderTable(tbody);
                });
                if (i === currentPage) {
                    button.classList.add('active');
                }
                paginationDiv.appendChild(button);
            }
        }


        function renderTable(tbody) {
            const rowsPerPage = parseInt(tbody.parentNode.getAttribute('data-rows-per-page'));
            const currentPage = parseInt(tbody.getAttribute('data-page'));
            const start = (currentPage - 1) * rowsPerPage;
            const end = start + rowsPerPage;
            const rows = tbody.getElementsByTagName('tr');
            for (let i = 0; i < rows.length; i++) {
                rows[i].style.display = (i >= start && i < end) ? 'table-row' : 'none';
            }
            renderPagination(tbody);
        }


        const table = document.querySelector('.right table');
        const tbody = table.querySelector('tbody');
        renderTable(tbody);
        table.addEventListener('render', () => {
            renderTable(tbody);
        });

    </script>

</html>
