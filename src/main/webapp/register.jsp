<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Register</title>
</head>
<body>
    <h2>Register</h2>
    <form action="register" method="post"> <!-- action="register" එක servlet එක point කරයි -->
        Username: <input type="text" name="username"><br>
        Password: <input type="password" name="password"><br>
        <input type="submit" value="Register">
    </form>
    <%
        // Success or error message (future එකේ use වෙයි)
        String message = request.getParameter("message");
        if (message != null) {
            out.println("<p>" + message + "</p>");
        }
    %>
</body>
</html>