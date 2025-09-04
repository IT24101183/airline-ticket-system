<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Daily Transaction Reports</title>
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
            stmt = conn.prepareStatement("SELECT id, user_id, amount, payment_method, status, transaction_date, booking_id FROM Transactions WHERE CONVERT(DATE, transaction_date) = CONVERT(DATE, GETDATE())");
            rs = stmt.executeQuery();
    %>
    <h2>Daily Transaction Report (Today)</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>User ID</th>
            <th>Amount</th>
            <th>Payment Method</th>
            <th>Status</th>
            <th>Date</th>
            <th>Booking ID</th>
        </tr>
        <%
            boolean hasData = false;
            while (rs.next()) {
                hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getInt("user_id") %></td>
            <td><%= rs.getDouble("amount") %></td>
            <td><%= rs.getString("payment_method") %></td>
            <td><%= rs.getString("status") %></td>
            <td><%= rs.getTimestamp("transaction_date") %></td>
            <td><%= rs.getObject("booking_id") != null ? rs.getInt("booking_id") : "N/A" %></td>
        </tr>
        <%
            }
            if (!hasData) {
                out.println("<tr><td colspan='7'>No transactions today.</td></tr>");
            }
        %>
    </table>
    <%
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p>Error generating report.</p>");
        } finally {
            if (rs != null) rs.close();
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    %>
    <a href="finance_dashboard.jsp">Back to Dashboard</a>
</body>
</html>