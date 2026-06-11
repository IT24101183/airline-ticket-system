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

public class UpdatePaymentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null || !"finance_officer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            if ("confirm".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Transactions SET status = 'success' WHERE id = ?");
                stmt.setInt(1, id);
                stmt.executeUpdate();

                PreparedStatement bookingStmt = conn.prepareStatement("UPDATE Bookings SET status = 'paid' WHERE id = (SELECT booking_id FROM Transactions WHERE id = ?)");
                bookingStmt.setInt(1, id);
                bookingStmt.executeUpdate();
                conn.close();
                response.sendRedirect("pending_payments.jsp?message=Payment confirmed, customer notified");
            } else if ("reject".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("UPDATE Transactions SET status = 'failed' WHERE id = ?");
                stmt.setInt(1, id);
                stmt.executeUpdate();
                conn.close();
                response.sendRedirect("pending_payments.jsp?message=Payment rejected, customer notified");
            }
        } catch (SQLException e) {
            response.sendRedirect("pending_payments.jsp?message=Error: " + e.getMessage());
        }
    }
}