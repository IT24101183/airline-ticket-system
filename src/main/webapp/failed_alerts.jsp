<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Failed Transaction Alerts</title>

  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

  <style>
    :root{ --accent:#d95e35; --muted:#6b7280; --radius:14px; --font:'Poppins',sans-serif; }
    body{ font-family:var(--font); background: linear-gradient(180deg,#f6f7fb,#eef2f7); margin:0; padding:24px 0; color:#111827; }
    .topbar{ background: linear-gradient(90deg,#1f2937,#111827); padding:12px 0; color:#fff; box-shadow:0 6px 18px rgba(16,24,40,0.08); }
    .card{ border-radius:var(--radius); box-shadow:0 6px 20px rgba(17,24,39,0.06); border:none; background:#fff; }
    .table-container{ max-width:1200px; margin:18px auto; }
    .muted{ color:var(--muted); }
    .action-links a{ margin-right:8px; }
  </style>
</head>
<body>
<%
  if (session.getAttribute("username") == null || !"finance_officer".equals(session.getAttribute("role"))) {
      response.sendRedirect("login.jsp");
      return;
  }
%>

<nav class="topbar">
  <div class="container d-flex align-items-center">
    <a class="navbar-brand text-white d-flex align-items-center" href="finance_dashboard.jsp" style="text-decoration:none;">
      <i class="bi bi-airplane-fill me-2" aria-hidden="true"></i><span style="font-weight:700">SkyLink Finance</span>
    </a>
    <div class="ms-auto text-white d-flex align-items-center">
      <div class="me-3" aria-live="polite">Welcome, <strong><%= session.getAttribute("username") %></strong></div>
      <a href="logout" class="btn btn-accent btn-sm d-flex align-items-center">
        <i class="bi bi-box-arrow-right me-2"></i> Logout
      </a>
    </div>
  </div>
</nav>

<div class="container dashboard-header" style="max-width:1200px;">
  <div>
    <h1>Failed Transaction Alerts</h1>
    <div class="muted" style="margin-top:6px;">Transactions marked as failed — take action to retry or refund</div>
  </div>
  <div class="text-end muted">
    <div style="font-size:13px;">Ordered by newest first</div>
  </div>
</div>

<div class="table-container container">
  <div class="card p-3">
    <div class="card-body">
      <!-- show message if present -->
      <%
        String msg = request.getParameter("message");
        if (msg != null && !msg.trim().isEmpty()) {
      %>
        <div class="alert alert-info"><%= java.net.URLDecoder.decode(msg, "UTF-8") %></div>
      <%
        }
      %>

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

            String sql = "SELECT id, user_id, amount, payment_method, transaction_date, booking_id FROM Transactions WHERE status = 'failed' ORDER BY transaction_date DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
      %>

      <div class="table-responsive">
        <table class="table table-hover align-middle">
          <thead class="table-light">
            <tr>
              <th>ID</th>
              <th>User ID</th>
              <th>Amount</th>
              <th>Payment Method</th>
              <th>Date</th>
              <th>Booking ID</th>
              <th>Action</th>
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
                String pm = rs.getString("payment_method");
                Timestamp t = rs.getTimestamp("transaction_date");
                String dateStr = (t != null) ? sdf.format(t) : "N/A";
                Object bookingObj = rs.getObject("booking_id");
                String booking = (bookingObj != null) ? String.valueOf(rs.getInt("booking_id")) : "N/A";
            %>
            <tr>
              <td><%= id %></td>
              <td><%= userId %></td>
              <td>Rs. <%= String.format("%.2f", amount) %></td>
              <td><%= pm %></td>
              <td><%= dateStr %></td>
              <td><%= booking %></td>
              <td class="action-links">
                <!-- Retry form -->
                <form method="post" action="<%= request.getContextPath() %>/updatePayment" style="display:inline;" onsubmit="return confirm('Mark transaction <%= id %> as SUCCESS?');">
                  <input type="hidden" name="action" value="retry">
                  <input type="hidden" name="id" value="<%= id %>">
                  <button type="submit" class="btn btn-sm btn-outline-primary" aria-label="Retry transaction <%= id %>">Retry</button>
                </form>

                <!-- Refund form -->
                <form method="post" action="<%= request.getContextPath() %>/updatePayment" style="display:inline;" onsubmit="return confirm('Refund transaction <%= id %>?');">
                  <input type="hidden" name="action" value="refund">
                  <input type="hidden" name="id" value="<%= id %>">
                  <button type="submit" class="btn btn-sm btn-outline-danger" aria-label="Refund transaction <%= id %>">Refund</button>
                </form>
              </td>
            </tr>
            <%
              } // end while
              if (!hasData) {
            %>
            <tr><td colspan="7" class="text-center muted">No failed transactions alerts.</td></tr>
            <%
              }
            %>
          </tbody>
        </table>
      </div>

      <%
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
      %>
        <div class="alert alert-danger" role="alert">
          Error viewing alerts. Please contact admin.
        </div>
      <%
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.close(); } catch (SQLException ignored) {}
        }
      %>

      <div class="d-flex justify-content-between align-items-center mt-3">
        <a href="finance_dashboard.jsp" class="btn btn-outline-secondary">← Back to Dashboard</a>
        <div class="muted" style="font-size:13px;">Actions (Retry / Refund) update the transaction status in DB</div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
