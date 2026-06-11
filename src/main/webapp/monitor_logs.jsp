<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Monitor Performance Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <div class="container mt-5">
        <h1>Monitor Performance Logs</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Log Type</th>
                    <th>ID</th>
                    <th>Time</th>
                    <th>Details</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;", "sa", "789");

                        // Backup Logs
                        PreparedStatement backupStmt = conn.prepareStatement("SELECT id, schedule_time, status FROM BackupLogs");
                        ResultSet backupRs = backupStmt.executeQuery();
                        while (backupRs.next()) {
                            out.println("<tr>");
                            out.println("<td>Backup</td>");
                            out.println("<td>" + backupRs.getInt("id") + "</td>");
                            out.println("<td>" + backupRs.getTimestamp("schedule_time") + "</td>");
                            out.println("<td>" + backupRs.getString("status") + "</td>");
                            out.println("</tr>");
                        }
                        backupRs.close();

                        // Transaction Logs
                        PreparedStatement transStmt = conn.prepareStatement("SELECT id, transaction_date, status FROM Transactions");
                        ResultSet transRs = transStmt.executeQuery();
                        while (transRs.next()) {
                            out.println("<tr>");
                            out.println("<td>Transaction</td>");
                            out.println("<td>" + transRs.getInt("id") + "</td>");
                            out.println("<td>" + transRs.getTimestamp("transaction_date") + "</td>");
                            out.println("<td>" + transRs.getString("status") + "</td>");
                            out.println("</tr>");
                        }
                        transRs.close();

                        conn.close();
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>
        <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</body>
</html>