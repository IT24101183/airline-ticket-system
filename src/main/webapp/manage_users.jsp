<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Manage User Accounts</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <div class="container mt-5">
        <h1>Manage User Accounts</h1>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    try {
                        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;", "sa", "789");
                        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Users");
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            out.println("<tr>");
                            out.println("<td>" + rs.getInt("id") + "</td>");
                            out.println("<td>" + rs.getString("username") + "</td>");
                            out.println("<td>" + rs.getString("first_name") + "</td>");
                            out.println("<td>" + rs.getString("last_name") + "</td>");
                            out.println("<td>" + rs.getString("email") + "</td>");
                            out.println("<td>" + rs.getString("role") + "</td>");
                            out.println("<td><a href='ManageUserServlet?action=edit&id=" + rs.getInt("id") + "' class='btn btn-warning btn-sm'>Edit</a> " +
                                        "<a href='ManageUserServlet?action=delete&id=" + rs.getInt("id") + "' class='btn btn-danger btn-sm' onclick='return confirm(\"Are you sure?\")'>Delete</a></td>");
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
        <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
    </div>
</body>
</html>