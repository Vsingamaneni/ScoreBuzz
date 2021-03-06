<%--
  Created by IntelliJ IDEA.
  User: v0s004a
  Date: 5/15/19
  Time: 6:54 AM
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
    <title>Add Settlement</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="icon" type="image/x-icon" href="/resources/login/images/icons/cricket.ico"/>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.6.0/css/all.css">
    <link rel="stylesheet" href="/resources/core/css/table.css"/>
    <link rel="stylesheet" href="/resources/core/css/format_css.css"/>
    <style>
        html, body, h1, h2, h3, h4, h5 {
            font-family: "Raleway", sans-serif
        }
    </style>
</head>

<body class="w3-light-grey">

<!-- Top container -->
<div class="w3-bar w3-top w3-black w3-large" style="z-index:4">
    <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-light-grey" onclick="w3_open();"><i
            class="fa fa-bars"></i> &nbsp;Menu
    </button>
    <span class="w3-bar-item w3-right">Score Buzz</span>
</div>

<c:if test="${not empty session}">
    <c:set var="user_name" value="${session.firstName}"/>
    <c:set var="role" value="${session.role}"/>
    <c:set var="isActivated" value="${}"/>
</c:if>

<c:if test="${empty session}">
    <c:set var="user_name" value="User"/>
</c:if>

<spring:url value="/match/${predictionForm.predictionId}/${predictionForm.matchNumber}/save" var="updateUrl"/>
<spring:url value="/predictions" var="cancelUrl"/>

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
        <a href="/logout" class="w3-bar-item w3-button w3-padding"><i class="fa fa-power-off"></i>&nbsp; Logout</a>
    </div>
</nav>
<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer"
     title="close side menu" id="myOverlay"></div>

<!-- !PAGE CONTENT! -->
<div class="w3-main" style="margin-left:300px;margin-top:43px;">

    <h2 style="text-align: center;"> &nbsp;&nbsp; Hey ${fn:toUpperCase(user_name)}, Ready to add a settlement? </h2>

    <c:if test="${not empty msg}">
    <div class="alert alert-${css} alert-dismissible" role="alert">
        <strong style="text-align: center; color: #4CAF50">${msg}</strong>
    </div>
    </c:if>

    <c:if test="${not empty errorDetailsList}">
    <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS; text-align:center;"> Dude, fix
        the below error(s)</h2>
    </c:if>
    <c:forEach var="errorDetails" items="${errorDetailsList}">
    <c:if test="${not empty errorDetails.errorMessage}">
    <h2 style="color:red;font-size:15px;text-decoration:none;font-family:Comic Sans MS; text-align:center;">
        *** ${errorDetails.errorMessage} </h2>
    </c:if>
    </c:forEach>
    <br/><br/><br/>

    <div style="width: 90%; margin: 0 auto;">

        <div class='container'>
            <div class='panel panel-primary dialog-panel'>
                <div class='panel-heading' style="background-color: #082a3e;">
                    <h1 style="text-align: center;">Add Settlement</h1>
                </div>
                <div class="w3-panel">
                    <div class="w3-row-padding" style="width:100%;margin:0 auto">
                        <form class="login100-form validate-form p-b-33 p-t-5" action="/saveSettlement" modelAttribute="trackSettlement" method="POST">
                            <table class="w3-table w3-striped w3-white" style="text-align: center; align:center; align-content: center">

                                <div class="wrap-input100 validate-input" data-validate = "To">
                                    To : <select class='form-control' id='id_to' name="toDetails"
                                                 style=" width:50%;">
                                    <c:forEach var="settlement" items="${settlementDetails}">
                                        <option>${settlement.memberId} - ${settlement.name} (${settlement.net})</option>
                                    </c:forEach>
                                </select>
                                </div>

                                <br />
                                <div class="wrap-input100 validate-input" data-validate = "From">
                                    From : <select class='form-control' id='id_from' name="fromDetails"
                                                   style=" width:50%;">
                                    <c:forEach var="settlement" items="${settlementDetails}">
                                        <option>${settlement.memberId} - ${settlement.name} (${settlement.net})</option>
                                    </c:forEach>
                                </select>
                                </div>

                                <br />

                                <div class="wrap-input100 validate-input" data-validate="Settle Amount">
                                    <input class="input100" type="text" placeholder="Settle Amount" name="settledAmount">
                                    <span class="focus-input100" data-placeholder="&#xe80f;"></span>
                                </div>

                                <br />

                                <div class="container-login100-form-btn m-t-32">
                                    <button type="submit" class="btn-lg btn-primary" style= "border-radius: 8px;"><a
                                            style="color:white;font-size:15px;text-decoration:none;font-family:Comic Sans MS">Settle</a>
                                    </button>
                                </div>

                                </tr>
                            </table>
                        </form>
                        <br/><br/>
                    </div>
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
