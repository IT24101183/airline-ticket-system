package com.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class financeBackupServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (!"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String frequency = request.getParameter("frequency");
        String backup_time = request.getParameter("backup_time");

        if (frequency == null || backup_time == null || frequency.isEmpty() || backup_time.isEmpty()) {
            response.sendRedirect("schedule_backups.jsp?message=Please fill all fields");
            return;
        }

        // Simulate backup scheduling (log or save to DB, real backup in future)
        // For example, print to console
        System.out.println("Backup scheduled: Frequency = " + frequency + ", Time = " + backup_time);

        response.sendRedirect("admin_dashboard.jsp?message=Backup scheduled successfully");
    }
}