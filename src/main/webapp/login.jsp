<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>SkyLink Login</title>
    <!-- Google Fonts -->
    <link
      href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&family=Poly:400&display=swap"
      rel="stylesheet"
    />
    <style>
      :root {
        --black: #333333;
        --white: #ffffff;
        --gray-input: #dddddd;
        --red: #bd4242;
        --input-radius: 4px;
        --field-gap: 20px;
        --logo-width: 157px;
        --logo-height: 150px;
        --logo-inner-size: 150px;
        --font-sans: "Poppins", sans-serif;
        --font-serif: "Poly", serif;
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

      .login-box {
        width: 100%;
        max-width: 500px;
        margin: 80px auto;
        background-color: var(--black);
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
        padding: 30px;
        color: var(--white);
      }

      .login-title {
        font-size: 24px;
        font-weight: 600;
        margin-bottom: 20px;
        text-align: center;
      }

      .login-field {
        margin-bottom: var(--field-gap);
      }
      .login-field label {
        display: block;
        margin-bottom: 8px;
        font-size: 16px;
      }
      .login-field input {
        width: 100%;
        height: 50px;
        padding: 10px;
        background-color: var(--gray-input);
        border: none;
        border-radius: var(--input-radius);
        font-size: 16px;
        color: #111;
      }

      .login-submit {
        width: 100%;
        height: 50px;
        background-color: var(--red);
        color: var(--white);
        font-size: 16px;
        font-weight: 600;
        border: none;
        border-radius: var(--input-radius);
        cursor: pointer;
        margin-top: 10px;
        transition: filter 0.2s ease;
      }
      .login-submit:hover {
        filter: brightness(1.1);
      }

      .error-msg {
        text-align: center;
        color: var(--red);
        font-size: 14px;
        margin-top: 10px;
      }

      .login-logo {
        width: var(--logo-width);
        height: var(--logo-height);
        margin: 0 auto 20px;
        display: flex;
        align-items: center;
        justify-content: center;
      }
      .login-logo img {
        max-width: var(--logo-inner-size);
        max-height: var(--logo-inner-size);
        object-fit: contain;
      }

      .register-link {
        text-align: center;
        margin-top: 15px;
        font-size: 14px;
      }
      .register-link a {
        color: var(--red);
        text-decoration: none;
      }
      .register-link a:hover {
        text-decoration: underline;
      }
    </style>
  </head>

  <body>
    <section class="login-box" aria-label="Login form">
      <div class="login-logo">
        <img src="LOG.png" alt="SkyLink Logo" />
      </div>
      <h2 class="login-title">Login to SkyLink</h2>
      <form action="login" method="post">
        <div class="login-field">
          <label for="username">Username</label>
          <input
            type="text"
            id="username"
            name="username"
            placeholder="Enter your username"
            required
          />
        </div>
        <div class="login-field">
          <label for="password">Password</label>
          <input
            type="password"
            id="password"
            name="password"
            placeholder="Enter your password"
            required
          />
        </div>

        <!-- Hidden redirect parameter -->
        <input
          type="hidden"
          name="redirect"
          value="<%= request.getParameter("redirect") != null ? request.getParameter("redirect") : "" %>"
        />

        <button type="submit" class="login-submit">Login</button>

        <% String error = request.getParameter("error");
           if ("true".equals(error)) { %>
            <p class="error-msg">Invalid username or password!</p>
        <% } %>
      </form>

      <div class="register-link">
        Don't have an account? <a href="register.jsp">Register here</a>
      </div>
    </section>
  </body>
</html>
