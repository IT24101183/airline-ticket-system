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
// import java.util.Random; // Removed: no longer simulating random outcomes

public class PaymentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("role") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Integer user_id = (Integer) session.getAttribute("user_id");
        String amountStr = request.getParameter("amount");
        String payment_method = request.getParameter("payment_method");
        String booking_idStr = request.getParameter("booking_id");

        if (amountStr == null || amountStr.isEmpty() || booking_idStr == null || booking_idStr.isEmpty()) {
            response.sendRedirect("process_payment.jsp?message=Amount and booking ID are required");
            return;
        }

        double amount = Double.parseDouble(amountStr);
        int booking_id = Integer.parseInt(booking_idStr);

        // Always treat payments as successful (disable random simulation)
        String status = "success";

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Insert transaction
                PreparedStatement stmt = conn.prepareStatement("INSERT INTO Transactions (user_id, amount, payment_method, status, booking_id) VALUES (?, ?, ?, ?, ?)");
                stmt.setInt(1, user_id);
                stmt.setDouble(2, amount);
                stmt.setString(3, payment_method);
                stmt.setString(4, status);
                stmt.setInt(5, booking_id);
                stmt.executeUpdate();

                // Get transaction_id
                int transaction_id = 0;
                PreparedStatement idStmt = conn.prepareStatement("SELECT SCOPE_IDENTITY() AS id");
                ResultSet idRs = idStmt.executeQuery();
                if (idRs.next()) {
                    transaction_id = idRs.getInt("id");
                }

                if ("success".equals(status)) {
                    // Update booking status to 'paid'
                    PreparedStatement updateBooking = conn.prepareStatement("UPDATE Bookings SET status = 'paid' WHERE id = ? AND user_id = ?");
                    updateBooking.setInt(1, booking_id);
                    updateBooking.setInt(2, user_id); // Security: only user's booking
                    int updated = updateBooking.executeUpdate();
                    if (updated > 0) {
                        response.sendRedirect(request.getContextPath() + "/ticket.jsp?booking_id=" + booking_id + "&message=Payment successful");
                    } else {
                        response.sendRedirect("process_payment.jsp?message=Booking not found");
                    }
                } else {
                    // If failed, add log
                    PreparedStatement logStmt = conn.prepareStatement("INSERT INTO PaymentLogs (transaction_id, log_message) VALUES (?, ?)");
                    logStmt.setInt(1, transaction_id);
                    logStmt.setString(2, "Payment failed for amount " + amount + " (Booking ID: " + booking_id + ")");
                    logStmt.executeUpdate();
                    response.sendRedirect("process_payment.jsp?message=Payment processed: " + status);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("process_payment.jsp?message=Error processing payment: " + e.getMessage());
        }
    }
}