<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>BusGo - Payment</title>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<link rel="stylesheet" href="payment.css">

</head>

<body>

<div class="payment-container">

    <div class="payment-box">

        <div class="header">

            <h1>🚌 BusGo</h1>

            <p>Secure Payment</p>

        </div>


        <div class="amount-box">

            <span>Total Amount</span>

            <strong>
                ₹<%= request.getAttribute("amount") %>
            </strong>

        </div>


        <h3>Select Payment Method</h3>


        <div class="methods">

            <label>
                <input type="radio"
                       name="method"
                       value="upi"
                       checked
                       onclick="showUPI()">

                📱 UPI
            </label>

            <label>
                <input type="radio"
                       name="method"
                       value="card"
                       onclick="showCard()">

                💳 Card
            </label>

            <label>
                <input type="radio"
                       name="method"
                       value="netbanking"
                       onclick="showNetBanking()">

                🏦 Net Banking
            </label>

        </div>


        <!-- UPI -->

        <div id="upi" class="payment-option">

            <label>UPI ID</label>

            <input type="text"
                   id="upiInput"
                   placeholder="example@upi">

        </div>


        <!-- CARD -->

        <div id="card" class="payment-option hidden">

            <label>Card Number</label>

            <input type="text"
                   maxlength="16"
                   placeholder="1234 5678 9012 3456">

            <div class="card-row">

                <div>

                    <label>Expiry</label>

                    <input type="text"
                           placeholder="MM/YY">

                </div>

                <div>

                    <label>CVV</label>

                    <input type="password"
                           maxlength="3"
                           placeholder="•••">

                </div>

            </div>

        </div>


        <!-- NET BANKING -->

        <div id="netbanking"
             class="payment-option hidden">

            <label>Select Bank</label>

            <select>

                <option>Select Bank</option>

                <option>SBI</option>

                <option>HDFC Bank</option>

                <option>ICICI Bank</option>

                <option>Axis Bank</option>

                <option>Bank of Baroda</option>

            </select>

        </div>


        <form action="ConfirmBookingServlet"
      method="post"
      onsubmit="return confirmPayment();">

    <input type="hidden"
           name="busId"
           value="<%= request.getAttribute("busId") %>">

    <input type="hidden"
           name="journeyDate"
           value="<%= request.getAttribute("journeyDate") %>">

    <input type="hidden"
           name="seatNumber"
           value="<%= request.getAttribute("seatNumber") %>">

    <input type="hidden"
           name="name"
           value="<%= request.getAttribute("name") %>">

    <input type="hidden"
           name="mobile"
           value="<%= request.getAttribute("mobile") %>">

    <input type="hidden"
           name="age"
           value="<%= request.getAttribute("age") %>">

    <input type="hidden"
           name="amount"
           value="<%= request.getAttribute("amount") %>">

    <button type="submit">
        🔒 Pay ₹<%= request.getAttribute("amount") %>
    </button>

</form>

        <a href="home.jsp" class="back">
            Cancel Payment
        </a>

    </div>

</div>


<script>

function hideAll() {

    document.getElementById("upi")
        .classList.add("hidden");

    document.getElementById("card")
        .classList.add("hidden");

    document.getElementById("netbanking")
        .classList.add("hidden");
}


function showUPI() {

    hideAll();

    document.getElementById("upi")
        .classList.remove("hidden");
}


function showCard() {

    hideAll();

    document.getElementById("card")
        .classList.remove("hidden");
}


function showNetBanking() {

    hideAll();

    document.getElementById("netbanking")
        .classList.remove("hidden");
}


function confirmPayment() {

    return confirm(
        "Confirm payment of ₹<%= request.getAttribute("amount") %>?"
    );
}

</script>

</body>

</html>