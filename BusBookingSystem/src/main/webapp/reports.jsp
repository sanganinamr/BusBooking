<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.db.DBConnection" %>

<%
int totalBuses = 0;
int totalBookings = 0;
int totalUsers = 0;
double totalAmount = 0;

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    con = DBConnection.getConnection();

    // Total Buses
    ps = con.prepareStatement("SELECT COUNT(*) FROM buses");
    rs = ps.executeQuery();

    if (rs.next()) {
        totalBuses = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // Total Bookings
    ps = con.prepareStatement("SELECT COUNT(*) FROM bookings");
    rs = ps.executeQuery();

    if (rs.next()) {
        totalBookings = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // Total Users
    ps = con.prepareStatement("SELECT COUNT(*) FROM users");
    rs = ps.executeQuery();

    if (rs.next()) {
        totalUsers = rs.getInt(1);
    }

    rs.close();
    ps.close();


    // Total Booking Amount
    ps = con.prepareStatement("SELECT COALESCE(SUM(amount), 0) FROM bookings");
    rs = ps.executeQuery();

    if (rs.next()) {
        totalAmount = rs.getDouble(1);
    }

    rs.close();
    ps.close();

    con.close();

} catch (Exception e) {
    e.printStackTrace();
}
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Reports - BusGo Admin</title>

    <link rel="stylesheet" href="reports.css">

</head>

<body>

<nav class="navbar">

    <div class="brand">
        🚌 BusGo <span>ADMIN</span>
    </div>

    <div class="nav-links">
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="manage-buses.jsp">Manage Buses</a>
        <a href="all-bookings.jsp">All Bookings</a>
        <a href="users.jsp">Users</a>
        <a href="reports.jsp">Reports</a>
        <a href="AdminLogoutServlet">Logout</a>
    </div>

</nav>


<div class="container">

    <div class="heading">

        <h1>📊 Reports</h1>

        <p>Overview of your BusGo booking system</p>

    </div>


    <div class="report-cards">

        <div class="report-card">

            <div class="icon">🚌</div>

            <h2><%= totalBuses %></h2>

            <p>Total Buses</p>

        </div>


        <div class="report-card">

            <div class="icon">🎫</div>

            <h2><%= totalBookings %></h2>

            <p>Total Bookings</p>

        </div>


        <div class="report-card">

            <div class="icon">👥</div>

            <h2><%= totalUsers %></h2>

            <p>Total Users</p>

        </div>


        <div class="report-card">

            <div class="icon">💰</div>

            <h2>₹<%= String.format("%.2f", totalAmount) %></h2>

            <p>Total Booking Amount</p>

        </div>

    </div>

</div>

</body>
</html>