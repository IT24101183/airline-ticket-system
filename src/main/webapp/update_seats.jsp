<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Seat Availability</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"flight_scheduler".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <div class="container mt-5">
        <h2 class="text-center">Update Seat Availability</h2>
        <form action="update_seats" method="post" class="w-75 mx-auto">
            <div class="mb-3">
                <label class="form-label">Flight ID:</label>
                <input type="number" name="flight_id" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">New Available Seats:</label>
                <input type="number" name="new_available_seats" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Update Seats</button>
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