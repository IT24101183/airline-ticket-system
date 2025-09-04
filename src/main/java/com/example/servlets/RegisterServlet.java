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
import java.sql.ResultSet;

public class RegisterServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone_number = request.getParameter("phone_number");
        String passport_number = request.getParameter("passport_number");
        String role = request.getParameter("role");

        // Validate required fields
        if (first_name == null || last_name == null || username == null || password == null || email == null || phone_number == null || role == null ||
                first_name.isEmpty() || last_name.isEmpty() || username.isEmpty() || password.isEmpty() || email.isEmpty() || phone_number.isEmpty() || role.isEmpty()) {
            response.sendRedirect("register.jsp?message=Please fill all required fields");
            return;
        }

        // Basic email format check
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect("register.jsp?message=Invalid email format");
            return;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Check for duplicate email
                PreparedStatement emailCheck = conn.prepareStatement("SELECT COUNT(*) FROM Users WHERE email = ?");
                emailCheck.setString(1, email);
                ResultSet rs = emailCheck.executeQuery();
                rs.next();
                if (rs.getInt(1) > 0) {
                    response.sendRedirect("register.jsp?message=Email already exists");
                    return;
                }

                // Insert new user
                PreparedStatement stmt = conn.prepareStatement(
                        "INSERT INTO Users (first_name, last_name, username, password, email, phone_number, passport_number, role) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
                stmt.setString(1, first_name);
                stmt.setString(2, last_name);
                stmt.setString(3, username);
                stmt.setString(4, password); // Future: hash password
                stmt.setString(5, email);
                stmt.setString(6, phone_number);
                stmt.setString(7, passport_number != null && !passport_number.isEmpty() ? passport_number : null);
                stmt.setString(8, role);
                stmt.executeUpdate();
                response.sendRedirect("login.jsp?message=Registration successful! Please login.");
            }
        } catch (SQLException e) {
            if (e.getErrorCode() == 2601 || e.getErrorCode() == 2627) { // Unique constraint (username)
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