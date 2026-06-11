<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Monetization Dashboard</title>

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(180deg, #f6f7fb, #eef2f7);
      margin: 0;
      padding: 24px 0;
      color: #111827;
    }

    .topbar {
      background: linear-gradient(90deg, #1f2937, #111827);
      padding: 12px 0;
      color: white;
      box-shadow: 0 6px 18px rgba(16, 24, 40, 0.08);
    }

    .card {
      background: #fff;
      border-radius: 14px;
      box-shadow: 0 6px 20px rgba(17, 24, 39, 0.06);
      border: none;
    }

    .card-body {
      padding: 24px;
    }

    .table-container {
      max-width: 1200px;
      margin: 18px auto;
    }

    .btn-accent {
      background: #d95e35;
      color: white;
      font-weight: 600;
      border-radius: 8px;
    }
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
      <i class="bi bi-airplane-fill me-2" aria-hidden="true"></i> SkyLink Finance
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
    <h1>Monetization Dashboard</h1>
    <div class="muted" style="margin-top:6px;">View and confirm payments for monetization.</div>
  </div>
</div>

<div class="table-container container">
  <div class="card p-3">
    <div class="card-body">
      <%
        String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
        String dbUser = "sa";
        String dbPassword = "789";

        double totalRevenue = 0.0;

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Query for successful transactions
            String sql = "SELECT amount FROM Transactions WHERE status = 'success'";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            // Calculate total revenue
            while (rs.next()) {
                totalRevenue += rs.getDouble("amount");
            }
        %>

        <div class="alert alert-success" role="alert">
          Total Revenue from Successful Transactions: Rs. <%= String.format("%.2f", totalRevenue) %>
        </div>

        <div class="table-responsive">
          <table class="table table-hover align-middle">
            <thead class="table-light">
              <tr>
                <th>ID</th>
                <th>User ID</th>
                <th>Amount</th>
                <th>Payment Method</th>
                <th>Status</th>
                <th>Date</th>
                <th>Action</th>
              </tr>
            </thead>
            <tbody>
              <%
                String getTransactionsQuery = "SELECT id, user_id, amount, payment_method, status, transaction_date FROM Transactions WHERE status = 'pending' ORDER BY transaction_date DESC";
                stmt = conn.prepareStatement(getTransactionsQuery);
                rs = stmt.executeQuery();
                boolean hasData = false;

                while (rs.next()) {
                    hasData = true;
                    int id = rs.getInt("id");
                    int userId = rs.getInt("user_id");
                    double amount = rs.getDouble("amount");
                    String paymentMethod = rs.getString("payment_method");
                    String status = rs.getString("status");
                    Timestamp t = rs.getTimestamp("transaction_date");
                    String dateStr = (t != null) ? new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(t) : "N/A";
              %>
              <tr>
                <td><%= id %></td>
                <td><%= userId %></td>
                <td>Rs. <%= String.format("%.2f", amount) %></td>
                <td><%= paymentMethod %></td>
                <td><%= status %></td>
                <td><%= dateStr %></td>
                <td>
                  <form method="post" action="${pageContext.request.contextPath}/updatePaymentStatus" style="display:inline;" onsubmit="return confirm('Confirm payment for transaction <%= id %>?');">
                    <input type="hidden" name="booking_id" value="<%= id %>">
                    <button type="submit" class="btn btn-sm btn-outline-success">Confirm Payment</button>
                  </form>
                </td>
              </tr>
              <%
                }
                if (!hasData) {
              %>
              <tr><td colspan="7" class="text-center muted">No pending transactions to confirm.</td></tr>
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
            Error retrieving transactions. Please contact admin.
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
        <div class="muted" style="font-size:13px;">All payments are logged for auditing purposes.</div>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
