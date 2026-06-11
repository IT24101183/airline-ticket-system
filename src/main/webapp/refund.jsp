<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Refund</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #e4e8f0 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .container {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            width: 100%;
            max-width: 500px;
            overflow: hidden;
        }

        .header {
            background: linear-gradient(135deg, #2c3e50 0%, #4a6491 100%);
            color: white;
            padding: 25px;
            text-align: center;
        }

        .header h1 {
            font-size: 24px;
            margin-bottom: 5px;
        }

        .header p {
            opacity: 0.9;
        }

        .content {
            padding: 25px;
        }

        .transaction-card {
            background-color: #f9fafc;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            border-left: 5px solid #4a6491;
        }

        .transaction-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 15px;
            margin-top: 15px;
        }

        .detail-item {
            margin-bottom: 10px;
        }

        .detail-label {
            font-weight: bold;
            color: #666;
            font-size: 14px;
        }

        .detail-value {
            font-size: 16px;
            margin-top: 5px;
            color: #333;
        }

        .confirmation {
            text-align: center;
            margin: 30px 0;
            padding: 15px;
            background-color: #fff9e6;
            border-radius: 8px;
            border-left: 4px solid #ffcc00;
        }

        .confirmation h3 {
            color: #e6a700;
            margin-bottom: 10px;
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 30px;
        }

        .btn {
            padding: 14px 30px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s;
            min-width: 120px;
        }

        .btn-yes {
            background: linear-gradient(135deg, #4CAF50 0%, #2E7D32 100%);
            color: white;
            box-shadow: 0 4px 6px rgba(76, 175, 80, 0.3);
        }

        .btn-yes:hover {
            background: linear-gradient(135deg, #43A047 0%, #1B5E20 100%);
            transform: translateY(-2px);
            box-shadow: 0 6px 8px rgba(76, 175, 80, 0.4);
        }

        .btn-no {
            background: linear-gradient(135deg, #f5f5f5 0%, #e0e0e0 100%);
            color: #666;
            border: 1px solid #ddd;
        }

        .btn-no:hover {
            background: linear-gradient(135deg, #eeeeee 0%, #d5d5d5 100%);
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .footer {
            text-align: center;
            padding: 20px;
            color: #666;
            font-size: 14px;
            border-top: 1px solid #eee;
        }

        @media (max-width: 500px) {
            .transaction-details {
                grid-template-columns: 1fr;
            }

            .buttons {
                flex-direction: column;
                gap: 15px;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Refund Transaction</h1>
            <p>Confirm refund action</p>
        </div>

        <div class="content">
            <div class="transaction-card">
                <h3>Transaction Details</h3>
                <div class="transaction-details">
                    <div class="detail-item">
                        <div class="detail-label">Transaction ID</div>
                        <div class="detail-value">TXN-789456123</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Date & Time</div>
                        <div class="detail-value">Oct 15, 2023 14:32:18</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Customer</div>
                        <div class="detail-value">Sarah Johnson</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Payment Method</div>
                        <div class="detail-value">Visa **** 4567</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Amount</div>
                        <div class="detail-value">$245.99</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">Status</div>
                        <div class="detail-value">Completed</div>
                    </div>
                </div>
            </div>

            <div class="confirmation">
                <h3>Confirm Refund</h3>
                <p>Are you sure you want to refund this transaction? This action cannot be undone.</p>
            </div>

            <div class="buttons">
                <button class="btn btn-yes" onclick="processRefund(true)">Yes, Refund</button>
                <button class="btn btn-no" onclick="processRefund(false)">Cancel</button>
            </div>
        </div>

        <div class="footer">
            <p>© 2023 Payment Solutions. All rights reserved.</p>
        </div>
    </div>

    <script>
        function processRefund(confirmRefund) {
            if (confirmRefund) {
                // Here you would typically make an AJAX call to your JSP backend
                alert('Refund processed successfully!');
                // In a real application, you would redirect or update the UI accordingly
            } else {
                // Here you would handle the cancellation
                alert('Refund cancelled.');
                // In a real application, you would redirect back to the previous page
            }

            // For demonstration purposes, let's simulate a redirect after 1 second
            setTimeout(() => {
                // window.location.href = 'transactions.jsp'; // Redirect to transactions page
            }, 1000);
        }
    </script>
</body>
</html>