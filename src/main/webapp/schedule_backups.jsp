<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Schedule Backups</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>
    <div class="container mt-5">
        <h1>Schedule Backups</h1>
        <form action="BackupServlet" method="post">
            <div class="mb-3">
                <label class="form-label">Backup Date</label>
                <input type="date" name="backup_date" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Backup Time</label>
                <input type="time" name="backup_time" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Schedule Backup</button>
            <a href="admin_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
        </form>
        <%
            String message = request.getParameter("message");
            if (message != null) {
                out.println("<p class='text-success mt-3'>" + message + "</p>");
            }
        %>
    </div>
</body>
</html>