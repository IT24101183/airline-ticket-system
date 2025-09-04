<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Customer Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body class="container mt-5">
    <%
        if (session.getAttribute("username") == null || !"customer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <h1 class="text-center">Welcome to Customer Dashboard, <%= session.getAttribute("username") %>!</h1>
    <p class="text-center">Manage your air ticket reservations.</p>
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Search Flights</h5>
                    <p class="card-text">Search by date and plan your travel.</p>
                    <a href="search_flights.jsp" class="btn btn-primary">Search</a>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Select Seats</h5>
                    <p class="card-text">Choose comfortable seats for your flight.</p>
                    <a href="select_seats.jsp" class="btn btn-primary">Select</a>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">Make Payment</h5>
                    <p class="card-text">Secure payment to complete booking.</p>
                    <a href="customer_payment.jsp" class="btn btn-primary">Pay</a>
                </div>
            </div>
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">View E-Tickets</h5>
                    <p class="card-text">Instant e-tickets for your bookings.</p>
                    <a href="e_tickets.jsp" class="btn btn-primary">View</a>
                </div>
            </div>
        </div>
    </div>
    <a href="logout" class="btn btn-secondary mt-3">Logout</a>
</body>
</html>