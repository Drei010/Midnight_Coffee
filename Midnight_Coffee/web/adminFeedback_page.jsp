<%-- 
    Document   : adminFeedback_page
    Created on : 5 Feb 2023, 6:14:21 pm
    Author     : rvhin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel='stylesheet' type='text/css' href='styles/general.css'>
        <link rel='stylesheet' type='text/css' href='styles/AdminFeedback.css'>
        <title>Feedback</title>
    </head>
    
    <jsp:include page="adminHeader.jsp" /> <!-- Calls the header jsp -->
    
    <body>
        <div class="container1">
        <table>
  <tr>
    <th colspan="2">Latest Comments</th>
  </tr>
  
  <tr>
    <td class="CDetails"> 
       <div class="Cname">
           R-Vhin Pogi
       </div>
        <div class="stars">
        <div class="rate">
    <input type="radio" id="star5" name="rate" value="5" />
    <label for="star5" title="text">5 stars</label>
    <input type="radio" id="star4" name="rate" value="4" />
    <label for="star4" title="text">4 stars</label>
    <input type="radio" id="star3" name="rate" value="3" />
    <label for="star3" title="text">3 stars</label>
    <input type="radio" id="star2" name="rate" value="2" />
    <label for="star2" title="text">2 stars</label>
    <input type="radio" id="star1" name="rate" value="1" />
    <label for="star1" title="text">1 star</label>
        </div>
        </div>
        <div class="Ccomment">
           Ang sarap mo mansee
       </div>
    </td>
    
    <td class="Cbox">
        <input type="checkbox" checked="checked">
        <span class="checkmark"></span>
    </td>
    
  </tr>
</table>
        </div>
    </body>
</html>
