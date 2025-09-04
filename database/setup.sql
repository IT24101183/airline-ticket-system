-- SkyLinkOnline Database Setup Script
-- Run this script to create the database and all required tables

-- Create Database
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'SkyLinkOnline')
BEGIN
    CREATE DATABASE SkyLinkOnline;
END
GO

USE SkyLinkOnline;
GO

-- Create Users Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
BEGIN
    CREATE TABLE Users (
        id INT IDENTITY(1,1) PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        password VARCHAR(255) NOT NULL,
        first_name VARCHAR(50),
        last_name VARCHAR(50),
        email VARCHAR(100) UNIQUE NOT NULL,
        phone_number VARCHAR(20),
        role VARCHAR(20) DEFAULT 'customer',
        created_date DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create Flights Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Flights]') AND type in (N'U'))
BEGIN
    CREATE TABLE Flights (
        id INT IDENTITY(1,1) PRIMARY KEY,
        flight_number VARCHAR(20) UNIQUE NOT NULL,
        departure_airport VARCHAR(100) NOT NULL,
        arrival_airport VARCHAR(100) NOT NULL,
        departure_date DATETIME NOT NULL,
        arrival_date DATETIME NOT NULL,
        available_seats INT DEFAULT 100,
        total_seats INT DEFAULT 100,
        price DECIMAL(10,2) NOT NULL,
        flight_class VARCHAR(20) DEFAULT 'Economy',
        status VARCHAR(20) DEFAULT 'Scheduled',
        created_date DATETIME DEFAULT GETDATE()
    );
END
GO

-- Create Bookings Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Bookings]') AND type in (N'U'))
BEGIN
    CREATE TABLE Bookings (
        id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        flight_id INT NOT NULL,
        seats INT NOT NULL,
        total_price DECIMAL(10,2) NOT NULL,
        status VARCHAR(20) DEFAULT 'pending',
        booking_date DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (user_id) REFERENCES Users(id),
        FOREIGN KEY (flight_id) REFERENCES Flights(id)
    );
END
GO

-- Create Transactions Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Transactions]') AND type in (N'U'))
BEGIN
    CREATE TABLE Transactions (
        id INT IDENTITY(1,1) PRIMARY KEY,
        user_id INT NOT NULL,
        booking_id INT,
        amount DECIMAL(10,2) NOT NULL,
        payment_method VARCHAR(50),
        status VARCHAR(20) DEFAULT 'pending',
        transaction_date DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (user_id) REFERENCES Users(id),
        FOREIGN KEY (booking_id) REFERENCES Bookings(id)
    );
END
GO

-- Create PaymentLogs Table
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PaymentLogs]') AND type in (N'U'))
BEGIN
    CREATE TABLE PaymentLogs (
        id INT IDENTITY(1,1) PRIMARY KEY,
        transaction_id INT,
        log_message TEXT,
        log_date DATETIME DEFAULT GETDATE(),
        FOREIGN KEY (transaction_id) REFERENCES Transactions(id)
    );
END
GO

-- Insert Sample Data

-- Insert default users
IF NOT EXISTS (SELECT * FROM Users WHERE username = 'customer')
BEGIN
    INSERT INTO Users (username, password, first_name, last_name, email, phone_number, role)
    VALUES ('customer', 'password', 'John', 'Doe', 'customer@example.com', '1234567890', 'customer');
END

IF NOT EXISTS (SELECT * FROM Users WHERE username = 'finance')
BEGIN
    INSERT INTO Users (username, password, first_name, last_name, email, phone_number, role)
    VALUES ('finance', 'password', 'Finance', 'Manager', 'finance@example.com', '0987654321', 'finance');
END

-- Insert sample flights
IF NOT EXISTS (SELECT * FROM Flights WHERE flight_number = 'FL001')
BEGIN
    INSERT INTO Flights (flight_number, departure_airport, arrival_airport, departure_date, arrival_date, available_seats, total_seats, price, flight_class)
    VALUES 
    ('FL001', 'New York (JFK)', 'London (LHR)', '2024-01-15 10:30:00', '2024-01-15 22:45:00', 85, 100, 850.00, 'Economy'),
    ('FL002', 'London (LHR)', 'Paris (CDG)', '2024-01-16 14:00:00', '2024-01-16 16:30:00', 92, 100, 450.00, 'Economy'),
    ('FL003', 'Paris (CDG)', 'Tokyo (NRT)', '2024-01-17 08:00:00', '2024-01-17 15:30:00', 78, 100, 1200.00, 'Economy'),
    ('FL004', 'Tokyo (NRT)', 'Singapore (SIN)', '2024-01-18 12:00:00', '2024-01-18 18:30:00', 88, 100, 650.00, 'Economy'),
    ('FL005', 'Singapore (SIN)', 'Sydney (SYD)', '2024-01-19 09:00:00', '2024-01-19 20:30:00', 95, 100, 750.00, 'Economy');
END

-- Create indexes for better performance
CREATE INDEX IX_Users_Username ON Users(username);
CREATE INDEX IX_Users_Email ON Users(email);
CREATE INDEX IX_Flights_DepartureDate ON Flights(departure_date);
CREATE INDEX IX_Bookings_UserId ON Bookings(user_id);
CREATE INDEX IX_Bookings_FlightId ON Bookings(flight_id);
CREATE INDEX IX_Transactions_UserId ON Transactions(user_id);
CREATE INDEX IX_Transactions_BookingId ON Transactions(booking_id);

PRINT 'Database setup completed successfully!';
PRINT 'Default users created:';
PRINT '  - Username: customer, Password: password, Role: customer';
PRINT '  - Username: finance, Password: password, Role: finance';
PRINT 'Sample flights have been added to the database.';
