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

    String sql = "SELECT * FROM users ORDER BY id DESC";

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

    <title>Users - BusGo Admin</title>

    <link rel="stylesheet" href="users.css">
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
        <a href="AdminLogoutServlet">Logout</a>
    </div>

</nav>


<div class="container">

    <div class="heading">
        <h1>👥 Registered Users</h1>
        <p>View all registered BusGo users</p>
    </div>


    <div class="users-card">

        <h2>User List</h2>

        <div class="table-container">

            <table class="users-table">

                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Mobile</th>
                        <th>Created At</th>
                    </tr>
                </thead>


                <tbody>

                    <%
                    boolean hasUsers = false;

                    if (rs != null) {

                        while (rs.next()) {

                            hasUsers = true;
                    %>

                    <tr>

                        <td><%= rs.getInt("id") %></td>

                        <td><%= rs.getString("full_name") %></td>

                        <td><%= rs.getString("email") %></td>

                        <td><%= rs.getString("mobile") %></td>

                        <td><%= rs.getString("created_at") %></td>

                    </tr>

                    <%
                        }
                    }

                    if (!hasUsers) {
                    %>

                    <tr>
                        <td colspan="5">No users found!</td>
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