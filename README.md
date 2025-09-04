# SkyLinkOnline - Air Ticket Reservation System

A web-based air ticket reservation system built with Java Servlets, JSP, and SQL Server.

## 🚀 Features

- User registration and authentication
- Flight search and booking
- Seat selection with interactive seat map
- Payment processing
- E-ticket generation
- Customer dashboard
- Finance manager dashboard
- Booking reports and analytics

## 🛠️ Technology Stack

- **Backend**: Java Servlets, JSP
- **Database**: SQL Server
- **Frontend**: HTML, CSS, JavaScript, Bootstrap 5
- **Build Tool**: Maven
- **Server**: Apache Tomcat

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

- Java JDK 8 or higher
- Apache Maven 3.6+
- Apache Tomcat 9+
- SQL Server 2019 or higher
- Git

## 🗄️ Database Setup

### 1. Create Database
```sql
CREATE DATABASE SkyLinkOnline;
```

### 2. Create Tables
Run the SQL scripts in the `database/` folder to create all required tables.

### 3. Database Configuration
Update the database connection details in the following files:
- `src/main/java/com/example/servlets/BookServlet.java`
- `src/main/java/com/example/servlets/PaymentServlet.java`
- `src/main/webapp/process_payment.jsp`
- `src/main/webapp/ticket.jsp`
- And other JSP files with database connections

Replace the connection string:
```java
String dbUrl = "jdbc:sqlserver://YOUR_SERVER;databaseName=SkyLinkOnline;integratedSecurity=false;";
String dbUser = "YOUR_USERNAME";
String dbPassword = "YOUR_PASSWORD";
```

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/YOUR_USERNAME/SkyLinkOnline.git
cd SkyLinkOnline
```

### 2. Configure Database
- Update database connection details in all servlet and JSP files
- Run the database setup scripts

### 3. Build the Project
```bash
mvn clean compile
```

### 4. Deploy to Tomcat
```bash
mvn package
```
Copy the generated WAR file from `target/finance-manager.war` to your Tomcat webapps directory.

### 5. Access the Application
Open your browser and navigate to: `http://localhost:8080/finance-manager`

## 👥 Default Users

### Customer Account
- Username: `customer`
- Password: `password`
- Role: Customer

### Finance Manager Account
- Username: `finance`
- Password: `password`
- Role: Finance Manager

## 📁 Project Structure

```
SkyLinkOnline/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/example/servlets/
│   │   │       ├── BookServlet.java
│   │   │       ├── LoginServlet.java
│   │   │       ├── LogoutServlet.java
│   │   │       ├── PaymentServlet.java
│   │   │       ├── RegisterServlet.java
│   │   │       └── SearchServlet.java
│   │   ├── resources/
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   └── web.xml
│   │       ├── *.jsp files
│   │       └── static assets
├── target/
├── pom.xml
└── README.md
```

## 🔧 Configuration

### Database Configuration
All database connection details are hardcoded in the servlet files. For production, consider using:
- Environment variables
- Configuration files
- JNDI resources

### Server Configuration
- Default context path: `/finance-manager`
- Default port: `8080`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Development Guidelines

### Code Style
- Follow Java naming conventions
- Use meaningful variable names
- Add comments for complex logic
- Keep methods small and focused

### Database
- Use prepared statements to prevent SQL injection
- Always close database connections
- Handle exceptions properly

### Frontend
- Use Bootstrap classes for consistent styling
- Validate forms on both client and server side
- Ensure responsive design

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check if SQL Server is running
   - Verify connection string and credentials
   - Ensure database exists

2. **Compilation Errors**
   - Make sure JDK is properly installed
   - Check Maven dependencies
   - Verify Java version compatibility

3. **Deployment Issues**
   - Check Tomcat logs for errors
   - Verify WAR file is properly deployed
   - Check context path configuration

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Contact the development team
- Check the troubleshooting section

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👨‍💻 Team Members

- [Your Name] - Project Lead
- [Team Member 1] - Backend Developer
- [Team Member 2] - Frontend Developer
- [Team Member 3] - Database Developer
- [Team Member 4] - UI/UX Designer
- [Team Member 5] - Testing
- [Team Member 6] - Documentation

---

**Note**: This is a development project. For production use, additional security measures and optimizations are required.
