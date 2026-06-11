<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Pending Payments</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"finance_officer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <div class="container mt-5">
        <h1>Pending Payments</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>User ID</th>
                    <th>Amount</th>
                    <th>Payment Method</th>
                    <th>Booking ID</th>
                    <th>Transaction Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;", "sa", "789");
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Transactions WHERE status = 'pending'");
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getInt("user_id") + "</td>");
                            out.println("<td>" + rs.getDouble("amount") + "</td>");
                            out.println("<td>" + rs.getString("payment_method") + "</td>");
                            out.println("<td>" + rs.getInt("booking_id") + "</td>");
                            out.println("<td>" + rs.getTimestamp("transaction_date") + "</td>");
                            out.println("<td><a href='UpdatePaymentServlet?action=confirm&id=" + rs.getInt("id") + "' class='btn btn-success btn-sm'>Confirm</a> " +
                                        "<a href='UpdatePaymentServlet?action=reject&id=" + rs.getInt("id") + "' class='btn btn-danger btn-sm' onclick='return confirm(\"Are you sure?\")'>Reject</a></td>");
                            out.println("</tr>");
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (Exception e) {
                        out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>
        <a href="finance_dashboard.jsp" class="btn btn-secondary">Back</a>
        <%
            String message = request.getParameter("message");
            if (message != null) {
                out.println("<p class='text-success mt-3'>" + message + "</p>");
            }
        %>
    </div>
</body>
</html>