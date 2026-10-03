<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.db.DBConnection" %>

<%
String busId = request.getParameter("bus_id");

if (busId == null) {
    response.sendRedirect("manage-buses.jsp");
    return;
}

Connection con = DBConnection.getConnection();

PreparedStatement ps = con.prepareStatement(
    "SELECT * FROM buses WHERE bus_id = ?"
);

ps.setInt(1, Integer.parseInt(busId));

ResultSet rs = ps.executeQuery();

if (!rs.next()) {
    response.sendRedirect("manage-buses.jsp");
    return;
}
%>

<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Bus - BusGo Admin</title>

<link rel="stylesheet" href="edit-bus.css">

</head>

<body>

<div class="container">

    <div class="form-card">

        <h1>✏️ Edit Bus</h1>

        <form action="UpdateBusServlet" method="post">

            <input type="hidden"
                   name="bus_id"
                   value="<%= rs.getInt("bus_id") %>">

            <label>Bus Number</label>

            <input type="text"
                   name="busNumber"
                   value="<%= rs.getString("bus_number") %>"
                   required>


            <label>Source</label>

            <input type="text"
                   name="source"
                   value="<%= rs.getString("source") %>"
                   required>


            <label>Destination</label>

            <input type="text"
                   name="destination"
                   value="<%= rs.getString("destination") %>"
                   required>


            <label>Departure Time</label>

            <input type="time"
                   name="departureTime"
                   value="<%= rs.getString("departure_time") %>"
                   required>


            <label>Arrival Time</label>

            <input type="time"
                   name="arrivalTime"
                   value="<%= rs.getString("arrival_time") %>"
                   required>


            <label>Fare (₹)</label>

            <input type="number"
                   name="fare"
                   value="<%= rs.getDouble("fare") %>"
                   required>


            <label>Total Seats</label>

            <input type="number"
                   value="<%= rs.getInt("total_seats") %>"
                   disabled>


            <button type="submit">
                💾 Update Bus
            </button>

        </form>

        <a href="manage-buses.jsp">
            ← Back to Manage Buses
        </a>

    </div>

</div>

</body>

</html>

<%
rs.close();
ps.close();
con.close();
%>