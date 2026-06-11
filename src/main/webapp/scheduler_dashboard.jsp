<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Flight Scheduler Dashboard</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet" />

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
      :root{
        --bg: #f6f7fb;
        --card-bg: #ffffff;
        --primary: #1f2937;
        --accent: #d95e35;
        --muted: #6b7280;
        --radius: 8px;
        --font-sans: 'Poppins', sans-serif;
      }

      html,body{height:100%}
      body{
        font-family:var(--font-sans);
        background: linear-gradient(180deg, var(--bg) 0%, #eef2f7 100%);
        margin:0;
        color:#111827;
        -webkit-font-smoothing:antialiased;
        -moz-osx-font-smoothing:grayscale;
      }

      .topbar{
        background: linear-gradient(90deg, var(--primary), #111827);
        color:white;
        box-shadow:0 6px 18px rgba(16,24,40,0.08);
      }
      .navbar-brand{ font-weight:700; letter-spacing:0.2px }
      .navbar-nav .nav-link{ color: rgba(255,255,255,0.9) !important }

      .dashboard-header{
        margin:24px auto 24px;
        max-width:1200px;
        background: linear-gradient(90deg, rgba(25,27,31,0.98), rgba(32,35,40,0.95));
        color:white;
        padding:28px 28px;
        border-radius:8px;
        box-shadow:0 10px 30px rgba(15,23,42,0.12);
        display:flex;
        align-items:center;
        justify-content:space-between;
        gap:16px;
      }
      .dashboard-header h1{ margin:0; font-size:20px; font-weight:700 }
      .dashboard-header p{ margin:6px 0 0; color: rgba(255,255,255,0.85); font-size:13px }

      .header-stats{ text-align:right }
      .header-stats .stat{ font-weight:600; font-size:18px }
      .header-stats .muted{ color: rgba(255,255,255,0.8); font-size:13px }

      .card{
        background: var(--card-bg);
        border: none;
        border-radius: var(--radius);
        box-shadow: 0 6px 20px rgba(17,24,39,0.06);
        transition: transform .18s ease, box-shadow .18s ease;
      }
      .card:hover{ transform: translateY(-6px); box-shadow:0 12px 30px rgba(17,24,39,0.12) }
      .card .card-body{ padding:22px }
      .card-title{ font-weight:700; margin-bottom:6px; font-size:16px }
      .card-text{ color: var(--muted); font-size:13px; margin-bottom:14px }

      .btn-accent{
        background: var(--accent);
        color: white;
        font-weight:600;
        border-radius:8px;
        border:none;
        padding:8px 12px;
      }
      .btn-accent:hover{ filter:brightness(1.05) }

      .icon-circle{
        width:44px; height:44px; border-radius:10px; display:inline-flex; align-items:center; justify-content:center;
        background: linear-gradient(180deg, rgba(217,94,53,0.12), rgba(217,94,53,0.06));
        color: var(--accent);
        font-size:18px; margin-right:12px;
      }

      .container-cards{ max-width:1200px; margin:0 auto; }

      .dashboard-footer{ text-align:center; color:var(--muted); font-size:13px; margin-top:28px }

      a:focus, button:focus { outline: 3px solid rgba(217,94,53,0.18); outline-offset:2px }

      .welcome-text{ color: rgba(255,255,255,0.9); margin-right:12px }

      @media (max-width:768px){
        .dashboard-header{ flex-direction:column; align-items:flex-start }
        .header-stats{ width:100%; text-align:left }
      }

    </style>
  </head>

  <body>
    <%
        // Keep original flight_scheduler role check unchanged (behaviour preserved).
        if (session.getAttribute("username") == null || !"flight_scheduler".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>

    <!-- Top navigation -->
    <nav class="navbar topbar navbar-expand-lg">
      <div class="container-fluid">
        <a class="navbar-brand text-white d-flex align-items-center" href="#">
          <i class="bi bi-calendar3-event me-2" aria-hidden="true"></i>
          SkyLink Scheduler
        </a>

        <div class="d-flex align-items-center ms-auto">
          <div class="welcome-text me-2" role="status" aria-live="polite">
            Welcome, <strong><%= session.getAttribute("username") %></strong>
          </div>
          <a href="logout" class="btn btn-accent btn-sm d-flex align-items-center">
            <i class="bi bi-box-arrow-right me-2" aria-hidden="true"></i>
            Logout
          </a>
        </div>
      </div>
    </nav>

    <!-- Header / hero -->
    <div class="dashboard-header container">
      <div class="title">
        <h1>Flight Scheduler Dashboard</h1>
        <p>Manage flight operations — add, edit, reschedule flights and update seat availability.</p>
      </div>

      <div class="header-stats">
        <div class="stat">12 <span class="muted">Pending</span></div>
        <div class="muted">Schedules awaiting confirmation</div>
      </div>
    </div>

    <!-- Main content -->
    <main class="container-cards py-5">
      <div class="container">
        <div class="row g-4">

          <!-- Add New Flight -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-add-flight">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-plus-square"></i></span>
                  <h5 id="card-add-flight" class="card-title mb-0">Add New Flight</h5>
                </div>
                <p class="card-text">Create a new flight schedule with route and timing details.</p>
                <a href="add_flight.jsp" class="btn btn-accent mt-auto w-100" aria-label="Go to Add New Flight">Go</a>
              </div>
            </div>
          </div>

          <!-- Edit Flight Details -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-edit-flight">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-pencil-square"></i></span>
                  <h5 id="card-edit-flight" class="card-title mb-0">Edit Flight Details</h5>
                </div>
                <p class="card-text">Modify flight information such as times, aircraft, or crew.</p>
                <a href="edit_flight.jsp" class="btn btn-accent mt-auto w-100" aria-label="Go to Edit Flight Details">Go</a>
              </div>
            </div>
          </div>

          <!-- Reschedule Flight -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-reschedule-flight">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-arrow-repeat"></i></span>
                  <h5 id="card-reschedule-flight" class="card-title mb-0">Reschedule Flight</h5>
                </div>
                <p class="card-text">Change departure/arrival times and notify affected passengers.</p>
                <a href="reschedule_flight.jsp" class="btn btn-accent mt-auto w-100" aria-label="Go to Reschedule Flight">Go</a>
              </div>
            </div>
          </div>

          <!-- Update Seat Availability -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-update-seats">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-people"></i></span>
                  <h5 id="card-update-seats" class="card-title mb-0">Update Seat Availability</h5>
                </div>
                <p class="card-text">Adjust seat counts for classes and cabin configurations.</p>
                <a href="update_seats.jsp" class="btn btn-accent mt-auto w-100" aria-label="Go to Update Seat Availability">Go</a>
              </div>
            </div>
          </div>

        </div>

        <div class="dashboard-footer mt-4">Only authorized schedulers can change flight data. All changes are tracked for audit.</div>
      </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
