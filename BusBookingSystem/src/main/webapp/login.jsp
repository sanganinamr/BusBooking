<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BusGo - Login</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="login.css">

</head>
<body>		

<div class="register-box">

    <div class="logo">🚌</div>

    <h2>BusGo</h2>

    <p class="subtitle">
        Login to your account
    </p>
    
    <form action="LoginServlet" method="post">

	    <label>Email</label><br>
	    <input type="email" name="email" placeholder="Enter your email" required><br>
	
	    <label>Password</label><br>
	    <input type="password" name="password" placeholder="Enter your password" required><br>
	
	    <input type="submit" value="Login">

	</form>

<p style="text-align:center; margin-top:15px;">
    Don't have an account?
    <a href="register.jsp">Register</a>
</p>

</div>

</body>
</html>