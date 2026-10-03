<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Booking Successful - BusGo</title>

<link rel="stylesheet"
href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">

<link rel="stylesheet" href="success.css">

</head>

<body>



<div class="success-container">

    <div class="success-card">

        <div class="check-circle">
            <span>✓</span>
        </div>

        <h1>Booking Confirmed!</h1>

        <p class="main-text">
            🎉 Your bus ticket has been booked successfully!
        </p>

        <div class="bus-animation">
            🚌
        </div>

        <p class="thank-text">
            Thank you for choosing <b>BusGo</b> ❤️
        </p>

        <div class="buttons">

            <a href="MyBookingsServlet" class="btn primary">
                🎫 View My Booking
            </a>

            <a href="home.jsp" class="btn secondary">
                🏠 Back to Home
            </a>

        </div>

    </div>

</div>

<script>

window.onload = function() {

    for (let i = 0; i < 60; i++) {

        let piece = document.createElement("div");

        piece.className = "confetti-piece";

        piece.style.left = Math.random() * 100 + "vw";

        piece.style.animationDelay =
            Math.random() * 3 + "s";

        piece.style.animationDuration =
            (2 + Math.random() * 3) + "s";

        document.body.appendChild(piece);
    }

};

</script>

</body>
</html>