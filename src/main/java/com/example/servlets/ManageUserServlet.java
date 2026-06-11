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

public class ManageUserServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
    private static final String DB_USER = "sa";
    private static final String DB_PASSWORD = "789";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));

        if ("delete".equals(action)) {
            try {
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM Users WHERE id = ?");
                stmt.setInt(1, id);
                stmt.executeUpdate();
                conn.close();
                response.sendRedirect("manage_users.jsp");
            } catch (SQLException e) {
                response.sendRedirect("manage_users.jsp?message=Error deleting user: " + e.getMessage());
            }
        } else if ("edit".equals(action)) {
            try {
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Users WHERE id = ?");
                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    String username = rs.getString("username");
                    String first_name = rs.getString("first_name");
                    String last_name = rs.getString("last_name");
                    String email = rs.getString("email");
                    String role = rs.getString("role");
                    rs.close();
                    stmt.close();
                    conn.close();
                    // Redirect with parameters to edit_user.jsp
                    response.sendRedirect("edit_user.jsp?id=" + id + "&username=" + username + "&first_name=" + first_name +
                            "&last_name=" + last_name + "&email=" + email + "&role=" + role);
                }
            } catch (SQLException e) {
                response.sendRedirect("manage_users.jsp?message=Error fetching user: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String first_name = request.getParameter("first_name");
        String last_name = request.getParameter("last_name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

        if ("update".equals(action)) {
            try {
                Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE Users SET username = ?, first_name = ?, last_name = ?, email = ?, role = ? WHERE id = ?");
                stmt.setString(1, username);
                stmt.setString(2, first_name);
                stmt.setString(3, last_name);
                stmt.setString(4, email);
                stmt.setString(5, role);
                stmt.setInt(6, id);
                stmt.executeUpdate();
                conn.close();
                response.sendRedirect("manage_users.jsp?message=User updated successfully");
            } catch (SQLException e) {
                response.sendRedirect("manage_users.jsp?message=Error updating user: " + e.getMessage());
            }
        }
    }
}