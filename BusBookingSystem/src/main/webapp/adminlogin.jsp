<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>BusGo - Admin Login</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
      rel="stylesheet">

<link rel="stylesheet" href="adminlogin.css">

</head>

<body>

<div class="admin-box">

    <h1>🚌 BusGo</h1>

    <p class="subtitle">Admin Panel Login</p>

    <form action="AdminLoginServlet" method="post">

        <label>Admin Email</label>

        <input type="email"
               name="email"
               placeholder="Enter admin email"
               required>

        <label>Password</label>

        <input type="password"
               name="password"
               placeholder="Enter password"
               required>

        <button type="submit">
            🔐 Admin Login
        </button>

    </form>

    <a href="login.jsp" class="back">
        ← User Login
    </a>

</div>

</body>
</html>