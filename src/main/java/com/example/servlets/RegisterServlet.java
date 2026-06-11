package com.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class RegisterServlet extends HttpServlet {
    // DB connection details (ඔබේ details එක use කරලා)
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("register.jsp?message=Please fill all fields");
            return;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("INSERT INTO Users (username, password) VALUES (?, ?)")) {
                stmt.setString(1, username);
                stmt.setString(2, password); // Note: Plain text - future එකේ hash කරන්න
                stmt.executeUpdate();
                response.sendRedirect("login.jsp?message=Registration successful! Please login.");
            }
        } catch (SQLException e) {
            if (e.getErrorCode() == 2601 || e.getErrorCode() == 2627) { // Unique constraint error
                response.sendRedirect("register.jsp?message=Username already exists");
            } else {
                e.printStackTrace();
                response.sendRedirect("register.jsp?message=Error during registration");
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?message=Database driver error");
        }
    }
}