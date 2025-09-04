# 🚀 SkyLinkOnline - Team Collaboration Guide

## 📋 Quick Start for Team Members

### 🎯 What You Need to Do

1. **Clone the repository** from GitHub
2. **Set up your database** using the provided script
3. **Update database connection** details in your local copy
4. **Build and run** the application
5. **Start collaborating** with your team!

---

## 🔧 Step-by-Step Setup

### 1. Prerequisites Installation
Make sure you have these installed:
- **Java JDK 8+** - [Download here](https://adoptium.net/)
- **Apache Maven 3.6+** - [Download here](https://maven.apache.org/download.cgi)
- **Apache Tomcat 9+** - [Download here](https://tomcat.apache.org/download-90.cgi)
- **SQL Server 2019+** - [Download here](https://www.microsoft.com/en-us/sql-server/sql-server-downloads)
- **Git** - [Download here](https://git-scm.com/downloads)

### 2. Project Setup

#### Windows Users:
```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/SkyLinkOnline.git
cd SkyLinkOnline

# Run the setup script
setup.bat
```

#### Linux/Mac Users:
```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/SkyLinkOnline.git
cd SkyLinkOnline

# Make setup script executable and run it
chmod +x setup.sh
./setup.sh
```

### 3. Database Setup

1. **Open SQL Server Management Studio (SSMS)**
2. **Connect to your SQL Server instance**
3. **Open the file**: `database/setup.sql`
4. **Execute the script**
5. **Verify** that the `SkyLinkOnline` database is created

### 4. Update Database Connection

**IMPORTANT**: You need to update the database connection details in these files:

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

#### What to Change:
Replace this:
```java
String dbUrl = "jdbc:sqlserver://LAPTOP-7KOM5EIS;databaseName=SkyLinkOnline;integratedSecurity=false;";
String dbUser = "sa";
String dbPassword = "789";
```

With your database details:
```java
String dbUrl = "jdbc:sqlserver://YOUR_SERVER;databaseName=SkyLinkOnline;integratedSecurity=false;";
String dbUser = "YOUR_USERNAME";
String dbPassword = "YOUR_PASSWORD";
```

### 5. Build and Deploy

```bash
# Build the project
mvn clean package

# Deploy to Tomcat
# Copy target/finance-manager.war to your Tomcat webapps directory
```

### 6. Access the Application

Open your browser and go to:
```
http://localhost:8080/finance-manager
```

---

## 👥 Default Login Credentials

### Customer Account
- **Username**: `customer`
- **Password**: `password`
- **Role**: Customer

### Finance Manager Account
- **Username**: `finance`
- **Password**: `password`
- **Role**: Finance Manager

---

## 🤝 Team Collaboration Guidelines

### Git Workflow

1. **Always pull latest changes** before starting work:
   ```bash
   git pull origin main
   ```

2. **Create a feature branch** for your work:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Commit your changes** with clear messages:
   ```bash
   git add .
   git commit -m "feat: add new booking functionality"
   ```

4. **Push your branch** and create a Pull Request:
   ```bash
   git push origin feature/your-feature-name
   ```

### Code Standards

- **Follow Java naming conventions**
- **Use meaningful variable names**
- **Add comments for complex logic**
- **Always use prepared statements for database queries**
- **Handle exceptions properly**

### Communication

- **Use GitHub Issues** for bug reports and feature requests
- **Use Pull Request comments** for discussions
- **Keep the team updated** on your progress
- **Ask for help** when you're stuck

---

## 🐛 Common Issues and Solutions

### Database Connection Issues
**Problem**: Application can't connect to database
**Solution**: 
- Check if SQL Server is running
- Verify connection string and credentials
- Ensure database exists

### Build Errors
**Problem**: Maven build fails
**Solution**:
- Check Java version compatibility
- Verify Maven installation
- Run `mvn clean compile`

### Deployment Issues
**Problem**: Application doesn't deploy
**Solution**:
- Check Tomcat logs
- Verify WAR file is properly copied
- Restart Tomcat server

---

## 📚 Useful Commands

### Git Commands
```bash
# Check status
git status

# See changes
git diff

# View commit history
git log --oneline

# Switch branches
git checkout branch-name

# Merge changes
git merge branch-name
```

### Maven Commands
```bash
# Clean and compile
mvn clean compile

# Run tests
mvn test

# Package application
mvn package

# Deploy to Tomcat
mvn tomcat7:deploy
```

### Database Commands
```bash
# Connect to SQL Server (Windows)
sqlcmd -S YOUR_SERVER -U YOUR_USERNAME -P YOUR_PASSWORD

# Run SQL script
sqlcmd -S YOUR_SERVER -U YOUR_USERNAME -P YOUR_PASSWORD -i database/setup.sql
```

---

## 📞 Getting Help

### When You're Stuck:

1. **Check the documentation**:
   - `README.md` - Project overview
   - `DEPLOYMENT.md` - Deployment guide
   - `CONTRIBUTING.md` - Team guidelines

2. **Check existing issues** on GitHub

3. **Ask your team members** for help

4. **Create a new issue** on GitHub if needed

### Team Communication Channels:
- **GitHub Issues** - For bugs and features
- **Pull Request comments** - For code reviews
- **Team meetings** - For discussions
- **Email/Teams** - For urgent issues

---

## 🎯 Your Role in the Team

### What You Can Do:
- ✅ **View and edit** all project files
- ✅ **Create branches** for new features
- ✅ **Submit Pull Requests** for review
- ✅ **Report bugs** and suggest improvements
- ✅ **Help other team members**

### Best Practices:
- 🔄 **Always pull latest changes** before working
- 📝 **Write clear commit messages**
- 🧪 **Test your changes** before submitting
- 👥 **Help review** other team members' code
- 📚 **Document** your changes

---

## 🚀 Next Steps

1. **Complete the setup** using the steps above
2. **Explore the application** using the default accounts
3. **Familiarize yourself** with the codebase
4. **Start working** on your assigned tasks
5. **Contribute** to the project!

---

## 📅 Important Dates

- **Project Start**: [Your start date]
- **Sprint Duration**: 2 weeks
- **Code Reviews**: Required for all changes
- **Team Meetings**: [Your meeting schedule]

---

**Welcome to the SkyLinkOnline team! 🎉**

If you have any questions or need help, don't hesitate to ask your team members or create an issue on GitHub.

**Happy coding! 🚀**
