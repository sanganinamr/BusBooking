<% 
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.db.DBConnection" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Manage Buses - BusGo Admin</title>

<link rel="stylesheet" href="manage-buses.css">

</head>

<body>

<nav class="navbar">

    <div class="brand">
        🚌 BusGo
        <span>ADMIN</span>
    </div>

    <div class="nav-links">
        <a href="adminDashboard.jsp">Dashboard</a>
        <a href="manage-buses.jsp">Manage Buses</a>
        <a href="AdminLogoutServlet">Logout</a>
    </div>

</nav>


<div class="container">

    <div class="heading">

        <h1>🚌 Manage Buses</h1>

        <p>Add, update and manage your buses</p>

    </div>


    <div class="bus-actions">

        <a href="add-bus.jsp" class="add-btn">
            ➕ Add New Bus
        </a>

    </div>


    <div class="bus-card">

    <h2>🚌 Bus List</h2>

    <table class="bus-table">

        <thead>
            <tr>
                <th>Bus ID</th>
                <th>Bus Number</th>
                <th>Source</th>
                <th>Destination</th>
                <th>Departure</th>
                <th>Arrival</th>
                <th>Fare</th>
                <th>Total Seats</th>
                <th>Action</th>
            </tr>
        </thead>

        <tbody>

			<%
			Connection con = DBConnection.getConnection();

			PreparedStatement ps = con.prepareStatement(
			    "SELECT bus_id, bus_number, source, destination, " +
			    "departure_time, arrival_time, fare, total_seats " +
    			"FROM buses"
				);

			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
			%>

			<tr>

		    	<td><%= rs.getInt("bus_id") %></td>

    			<td><%= rs.getString("bus_number") %></td>

    			<td><%= rs.getString("source") %></td>

    			<td><%= rs.getString("destination") %></td>

    			<td><%= rs.getString("departure_time") %></td>

    			<td><%= rs.getString("arrival_time") %></td>

    			<td>₹<%= rs.getDouble("fare") %></td>

    			<td><%= rs.getInt("total_seats") %></td>
    			
    			<td>
    				<a href="edit-bus.jsp?bus_id=<%= rs.getInt("bus_id") %>"
       					class="edit-btn">
       					✏️ Edit
    				</a>

    				<a href="DeleteBusServlet?bus_id=<%= rs.getInt("bus_id") %>"
       				class="delete-btn"
       				onclick="return confirm('Are you sure you want to delete this bus?');">
       				🗑️ Delete
    				</a>
				</td>

			</tr>

			<%
			}

			rs.close();
			ps.close();
			con.close();
			%>

		</tbody>
    </table>

</div>
</div>

</body>
</html>