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

<%@ page import="java.sql.*" %>
<%@ page import="com.busbooking.db.DBConnection" %>

<%
Integer busId = (Integer) request.getAttribute("busId");

if (busId == null) {
    response.sendRedirect("home.jsp");
    return;
}

String journeyDate = (String) request.getAttribute("journeyDate");

if (journeyDate == null || journeyDate.trim().isEmpty()) {
    response.sendRedirect("home.jsp");
    return;
}

Connection con = DBConnection.getConnection();

/* Get bus fare */
PreparedStatement farePs = con.prepareStatement(
    "SELECT fare FROM buses WHERE bus_id=?"
);

farePs.setInt(1, busId);

ResultSet fareRs = farePs.executeQuery();

double fare = 0;

if (fareRs.next()) {
    fare = fareRs.getDouble("fare");
}

fareRs.close();
farePs.close();


/* Total booked seats for selected bus and selected date */

PreparedStatement ps = con.prepareStatement(
    "SELECT COALESCE(SUM(" +
    "LENGTH(seat_number) - LENGTH(REPLACE(seat_number, ',', '')) + 1" +
    "), 0) " +
    "FROM bookings WHERE bus_id=? AND journey_date=?"
);

ps.setInt(1, busId);
ps.setString(2, journeyDate);

ResultSet seatRs = ps.executeQuery();

int bookedSeats = 0;

if (seatRs.next()) {
    bookedSeats = seatRs.getInt(1);
}

int totalSeats = 40;
int availableSeats = totalSeats - bookedSeats;


/* Get booked seat numbers */

PreparedStatement ps2 = con.prepareStatement(
    "SELECT seat_number FROM bookings " +
    "WHERE bus_id=? AND journey_date=?"
);

ps2.setInt(1, busId);
ps2.setString(2, journeyDate);

ResultSet bookedRs = ps2.executeQuery();

java.util.HashSet<String> bookedSeatSet =
    new java.util.HashSet<String>();

while (bookedRs.next()) {

    String bookedSeatString =
        bookedRs.getString("seat_number");

    if (bookedSeatString != null) {

        String[] bookedSeatsArray =
            bookedSeatString.split(",");

        for (String bookedSeat : bookedSeatsArray) {

            bookedSeatSet.add(bookedSeat.trim());
        }
    }
}
%>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Passenger Details - BusGo</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet" href="passenger.css">

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



<section class="hero">

<div class="card">


<h2>Passenger Details</h2>


<p style="text-align:center;color:white;margin-bottom:20px;font-size:16px;">

    Total Seats :
    <b>40</b>

    <br>

    Booked Seats :
    <b><%= bookedSeats %></b>

    <br>

    Available Seats :
    <b><%= availableSeats %></b>

</p>



<!-- ================= FORM ================= -->

<form action="PaymentServlet" method="post">


<!-- Bus ID -->

<input
    type="hidden"
    name="busId"
    value="<%= busId %>"
>


<!-- Journey Date -->

<input
    type="hidden"
    name="journeyDate"
    value="<%= journeyDate %>"
>


<p style="color:white;text-align:center;margin-bottom:20px;">

    Journey Date :

    <b><%= journeyDate %></b>

</p>



<!-- Passenger Name -->

<label>Passenger Name</label>

<input
    type="text"
    name="name"
    placeholder="Enter Passenger Name"
    required
>



<!-- Mobile -->

<label>Mobile Number</label>

<input
    type="text"
    name="mobile"
    placeholder="Enter Mobile Number"
    maxlength="10"
    required
>



<!-- Age -->

<label>Age</label>

<input
    type="number"
    name="age"
    placeholder="Enter Age"
    min="1"
    max="100"
    required
>



<!-- Total Passengers -->

<label>Total Passengers</label>

<input
    type="number"
    name="totalPassengers"
    id="totalPassengers"
    min="1"
    max="<%= availableSeats %>"
    value="1"
    required
>



<!-- Select Seat -->

<div
    class="seat-selector"
    onclick="openSeats()"
>

    Select Seat

</div>



<div class="seat-box">


<%

