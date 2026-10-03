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

<title>BusGo - Ticket</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet" href="ticket.css">

</head>

<body>

<nav class="navbar">

    <div class="brand">
        🚌 <span>BusGo</span>
    </div>

    <ul class="menu">

        <li>
            <a href="home.jsp">Home</a>
        </li>

        <li>
            <a href="MyBookingsServlet">My Bookings</a>
        </li>

        <li>
            <a href="ProfileServlet">Profile</a>
        </li>

        <li>
            <a href="LogoutServlet">Logout</a>
        </li>

    </ul>

</nav>


<div class="ticket-container">

    <div class="ticket">

        <div class="ticket-header">

            <div>
                <h1>🚌 BusGo</h1>
                <p>BUS TICKET</p>
            </div>

            <div class="booking-id">
                Booking ID<br>
                <strong>#<%= request.getAttribute("bookingId") %></strong>
            </div>

        </div>


        <div class="route">

            <div>

                <span>FROM</span>

                <h2>
                    <%= request.getAttribute("source") %>
                </h2>

            </div>


            <div class="arrow">
                ➜
            </div>


            <div>

                <span>TO</span>

                <h2>
                    <%= request.getAttribute("destination") %>
                </h2>

            </div>

        </div>


        <div class="details">

            <div class="detail">

                <span>BUS NUMBER</span>

                <strong>
                    <%= request.getAttribute("busNumber") %>
                </strong>

            </div>


            <div class="detail">

                <span>JOURNEY DATE</span>

                <strong>
                    <%= request.getAttribute("journeyDate") %>
                </strong>

            </div>


            <div class="detail">

                <span>DEPARTURE</span>

                <strong>
                    <%= request.getAttribute("departure") %>
                </strong>

            </div>


            <div class="detail">

                <span>ARRIVAL</span>

                <strong>
                    <%= request.getAttribute("arrival") %>
                </strong>

            </div>

        </div>


        <div class="passenger-section">

            <h3>Passenger Details</h3>

            <div class="passenger-grid">

                <div>
                    <span>NAME</span>
                    <strong>
                        <%= request.getAttribute("passenger") %>
                    </strong>
                </div>

                <div>
                    <span>MOBILE</span>
                    <strong>
                        <%= request.getAttribute("mobile") %>
                    </strong>
                </div>

                <div>
                    <span>AGE</span>
                    <strong>
                        <%= request.getAttribute("age") %>
                    </strong>
                </div>

                <div>
                    <span>SEAT</span>
                    <strong class="seat">
                        <%= request.getAttribute("seat") %>
                    </strong>
                </div>

            </div>

        </div>


        <div class="fare-section">

            <span>Total Fare</span>

            <strong>
                ₹<%= request.getAttribute("fare") %>
            </strong>

        </div>


        <div class="status">
            ✓ BOOKING CONFIRMED
        </div>


        <div class="buttons">

            <button onclick="window.print()">
                🖨 Print Ticket
            </button>

            <a href="MyBookingsServlet">
                ← Back to My Bookings
            </a>

        </div>


        <p class="footer-text">
            Thank you for choosing BusGo. Have a safe journey! 🚌
        </p>

    </div>

</div>

</body>

</html>