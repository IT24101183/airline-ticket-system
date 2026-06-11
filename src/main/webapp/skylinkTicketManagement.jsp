<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SkyLink Airline E-Tickets</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background: #f5f7fa;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
        }

        header {
            text-align: center;
            margin-bottom: 30px;
            padding: 20px;
            background: linear-gradient(135deg, #1a237e 0%, #283593 100%);
            color: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }

        .subtitle {
            font-size: 1.2rem;
            opacity: 0.9;
        }

        .search-section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
            margin-bottom: 30px;
        }

        .search-form {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            align-items: center;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #1a237e;
        }

        input[type="text"] {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 16px;
            transition: border-color 0.3s;
        }

        input[type="text"]:focus {
            border-color: #3949ab;
            outline: none;
            box-shadow: 0 0 0 2px rgba(57, 73, 171, 0.2);
        }

        button {
            background: #3949ab;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: background 0.3s;
            margin-top: 25px;
        }

        button:hover {
            background: #283593;
        }

        .tickets-container {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .ticket {
            width: 100%;
            height: 250px;
            background: #fff;
            border-radius: 3px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.15);
            border-top: 1px solid #e89f3d;
            border-bottom: 1px solid #e89f3d;
            position: relative;
            overflow: hidden;
        }

        .ticket.economy {
            background: #ffb300;
        }

        .ticket.business {
            background: #d95e35;
        }

        .ticket.first {
            background: #8e24aa;
        }

        .ticket:after {
            content: "";
            position: absolute;
            right: 200px;
            top: 0px;
            width: 2px;
            height: 250px;
            box-shadow: inset 0 0 0 #ffb300, inset 0 -10px 0 #b56e0a,
                inset 0 -20px 0 #ffb300, inset 0 -30px 0 #b56e0a,
                inset 0 -40px 0 #ffb300, inset 0 -50px 0 #999999,
                inset 0 -60px 0 #e5e5e5, inset 0 -70px 0 #999999,
                inset 0 -80px 0 #e5e5e5, inset 0 -90px 0 #999999,
                inset 0 -100px 0 #e5e5e5, inset 0 -110px 0 #999999,
                inset 0 -120px 0 #e5e5e5, inset 0 -130px 0 #999999,
                inset 0 -140px 0 #e5e5e5, inset 0 -150px 0 #b0b0b0,
                inset 0 -160px 0 #eeeeee, inset 0 -170px 0 #b0b0b0,
                inset 0 -180px 0 #eeeeee, inset 0 -190px 0 #b0b0b0,
                inset 0 -200px 0 #eeeeee, inset 0 -210px 0 #b0b0b0,
                inset 0 -220px 0 #ffb300, inset 0 -230px 0 #b56e0a,
                inset 0 -240px 0 #ffb300, inset 0 -250px 0 #b56e0a;
        }

        .ticket.business:after {
            box-shadow: inset 0 0 0 #d95e35, inset 0 -10px 0 #a03019,
                inset 0 -20px 0 #d95e35, inset 0 -30px 0 #a03019,
                inset 0 -40px 0 #d95e35, inset 0 -50px 0 #999999,
                inset 0 -60px 0 #e5e5e5, inset 0 -70px 0 #999999,
                inset 0 -80px 0 #e5e5e5, inset 0 -90px 0 #999999,
                inset 0 -100px 0 #e5e5e5, inset 0 -110px 0 #999999,
                inset 0 -120px 0 #e5e5e5, inset 0 -130px 0 #999999,
                inset 0 -140px 0 #e5e5e5, inset 0 -150px 0 #b0b0b0,
                inset 0 -160px 0 #eeeeee, inset 0 -170px 0 #b0b0b0,
                inset 0 -180px 0 #eeeeee, inset 0 -190px 0 #b0b0b0,
                inset 0 -200px 0 #eeeeee, inset 0 -210px 0 #b0b0b0,
                inset 0 -220px 0 #d95e35, inset 0 -230px 0 #a03019,
                inset 0 -240px 0 #d95e35, inset 0 -250px 0 #a03019;
        }

        .content {
            position: absolute;
            top: 40px;
            width: 100%;
            height: 170px;
            background: #eee;
        }

        .airline {
            position: absolute;
            top: 10px;
            left: 10px;
            font-family: Arial;
            font-size: 20px;
            font-weight: bold;
            color: rgba(0, 0, 102, 1);
        }

        .boarding {
            position: absolute;
            top: 10px;
            right: 220px;
            font-family: Arial;
            font-size: 18px;
            color: rgba(255, 255, 255, 0.6);
        }

        .jfk {
            position: absolute;
            top: 10px;
            left: 20px;
            font-family: Arial;
            font-size: 18px;
            font-weight: bold;
            color: #222;
        }

        .sfo {
            position: absolute;
            top: 10px;
            left: 180px;
            font-family: Arial;
            font-size: 18px;
            font-weight: bold;
            color: #222;
        }

        .plane {
            position: absolute;
            left: 115px;
            top: 0px;
        }

        .sub-content {
            background: #e5e5e5;
            width: 100%;
            height: 100px;
            position: absolute;
            top: 70px;
        }

        .watermark {
            position: absolute;
            left: 5px;
            top: -10px;
            font-family: Arial;
            font-size: 110px;
            font-weight: bold;
            color: rgba(255, 255, 255, 0.2);
        }

        .name {
            position: absolute;
            top: 10px;
            left: 10px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .name span {
            color: #555;
            font-size: 17px;
        }

        .flight {
            position: absolute;
            top: 10px;
            left: 180px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .flight span {
            color: #555;
            font-size: 17px;
        }

        .gate {
            position: absolute;
            top: 10px;
            left: 280px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .gate span {
            color: #555;
            font-size: 17px;
        }

        .seat {
            position: absolute;
            top: 10px;
            left: 350px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .seat span {
            color: #555;
            font-size: 17px;
        }

        .boardingtime {
            position: absolute;
            top: 60px;
            left: 10px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .boardingtime span {
            color: #555;
            font-size: 17px;
        }

        .ticketclass {
            position: absolute;
            top: 60px;
            left: 180px;
            font-family: Arial Narrow, Arial;
            font-weight: bold;
            font-size: 14px;
            color: #999;
        }

        .ticketclass span {
            color: #555;
            font-size: 17px;
        }

        .barcode {
            position: absolute;
            left: 8px;
            bottom: 6px;
            height: 30px;
            width: 90px;
            background: #222;
            box-shadow:
                inset 0 1px 0 #ffb300, inset -2px 0 0 #ffb300,
                inset -4px 0 0 #222, inset -5px 0 0 #ffb300, inset -6px 0 0 #222,
                inset -9px 0 0 #ffb300, inset -12px 0 0 #222, inset -13px 0 0 #ffb300,
                inset -14px 0 0 #222, inset -15px 0 0 #ffb300, inset -16px 0 0 #222,
                inset -17px 0 0 #ffb300, inset -19px 0 0 #222, inset -20px 0 0 #ffb300,
                inset -23px 0 0 #222, inset -25px 0 0 #ffb300, inset -26px 0 0 #222,
                inset -26px 0 0 #ffb300, inset -27px 0 0 #222, inset -30px 0 0 #ffb300,
                inset -31px 0 0 #222, inset -33px 0 0 #ffb300, inset -35px 0 0 #222,
                inset -37px 0 0 #ffb300, inset -40px 0 0 #222, inset -43px 0 0 #ffb300,
                inset -44px 0 0 #222, inset -45px 0 0 #ffb300, inset -46px 0 0 #222,
                inset -48px 0 0 #ffb300, inset -49px 0 0 #222, inset -50px 0 0 #ffb300,
                inset -52px 0 0 #222, inset -54px 0 0 #ffb300, inset -55px 0 0 #222,
                inset -57px 0 0 #ffb300, inset -59px 0 0 #222, inset -61px 0 0 #ffb300,
                inset -64px 0 0 #222, inset -66px 0 0 #ffb300, inset -67px 0 0 #222,
                inset -68px 0 0 #ffb300, inset -69px 0 0 #222, inset -71px 0 0 #ffb300,
                inset -72px 0 0 #222, inset -73px 0 0 #ffb300, inset -75px 0 0 #222,
                inset -77px 0 0 #ffb300, inset -80px 0 0 #222, inset -82px 0 0 #ffb300,
                inset -83px 0 0 #222, inset -84px 0 0 #ffb300, inset -86px 0 0 #222,
                inset -88px 0 0 #ffb300, inset -89px 0 0 #222, inset -90px 0 0 #ffb300;
        }

        .ticket.business .barcode {
            background: #222;
            box-shadow:
                inset 0 1px 0 #d95e35, inset -2px 0 0 #d95e35,
                inset -4px 0 0 #222, inset -5px 0 0 #d95e35, inset -6px 0 0 #222,
                inset -9px 0 0 #d95e35, inset -12px 0 0 #222, inset -13px 0 0 #d95e35,
                inset -14px 0 0 #222, inset -15px 0 0 #d95e35, inset -16px 0 0 #222,
                inset -17px 0 0 #d95e35, inset -19px 0 0 #222, inset -20px 0 0 #d95e35,
                inset -23px 0 0 #222, inset -25px 0 0 #d95e35, inset -26px 0 0 #222,
                inset -26px 0 0 #d95e35, inset -27px 0 0 #222, inset -30px 0 0 #d95e35,
                inset -31px 0 0 #222, inset -33px 0 0 #d95e35, inset -35px 0 0 #222,
                inset -37px 0 0 #d95e35, inset -40px 0 0 #222, inset -43px 0 0 #d95e35,
                inset -44px 0 0 #222, inset -45px 0 0 #d95e35, inset -46px 0 0 #222,
                inset -48px 0 0 #d95e35, inset -49px 0 0 #222, inset -50px 0 0 #d95e35,
                inset -52px 0 0 #222, inset -54px 0 0 #d95e35, inset -55px 0 0 #222,
                inset -57px 0 0 #d95e35, inset -59px 0 0 #222, inset -61px 0 0 #d95e35,
                inset -64px 0 0 #222, inset -66px 0 0 #d95e35, inset -67px 0 0 #222,
                inset -68px 0 0 #d95e35, inset -69px 0 0 #222, inset -71px 0 0 #d95e35,
                inset -72px 0 0 #222, inset -73px 0 0 #d95e35, inset -75px 0 0 #222,
                inset -77px 0 0 #d95e35, inset -80px 0 0 #222, inset -82px 0 0 #d95e35,
                inset -83px 0 0 #222, inset -84px 0 0 #d95e35, inset -86px 0 0 #222,
                inset -88px 0 0 #d95e35, inset -89px 0 0 #222, inset -90px 0 0 #d95e35;
        }

        .slip {
            left: 455px;
        }

        .nameslip {
            top: 60px;
            left: 410px;
        }

        .flightslip {
            left: 410px;
        }

        .seatslip {
            left: 540px;
        }

        .jfkslip {
            font-size: 18px;
            font-weight: bold;
            top: 20px;
            left: 410px;
        }

        .sfoslip {
            font-size: 18px;
            font-weight: bold;
            top: 20px;
            left: 530px;
        }

        .planeslip {
            top: 10px;
            left: 495px;
        }

        .airlineslip {
            left: 455px;
        }

        .error-message {
            color: #d32f2f;
            text-align: center;
            margin-top: 20px;
            font-family: Arial, sans-serif;
            padding: 15px;
            background: #ffebee;
            border-radius: 6px;
            border-left: 4px solid #d32f2f;
        }

        .success-message {
            color: #2e7d32;
            text-align: center;
            margin-top: 20px;
            font-family: Arial, sans-serif;
            padding: 15px;
            background: #e8f5e9;
            border-radius: 6px;
            border-left: 4px solid #2e7d32;
        }

        .ticket-actions {
            display: flex;
            justify-content: flex-end;
            padding: 10px;
            gap: 10px;
        }

        .action-btn {
            padding: 8px 15px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }

        .download-btn {
            background: #3949ab;
            color: white;
        }

        .share-btn {
            background: #43a047;
            color: white;
        }

        .no-tickets {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        .no-tickets h3 {
            color: #666;
            margin-bottom: 15px;
        }

        .no-tickets p {
            color: #888;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>SkyLink Airlines</h1>
            <p class="subtitle">Manage Your Flight Tickets</p>
        </header>

        <section class="search-section">
            <h2>Retrieve Your Tickets</h2>
            <p>Enter your booking reference to retrieve your flight tickets</p>
            <form class="search-form" id="ticketForm">
                <div class="form-group">
                    <label for="bookingId">Booking Reference</label>
                    <input type="text" id="bookingId" placeholder="Enter your booking ID">
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" placeholder="Enter your last name">
                </div>
                <button type="button" onclick="retrieveTickets()">Retrieve Tickets</button>
            </form>
        </section>

        <section class="tickets-container" id="ticketsContainer">
            <div class="no-tickets" id="noTickets">
                <h3>No Tickets Yet</h3>
                <p>Enter your booking reference above to retrieve your flight tickets</p>
            </div>

            <!-- Sample tickets will be added here by JavaScript -->
        </section>
    </div>

    <script>
        // Sample ticket data
        const sampleTickets = [
            {
                passenger_name: "John Smith",
                seats_count: 2,
                flight_id: "SL1024",
                arrival_airport: "JFK",
                departure_airport: "LAX",
                departure_time: "14:30",
                ticket_class: "economy"
            },
            {
                passenger_name: "Sarah Johnson",
                seats_count: 1,
                flight_id: "SL2048",
                arrival_airport: "CDG",
                departure_airport: "LHR",
                departure_time: "09:15",
                ticket_class: "business"
            },
            {
                passenger_name: "Robert Williams",
                seats_count: 4,
                flight_id: "SL4096",
                arrival_airport: "DXB",
                departure_airport: "SIN",
                departure_time: "22:45",
                ticket_class: "first"
            }
        ];

        // Function to retrieve tickets (simulated)
        function retrieveTickets() {
            const bookingId = document.getElementById('bookingId').value;
            const lastName = document.getElementById('lastName').value;

            if (!bookingId || !lastName) {
                showError('Please enter both booking reference and last name');
                return;
            }

            // In a real application, you would fetch data from a server
            // Here we'll use sample data after a short delay to simulate network request
            showLoading();

            setTimeout(() => {
                // Clear any previous tickets and messages
                clearTickets();
                hideNoTickets();

                // Add sample tickets
                sampleTickets.forEach(ticket => {
                    addTicket(ticket);
                });

                showSuccess('Tickets retrieved successfully!');
            }, 1500);
        }

        // Function to add a ticket to the list
        function addTicket(ticketData) {
            const ticketsContainer = document.getElementById('ticketsContainer');
            const noTickets = document.getElementById('noTickets');

            // Hide the no tickets message if it's visible
            noTickets.style.display = 'none';

            // Create ticket element
            const ticketElement = document.createElement('div');
            ticketElement.className = `ticket ${ticketData.ticket_class}`;

            // Set ticket content
            ticketElement.innerHTML = `
                <span class="airline">SkyLink</span>
                <span class="airline airlineslip">SkyLink</span>
                <span class="boarding">Boarding Pass</span>
                <div class="content">
                    <span class="jfk">${ticketData.departure_airport}</span>
                    <span class="plane">
                        <svg clip-rule="evenodd" fill-rule="evenodd" height="40" width="40" image-rendering="optimizeQuality" shape-rendering="geometricPrecision" text-rendering="geometricPrecision" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
                            <g stroke="#222">
                                <line fill="none" stroke-linecap="round" stroke-width="30" x1="300" x2="55" y1="390" y2="390"/>
                                <path d="M98 325c-9 10 10 16 25 6l311-156c24-17 35-25 42-50 2-15-46-11-78-7-15 1-34 10-42 16l-56 35 1-1-169-31c-14-3-24-5-37-1-10 5-18 10-27 18l122 72c4 3 5 7 1 9l-44 27-75-15c-10-2-18-4-28 0-8 4-14 9-20 15l74 63z" fill="#222" stroke-linejoin="round" stroke-width="10"/>
                            </g>
                        </svg>
                    </span>
                    <span class="sfo">${ticketData.arrival_airport}</span>

                    <span class="jfk jfkslip">${ticketData.departure_airport}</span>
                    <span class="plane planeslip">
                        <svg clip-rule="evenodd" fill-rule="evenodd" height="35" width="35" image-rendering="optimizeQuality" shape-rendering="geometricPrecision" text-rendering="geometricPrecision" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg">
                            <g stroke="#222">
                                <line fill="none" stroke-linecap="round" stroke-width="30" x1="300" x2="55" y1="390" y2="390"/>
                                <path d="M98 325c-9 10 10 16 25 6l311-156c24-17 35-25 42-50 2-15-46-11-78-7-15 1-34 10-42 16l-56 35 1-1-169-31c-14-3-24-5-37-1-10 5-18 10-27 18l122 72c4 3 5 7 1 9l-44 27-75-15c-10-2-18-4-28 0-8 4-14 9-20 15l74 63z" fill="#222" stroke-linejoin="round" stroke-width="10"/>
                            </g>
                        </svg>
                    </span>
                    <span class="sfo sfoslip">${ticketData.arrival_airport}</span>

                    <div class="sub-content">
                        <span class="watermark">SkyLink</span>
                        <span class="name">PASSENGER NAME<br><span>${ticketData.passenger_name}</span></span>
                        <span class="flight">FLIGHT N°<br><span>${ticketData.flight_id}</span></span>
                        <span class="gate">GATE<br><span>11B</span></span>
                        <span class="seat">SEATS<br><span>${ticketData.seats_count}</span></span>
                        <span class="boardingtime">BOARDING TIME<br><span>${ticketData.departure_time}</span></span>
                        <span class="ticketclass">CLASS<br><span>${ticketData.ticket_class.toUpperCase()}</span></span>

                        <span class="flight flightslip">FLIGHT N°<br><span>${ticketData.flight_id}</span></span>
                        <span class="seat seatslip">SEATS<br><span>${ticketData.seats_count}</span></span>
                        <span class="name nameslip">PASSENGER NAME<br><span>${ticketData.passenger_name}</span></span>
                    </div>
                </div>
                <div class="barcode"></div>
                <div class="barcode slip"></div>
                <div class="ticket-actions">
                    <button class="action-btn download-btn" onclick="downloadTicket(this)">Download</button>
                    <button class="action-btn share-btn" onclick="shareTicket(this)">Share</button>
                </div>
            `;

            // Add the ticket to the container
            ticketsContainer.appendChild(ticketElement);
        }

        // Function to clear all tickets
        function clearTickets() {
            const ticketsContainer = document.getElementById('ticketsContainer');
            const tickets = ticketsContainer.querySelectorAll('.ticket');
            const messages = ticketsContainer.querySelectorAll('.error-message, .success-message');

            tickets.forEach(ticket => ticket.remove());
            messages.forEach(message => message.remove());
        }

        // Function to show error message
        function showError(message) {
            clearMessages();

            const errorElement = document.createElement('div');
            errorElement.className = 'error-message';
            errorElement.textContent = message;

            document.getElementById('ticketsContainer').appendChild(errorElement);
        }

        // Function to show success message
        function showSuccess(message) {
            clearMessages();

            const successElement = document.createElement('div');
            successElement.className = 'success-message';
            successElement.textContent = message;

            document.getElementById('ticketsContainer').appendChild(successElement);
        }

        // Function to clear all messages
        function clearMessages() {
            const messages = document.querySelectorAll('.error-message, .success-message');
            messages.forEach(message => message.remove());
        }

        // Function to show loading state
        function showLoading() {
            clearTickets();
            clearMessages();

            const loadingElement = document.createElement('div');
            loadingElement.className = 'no-tickets';
            loadingElement.innerHTML = '<h3>Loading your tickets...</h3><p>Please wait while we retrieve your flight information</p>';

            document.getElementById('ticketsContainer').appendChild(loadingElement);
        }

        // Function to hide no tickets message
        function hideNoTickets() {
            document.getElementById('noTickets').style.display = 'none';
        }

        // Function to download ticket (simulated)
        function downloadTicket(button) {
            const ticket = button.closest('.ticket');
            alert('Download functionality would be implemented here for ticket: ' +
                  ticket.querySelector('.name span').textContent);
        }

        // Function to share ticket (simulated)
        function shareTicket(button) {
            const ticket = button.closest('.ticket');
            alert('Share functionality would be implemented here for ticket: ' +
                  ticket.querySelector('.name span').textContent);
        }

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            // Add event listener for form submission
            document.getElementById('ticketForm').addEventListener('submit', function(e) {
                e.preventDefault();
                retrieveTickets();
            });
        });
    </script>
</body>
</html>