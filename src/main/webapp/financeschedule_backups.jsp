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
        <h2 class="text-center">Schedule Backups</h2>
        <form action="schedule_backup" method="post" class="w-75 mx-auto">
            <div class="mb-3">
                <label class="form-label">Backup Frequency:</label>
                <select name="frequency" class="form-select" required>
                    <option value="daily">Daily</option>
                    <option value="weekly">Weekly</option>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label">Backup Time:</label>
                <input type="time" name="backup_time" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary w-100">Schedule Backup</button>
        </form>
        <%
            String message = request.getParameter("message");
            if (message != null) {
                out.println("<p class='text-center mt-3'>" + message + "</p>");
            }
        %>
        <a href="admin_dashboard.jsp" class="d-block text-center mt-3">Back to Dashboard</a>
    </div>
</body>
</html>