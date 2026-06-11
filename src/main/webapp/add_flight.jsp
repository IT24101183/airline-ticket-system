<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add New Flight</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"flight_scheduler".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <div class="container mt-5">
        <h2 class="text-center">Add New Flight</h2>
        <form action="add_flight" method="post" class="w-75 mx-auto">
            <div class="mb-3">
                <label class="form-label">Departure Airport:</label>
                <input type="text" name="departure_airport" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Arrival Airport:</label>
                <input type="text" name="arrival_airport" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Departure Date:</label>
                <input type="date" name="departure_date" class="form-control" required>
            </div>
            <div class="mb-3">
                        <label class="form-label">Departure Time:</label>
                        <input type="time" name="departure_time" class="form-control" required>
                    </div>
            <div class="mb-3">
                <label class="form-label">Flight Class:</label>
                <select name="flight_class" class="form-select" required>
                    <option value="economy">Economy</option>
                    <option value="business">Business</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Max Passengers:</label>
                <input type="number" name="passengers" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Available Seats:</label>
                <input type="number" name="available_seats" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Price:</label>
                <input type="number" name="price" class="form-control" step="0.01" required>
            </div>
            <input type="submit" value="Add Flight" class="btn btn-primary w-100">
        </form>
        <%
            String message = request.getParameter("message");
            if (message != null) {
                out.println("<p class='text-center mt-3'>" + message + "</p>");
            }
        %>
        <a href="scheduler_dashboard.jsp" class="d-block text-center mt-3">Back to Dashboard</a>
    </div>
</body>
</html>