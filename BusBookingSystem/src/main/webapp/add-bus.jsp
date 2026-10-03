<%


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

    <title>Add New Bus - BusGo Admin</title>

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">

    <link rel="stylesheet" href="add-bus.css">

</head>

<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar">

    <div class="brand">
        🚌 BusGo
        <span>ADMIN</span>
    </div>

    <div class="nav-links">

        <a href="adminDashboard.jsp">
            Dashboard
        </a>

        <a href="manage-buses.jsp">
            Manage Buses
        </a>

        <a href="AdminLogoutServlet">
            Logout
        </a>

    </div>

</nav>


<!-- ================= MAIN ================= -->

<div class="container">

    <div class="heading">

        <h1>🚌 Add New Bus</h1>

        <p>
            Add a new bus to your BusGo system
        </p>

    </div>


    <!-- ================= FORM CARD ================= -->

    <div class="form-card">

        <h2>Bus Information</h2>


        <form action="AddBusServlet" method="post">


            <!-- Bus Name -->

            <div class="form-group">

                <label>
                    Bus ID
                </label>

                <input
                    type="text"
                    name="bus_id"
                    placeholder="Enter bus Id"
                    required>

            </div>


            <!-- Bus Number -->

            <div class="form-group">

                <label>
                    Bus Number
                </label>

                <input
                    type="text"
                    name="busNumber"
                    placeholder="Enter bus number"
                    required>

            </div>


            <!-- Source & Destination -->

            <div class="form-row">

                <div class="form-group">

                    <label>
                        Source
                    </label>

                    <input
                        type="text"
                        name="source"
                        placeholder="Enter source"
                        required>

                </div>


                <div class="form-group">

                    <label>
                        Destination
                    </label>

                    <input
                        type="text"
                        name="destination"
                        placeholder="Enter destination"
                        required>

                </div>

            </div>


            <!-- Departure & Arrival -->

            <div class="form-row">

                <div class="form-group">

                    <label>
                        Departure Time
                    </label>

                    <input
                        type="time"
                        name="departureTime"
                        required>

                </div>


                <div class="form-group">

                    <label>
                        Arrival Time
                    </label>

                    <input
                        type="time"
                        name="arrivalTime"
                        required>

                </div>

            </div>


            <!-- Fare -->

            <div class="form-group">

                <label>
                    Fare (₹)
                </label>

                <input
                    type="number"
                    name="fare"
                    placeholder="Enter bus fare"
                    min="1"
                    required>

            </div>
            
            
			

            <!-- Add Bus -->

            <button
                type="submit"
                class="add-button">

                ➕ Add Bus

            </button>


        </form>


        <!-- Back -->

        <a
            href="manage-buses.jsp"
            class="back-btn">

            ← Back to Manage Buses

        </a>

    </div>

</div>

</body>

</html>