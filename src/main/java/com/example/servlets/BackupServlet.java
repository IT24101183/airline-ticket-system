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
import java.sql.Timestamp;

public class BackupServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String backup_date = request.getParameter("backup_date") + " " + request.getParameter("backup_time") + ":00";
        Timestamp schedule_time = Timestamp.valueOf(backup_date);

        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO BackupLogs (schedule_time, status) VALUES (?, ?)");
            stmt.setTimestamp(1, schedule_time);
            stmt.setString(2, "Scheduled");
            stmt.executeUpdate();
            conn.close();
            response.sendRedirect("schedule_backups.jsp?message=Backup scheduled successfully at " + backup_date);
        } catch (SQLException e) {
            response.sendRedirect("schedule_backups.jsp?message=Error scheduling backup: " + e.getMessage());
        }
    }
}