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

public class RetryServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!"finance_officer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String transaction_idStr = request.getParameter("id");

        if (transaction_idStr == null || transaction_idStr.isEmpty()) {
            response.sendRedirect("alerts.jsp?message=Invalid transaction ID");
            return;
        }

        int transaction_id = Integer.parseInt(transaction_idStr);

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE Transactions SET status = 'success' WHERE id = ? AND status = 'failed'")) {
                stmt.setInt(1, transaction_id);
                int updated = stmt.executeUpdate();
                if (updated > 0) {
                    response.sendRedirect("alerts.jsp?message=Transaction retried successfully");
                } else {
                    response.sendRedirect("alerts.jsp?message=Transaction not found or already processed");
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("alerts.jsp?message=Error retrying transaction");
        }
    }
}