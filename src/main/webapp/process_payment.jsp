<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Process Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <% 
    if (session.getAttribute("username") == null || !"customer".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    String booking_idStr = request.getParameter("booking_id");
    String amountStr = request.getParameter("amount");
    
    if (booking_idStr == null || booking_idStr.isEmpty()) {
        response.sendRedirect("customer_dashboard.jsp?message=Booking ID is required");
        return;
    }
    
    int booking_id = Integer.parseInt(booking_idStr);
    double amount = 0.0;
    
    // If amount is not provided in URL, fetch it from database
    if (amountStr == null || amountStr.isEmpty()) {
        String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
        String dbUser = "sa";
        String dbPassword = "789";
        
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
            PreparedStatement stmt = conn.prepareStatement("SELECT total_price FROM Bookings WHERE id = ? AND user_id = ?");
            stmt.setInt(1, booking_id);
            stmt.setInt(2, (Integer) session.getAttribute("user_id"));
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                amount = rs.getDouble("total_price");
            } else {
                response.sendRedirect("customer_dashboard.jsp?message=Booking not found");
                return;
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("customer_dashboard.jsp?message=Error fetching booking details");
            return;
        }
    } else {
        amount = Double.parseDouble(amountStr);
    }
    %>
    <div class="container mt-5">
        <h2 class="text-center">Process Payment</h2>
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title text-center mb-4">Payment Details</h5>
                        <form action="payment" method="post">
                            <input type="hidden" name="booking_id" value="<%= booking_id %>">
                            <div class="mb-3">
                                <label class="form-label">Booking ID:</label>
                                <input type="text" class="form-control" value="<%= booking_id %>" readonly />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Total Amount:</label>
                                <input type="number" name="amount" class="form-control" value="<%= amount %>" readonly />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Payment Method:</label>
                                <select name="payment_method" class="form-select" required>
                                    <option value="">Select Payment Method</option>
                                    <option value="credit_card">Credit Card</option>
                                    <option value="debit_card">Debit Card</option>
                                    <option value="bank_transfer">Bank Transfer</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Card Number:</label>
                                <input type="text" name="card_number" class="form-control" placeholder="1234 5678 9012 3456" required />
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Expiry Date (MM/YY):</label>
                                    <input type="text" name="expiry" class="form-control" placeholder="12/25" required />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">CVV:</label>
                                    <input type="text" name="cvv" class="form-control" placeholder="123" required />
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Billing Address (Optional):</label>
                                <input type="text" name="billing_address" class="form-control" placeholder="Enter billing address" />
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Process Payment</button>
                        </form>
                        <% String message = request.getParameter("message"); 
                        if (message != null) { %>
                            <div class="alert alert-info mt-3 text-center">
                                <%= message %>
                            </div>
                        <% } %>
                        <div class="text-center mt-3">
                            <a href="customer_dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
