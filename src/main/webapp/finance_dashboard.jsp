<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Finance Officer Dashboard</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <style>
      :root {
        --black: #333333;
        --white: #ffffff;
        --red: #bd4242;
        --gray-input: #dddddd;
        --font-sans: "Poppins", sans-serif;
      }
      body {
        font-family: var(--font-sans);
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
      }
      .navbar {
        background-color: var(--black);
      }
      .navbar-brand, .nav-link {
        color: var(--white) !important;
      }
      .dashboard-header {
        background: var(--black);
        color: var(--white);
        padding: 40px 20px;
        text-align: center;
        border-radius: 0 0 20px 20px;
      }
      .dashboard-header h1 {
        font-size: 28px;
        font-weight: 600;
      }
      .dashboard-header p {
        font-size: 16px;
        margin-top: 10px;
      }
      .card {
        border: none;
        border-radius: 12px;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        transition: transform 0.2s ease;
      }
      .card:hover {
        transform: translateY(-5px);
      }
      .card-title {
        font-size: 18px;
        font-weight: 600;
      }
      .btn-red {
        background-color: var(--red);
        color: var(--white);
        font-weight: 600;
        border-radius: 6px;
        transition: filter 0.2s ease;
      }
      .btn-red:hover {
        filter: brightness(1.1);
      }
    </style>
</head>
<body>
    <%
        // ✅ Access control: only finance_officer can view
        if (session.getAttribute("username") == null || !"finance_officer".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <!-- Top Navbar -->
    <nav class="navbar navbar-expand-lg">
      <div class="container-fluid">
        <a class="navbar-brand" href="#">SkyLink Finance</a>
        <div class="d-flex">
          <span class="navbar-text me-3 text-white">
            Welcome, <%= session.getAttribute("username") %>
          </span>
          <a href="logout" class="btn btn-sm btn-red">Logout</a>
        </div>
      </div>
    </nav>

    <!-- Header Section -->
    <div class="dashboard-header">
      <h1>Finance Officer Dashboard</h1>
      <p>Manage ticket payments, financial reports, and alerts in one place.</p>
    </div>

    <!-- Dashboard Cards -->
    <div class="container my-5">
      <div class="row g-4">
        <!-- Process Payments -->
        <div class="col-md-6 col-lg-3">
          <div class="card p-3 text-center">
            <h5 class="card-title">Process Payments</h5>
            <p class="card-text">Securely handle and approve customer payments.</p>
            <a href="process_payment.jsp" class="btn btn-red w-100">Go</a>
          </div>
        </div>

        <!-- Daily Transaction Reports -->
        <div class="col-md-6 col-lg-3">
          <div class="card p-3 text-center">
            <h5 class="card-title">Daily Reports</h5>
            <p class="card-text">Generate and download daily financial summaries.</p>
            <a href="reports.jsp" class="btn btn-red w-100">Go</a>
          </div>
        </div>

        <!-- View Logs -->
        <div class="col-md-6 col-lg-3">
          <div class="card p-3 text-center">
            <h5 class="card-title">Payment Logs</h5>
            <p class="card-text">Check payment histories and audit logs.</p>
            <a href="logs.jsp" class="btn btn-red w-100">Go</a>
          </div>
        </div>

        <!-- Failed Alerts -->
        <div class="col-md-6 col-lg-3">
          <div class="card p-3 text-center">
            <h5 class="card-title">Failed Transactions</h5>
            <p class="card-text">View alerts for failed or suspicious transactions.</p>
            <a href="alerts.jsp" class="btn btn-red w-100">Go</a>
          </div>
        </div>
      </div>
    </div>
</body>
</html>
