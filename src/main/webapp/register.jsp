<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SkyLink Register</title>
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Poly:400&display=swap" rel="stylesheet" />
    <style>
        :root {
            --black: #333333;
            --white: #ffffff;
            --gray-input: #dddddd;
            --red: #bd4242;
            --search-width: 1129px;
            --input-radius: 4px;
            --field-gap: 20px;
            --font-sans: "Poppins", sans-serif;
        }
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: var(--font-sans);
            background-color: var(--white);
            color: #111;
            line-height: 1.4;
        }
        .register-box {
            position: relative;
            width: 100%;
            max-width: var(--search-width);
            min-height: 450px;
            margin: 50px auto;
            background-color: var(--black);
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
            padding: 30px;
            color: var(--white);
        }
        .register-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 20px;
            text-align: center;
        }
        .register-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--field-gap);
        }
        @media (max-width: 768px) {
            .register-grid {
                grid-template-columns: 1fr;
            }
        }
        .register-field {
            position: relative;
        }
        .register-field input, .register-field select {
            width: 100%;
            height: 60px;
            padding: 10px;
            background-color: var(--gray-input);
            border: none;
            border-radius: var(--input-radius);
            font-size: 16px;
            color: #111;
        }
        .register-field label {
            display: block;
            margin-bottom: 8px;
            font-size: 16px;
        }
        .register-field label::after {
            content: "*";
            color: var(--red);
            margin-left: 4px;
        }
        .register-field label.optional::after {
            content: "";
        }
        .register-submit {
            grid-column: span 3;
            width: 100%;
            height: 60px;
            background-color: var(--red);
            color: var(--white);
            font-size: 16px;
            font-weight: 600;
            border: none;
            border-radius: var(--input-radius);
            cursor: pointer;
            margin-top: 20px;
            transition: filter 0.2s ease;
        }
        .register-submit:hover {
            filter: brightness(1.1);
        }
        .message {
            grid-column: span 3;
            text-align: center;
            font-size: 14px;
            margin-top: 10px;
        }
        .message.success {
            color: lightgreen;
        }
        .message.error {
            color: var(--red);
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
        }
        .login-link a {
            color: var(--red);
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <section class="register-box" aria-label="Register form">
        <h2 class="register-title">Create Your SkyLink Account</h2>
        <form action="register" method="post">
            <div class="register-grid">
                <div class="register-field">
                    <label for="first_name">First Name</label>
                    <input type="text" id="first_name" name="first_name" placeholder="Enter your first name" required />
                </div>
                <div class="register-field">
                    <label for="last_name">Last Name</label>
                    <input type="text" id="last_name" name="last_name" placeholder="Enter your last name" required />
                </div>
                <div class="register-field">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Enter your username" required />
                </div>
                <div class="register-field">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required />
                </div>
                <div class="register-field">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="Enter your email" required />
                </div>
                <div class="register-field">
                    <label for="phone_number">Phone Number</label>
                    <input type="text" id="phone_number" name="phone_number" placeholder="Enter your phone number" required />
                </div>
                <div class="register-field">
                    <label for="passport_number" class="optional">Passport Number</label>
                    <input type="text" id="passport_number" name="passport_number" placeholder="Enter your passport number" />
                </div>
                <div class="register-field">
                    <label for="role">Role</label>
                    <select id="role" name="role" required>
                        <option value="customer">Customer</option>
                        <option value="finance_officer">Finance Officer</option>
                        <!-- Add other roles later -->
                    </select>
                </div>
            </div>
            <%
                String message = request.getParameter("message");
                if (message != null) {
                    if (message.toLowerCase().contains("success")) {
                        out.println("<p class='message success'>" + message + "</p>");
                    } else {
                        out.println("<p class='message error'>" + message + "</p>");
                    }
                }
            %>
            <button type="submit" class="register-submit">Register</button>
        </form>
        <div class="login-link">
            Already have an account? <a href="login.jsp">Login here</a>
        </div>
    </section>
</body>
</html>