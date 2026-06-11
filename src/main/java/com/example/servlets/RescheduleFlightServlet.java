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

public class RescheduleFlightServlet extends HttpServlet {
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
        String new_departure_date = request.getParameter("new_departure_date");

        if (flight_idStr == null || new_departure_date == null || flight_idStr.isEmpty() || new_departure_date.isEmpty()) {
            response.sendRedirect("reschedule_flight.jsp?message=Please fill all fields");
            return;
        }

        int flight_id = Integer.parseInt(flight_idStr);

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE Flights SET departure_date = ? WHERE id = ?")) {
                stmt.setString(1, new_departure_date);
                stmt.setInt(2, flight_id);
                int updated = stmt.executeUpdate();
                if (updated > 0) {
                    response.sendRedirect("scheduler_dashboard.jsp?message=Flight rescheduled successfully");
                } else {
                    response.sendRedirect("reschedule_flight.jsp?message=Flight not found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("reschedule_flight.jsp?message=Error rescheduling flight");
        }
    }
}