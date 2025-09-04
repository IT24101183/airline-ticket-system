<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>E-Ticket</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container mt-5">
    <%
        if (session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String booking_id = request.getParameter("booking_id");
        if (booking_id == null) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
        String dbUser = "sa";
        String dbPassword = "789";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            stmt = conn.prepareStatement("SELECT b.id, b.seats, b.total_price, b.booking_date, f.departure_airport, f.arrival_airport, f.departure_date, f.flight_class, u.username FROM Bookings b JOIN Flights f ON b.flight_id = f.id JOIN Users u ON b.user_id = u.id WHERE b.id = ? AND b.user_id = ?");
            stmt.setInt(1, Integer.parseInt(booking_id));
            stmt.setInt(2, (Integer) session.getAttribute("user_id"));
            rs = stmt.executeQuery();
            if (rs.next()) {
    %>
    <h2 class="text-center">E-Ticket Confirmation</h2>
    <div class="card">
        <div class="card-body">
            <p><strong>Ticket ID:</strong> <%= rs.getInt("id") %></p>
            <p><strong>Customer:</strong> <%= rs.getString("username") %></p>
            <p><strong>Departure:</strong> <%= rs.getString("departure_airport") %></p>
            <p><strong>Arrival:</strong> <%= rs.getString("arrival_airport") %></p>
            <p><strong>Date:</strong> <%= rs.getDate("departure_date") %></p>
            <p><strong>Class:</strong> <%= rs.getString("flight_class") %></p>
            <p><strong>Seats:</strong> <%= rs.getInt("seats") %></p>
            <p><strong>Total Price:</strong> <%= rs.getDouble("total_price") %></p>
            <p><strong>Booking Date:</strong> <%= rs.getTimestamp("booking_date") %></p>
        </div>
    </div>
    <a href="dashboard.jsp" class="btn btn-primary mt-3">Back to Dashboard</a>
    <%
            } else {
                out.println("<p class='text-danger'>Invalid booking.</p>");
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p>Error generating ticket.</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
</body>
</html>