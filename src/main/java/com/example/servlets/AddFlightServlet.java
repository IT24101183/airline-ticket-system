package com.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AddFlightServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!"flight_scheduler".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String departure_airport = request.getParameter("departure_airport");
        String arrival_airport = request.getParameter("arrival_airport");
        String departure_date = request.getParameter("departure_date");
        String departure_time = request.getParameter("departure_time");
        String flight_class = request.getParameter("flight_class");
        String passengersStr = request.getParameter("passengers");
        String available_seatsStr = request.getParameter("available_seats");
        String priceStr = request.getParameter("price");

        // Fixed null check for departure_time
        if (departure_airport == null || arrival_airport == null || departure_date == null || departure_time == null ||
                flight_class == null || passengersStr == null || available_seatsStr == null || priceStr == null ||
                departure_airport.isEmpty() || arrival_airport.isEmpty() || departure_date.isEmpty() ||
                departure_time.isEmpty() || flight_class.isEmpty() || passengersStr.isEmpty() ||
                available_seatsStr.isEmpty() || priceStr.isEmpty()) {
            response.sendRedirect("add_flight.jsp?message=Please fill all fields");
            return;
        }

        try {
            int passengers = Integer.parseInt(passengersStr);
            int available_seats = Integer.parseInt(available_seatsStr);
            double price = Double.parseDouble(priceStr);

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            // Fixed SQL query - corrected column count and parameter mapping
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO Flights (departure_airport, arrival_airport, departure_date, departure_time, flight_class, passengers, available_seats, price) VALUES (?, ?, ?, ?, ?, ?, ?, ?)")) {

                stmt.setString(1, departure_airport);
                stmt.setString(2, arrival_airport);
                stmt.setString(3, departure_date);
                stmt.setString(4, departure_time);  // Fixed: now using departure_time instead of duplicate departure_date
                stmt.setString(5, flight_class);
                stmt.setInt(6, passengers);
                stmt.setInt(7, available_seats);
                stmt.setDouble(8, price);

                stmt.executeUpdate();
                response.sendRedirect("scheduler_dashboard.jsp?message=Flight added successfully");
            }
        } catch (NumberFormatException e) {
            // Added specific handling for number parsing errors
            e.printStackTrace();
            response.sendRedirect("add_flight.jsp?message=Invalid number format");
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("add_flight.jsp?message=Error adding flight");
        }
    }
}