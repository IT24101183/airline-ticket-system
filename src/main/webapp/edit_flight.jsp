<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Flight Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    if (session.getAttribute("username") == null || !"flight_scheduler".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String flight_idStr = request.getParameter("flight_id");
    String departure_airport = "";
    String arrival_airport = "";
    String departure_date = "";
    String flight_class = "";
    int passengers = 0;
    int available_seats = 0;
    double price = 0.0;
    boolean flightFound = false;

    if (flight_idStr != null && !flight_idStr.isEmpty()) {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;", "sa", "789");
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Flights WHERE id = ?");
            stmt.setInt(1, Integer.parseInt(flight_idStr));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                departure_airport = rs.getString("departure_airport");
                arrival_airport = rs.getString("arrival_airport");
                departure_date = rs.getString("departure_date");
                flight_class = rs.getString("flight_class");
                passengers = rs.getInt("passengers");
                available_seats = rs.getInt("available_seats");
                price = rs.getDouble("price");
                flightFound = true;

                // Format the departure_date for datetime-local input
                if (departure_date != null && !departure_date.isEmpty()) {
                    try {
                        // If the date is in SQL format (yyyy-MM-dd HH:mm:ss), convert it
                        if (departure_date.contains(" ")) {
                            departure_date = departure_date.replace(" ", "T");
                            if (departure_date.length() > 16) {
                                departure_date = departure_date.substring(0, 16);
                            }
                        }
                    } catch (Exception e) {
                        // Keep original format if conversion fails
                    }
                }
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error fetching flight: " + e.getMessage() + "</div>");
        }
    }
%>

<div class="container mt-4">
    <h2 class="text-center mb-4">Edit Flight Details</h2>

    <div class="row justify-content-center">
        <div class="col-md-8">
            <!-- Flight ID Search Section -->
            <% if (flight_idStr == null || flight_idStr.isEmpty() || !flightFound) { %>
            <div class="card mb-4">
                <div class="card-header">
                    <h5>Search Flight to Edit</h5>
                </div>
                <div class="card-body">
                    <form method="get" action="edit_flight.jsp">
                        <div class="input-group">
                            <input type="number" name="flight_id" class="form-control"
                                   placeholder="Enter Flight ID" value="<%= flight_idStr != null ? flight_idStr : "" %>" required>
                            <button type="submit" class="btn btn-primary">Load Flight Details</button>
                        </div>
                    </form>
                    <% if (flight_idStr != null && !flightFound) { %>
                        <div class="alert alert-warning mt-3">Flight with ID <%= flight_idStr %> not found.</div>
                    <% } %>
                </div>
            </div>
            <% } %>

            <!-- Edit Flight Form -->
            <% if (flightFound) { %>
            <div class="card">
                <div class="card-header">
                    <h5>Edit Flight ID: <%= flight_idStr %></h5>
                </div>
                <div class="card-body">
                    <form action="edit_flight" method="post">
                        <!-- Hidden flight ID field -->
                        <input type="hidden" name="flight_id" value="<%= flight_idStr %>">

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Departure Airport:</label>
                                <input type="text" name="departure_airport" class="form-control"
                                       value="<%= departure_airport %>" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Arrival Airport:</label>
                                <input type="text" name="arrival_airport" class="form-control"
                                       value="<%= arrival_airport %>" required>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Departure Date & Time:</label>
                                <input type="datetime-local" name="departure_date" class="form-control"
                                       value="<%= departure_date %>" required>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label class="form-label">Flight Class:</label>
                                <select name="flight_class" class="form-select" required>
                                    <option value="economy" <%= "economy".equals(flight_class) ? "selected" : "" %>>Economy</option>
                                    <option value="business" <%= "business".equals(flight_class) ? "selected" : "" %>>Business</option>
                                    <option value="first" <%= "first".equals(flight_class) ? "selected" : "" %>>First Class</option>
                                </select>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label class="form-label">Max Passengers:</label>
                                <input type="number" name="passengers" class="form-control"
                                       value="<%= passengers %>" min="1" required>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Available Seats:</label>
                                <input type="number" name="available_seats" class="form-control"
                                       value="<%= available_seats %>" min="0" required>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label class="form-label">Price ($):</label>
                                <input type="number" step="0.01" name="price" class="form-control"
                                       value="<%= price %>" min="0.01" required>
                            </div>
                        </div>

                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary btn-lg">Update Flight</button>
                        </div>
                    </form>

                    <!-- Reset button to search for another flight -->
                    <div class="text-center mt-3">
                        <a href="edit_flight.jsp" class="btn btn-outline-secondary">Edit Another Flight</a>
                    </div>
                </div>
            </div>
            <% } %>

            <!-- Message Display -->
            <%
                String message = request.getParameter("message");
                if (message != null) {
                    String alertClass = message.toLowerCase().contains("success") ? "alert-success" : "alert-info";
                    out.println("<div class='alert " + alertClass + " mt-3'>" + message + "</div>");
                }
            %>

            <!-- Back to Dashboard -->
            <div class="text-center mt-4">
                <a href="scheduler_dashboard.jsp" class="btn btn-secondary">← Back to Dashboard</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<script>
// Auto-calculate available seats when max passengers changes
document.addEventListener('DOMContentLoaded', function() {
    const passengersInput = document.querySelector('input[name="passengers"]');
    const availableSeatsInput = document.querySelector('input[name="available_seats"]');

    if (passengersInput && availableSeatsInput) {
        passengersInput.addEventListener('input', function() {
            const maxPassengers = parseInt(this.value) || 0;
            const currentAvailable = parseInt(availableSeatsInput.value) || 0;

            // Ensure available seats doesn't exceed max passengers
            if (currentAvailable > maxPassengers) {
                availableSeatsInput.value = maxPassengers;
            }
            availableSeatsInput.max = maxPassengers;
        });
    }
});
</script>
</body>
</html>