String[] seats = {

    "A1","A2","A3","A4","A5",
    "A6","A7","A8","A9","A10",

    "B1","B2","B3","B4","B5",
    "B6","B7","B8","B9","B10",

    "C1","C2","C3","C4","C5",
    "C6","C7","C8","C9","C10",

    "D1","D2","D3","D4","D5",
    "D6","D7","D8","D9","D10"
};


for(String seat : seats) {

    boolean booked =
        bookedSeatSet.contains(seat);

%>


<button

    type="button"

    class="seat <%= booked ? "booked" : "" %>"

    data-seat="<%= seat %>"

    <%= booked ? "disabled" : "" %>

>

    <%= seat %>

</button>


<%

}

%>


</div>



<!-- Selected Seats -->

<input

    type="hidden"

    id="seatNumber"

    name="seatNumber"

    required

>



<!-- Amount -->

<input

    type="hidden"

    id="amount"

    name="amount"

>



<!-- Fare information -->

<p style="color:white;text-align:center;margin:15px 0;">

    Fare per Passenger :
    <b>₹<%= fare %></b>

    <br>

    Total Amount :
    <b id="totalAmount">₹<%= fare %></b>

</p>



<br>


<!-- Continue -->

<button
    type="submit"
    onclick="return validateSeats()"
>

    Continue to Payment 💳

</button>


</form>


</div>

</section>



<script>


const seats =
    document.querySelectorAll(".seat");


const hiddenSeat =
    document.getElementById("seatNumber");


const totalPassengers =
    document.getElementById("totalPassengers");


const amountInput =
    document.getElementById("amount");


const totalAmount =
    document.getElementById("totalAmount");


const fare =
    <%= fare %>;



/* ================= SEAT SELECTION ================= */

seats.forEach(function(seat) {

    seat.addEventListener("click", function() {

        if (this.disabled) {
            return;
        }


        let selectedCount =
            document.querySelectorAll(
                ".seat.selected"
            ).length;


        let maxSeats =
            parseInt(totalPassengers.value);


        if (
            !this.classList.contains("selected")
            &&
            selectedCount >= maxSeats
        ) {

            alert(
                "You can select only "
                + maxSeats
                + " seat(s)."
            );

            return;
        }


        this.classList.toggle("selected");


        let selectedSeats = [];


        seats.forEach(function(s) {

            if (
                s.classList.contains("selected")
            ) {

                selectedSeats.push(
                    s.dataset.seat
                );
            }

        });


        hiddenSeat.value =
            selectedSeats.join(",");


        updateAmount();

    });

});



/* ================= AMOUNT ================= */

function updateAmount() {

    let passengers =
        parseInt(totalPassengers.value);


    if (isNaN(passengers) || passengers < 1) {

        passengers = 1;

    }


    let total =
        fare * passengers;


    totalAmount.innerText =
        "₹" + total.toFixed(2);


    amountInput.value =
        total.toFixed(2);

}



totalPassengers.addEventListener(
    "change",
    function() {

        let selectedCount =
            document.querySelectorAll(
                ".seat.selected"
            ).length;


        let maxSeats =
            parseInt(this.value);


        if (selectedCount > maxSeats) {

            alert(
                "Please select only "
                + maxSeats
                + " seat(s)."
            );

            this.value =
                selectedCount;

        }


        updateAmount();

    }
);



/* ================= VALIDATION ================= */

function validateSeats() {


    let selectedCount =
        document.querySelectorAll(
            ".seat.selected"
        ).length;


    let maxSeats =
        parseInt(totalPassengers.value);


    if (selectedCount !== maxSeats) {

        alert(
            "Please select exactly "
            + maxSeats
            + " seat(s)."
        );

        return false;

    }


    if (!hiddenSeat.value) {

        alert("Please select your seat.");

        return false;

    }


    updateAmount();


    return true;

}



/* ================= OPEN SEATS ================= */

function openSeats() {

    document.querySelector(
        ".seat-box"
    ).style.display = "block";

}


</script>


</body>

</html>


<%

/* Close database resources */

bookedRs.close();

ps2.close();

seatRs.close();

ps.close();

con.close();

%>