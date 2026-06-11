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

public class UpdateSeatsServlet extends HttpServlet {
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
        String new_available_seatsStr = request.getParameter("new_available_seats");

        if (flight_idStr == null || new_available_seatsStr == null || flight_idStr.isEmpty() || new_available_seatsStr.isEmpty()) {
            response.sendRedirect("update_seats.jsp?message=Please fill all fields");
            return;
        }

        int flight_id = Integer.parseInt(flight_idStr);
        int new_available_seats = Integer.parseInt(new_available_seatsStr);

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE Flights SET available_seats = ? WHERE id = ?")) {
                stmt.setInt(1, new_available_seats);
                stmt.setInt(2, flight_id);
                int updated = stmt.executeUpdate();
                if (updated > 0) {
                    response.sendRedirect("scheduler_dashboard.jsp?message=Seats updated successfully");
                } else {
                    response.sendRedirect("update_seats.jsp?message=Flight not found");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("update_seats.jsp?message=Error updating seats");
        }
    }
}