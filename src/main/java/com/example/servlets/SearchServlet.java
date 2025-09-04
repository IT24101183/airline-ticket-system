package com.example.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SearchServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String departure_airport = request.getParameter("departure_airport");
        String arrival_airport = request.getParameter("arrival_airport");
        String departure_date = request.getParameter("departure_date");
        String flight_class = request.getParameter("flight_class");
        String passengersStr = request.getParameter("passengers");

        if (departure_airport == null || arrival_airport == null || departure_date == null || flight_class == null || passengersStr == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        int passengers = Integer.parseInt(passengersStr);

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Flights WHERE departure_airport = ? AND arrival_airport = ? AND departure_date = ? AND flight_class = ? AND available_seats >= ?");
                stmt.setString(1, departure_airport);
                stmt.setString(2, arrival_airport);
                stmt.setDate(3, java.sql.Date.valueOf(departure_date));
                stmt.setString(4, flight_class);
                stmt.setInt(5, passengers);
                ResultSet rs = stmt.executeQuery();

                request.setAttribute("results", rs);
                RequestDispatcher dispatcher = request.getRequestDispatcher("results.jsp");
                dispatcher.forward(request, response);
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?message=Error searching flights");
        }
    }
}