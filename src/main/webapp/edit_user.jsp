<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Edit User</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
        String id = request.getParameter("id");
        String username = "", first_name = "", last_name = "", email = "", role = "";

        if (id != null) {
            try {
                Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                Connection conn = DriverManager.getConnection("jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;", "sa", "789");
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM Users WHERE id = ?");
                stmt.setInt(1, Integer.parseInt(id));
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    username = rs.getString("username");
                    first_name = rs.getString("first_name");
                    last_name = rs.getString("last_name");
                    email = rs.getString("email");
                    role = rs.getString("role");
                }
                rs.close();
                stmt.close();
                conn.close();
            } catch (Exception e) {
                out.println("<p class='text-danger'>Error: " + e.getMessage() + "</p>");
            }
        }
    %>
    <div class="container mt-5">
        <h1>Edit User</h1>
        <form action="ManageUserServlet" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <input type="hidden" name="action" value="update">
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="username" class="form-control" value="<%= username %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">First Name</label>
                <input type="text" name="first_name" class="form-control" value="<%= first_name %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Last Name</label>
                <input type="text" name="last_name" class="form-control" value="<%= last_name %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="<%= email %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Role</label>
                <select name="role" class="form-select" required>
                    <option value="customer" <%= "customer".equals(role) ? "selected" : "" %>>Customer</option>
                    <option value="it_admin" <%= "it_admin".equals(role) ? "selected" : "" %>>IT Admin</option>
                    <option value="finance_officer" <%= "finance_officer".equals(role) ? "selected" : "" %>>Finance Officer</option>
                    <option value="flight_scheduler" <%= "flight_scheduler".equals(role) ? "selected" : "" %>>Flight Scheduler</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Save Changes</button>
            <a href="manage_users.jsp" class="btn btn-secondary">Cancel</a>
        </form>
    </div>
</body>
</html>