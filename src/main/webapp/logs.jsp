<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Payment Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"finance_officer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
        String dbUser = "sa";
        String dbPassword = "789";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            stmt = conn.prepareStatement("SELECT id, transaction_id, log_message, log_date FROM PaymentLogs ORDER BY log_date DESC");
            rs = stmt.executeQuery();
    %>
    <h2>Payment Logs</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Transaction ID</th>
            <th>Log Message</th>
            <th>Date</th>
        </tr>
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getInt("transaction_id") %></td>
            <td><%= rs.getString("log_message") %></td>
            <td><%= rs.getTimestamp("log_date") %></td>
        </tr>
        <%
            }
            if (!hasData) {
                out.println("<tr><td colspan='4'>No payment logs available.</td></tr>");
            }
        %>
    </table>
    <%
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p>Error viewing logs.</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
    <a href="finance_dashboard.jsp">Back to Dashboard</a>
</body>
</html>