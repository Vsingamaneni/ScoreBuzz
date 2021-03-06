<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 1/1/19
  Time: 10:34 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page session="false" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Confirm Update</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="/resources/login/images/icons/cricket.ico"/>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.0/css/all.css">
    <link rel="stylesheet" href="/resources/core/css/table.css"/>
    <link rel="stylesheet" href="/resources/core/css/bootstrap.min.css"/>
    <style>
        html,body,h1,h2,h3,h4,h5 {font-family: "Raleway", sans-serif}
    </style>
</head>

<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
    <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i class="fa fa-bars"></i> &nbsp;Menu</button>
    <span class="w3-bar-item w3-right">Score Buzz</span>
</div>

<c:if test="${not empty session}">
    <c:set var="user_name" value="${session.firstName}"/>
    <c:set var="role" value="${session.role}"/>
</c:if>

<c:if test="${empty session}">
    <c:set var="user_name" value="User"/>
</c:if>

<spring:url value="/prediction/${predictionForm.predictionId}/delete" var="updateUrl" />
<spring:url value="/predictions" var="cancelUrl" />

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3;width:300px;" id="mySidebar"><br>
    <div class="w3-container w3-row">
        <div class="w3-col s4">
            <img src="/resources/core/images/avatar2.png" class="w3-circle w3-margin-right" style="width:46px">
        </div>
        <div class="w3-col s8 w3-bar">
            <span>Welcome, <strong>${user_name}</strong></span><br>
            <a href="/" class="w3-bar-item w3-button"><i class="fa fa-home"></i></a>
            <a href="/schedule" style="text-decoration : none;" class="w3-bar-item w3-button w3-padding"><i class="fa fa-bell fa-fw"></i></a>
            <a href="/logout" style="text-decoration : none;" style="text-decoration : none;"class="w3-bar-item w3-button w3-padding"><i class="fa fa-power-off"></i></a>
        </div>
    </div>
    <hr>
    <div class="w3-container">
        <h5>Dashboard</h5>
    </div>
    <div class="w3-bar-block">
        <a href="#" class="w3-bar-item w3-button w3-padding-16 w3-hide-large w3-dark-grey w3-hover-black"
           onclick="w3_close()" title="close menu"><i class="fa fa-remove fa-fw"></i>&nbsp; Close Menu</a>
        <c:if test="${session.choice.equalsIgnoreCase('1')}">
            <%@include file="../navigation/gameodds.jsp" %>
        </c:if>
        <c:if test="${session.choice.equalsIgnoreCase('2')}">
            <%@include file="../navigation/topten.jsp" %>
        </c:if>
        <c:if test="${session.choice.equalsIgnoreCase('3')}">
            <%@include file="../navigation/both.jsp" %>
        </c:if>

        <c:if test="${role.equalsIgnoreCase('admin')}">
            <%@include file="../navigation/admin.jsp" %>
        </c:if>
        <a href="/logout" style="text-decoration: none" class="w3-bar-item w3-button w3-padding"><i class="fa fa-power-off"></i>&nbsp; Logout</a>
    </div>
</nav>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

        <h2 style="text-align: center;"> Hey ${fn:toUpperCase(user_name)}, You are about to delete your prediction. </h2>
        <br /><br /><br />

            <div class='container' style="width: 80%; margin: 0 auto;">
                <div class='panel panel-primary dialog-panel'>
                    <div class='panel-heading' style="background-color: #082a3e;">
                        <h3 style="text-align: center;">Make sure you don't miss the deadline !!</h3>
                    </div>
                    <div class='panel-body' >
                        <form modelAttribute="predictionForm" method="POST" class='form-horizontal' role='form'>
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_event'>Match</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_event' name="event" style="min-width:150px;">
                                        <option style="text-align: center">${fn:toUpperCase(predictionForm.homeTeam)}
                                            vs ${fn:toUpperCase(predictionForm.awayTeam)}</option>
                                    </select>
                                </div>
                            </div>
                            <input type=hidden id="predictionId" name="predictionId" value="${predictionForm.predictionId}">
                            <input type=hidden id="memberId" name="memberId" value="${session.memberId}">
                            <input type=hidden id="matchNumber" name="matchNumber" value="${predictionForm.matchNumber}">
                            <input type=hidden id="homeTeam" name="homeTeam" value="${predictionForm.homeTeam}">
                            <input type=hidden id="awayTeam" name="awayTeam" value="${predictionForm.awayTeam}">
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_name'>Name</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_name' name="abc"
                                            style="min-width:150px; ">
                                        <option style="text-align: center">${predictionForm.firstName}</option>
                                    </select>
                                </div>
                            </div>
                            <div class='form-group'>
                                <label class='control-label col-md-2 col-md-offset-2' for='id_selected'>Selected</label>
                                <div class='col-md-2'>
                                    <select class='form-control' id='id_selected' name="selected"
                                            style="min-width:150px; ">
                                        <option style="text-align: center">${predictionForm.selected}</option>
                                    </select>
                                </div>
                            </div>
                            <br />
                            <div class='form-group'>
                                <div class='col-md-offset-4 col-md-3'>
                                    <button class='btn-lg btn-primary' type='submit' onclick="post('/prediction/${predictionForm.predictionId}/delete/${predictionForm.choice}')">
                                        Confirm
                                    </button>
                                </div>
                                <div class='col-md-3'>
                                    <button class='btn-lg btn-danger' type='submit'>
                                        <a href="/predictions" style="color:white;text-decoration : none;">Cancel</a>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
    <br>

    <!-- Footer -->
    <footer class="w3-container w3-padding-16 w3-light-grey">
        <p>&copy; All rights Reserved @<b>Vamsi Krishna Singamaneni</b></p>
    </footer>

    <!-- End page content -->
</div>

<script>
    // Get the Sidebar
    var mySidebar = document.getElementById("mySidebar");

    // Get the DIV with overlay effect
    var overlayBg = document.getElementById("myOverlay");

    // Toggle between showing and hiding the sidebar, and add overlay effect
    function w3_open() {
        if (mySidebar.style.display === 'block') {
            mySidebar.style.display = 'none';
            overlayBg.style.display = "none";
        } else {
            mySidebar.style.display = 'block';
            overlayBg.style.display = "block";
        }
    }

    // Close the sidebar with the close button
    function w3_close() {
        mySidebar.style.display = "none";
        overlayBg.style.display = "none";
    }
</script>

</body>
</html>