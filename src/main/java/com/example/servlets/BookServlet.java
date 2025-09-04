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
import java.sql.ResultSet;
import java.sql.SQLException;

public class BookServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String role = (String) session.getAttribute("role");
        Integer user_id = (Integer) session.getAttribute("user_id");

        System.out.println("User ID: " + user_id + ", Role: " + role);

        if (user_id == null || !"customer".equals(role)) {
            System.out.println("Role check failed - redirecting to login");
            response.sendRedirect("login.jsp");
            return;
        }

        System.out.println("Role check passed - starting DB operations");

        String flight_idStr = request.getParameter("flight_id");
        String seatsStr = request.getParameter("seats");

        if (flight_idStr == null || seatsStr == null) {
            System.out.println("Parameters missing - redirect to index");
            response.sendRedirect("index.jsp");
            return;
        }

        int flight_id = Integer.parseInt(flight_idStr);
        int seats = Integer.parseInt(seatsStr);

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                System.out.println("DB connection success");

                // Check available seats
                PreparedStatement checkStmt = conn.prepareStatement("SELECT available_seats, price FROM Flights WHERE id = ?");
                checkStmt.setInt(1, flight_id);
                ResultSet rs = checkStmt.executeQuery();
                if (rs.next()) {
                    int available = rs.getInt("available_seats");
                    double price = rs.getDouble("price");
                    System.out.println("Checked available seats: available = " + available + ", price = " + price);
                    if (available < seats) {
                        System.out.println("Not enough seats - redirect");
                        response.sendRedirect("book.jsp?flight_id=" + flight_id + "&message=Not enough seats");
                        return;
                    }
                    double total_price = price * seats;

                    // Insert booking and fetch generated booking_id via OUTPUT Inserted.id for SQL Server reliability
                    System.out.println("Executing insert for booking");
                    PreparedStatement insertStmt = conn.prepareStatement(
                            "INSERT INTO Bookings (user_id, flight_id, seats, total_price) OUTPUT Inserted.id VALUES (?, ?, ?, ?)"
                    );
                    insertStmt.setInt(1, user_id);
                    insertStmt.setInt(2, flight_id);
                    insertStmt.setInt(3, seats);
                    insertStmt.setDouble(4, total_price);
                    ResultSet insertedRs = insertStmt.executeQuery();
                    System.out.println("Booking inserted successfully");

                    int booking_id = 0;
                    if (insertedRs != null && insertedRs.next()) {
                        booking_id = insertedRs.getInt(1);
                        System.out.println("Generated booking_id: " + booking_id);
                    } else {
                        System.out.println("Failed to retrieve booking_id from OUTPUT");
                    }

                    // Update flights available seats
                    System.out.println("Updating flights seats");
                    PreparedStatement updateStmt = conn.prepareStatement("UPDATE Flights SET available_seats = available_seats - ? WHERE id = ?");
                    updateStmt.setInt(1, seats);
                    updateStmt.setInt(2, flight_id);
                    updateStmt.executeUpdate();
                    System.out.println("Flights updated successfully");

                    if (booking_id == 0) {
                        System.out.println("Booking ID 0 - attempting fallback lookup by user and flight");
                        PreparedStatement findStmt = conn.prepareStatement("SELECT TOP 1 id FROM Bookings WHERE user_id = ? AND flight_id = ? ORDER BY id DESC");
                        findStmt.setInt(1, user_id);
                        findStmt.setInt(2, flight_id);
                        ResultSet findRs = findStmt.executeQuery();
                        if (findRs.next()) {
                            booking_id = findRs.getInt("id");
                            System.out.println("Fallback found booking_id: " + booking_id);
                        }
                    }

                    if (booking_id == 0) {
                        System.out.println("Booking ID still 0 after fallback - redirect with error");
                        response.sendRedirect("book.jsp?flight_id=" + flight_id + "&message=Error fetching booking ID");
                        return;
                    }

                    System.out.println("Redirecting to process_payment.jsp with booking_id=" + booking_id + "&amount=" + total_price);
                    response.sendRedirect(request.getContextPath() + "/process_payment.jsp?booking_id=" + booking_id + "&amount=" + total_price);
                } else {
                    System.out.println("Flight not found - redirect");
                    response.sendRedirect("index.jsp?message=Flight not found");
                }
            }
        } catch (SQLException e) {
            System.out.println("DB Error (SQL): " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("book.jsp?flight_id=" + flight_id + "&message=Error booking - SQL issue: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            System.out.println("Driver Error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("book.jsp?flight_id=" + flight_id + "&message=Error booking - Driver issue: " + e.getMessage());
        } catch (Exception e) {
            System.out.println("General Error: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("book.jsp?flight_id=" + flight_id + "&message=Error booking: " + e.getMessage());
        }
    }
}