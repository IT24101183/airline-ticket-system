<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Daily Transaction Reports</title>

  <!-- Typography & Bootstrap (matching dashboard) -->
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    /* Minimal duplicated theme to match dashboard look & feel */
    :root{
      --accent:#d95e35;
      --muted:#6b7280;
      --card-bg:#fff;
      --radius:14px;
      --font:'Poppins', sans-serif;
    }
    body{ font-family:var(--font); background: linear-gradient(180deg,#f6f7fb,#eef2f7); margin:0; padding:24px 0; color:#111827; }
    .topbar{ background: linear-gradient(90deg,#1f2937,#111827); padding:12px 0; color:#fff; box-shadow:0 6px 18px rgba(16,24,40,0.08); }
    .dashboard-header{ max-width:1200px; margin:20px auto; background: linear-gradient(90deg, rgba(25,27,31,0.98), rgba(32,35,40,0.95)); color:#fff; padding:20px 22px; border-radius:12px; display:flex; justify-content:space-between; align-items:center; }
    h1{ margin:0; font-size:20px; font-weight:700; }
    .card{ background:var(--card-bg); border-radius:var(--radius); box-shadow:0 6px 20px rgba(17,24,39,0.06); border:none; }
    .btn-accent{ background:var(--accent); color:#fff; border:none; font-weight:600; border-radius:8px; }
    .table-container{ max-width:1200px; margin:18px auto; }
    .muted{ color:var(--muted); }
    a.btn-back{ text-decoration:none; }
    /* focus outline for accessibility */
    a:focus, button:focus { outline: 3px solid rgba(217,94,53,0.18); outline-offset:2px; }
  </style>
</head>
<body>
<%--
  Server-side access control:
  If user not logged in OR role != finance_officer then redirect to login.jsp
--%>
<%
  if (session.getAttribute("username") == null || !"finance_officer".equals(session.getAttribute("role"))) {
      response.sendRedirect("login.jsp");
      return;
  }
%>

<!-- Top navigation bar (visual only; same logout behaviour) -->
<nav class="topbar">
  <div class="container d-flex align-items-center">
    <a class="navbar-brand text-white d-flex align-items-center" href="finance_dashboard.jsp" style="text-decoration:none;">
      <i class="bi bi-airplane-fill me-2" aria-hidden="true"></i>
      <span style="font-weight:700">SkyLink Finance</span>
    </a>
    <div class="ms-auto text-white d-flex align-items-center">
      <div class="me-3" aria-live="polite">Welcome, <strong><%= session.getAttribute("username") %></strong></div>
      <a href="logout" class="btn btn-accent btn-sm d-flex align-items-center">
        <i class="bi bi-box-arrow-right me-2"></i> Logout
      </a>
    </div>
  </div>
</nav>

<!-- Header / hero -->
<div class="dashboard-header container">
  <div>
    <h1>Daily Transaction Report</h1>
    <div class="muted" style="margin-top:6px;">Showing transactions for today</div>
  </div>
  <div class="text-end muted">
    <div><strong>Today</strong></div>
    <div class="muted" style="font-size:13px;"><%= new java.util.Date() %></div>
  </div>
</div>

<!-- Main content: Transactions table -->
<div class="table-container container">
  <div class="card p-3">
    <div class="card-body">
      <%-- Database: fetch today's transactions --%>
      <%
        String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
        String dbUser = "sa";
        String dbPassword = "789";

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Query: transactions where transaction_date is today (server DB GETDATE())
            String sql = "SELECT id, user_id, amount, payment_method, status, transaction_date, booking_id FROM Transactions WHERE CONVERT(DATE, transaction_date) = CONVERT(DATE, GETDATE()) ORDER BY transaction_date DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
      %>

      <!-- Responsive table with Bootstrap styling -->
      <div class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th scope="col">ID</th>
              <th scope="col">User ID</th>
              <th scope="col">Amount</th>
              <th scope="col">Payment Method</th>
              <th scope="col">Status</th>
              <th scope="col">Date</th>
              <th scope="col">Booking ID</th>
            </tr>
          </thead>
          <tbody>
          <%
            boolean hasData = false;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            while (rs.next()) {
              hasData = true;
              int id = rs.getInt("id");
              int userId = rs.getInt("user_id");
              double amount = rs.getDouble("amount");
              String paymentMethod = rs.getString("payment_method");
              String status = rs.getString("status");
              Timestamp t = rs.getTimestamp("transaction_date");
              String dateStr = (t != null) ? sdf.format(t) : "N/A";
              Object bookingObj = rs.getObject("booking_id");
              String booking = (bookingObj != null) ? String.valueOf(rs.getInt("booking_id")) : "N/A";
          %>
            <tr>
              <td><%= id %></td>
              <td><%= userId %></td>
              <td>Rs. <%= String.format("%.2f", amount) %></td>
              <td><%= paymentMethod %></td>
              <td>
                <%-- visual badge for status (helps quick scan) --%>
                <%
                  String badgeClass = "bg-success text-white";
                  if (status == null) status = "unknown";
                  if ("failed".equalsIgnoreCase(status)) badgeClass = "bg-danger text-white";
                  else if ("pending".equalsIgnoreCase(status)) badgeClass = "bg-warning text-dark";
                %>
                <span class="badge <%= badgeClass %>"><%= status %></span>
              </td>
              <td><%= dateStr %></td>
              <td><%= booking %></td>
            </tr>
          <%
            } // end while
            if (!hasData) {
          %>
            <tr><td colspan="7" class="text-center muted">No transactions today.</td></tr>
          <%
            }
          %>
          </tbody>
        </table>
      </div> <!-- /.table-responsive -->

      <%  // end try block for DB fetching
        } catch (SQLException | ClassNotFoundException e) {
            // Log stack trace (server logs) and show user-friendly message
            e.printStackTrace();
      %>
          <div class="alert alert-danger" role="alert">
            Error generating report. Please contact admin.
          </div>
      <%
        } finally {
            // Safe close resources individually to avoid masking exceptions
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
      %>

      <!-- Footer actions: back to dashboard -->
      <div class="d-flex justify-content-between align-items-center mt-3">
        <a href="finance_dashboard.jsp" class="btn btn-outline-secondary">← Back to Dashboard</a>
        <div class="muted" style="font-size:13px;">Report generated for today's transactions</div>
      </div>
    </div> <!-- /.card-body -->
  </div> <!-- /.card -->
</div> <!-- /.table-container -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
