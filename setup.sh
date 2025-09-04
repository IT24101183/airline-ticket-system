#!/bin/bash

# SkyLinkOnline Quick Setup Script for Linux/Mac
# Run this script to quickly set up the project for development

echo "========================================"
echo "SkyLinkOnline - Quick Setup Script"
echo "========================================"
echo

echo "[1/5] Checking prerequisites..."
echo

# Check if Java is installed
if command -v java &> /dev/null; then
    echo "✓ Java is installed"
    java -version
else
    echo "ERROR: Java is not installed or not in PATH"
    echo "Please install Java JDK 8 or higher"
    exit 1
fi

# Check if Maven is installed
if command -v mvn &> /dev/null; then
    echo "✓ Maven is installed"
    mvn -version
else
    echo "ERROR: Maven is not installed or not in PATH"
    echo "Please install Apache Maven 3.6 or higher"
    exit 1
fi

echo
echo "[2/5] Database setup instructions..."
echo
echo "Please ensure you have:"
echo "- SQL Server installed and running"
echo "- SQL Server Management Studio (SSMS) or sqlcmd"
echo
echo "Run the database setup script:"
echo "database/setup.sql"
echo

echo "[3/5] Building project..."
echo
mvn clean compile
if [ $? -ne 0 ]; then
    echo "ERROR: Build failed"
    exit 1
else
    echo "✓ Project built successfully"
fi

echo
echo "[4/5] Configuration reminder..."
echo
echo "IMPORTANT: You need to update database connection details in:"
echo "- src/main/java/com/example/servlets/*.java"
echo "- src/main/webapp/*.jsp (files with database connections)"
echo
echo "Replace the connection string with your database details:"
echo 'String dbUrl = "jdbc:sqlserver://YOUR_SERVER;databaseName=SkyLinkOnline;integratedSecurity=false;";'
echo 'String dbUser = "YOUR_USERNAME";'
echo 'String dbPassword = "YOUR_PASSWORD";'
echo

echo "[5/5] Setup complete!"
echo
echo "Next steps:"
echo "1. Set up your database using database/setup.sql"
echo "2. Update database connection details in the code"
echo "3. Deploy to Tomcat: mvn package"
echo "4. Access the application at: http://localhost:8080/finance-manager"
echo
echo "Default users:"
echo "- Customer: username=customer, password=password"
echo "- Finance: username=finance, password=password"
echo

read -p "Press Enter to continue..."
