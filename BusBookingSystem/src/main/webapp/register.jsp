<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="login.css">
</head>
<body>
<div class="register-box">

<h2>🚌 BusGo</h2>

<p class="subtitle">
    Fast, Secure and Easy Bus Ticket Booking
</p>

<form action="RegisterServlet" method="post">

    <label>Full Name:</label><br>
    <input type="text" name="fullname" required><br><br>

    <label>Email:</label><br>
    <input type="email" name="email" required><br><br>

    <label>Mobile:</label><br>
    <input type="text" name="mobile" required><br><br>

    <label>Password:</label><br>
    <input type="password" name="password" required><br><br>

    <label>Confirm Password:</label><br>
    <input type="password" name="confirmPassword" required><br><br>

    <input type="submit" value="Register">
    
    <p style="text-align:center; margin-top:15px;">
    Already have an account?
    <a href="login.jsp">Login</a>
</p>
    	

</form>
</div>



</body>
</html>