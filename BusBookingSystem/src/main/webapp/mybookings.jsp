<%
if (session.getAttribute("userId") == null) {
    response.sendRedirect("login.jsp");
    return;
}

response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>

<%@ page import="java.sql.ResultSet" %>

<%
ResultSet rs = (ResultSet) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Bookings - BusGo</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet" href="mybookings.css">

</head>

<body>

<nav class="navbar">

    <div class="brand">
         <span>BusGo</span>
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


<div class="container">

    <h1>My Bookings</h1>

    <%

    boolean found = false;

    while(rs != null && rs.next()) {

        found = true;

    %>


    <div class="ticket">

        <div class="ticket-header">

            <div class="bus-name">
                 BusGo
            </div>

            <div class="booking-id">
                Booking #<%= rs.getInt("booking_id") %>
            </div>

        </div>


        <div class="bus-info">

            <div>

                <span>BUS NUMBER</span>

                <strong>
                    <%= rs.getString("bus_number") %>
                </strong>

            </div>


            <div class="route">

                <strong>
                    <%= rs.getString("source") %>
                </strong>

                <b> TO </b>

                <strong>
                    <%= rs.getString("destination") %>
                </strong>

            </div>

        </div>


        <div class="line"></div>


        <div class="details">

            <div>
                <span>PASSENGER</span>
                <strong>
                    <%= rs.getString("passenger_name") %>
                </strong>
            </div>


            <div>
                <span>MOBILE</span>
                <strong>
                    <%= rs.getString("mobile") %>
                </strong>
            </div>


            <div>
                <span>AGE</span>
                <strong>
                    <%= rs.getInt("age") %>
                </strong>
            </div>


            <div>
                <span>SEAT</span>
                <strong class="seat">
                    <%= rs.getString("seat_number") %>
                </strong>
            </div>


            <div>
                <span>JOURNEY DATE</span>
                <strong>
                    <%= rs.getString("journey_date") %>
                </strong>
            </div>

        </div>


        <div class="ticket-footer">

    <span>
         Confirmed Booking
    </span>

    <form action="CancelBookingServlet"
          method="post"
          onsubmit="return confirm('Are you sure you want to cancel this booking?');">

        <input type="hidden"
               name="bookingId"
               value="<%= rs.getInt("booking_id") %>">

        <button type="submit" class="cancel-btn">
            Cancel Booking
        </button>

    </form>
    
    <a href="TicketServlet?bookingId=<%= rs.getInt("booking_id") %>"
   		class="ticket-btn">
    	 View Ticket
	</a>

</div>
    </div>


    <%

    }

    if(!found) {

    %>

        <div class="no-booking">

            <div class="empty-icon"></div>

            <h2>No Bookings Found</h2>

            <p>You haven't booked any bus tickets yet.</p>

            <a href="home.jsp">
                Book a Bus
            </a>

        </div>

    <%

    }

    %>

</div>

</body>

</html>