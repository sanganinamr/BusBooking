<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.db.DBConnection" %>

<%
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {

    con = DBConnection.getConnection();

    String sql = "SELECT * FROM bookings ORDER BY booking_id DESC";

    ps = con.prepareStatement(sql);

    rs = ps.executeQuery();

} catch (Exception e) {

    e.printStackTrace();

}
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>All Bookings - BusGo Admin</title>

    <link rel="stylesheet" href="all-bookings.css">

</head>

<body>

<!-- NAVBAR -->

<nav class="navbar">

    <div class="brand">

        🚌 BusGo

        <span>ADMIN</span>

    </div>

    <div class="nav-links">

        <a href="adminDashboard.jsp">Dashboard</a>

        <a href="manage-buses.jsp">Manage Buses</a>

        <a href="all-bookings.jsp">All Bookings</a>

        <a href="AdminLogoutServlet">Logout</a>

    </div>

</nav>


<!-- MAIN CONTENT -->

<div class="container">

    <div class="heading">

        <h1>🎫 All Bookings</h1>

        <p>View and manage all customer bookings</p>

    </div>


    <!-- BOOKING TABLE -->

    <div class="booking-card">

        <h2>Booking List</h2>

        <div class="table-container">

            <table class="booking-table">

                <thead>

                    <tr>

                        <th>Booking ID</th>

                        <th>User ID</th>

                        <th>Bus ID</th>

                        <th>Passenger Name</th>

                        <th>Mobile</th>

                        <th>Age</th>

                        <th>Journey Date</th>

                        <th>Booking Date</th>

                        <th>Status</th>

                        <th>Seat Number</th>

                        <th>Amount</th>

                    </tr>

                </thead>


                <tbody>

                    <%
                    boolean hasBookings = false;

                    if (rs != null) {

                        while (rs.next()) {

                            hasBookings = true;
                    %>

                    <tr>

                        <td><%= rs.getInt("booking_id") %></td>

                        <td><%= rs.getInt("user_id") %></td>

                        <td><%= rs.getInt("bus_id") %></td>

                        <td><%= rs.getString("passenger_name") %></td>

                        <td><%= rs.getString("mobile") %></td>

                        <td><%= rs.getInt("age") %></td>

                        <td><%= rs.getString("journey_date") %></td>

                        <td><%= rs.getString("booking_date") %></td>

                        <td>
                            <span class="status">
                                <%= rs.getString("status") %>
                            </span>
                        </td>

                        <td><%= rs.getString("seat_number") %></td>

                        <td>
                            ₹<%= rs.getDouble("amount") %>
                        </td>

                    </tr>

                    <%
                        }
                    }

                    if (!hasBookings) {
                    %>

                    <tr>

                        <td colspan="11">

                            No bookings found!

                        </td>

                    </tr>

                    <%
                    }
                    %>

                </tbody>

            </table>

        </div>

    </div>

</div>

</body>

</html>

<%
try {

    if (rs != null) rs.close();

    if (ps != null) ps.close();

    if (con != null) con.close();

} catch (Exception e) {

    e.printStackTrace();

}
%>