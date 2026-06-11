<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h2>Login</h2>
    <form action="login" method="post"> <!-- action="login" එක servlet එක point කරයි -->
        Username: <input type="text" name="username"><br>
        Password: <input type="password" name="password"><br>
        <input type="submit" value="Login">
    </form>
    <%
        // Error message show කිරීමට (future එකේ use වෙයි)
        String error = request.getParameter("error");
        if ("true".equals(error)) {
            out.println("<p style='color:red;'>Invalid username or password!</p>");
        }
    %>
</body>
</html>