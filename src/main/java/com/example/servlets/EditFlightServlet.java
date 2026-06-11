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

public class EditFlightServlet extends HttpServlet {
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

        String flight_idStr = request.getParameter("flight_id");
        String departure_airport = request.getParameter("departure_airport");
        String arrival_airport = request.getParameter("arrival_airport");
        String departure_date = request.getParameter("departure_date");
        String flight_class = request.getParameter("flight_class");
        String passengersStr = request.getParameter("passengers");
        String available_seatsStr = request.getParameter("available_seats");
        String priceStr = request.getParameter("price");

        if (flight_idStr == null || departure_airport == null || arrival_airport == null || departure_date == null || flight_class == null || passengersStr == null || available_seatsStr == null || priceStr == null ||
                flight_idStr.isEmpty() || departure_airport.isEmpty() || arrival_airport.isEmpty() || departure_date.isEmpty() || flight_class.isEmpty() || passengersStr.isEmpty() || available_seatsStr.isEmpty() || priceStr.isEmpty()) {
            response.sendRedirect("edit_flight.jsp?message=Please fill all fields");
            return;
        }

        int flight_id = Integer.parseInt(flight_idStr);
        int passengers = Integer.parseInt(passengersStr);
        int available_seats = Integer.parseInt(available_seatsStr);
        double price = Double.parseDouble(priceStr);

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE Flights SET departure_airport = ?, arrival_airport = ?, departure_date = ?, flight_class = ?, passengers = ?, available_seats = ?, price = ? WHERE id = ?")) {
                stmt.setString(1, departure_airport);
                stmt.setString(2, arrival_airport);
                stmt.setString(3, departure_date);
                stmt.setString(4, flight_class);
                stmt.setInt(5, passengers);
                stmt.setInt(6, available_seats);
                stmt.setDouble(7, price);
                stmt.setInt(8, flight_id);
                int updated = stmt.executeUpdate();
                if (updated > 0) {
                    response.sendRedirect("scheduler_dashboard.jsp?message=Flight updated successfully");
                } else {
                    response.sendRedirect("edit_flight.jsp?message=Flight not found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("edit_flight.jsp?message=Error updating flight");
        }
    }
}