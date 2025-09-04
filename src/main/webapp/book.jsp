<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    // Session & role check
    if (session.getAttribute("username") == null || !"customer".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String flight_id = request.getParameter("flight_id");
    if (flight_id == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    // Auto-fill data from DB
    String fullName = "";
    String email = "";
    String phoneNumber = "";
    String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    String dbUser = "sa";
    String dbPassword = "789";

    try {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
        PreparedStatement stmt = conn.prepareStatement("SELECT first_name, last_name, email, phone_number FROM Users WHERE id = ?");
        stmt.setInt(1, (Integer) session.getAttribute("user_id"));
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            String firstName = rs.getString("first_name");
            String lastName = rs.getString("last_name");
            fullName = (firstName != null ? firstName : "") + (lastName != null ? " " + lastName : "");
            email = rs.getString("email");
            phoneNumber = rs.getString("phone_number");
        }
        rs.close();
        stmt.close();
        conn.close();
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // show an alert in the page if DB fetch failed
%>
        <div class='alert alert-danger mt-3'>Error fetching user data: <%= e.getMessage() %></div>
<%
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <title>Book Flight</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #bd4242;
            --primary-dark: #9a3636;
            --dark: #1a1a1a;
            --darker: #121212;
            --light: #f8f9fa;
            --lighter: #ffffff;
            --gray: #6c757d;
            --border-radius: 8px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            transition: all 0.3s ease;
        }

        body.light-theme {
            background-color: #f5f7f9;
            color: #333;
        }

        body.dark-theme {
            background-color: var(--darker);
            color: white;
        }

        .container-main {
            border-radius: var(--border-radius);
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            padding: 2rem;
            margin-top: 2rem;
            margin-bottom: 2rem;
            transition: all 0.3s ease;
        }

        .light-theme .container-main {
            background-color: var(--lighter);
            border: 1px solid #e0e0e0;
        }

        .dark-theme .container-main {
            background-color: var(--dark);
            border: 1px solid #333;
        }

        .header {
            border-bottom: 2px solid var(--primary);
            padding-bottom: 1rem;
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .theme-switch-wrapper {
            display: flex;
            align-items: center;
        }

        .theme-switch {
            display: inline-block;
            height: 24px;
            position: relative;
            width: 50px;
            margin: 0 8px;
        }

        .theme-switch input {
            display: none;
        }

        .slider {
            background-color: #ccc;
            bottom: 0;
            cursor: pointer;
            left: 0;
            position: absolute;
            right: 0;
            top: 0;
            transition: .4s;
        }

        .slider:before {
            background-color: white;
            bottom: 4px;
            content: "";
            height: 16px;
            left: 4px;
            position: absolute;
            transition: .4s;
            width: 16px;
        }

        input:checked + .slider {
            background-color: var(--primary);
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }

        .btn-primary {
            background-color: var(--primary);
            border-color: var(--primary);
            font-weight: 600;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
        }

        .light-theme .btn-secondary {
            background-color: #f0f0f0;
            border-color: #ddd;
            color: #333;
        }

        .dark-theme .btn-secondary {
            background-color: #444;
            border-color: #444;
            color: white;
        }

        .light-theme .form-control,
        .light-theme .form-select {
            background-color: white;
            border: 1px solid #ddd;
            color: #333;
        }

        .dark-theme .form-control,
        .dark-theme .form-select {
            background-color: #333;
            border: 1px solid #555;
            color: white;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 0.25rem rgba(189, 66, 66, 0.25);
        }

        .seat-map {
            border-radius: var(--border-radius);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .light-theme .seat-map {
            background-color: #f9f9f9;
            border: 1px solid #eee;
        }

        .dark-theme .seat-map {
            background-color: #2a2a2a;
            border: 1px solid #444;
        }

        .airplane-cabin {
            position: relative;
            margin: 0 auto;
            max-width: 500px;
        }

        .airplane-header {
            height: 40px;
            border-top-left-radius: 20px;
            border-top-right-radius: 20px;
            margin-bottom: 10px;
            position: relative;
            display: flex;
            justify-content: center;
            align-items: center;
            font-weight: bold;
            font-size: 14px;
        }

        .light-theme .airplane-header {
            background-color: #e9e9e9;
            color: #bd4242;
        }

        .dark-theme .airplane-header {
            background-color: #333;
            color: #bd4242;
        }

        .cabin-section {
            margin-bottom: 30px;
        }

        .cabin-label {
            text-align: center;
            font-size: 12px;
            color: #bd4242;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .seat-row {
            display: flex;
            justify-content: center;
            margin-bottom: 10px;
        }

        .row-number {
            width: 30px;
            text-align: right;
            padding-right: 10px;
            align-self: center;
            font-size: 12px;
        }

        .light-theme .row-number {
            color: #666;
        }

        .dark-theme .row-number {
            color: #aaa;
        }

        .seats {
            display: flex;
            gap: 10px;
        }

        .aisle-space {
            width: 40px;
        }

        .seat {
            width: 30px;
            height: 30px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            cursor: pointer;
            transition: all 0.2s;
            user-select: none;
        }

        .light-theme .seat {
            background-color: #e0e0e0;
            color: #333;
        }

        .dark-theme .seat {
            background-color: #444;
            color: white;
        }

        .seat:hover {
            transform: scale(1.1);
        }

        .seat.selected {
            background-color: var(--primary);
            color: white;
        }

        .seat.occupied {
            cursor: not-allowed;
        }

        .light-theme .seat.occupied {
            background-color: #bbb;
            color: #888;
        }

        .dark-theme .seat.occupied {
            background-color: #777;
            color: #ccc;
        }

        .seat-map-legend {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }

        .legend-item {
            display: flex;
            align-items: center;
            gap: 5px;
            font-size: 12px;
        }

        .legend-color {
            width: 15px;
            height: 15px;
            border-radius: 3px;
        }

        .light-theme .legend-available {
            background-color: #e0e0e0;
        }

        .dark-theme .legend-available {
            background-color: #444;
        }

        .legend-selected {
            background-color: var(--primary);
        }

        .light-theme .legend-occupied {
            background-color: #bbb;
        }

        .dark-theme .legend-occupied {
            background-color: #777;
        }

        .flight-info-card {
            border-radius: var(--border-radius);
            padding: 1rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .light-theme .flight-info-card {
            background-color: #f9f9f9;
            border: 1px solid #eee;
        }

        .dark-theme .flight-info-card {
            background-color: #2a2a2a;
            border: 1px solid #444;
        }

        .info-label {
            font-size: 0.85rem;
            margin-bottom: 0.2rem;
        }

        .light-theme .info-label {
            color: #666;
        }

        .dark-theme .info-label {
            color: #aaa;
        }

        .info-value {
            font-size: 1.1rem;
            margin-bottom: 1rem;
            font-weight: 500;
        }

        .light-theme .info-value {
            color: #333;
        }

        .dark-theme .info-value {
            color: white;
        }

        .alert-info {
            border-color: rgba(189, 66, 66, 0.5);
            color: white;
        }

        .light-theme .alert-info {
            background-color: rgba(189, 66, 66, 0.15);
            color: #333;
        }

        .dark-theme .alert-info {
            background-color: rgba(189, 66, 66, 0.2);
            color: white;
        }

        .theme-icon {
            margin-right: 10px;
            font-size: 1.2rem;
        }

        .light-theme .theme-icon {
            color: #f39c12;
        }

        .dark-theme .theme-icon {
            color: #f1c40f;
        }

        .booking-success {
            display: none;
            text-align: center;
            padding: 2rem;
            border-radius: var(--border-radius);
            margin-top: 1rem;
        }

        .light-theme .booking-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .dark-theme .booking-success {
            background-color: #1e4d2b;
            color: #d4edda;
            border: 1px solid #2d6a3b;
        }
    </style>
</head>
<body class="dark-theme">
    <div class="container container-main">
        <div class="header">
            <h2 class="m-0">Book Flight #FL<%= flight_id %></h2>
            <div class="theme-switch-wrapper">
                <i class="fas fa-moon theme-icon"></i>
                <label class="theme-switch" for="checkbox">
                    <input type="checkbox" id="checkbox" />
                    <div class="slider round"></div>
                </label>
                <i class="fas fa-sun theme-icon"></i>
            </div>
        </div>

        <div class="row">
            <div class="col-md-6">
                <div class="flight-info-card">
                    <div class="row">
                        <div class="col-6">
                            <div class="info-label">Flight Number</div>
                            <div class="info-value">FL<%= flight_id %></div>
                        </div>
                        <div class="col-6">
                            <div class="info-label">Aircraft</div>
                            <div class="info-value">Boeing 737</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="info-label">Departure</div>
                            <div class="info-value">10:30 AM</div>
                        </div>
                        <div class="col-6">
                            <div class="info-label">Arrival</div>
                            <div class="info-value">1:45 PM</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="info-label">From</div>
                            <div class="info-value">New York (JFK)</div>
                        </div>
                        <div class="col-6">
                            <div class="info-label">To</div>
                            <div class="info-value">London (LHR)</div>
                        </div>
                    </div>
                </div>

                <form id="bookingForm" action="<%= request.getContextPath() %>/book" method="post" novalidate>
                    <input type="hidden" name="flight_id" value="<%= flight_id %>">
                    <input type="hidden" name="selected_seats" id="selectedSeats" value="">

                    <div class="mb-3">
                        <label class="form-label">Number of Seats:</label>
                        <input type="number" name="seats" class="form-control" min="1" max="6" required id="seatCount">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Passenger Details:</label>
                        <input type="text" name="passenger_name" class="form-control mb-2" placeholder="Full Name" required value="<%= fullName %>">
                        <input type="email" name="passenger_email" class="form-control mb-2" placeholder="Email Address" required value="<%= email %>">
                        <input type="tel" name="passenger_phone" class="form-control" placeholder="Phone Number" value="<%= phoneNumber %>">
                    </div>

                    <div class="d-grid gap-2">
                        <button type="submit" class="btn btn-primary btn-lg">Book and Proceed to Pay</button>
                        <button type="button" class="btn btn-secondary" onclick="window.history.back()">Back to Results</button>
                    </div>
                </form>

                <!-- server messages (e.g. after redirect from payment or booking) -->
                <%
                    String message = request.getParameter("message");
                    if (message != null) {
                %>
                <div class="alert alert-info mt-3"><%= message %></div>
                <% } %>

                <div class="booking-success" id="bookingSuccess">
                    <i class="fas fa-check-circle fa-3x mb-3"></i>
                    <h4>Booking Confirmed!</h4>
                    <p>Your flight has been successfully booked. A confirmation email will be sent shortly.</p>
                    <div class="booking-details mt-3">
                        <strong>Booking Reference: </strong><span id="bookingRef"></span><br>
                        <strong>Selected Seats: </strong><span id="confirmedSeats"></span>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="seat-map">
                    <h4 class="text-center mb-4">Select Your Seats</h4>
                    <div class="airplane-cabin">
                        <div class="airplane-header">FIRST CLASS</div>

                        <div class="cabin-section">
                            <div class="seat-row">
                                <div class="row-number">1</div>
                                <div class="seats">
                                    <div class="seat" data-seat="1A">1A</div>
                                    <div class="seat" data-seat="1B">1B</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="1C">1C</div>
                                    <div class="seat" data-seat="1D">1D</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">2</div>
                                <div class="seats">
                                    <div class="seat occupied" data-seat="2A">2A</div>
                                    <div class="seat" data-seat="2B">2B</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat occupied" data-seat="2C">2C</div>
                                    <div class="seat" data-seat="2D">2D</div>
                                </div>
                            </div>
                        </div>

                        <div class="cabin-section">
                            <div class="cabin-label">ECONOMY CLASS</div>
                            <!-- Economy rows (3 - 10) -->
                            <div class="seat-row">
                                <div class="row-number">3</div>
                                <div class="seats">
                                    <div class="seat occupied" data-seat="3A">3A</div>
                                    <div class="seat occupied" data-seat="3B">3B</div>
                                    <div class="seat" data-seat="3C">3C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="3D">3D</div>
                                    <div class="seat" data-seat="3E">3E</div>
                                    <div class="seat" data-seat="3F">3F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">4</div>
                                <div class="seats">
                                    <div class="seat" data-seat="4A">4A</div>
                                    <div class="seat" data-seat="4B">4B</div>
                                    <div class="seat occupied" data-seat="4C">4C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat occupied" data-seat="4D">4D</div>
                                    <div class="seat" data-seat="4E">4E</div>
                                    <div class="seat" data-seat="4F">4F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">5</div>
                                <div class="seats">
                                    <div class="seat occupied" data-seat="5A">5A</div>
                                    <div class="seat" data-seat="5B">5B</div>
                                    <div class="seat" data-seat="5C">5C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="5D">5D</div>
                                    <div class="seat occupied" data-seat="5E">5E</div>
                                    <div class="seat" data-seat="5F">5F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">6</div>
                                <div class="seats">
                                    <div class="seat" data-seat="6A">6A</div>
                                    <div class="seat occupied" data-seat="6B">6B</div>
                                    <div class="seat" data-seat="6C">6C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="6D">6D</div>
                                    <div class="seat" data-seat="6E">6E</div>
                                    <div class="seat occupied" data-seat="6F">6F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">7</div>
                                <div class="seats">
                                    <div class="seat" data-seat="7A">7A</div>
                                    <div class="seat" data-seat="7B">7B</div>
                                    <div class="seat occupied" data-seat="7C">7C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="7D">7D</div>
                                    <div class="seat" data-seat="7E">7E</div>
                                    <div class="seat" data-seat="7F">7F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">8</div>
                                <div class="seats">
                                    <div class="seat" data-seat="8A">8A</div>
                                    <div class="seat" data-seat="8B">8B</div>
                                    <div class="seat" data-seat="8C">8C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat occupied" data-seat="8D">8D</div>
                                    <div class="seat" data-seat="8E">8E</div>
                                    <div class="seat" data-seat="8F">8F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">9</div>
                                <div class="seats">
                                    <div class="seat" data-seat="9A">9A</div>
                                    <div class="seat" data-seat="9B">9B</div>
                                    <div class="seat" data-seat="9C">9C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="9D">9D</div>
                                    <div class="seat occupied" data-seat="9E">9E</div>
                                    <div class="seat" data-seat="9F">9F</div>
                                </div>
                            </div>
                            <div class="seat-row">
                                <div class="row-number">10</div>
                                <div class="seats">
                                    <div class="seat" data-seat="10A">10A</div>
                                    <div class="seat" data-seat="10B">10B</div>
                                    <div class="seat" data-seat="10C">10C</div>
                                    <div class="aisle-space"></div>
                                    <div class="seat" data-seat="10D">10D</div>
                                    <div class="seat" data-seat="10E">10E</div>
                                    <div class="seat occupied" data-seat="10F">10F</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="seat-map-legend">
                        <div class="legend-item">
                            <div class="legend-color legend-available"></div>
                            <span>Available</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color legend-selected"></div>
                            <span>Selected</span>
                        </div>
                        <div class="legend-item">
                            <div class="legend-color legend-occupied"></div>
                            <span>Occupied</span>
                        </div>
                    </div>
                </div>

                <div class="selected-seats-info p-3 mt-3 flight-info-card">
                    <h5>Selected Seats: <span id="selectedSeatsDisplay">None</span></h5>
                    <p class="mb-0 info-label">Select seats by clicking on them. The number of seats you can select is determined by the "Number of Seats" field.</p>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Theme switching functionality
        const toggleSwitch = document.querySelector('#checkbox');

        // Default theme: dark-theme (keeps your previous behavior)
        const defaultTheme = 'dark-theme';

        function applyTheme(themeName) {
            document.body.className = themeName;
            toggleSwitch.checked = (themeName === 'dark-theme');
        }

        // Apply initial theme
        applyTheme(defaultTheme);

        function switchTheme(e) {
            if (e.target.checked) {
                applyTheme('dark-theme');
            } else {
                applyTheme('light-theme');
            }
        }

        toggleSwitch.addEventListener('change', switchTheme, false);

        // Seat selection + form validation
        document.addEventListener('DOMContentLoaded', function () {
            const seatCountInput = document.getElementById('seatCount');
            const selectedSeatsInput = document.getElementById('selectedSeats');
            const selectedSeatsDisplay = document.getElementById('selectedSeatsDisplay');
            const bookingForm = document.getElementById('bookingForm');

            // set default seat count to 1
            seatCountInput.value = 1;
            let maxSeats = parseInt(seatCountInput.value) || 1;
            let selectedSeats = [];

            // query seats (only seats that are not occupied)
            // note: we still want click listeners on non-occupied seats only
            const seatElements = Array.from(document.querySelectorAll('.seat'));

            function updateSelectedSeatsData() {
                selectedSeatsInput.value = selectedSeats.join(',');
                selectedSeatsDisplay.textContent = selectedSeats.length > 0 ? selectedSeats.join(', ') : 'None';
            }

            function updateSeatSelectionAfterCountChange() {
                maxSeats = parseInt(seatCountInput.value) || 1;
                if (selectedSeats.length > maxSeats) {
                    const seatsToDeselect = selectedSeats.slice(maxSeats);
                    seatsToDeselect.forEach(seatId => {
                        const seatEl = document.querySelector(`.seat[data-seat="${seatId}"]`);
                        if (seatEl) seatEl.classList.remove('selected');
                    });
                    selectedSeats = selectedSeats.slice(0, maxSeats);
                    updateSelectedSeatsData();
                }
            }

            seatCountInput.addEventListener('change', updateSeatSelectionAfterCountChange);
            seatCountInput.addEventListener('input', updateSeatSelectionAfterCountChange);

            seatElements.forEach(seat => {
                seat.addEventListener('click', () => {
                    if (seat.classList.contains('occupied')) {
                        return; // can't select occupied
                    }
                    const seatId = seat.getAttribute('data-seat');
                    if (!seatId) return;

                    if (seat.classList.contains('selected')) {
                        // Deselect
                        seat.classList.remove('selected');
                        selectedSeats = selectedSeats.filter(s => s !== seatId);
                    } else {
                        // Select only if not exceeding max
                        if (selectedSeats.length < maxSeats) {
                            seat.classList.add('selected');
                            selectedSeats.push(seatId);
                        } else {
                            alert(`You can only select ${maxSeats} seat(s). Please decrease your seat count or deselect a seat first.`);
                        }
                    }
                    updateSelectedSeatsData();
                });
            });

            // Validate before letting the form submit
            bookingForm.addEventListener('submit', function (e) {
                // Client-side validation: ensure seats selected and passenger name/email present
                const passengerName = bookingForm.querySelector('[name="passenger_name"]').value.trim();
                const passengerEmail = bookingForm.querySelector('[name="passenger_email"]').value.trim();
                const requestedSeats = parseInt(seatCountInput.value) || 1;

                // Ensure the selected seats field is synchronized
                selectedSeatsInput.value = selectedSeats.join(',');

                if (selectedSeats.length === 0) {
                    e.preventDefault();
                    alert('Please select at least one seat before booking.');
                    return;
                }

                if (selectedSeats.length !== requestedSeats) {
                    e.preventDefault();
                    alert(`Please select exactly ${requestedSeats} seat(s) to match your seat count.`);
                    return;
                }

                if (!passengerName) {
                    e.preventDefault();
                    alert('Please enter the passenger name.');
                    return;
                }

                if (!passengerEmail) {
                    e.preventDefault();
                    alert('Please enter a valid email address.');
                    return;
                }

                // If validation passes, do NOT preventDefault() — allow the form to submit to server.
                // selected seats are already placed into the hidden input.
            });
        });
    </script>
</body>
</html>
