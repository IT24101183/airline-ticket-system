<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Finance Manager Dashboard</title>
</head>
<body>
    <%
        // Check if user is logged in
        if (session.getAttribute("username") == null) {
            response.sendRedirect("login.jsp");
        }
    %>
    <h1>Welcome to Finance Manager Dashboard, <%= session.getAttribute("username") %>!</h1>
    <p>This is your finance overview.</p>
    <!-- Placeholders for future features -->
    <h2>Balance: $0.00</h2> <!-- Future: DB එකෙන් load කරන්න -->
    <h2>Recent Transactions:</h2> <!-- Future: Table add කරන්න -->
    <ul>
        <li>No transactions yet.</li>
    </ul>
    <a href="logout">Logout</a> <!-- ඊළඟ step එකේ LogoutServlet add වෙයි -->
</body>
</html>