<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Profile - BusGo</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet" href="profile.css">

</head>

<body>

<nav class="navbar">

    <div class="brand">
        🚌 <span>BusGo</span>
    </div>

    <ul class="menu">

        <li>
            <a href="home.jsp">Home</a>
        </li>

        <li>
            <a href="MyBookingsServlet">My Bookings</a>
        </li>

        <li>
            <a href="ProfileServlet">Profile</a>
        </li>

        <li>
            <a href="LogoutServlet">Logout</a>
        </li>

    </ul>

</nav>


<div class="profile-container">

    <div class="profile-card">

        <div class="profile-icon">
            👤
        </div>

        <h1>My Profile</h1>

        <div class="profile-info">

            <div class="info-box">

                <span>FULL NAME</span>

                <strong>
                    <%= request.getAttribute("name") %>
                </strong>

            </div>


            <div class="info-box">

                <span>EMAIL</span>

                <strong>
                    <%= request.getAttribute("email") %>
                </strong>

            </div>
            
			<div class="info-box">

                <span>Mobile Number</span>

                <strong>
                    <%= request.getAttribute("mobile") %>
                </strong>

            </div>
            

        </div>


        <div class="profile-buttons">

            <a href="home.jsp" class="home-btn">
                🏠 Home
            </a>

            <a href="MyBookingsServlet" class="booking-btn">
                🎫 My Bookings
            </a>

        </div>

    </div>

</div>

</body>

</html>