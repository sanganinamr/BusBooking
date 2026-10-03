<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.db.DBConnection" %>

<%
if (session.getAttribute("adminId") == null) {
    response.sendRedirect("adminlogin.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);

String adminName = (String) session.getAttribute("adminName");

int totalBuses = 0;
int totalBookings = 0;
int totalUsers = 0;

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

    con.close();

} catch (Exception e) {

    e.printStackTrace();

}

%>


<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Admin Dashboard - BusGo</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet" href="adminDashboard.css">

</head>

<body>

<nav class="navbar">

    <div class="brand">
        🚌 <span>BusGo</span>
        <small>ADMIN</small>
    </div>

    <div class="admin-info">
        👤 <%= adminName %>
    </div>

</nav>


<div class="dashboard">

    <div class="welcome">

        <h1>Welcome, <%= adminName %> 👋</h1>

        <p>
            Manage your BusGo booking system from here.
        </p>

    </div>


    <div class="cards">

        <div class="dashboard-card">

            <div class="icon">🚌</div>

            <h2>Manage Buses</h2>
            <h3><%= totalBuses %> Total Buses</h3>

            <p>
                Add, update and delete buses.
            </p>

            <a href="manage-buses.jsp">
                Manage Buses →
            </a>

        </div>


        <div class="dashboard-card">

            <div class="icon">🎫</div>

            <h2>All Bookings</h2>
            <h3><%= totalBookings %> Total Bookings</h3>

            <p>
                View all customer bookings.
            </p>

            <a href="all-bookings.jsp">
                View Bookings →
            </a>

        </div>


        <div class="dashboard-card">

            <div class="icon">👥</div>

            <h2>Users</h2>
            <h3><%= totalUsers %> Total Users</h3>

            <p>
                View registered BusGo users.
            </p>

            <a href="users.jsp">
                View Users →
            </a>

        </div>


        <div class="dashboard-card">

            <div class="icon">📊</div>

            <h2>Reports</h2>

            <p>
                View booking and bus reports.
            </p>

            <a href="reports.jsp">
                View Reports →
            </a>

        </div>

    </div>


    <div class="logout-area">

        <a href="AdminLogoutServlet" class="logout">
            🚪 Admin Logout
        </a>

    </div>

</div>

</body>

</html>