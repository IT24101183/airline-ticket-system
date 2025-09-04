# Deployment Guide for SkyLinkOnline

This guide will help you deploy the SkyLinkOnline application on your local machine or server.

## 🚀 Prerequisites

Before deployment, ensure you have the following installed:

- **Java JDK 8 or higher**
- **Apache Maven 3.6+**
- **Apache Tomcat 9+**
- **SQL Server 2019 or higher**
- **Git**

## 📋 Step-by-Step Deployment

### 1. Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/SkyLinkOnline.git
cd SkyLinkOnline
```

### 2. Database Setup

#### Option A: Using SQL Server Management Studio (SSMS)
1. Open SQL Server Management Studio
2. Connect to your SQL Server instance
3. Open the file `database/setup.sql`
4. Execute the script
5. Verify that the database `SkyLinkOnline` is created with all tables

#### Option B: Using Command Line
```bash
sqlcmd -S YOUR_SERVER -U YOUR_USERNAME -P YOUR_PASSWORD -i database/setup.sql
```

### 3. Configure Database Connection

You need to update the database connection details in the following files:

#### Files to Update:
- `src/main/java/com/example/servlets/BookServlet.java`
- `src/main/java/com/example/servlets/PaymentServlet.java`
- `src/main/webapp/process_payment.jsp`
- `src/main/webapp/ticket.jsp`
- `src/main/webapp/book.jsp`
- `src/main/webapp/customer_dashboard.jsp`
- `src/main/webapp/finance_dashboard.jsp`
- `src/main/webapp/reports.jsp`
- `src/main/webapp/alerts.jsp`
- `src/main/webapp/logs.jsp`

#### Update Pattern:
Replace the connection string in each file:
```java
// Old connection (replace with your details)
String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
String dbUser = "sa";
String dbPassword = "789";

// New connection (your details)
String dbUrl = "jdbc:sqlserver://YOUR_SERVER;databaseName=SkyLinkOnline;integratedSecurity=false;";
String dbUser = "YOUR_USERNAME";
String dbPassword = "YOUR_PASSWORD";
```

### 4. Build the Project

```bash
# Clean and compile
mvn clean compile

# Package the application
mvn package
```

This will create a WAR file in the `target/` directory: `target/finance-manager.war`

### 5. Deploy to Tomcat

#### Option A: Manual Deployment
1. Copy `target/finance-manager.war` to your Tomcat `webapps/` directory
2. Start Tomcat server
3. The application will be automatically deployed

#### Option B: Using Maven Tomcat Plugin
```bash
mvn tomcat7:deploy
```

### 6. Access the Application

Open your web browser and navigate to:
```
http://localhost:8080/finance-manager
```

## 🔧 Configuration Options

### Database Configuration

#### Environment Variables (Recommended for Production)
Set these environment variables:
```bash
export DB_SERVER=your-server
export DB_NAME=SkyLinkOnline
export DB_USER=your-username
export DB_PASSWORD=your-password
```

#### Configuration File
Create a `database.properties` file based on the template:
```bash
cp database/database.properties.template database/database.properties
```

Then edit the file with your database details.

### Server Configuration

#### Tomcat Configuration
Edit `conf/server.xml` to change the port:
```xml
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```

#### Context Path
The application is deployed with context path `/finance-manager`. To change this:
1. Rename the WAR file to your desired context name
2. Or configure it in Tomcat's `conf/server.xml`

## 🐛 Troubleshooting

### Common Issues

#### 1. Database Connection Error
**Symptoms:** Application fails to start or shows database errors
**Solutions:**
- Verify SQL Server is running
- Check connection string and credentials
- Ensure database exists
- Verify network connectivity

#### 2. Compilation Errors
**Symptoms:** Maven build fails
**Solutions:**
- Check Java version compatibility
- Verify Maven installation
- Check for missing dependencies
- Clean and rebuild: `mvn clean compile`

#### 3. Deployment Issues
**Symptoms:** Application doesn't deploy or shows 404 errors
**Solutions:**
- Check Tomcat logs in `logs/` directory
- Verify WAR file is properly copied
- Check context path configuration
- Restart Tomcat server

#### 4. Runtime Errors
**Symptoms:** Application starts but shows errors
**Solutions:**
- Check Tomcat logs for detailed error messages
- Verify all database tables exist
- Check file permissions
- Ensure all dependencies are available

### Log Files

#### Tomcat Logs
- Location: `TOMCAT_HOME/logs/`
- Files: `catalina.out`, `localhost.log`, `catalina.log`

#### Application Logs
- Check console output during startup
- Look for error messages in browser console

## 🔒 Security Considerations

### Production Deployment

#### 1. Database Security
- Use strong passwords
- Limit database user permissions
- Enable SSL/TLS for database connections
- Regular security updates

#### 2. Application Security
- Change default passwords
- Use HTTPS in production
- Implement proper session management
- Regular security audits

#### 3. Server Security
- Keep Tomcat updated
- Configure firewall rules
- Use reverse proxy (nginx/Apache)
- Regular backups

## 📊 Monitoring

### Health Checks
- Database connectivity
- Application response time
- Error rates
- User sessions

### Performance Monitoring
- Monitor memory usage
- Check database performance
- Monitor network traffic
- Set up alerts for issues

## 🔄 Updates and Maintenance

### Updating the Application
1. Pull latest changes from Git
2. Update database if needed
3. Rebuild and redeploy
4. Test thoroughly

### Database Maintenance
- Regular backups
- Index optimization
- Data cleanup
- Performance monitoring

## 📞 Support

For deployment issues:
1. Check the troubleshooting section
2. Review Tomcat and application logs
3. Create an issue on GitHub
4. Contact the development team

## 🎯 Next Steps

After successful deployment:
1. Test all functionality
2. Set up monitoring
3. Configure backups
4. Plan for production deployment
5. Train team members on the system

---

**Note:** This guide covers basic deployment. For production environments, additional security, monitoring, and performance optimizations are required.
