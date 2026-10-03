<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BusGo - Home</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="home.css?v=1">

</head>
<body>

<nav class="navbar">
    <div class="brand">
        🚌 <span>BusGo</span>
    </div>

    <ul class="menu">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="MyBookingsServlet">My Bookings</a></li>
        <li><a href="ProfileServlet">Profile</a></li>
        <li><a href="LogoutServlet">Logout</a></li>
    </ul>
</nav>

<section class="hero">

    <div class="hero-content">

        <h1>Travel Across Gujarat</h1>

        <p>Book your bus tickets quickly, safely and comfortably.</p>

        <div class="search-card">

            <form action="SearchBusServlet" method="post" class="search-form">

    <input type="text" name="from" placeholder="📍 From" required>

    <input type="text" name="to" placeholder="📍 To" required>

    <input type="date" name="journeyDate" required>


    <button type="submit">🔍 Search Buses</button>

</form>
        </div>

    </div>

</section>

<section class="routes">

    <h2>Popular Routes</h2>

    <div class="route-container">

        <div class="route-card">
            <h3>Ahmedabad ➜ Rajkot</h3>
        </div>

        <div class="route-card">
            <h3>Surat ➜ Junagadh</h3>
        </div>

        <div class="route-card">
            <h3>Vadodara ➜ Bhavnagar</h3>
        </div>

    </div>

</section>

<footer>

    <p>© 2026 BusGo. All Rights Reserved.</p>

</footer>

</body>
</html>