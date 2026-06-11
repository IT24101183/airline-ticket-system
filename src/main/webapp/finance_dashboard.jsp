<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Finance Officer Dashboard - Payment Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #3498db;
            --success: #2ecc71;
            --warning: #f39c12;
            --danger: #e74c3c;
            --light: #ecf0f1;
            --dark: #34495e;
        }

        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .navbar {
            background-color: var(--primary);
        }

        .sidebar {
            background-color: var(--dark);
            color: white;
            height: calc(100vh - 56px);
            position: sticky;
            top: 56px;
        }

        .sidebar a {
            color: white;
            padding: 15px 20px;
            display: block;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .sidebar a:hover, .sidebar a.active {
            background-color: var(--secondary);
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: transform 0.3s;
            margin-bottom: 20px;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .status-badge {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
        }

        .status-pending {
            background-color: var(--warning);
            color: white;
        }

        .status-paid {
            background-color: var(--success);
            color: white;
        }

        .status-failed {
            background-color: var(--danger);
            color: white;
        }

        .action-btn {
            margin-right: 5px;
        }

        .stats-card {
            text-align: center;
            padding: 20px;
        }

        .stats-number {
            font-size: 2rem;
            font-weight: bold;
        }

        .booking-details {
            background-color: var(--light);
            border-radius: 5px;
            padding: 15px;
            margin-top: 15px;
        }

        .alert-notification {
            position: fixed;
            top: 70px;
            right: 20px;
            z-index: 1050;
            animation: slideIn 0.5s forwards;
        }

        @keyframes slideIn {
            from { transform: translateX(100%); opacity: 0; }
            to { transform: translateX(0); opacity: 1; }
        }

        .table-hover tbody tr:hover {
            cursor: pointer;
            background-color: rgba(52, 152, 219, 0.1);
        }
    </style>
</head>
<body>
    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-plane-departure"></i> SkyLink Airlines
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> Finance Officer
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="#"><i class="fas fa-cog"></i> Settings</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="#"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-2 sidebar d-none d-md-block p-0">
                <a href="#" class="active"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                <a href="#"><i class="fas fa-money-check"></i> Payment Management</a>
                <a href="#"><i class="fas fa-chart-line"></i> Financial Reports</a>
                <a href="#"><i class="fas fa-users"></i> Customer Accounts</a>
                <a href="#"><i class="fas fa-plane"></i> Flight Management</a>
                <a href="#"><i class="fas fa-cog"></i> Settings</a>
            </div>

            <!-- Main Content -->
            <div class="col-md-10 ms-sm-auto col-lg-10 px-4 py-4">
                <!-- Notification Alert -->
                <div class="alert alert-success alert-dismissible fade show d-none" role="alert" id="notificationAlert">
                    <span id="alertMessage"></span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Payment Management Dashboard</h2>
                    <div class="d-flex">
                        <input type="text" class="form-control me-2" placeholder="Search transactions..." id="searchInput">
                        <button class="btn btn-outline-secondary">
                            <i class="fas fa-filter"></i> Filter
                        </button>
                    </div>
                </div>

                <!-- Stats Overview -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card stats-card bg-primary text-white">
                            <i class="fas fa-file-invoice-dollar fa-2x mb-2"></i>
                            <div class="stats-number">14</div>
                            <div>Pending Payments</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card bg-success text-white">
                            <i class="fas fa-check-circle fa-2x mb-2"></i>
                            <div class="stats-number">0</div>
                            <div>Confirmed Payments</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card bg-danger text-white">
                            <i class="fas fa-times-circle fa-2x mb-2"></i>
                            <div class="stats-number">0</div>
                            <div>Rejected Payments</div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card bg-info text-white">
                            <i class="fas fa-dollar-sign fa-2x mb-2"></i>
                            <div class="stats-number">$60,500</div>
                            <div>Total Revenue</div>
                        </div>
                    </div>
                </div>

                <!-- Transactions Table -->
                <div class="card">
                    <div class="card-header bg-white">
                        <h5 class="mb-0">Pending Payment Requests</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>User ID</th>
                                        <th>Flight ID</th>
                                        <th>Seats</th>
                                        <th>Total Price</th>
                                        <th>Booking Date</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td>5</td>
                                        <td>1</td>
                                        <td>16</td>
                                        <td>$8000.00</td>
                                        <td>2025-08-31 12:41:02</td>
                                        <td><span class="status-badge status-pending">Pending</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success action-btn confirm-btn" data-id="1">
                                                <i class="fas fa-check"></i> Confirm
                                            </button>
                                            <button class="btn btn-sm btn-danger action-btn reject-btn" data-id="1">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td>5</td>
                                        <td>1</td>
                                        <td>25</td>
                                        <td>$12500.00</td>
                                        <td>2025-08-31 12:41:52</td>
                                        <td><span class="status-badge status-pending">Pending</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success action-btn confirm-btn" data-id="2">
                                                <i class="fas fa-check"></i> Confirm
                                            </button>
                                            <button class="btn btn-sm btn-danger action-btn reject-btn" data-id="2">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td>5</td>
                                        <td>1</td>
                                        <td>20</td>
                                        <td>$10000.00</td>
                                        <td>2025-08-31 12:49:43</td>
                                        <td><span class="status-badge status-pending">Pending</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success action-btn confirm-btn" data-id="3">
                                                <i class="fas fa-check"></i> Confirm
                                            </button>
                                            <button class="btn btn-sm btn-danger action-btn reject-btn" data-id="3">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td>5</td>
                                        <td>1</td>
                                        <td>20</td>
                                        <td>$10000.00</td>
                                        <td>2025-08-31 12:50:14</td>
                                        <td><span class="status-badge status-pending">Pending</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success action-btn confirm-btn" data-id="4">
                                                <i class="fas fa-check"></i> Confirm
                                            </button>
                                            <button class="btn btn-sm btn-danger action-btn reject-btn" data-id="4">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td>5</td>
                                        <td>1</td>
                                        <td>10</td>
                                        <td>$5000.00</td>
                                        <td>2025-08-31 13:07:10</td>
                                        <td><span class="status-badge status-pending">Pending</span></td>
                                        <td>
                                            <button class="btn btn-sm btn-success action-btn confirm-btn" data-id="5">
                                                <i class="fas fa-check"></i> Confirm
                                            </button>
                                            <button class="btn btn-sm btn-danger action-btn reject-btn" data-id="5">
                                                <i class="fas fa-times"></i> Reject
                                            </button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <nav aria-label="Transaction pagination">
                            <ul class="pagination justify-content-center">
                                <li class="page-item disabled">
                                    <a class="page-link" href="#">Previous</a>
                                </li>
                                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                <li class="page-item"><a class="page-link" href="#">2</a></li>
                                <li class="page-item"><a class="page-link" href="#">3</a></li>
                                <li class="page-item">
                                    <a class="page-link" href="#">Next</a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <!-- Booking Details Modal -->
                <div class="modal fade" id="bookingDetailsModal" tabindex="-1" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">Booking Details #<span id="modalBookingId"></span></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-md-6">
                                        <h6>Customer Information</h6>
                                        <p><strong>User ID:</strong> 5</p>
                                        <p><strong>Name:</strong> John Doe</p>
                                        <p><strong>Email:</strong> john.doe@example.com</p>
                                        <p><strong>Phone:</strong> (555) 123-4567</p>
                                    </div>
                                    <div class="col-md-6">
                                        <h6>Flight Information</h6>
                                        <p><strong>Flight ID:</strong> 1</p>
                                        <p><strong>Route:</strong> New York (JFK) to London (LHR)</p>
                                        <p><strong>Departure:</strong> 2025-09-15 14:30</p>
                                        <p><strong>Arrival:</strong> 2025-09-15 23:45</p>
                                    </div>
                                </div>
                                <div class="booking-details mt-3">
                                    <h6>Booking Details</h6>
                                    <p><strong>Seats:</strong> <span id="modalSeats"></span></p>
                                    <p><strong>Total Price:</strong> <span id="modalPrice"></span></p>
                                    <p><strong>Booking Date:</strong> <span id="modalBookingDate"></span></p>
                                    <p><strong>Status:</strong> <span id="modalStatus" class="status-badge status-pending">Pending</span></p>
                                    <p><strong>Flight Class:</strong> Not specified</p>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-success confirm-btn" data-bs-dismiss="modal" id="modalConfirmBtn">
                                    <i class="fas fa-check"></i> Confirm Payment
                                </button>
                                <button type="button" class="btn btn-danger reject-btn" data-bs-dismiss="modal" id="modalRejectBtn">
                                    <i class="fas fa-times"></i> Reject Payment
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Check if there's a message parameter in URL (simulating redirect from servlet)
            const urlParams = new URLSearchParams(window.location.search);
            const message = urlParams.get('message');

            if (message) {
                showNotification(message, 'success');
            }

            // Add event listeners to all action buttons
            document.querySelectorAll('.confirm-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const id = this.getAttribute('data-id');
                    confirmPayment(id);
                });
            });

            document.querySelectorAll('.reject-btn').forEach(button => {
                button.addEventListener('click', function() {
                    const id = this.getAttribute('data-id');
                    rejectPayment(id);
                });
            });

            // Add row click event for showing details
            document.querySelectorAll('tbody tr').forEach(row => {
                row.addEventListener('click', function(e) {
                    if (!e.target.classList.contains('action-btn')) {
                        const cells = this.cells;
                        showBookingDetails(
                            cells[0].textContent,
                            cells[3].textContent,
                            cells[4].textContent,
                            cells[5].textContent,
                            cells[6].textContent
                        );
                    }
                });
            });

            // Search functionality
            document.getElementById('searchInput').addEventListener('keyup', function() {
                const searchText = this.value.toLowerCase();
                document.querySelectorAll('tbody tr').forEach(row => {
                    const rowText = row.textContent.toLowerCase();
                    row.style.display = rowText.includes(searchText) ? '' : 'none';
                });
            });

            // Modal button event listeners
            document.getElementById('modalConfirmBtn').addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                confirmPayment(id);
            });

            document.getElementById('modalRejectBtn').addEventListener('click', function() {
                const id = this.getAttribute('data-id');
                rejectPayment(id);
            });
        });

        function confirmPayment(id) {
            // In a real application, this would make an AJAX call to the servlet
            // For now, we'll simulate the servlet call with a redirect
            window.location.href = `UpdatePaymentServlet?action=confirm&id=${id}`;
        }

        function rejectPayment(id) {
            // In a real application, this would make an AJAX call to the servlet
            // For now, we'll simulate the servlet call with a redirect
            window.location.href = `UpdatePaymentServlet?action=reject&id=${id}`;
        }

        function showBookingDetails(id, seats, price, date, status) {
            document.getElementById('modalBookingId').textContent = id;
            document.getElementById('modalSeats').textContent = seats;
            document.getElementById('modalPrice').textContent = price;
            document.getElementById('modalBookingDate').textContent = date;
            document.getElementById('modalStatus').textContent = status.trim();

            // Set up modal buttons
            document.getElementById('modalConfirmBtn').setAttribute('data-id', id);
            document.getElementById('modalRejectBtn').setAttribute('data-id', id);

            // Show the modal
            const modal = new bootstrap.Modal(document.getElementById('bookingDetailsModal'));
            modal.show();
        }

        function showNotification(message, type) {
            const alert = document.getElementById('notificationAlert');
            alert.classList.remove('alert-success', 'alert-danger', 'd-none');
            alert.classList.add(`alert-${type}`);
            document.getElementById('alertMessage').textContent = message;
            alert.classList.remove('d-none');

            // Auto hide after 5 seconds
            setTimeout(() => {
                alert.classList.add('d-none');
            }, 5000);
        }
    </script>
</body>
</html>