<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.ResultSet" %>
<html>
<head>
    <title>Flight Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            background-color: #000; /* Black background */
            color: #f1f1f1;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #ffffff;
            font-weight: 600;
        }

        .table {
            background: #1c1c1c; /* dark table background */
            border-radius: 10px;
            overflow: hidden;
        }

        .table th {
            background: #222;
            color: #fff;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .table td {
            vertical-align: middle;
        }

        .btn-custom-red {
            background-color: #bd4242;
            border: none;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-custom-red:hover {
            background-color: #a83232;
        }

        .btn-secondary {
            background-color: #333;
            border: none;
        }

        .btn-secondary:hover {
            background-color: #444;
        }

        .container-box {
            max-width: 1100px;
            margin: auto;
            padding: 30px;
        }
    </style>
</head>
<body>
<div class="container-box">
    <h2>Flight Search Results</h2>
    <%
        ResultSet rs = (ResultSet) request.getAttribute("results");
        if (rs != null) {
            boolean hasResults = false;
    %>
    <table class="table table-dark table-striped text-center">
        <tr>
            <th>ID</th>
            <th>Departure</th>
            <th>Arrival</th>
            <th>Date</th>
            <th>Class</th>
            <th>Seats</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        <%
            while (rs.next()) {
                hasResults = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("departure_airport") %></td>
            <td><%= rs.getString("arrival_airport") %></td>
            <td><%= rs.getDate("departure_date") %></td>
            <td><%= rs.getString("flight_class") %></td>
            <td><%= rs.getInt("available_seats") %></td>
            <td>$<%= rs.getDouble("price") %></td>
            <td>
                <%
                    if (session.getAttribute("username") != null && "customer".equals(session.getAttribute("role"))) {
                %>
                <a href="book.jsp?flight_id=<%= rs.getInt("id") %>" class="btn btn-custom-red">Book</a>
                <%
                    } else {
                        String redirect = "book.jsp?flight_id=" + rs.getInt("id");
                %>
                <a href="login.jsp?redirect=<%= java.net.URLEncoder.encode(redirect, "UTF-8") %>" class="btn btn-custom-red">Book</a>
                <%
                    }
                %>
            </td>
        </tr>
        <%
            }
            if (!hasResults) {
                out.println("<tr><td colspan='8'>No flights found.</td></tr>");
            }
        %>
    </table>
    <%
        } else {
            out.println("<p>No results.</p>");
        }
    %>
    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-secondary">⬅ Back to Home</a>
    </div>
</div>
</body>
</html>
