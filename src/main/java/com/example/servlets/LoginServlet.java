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
import java.net.URLEncoder;

public class LoginServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null || username.isEmpty() || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=true");
            return;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT id, role FROM Users WHERE username = ? AND password = ?")) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("user_id", rs.getInt("id"));
                    session.setAttribute("role", rs.getString("role"));
                    String redirect = request.getParameter("redirect");
                    if (redirect != null && !redirect.isEmpty()) {
                        response.sendRedirect(redirect);
                    } else if ("finance_officer".equals(rs.getString("role"))) {
                        response.sendRedirect("finance_dashboard.jsp");
                    } else {
                        response.sendRedirect("dashboard.jsp");
                    }
                } else {
                    String errorRedirect = "login.jsp?error=true";
                    if (request.getParameter("redirect") != null) {
                        errorRedirect += "&redirect=" + URLEncoder.encode(request.getParameter("redirect"), "UTF-8");
                    }
                    response.sendRedirect(errorRedirect);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=true");
        }
    }
}