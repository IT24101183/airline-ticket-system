<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>IT Administrator Dashboard</title>

    <!-- Google font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet" />

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet" />

    <style>
      :root{
        --bg: #f4f7fb;
        --nav: #0b1220;
        --accent: #0b84ff;
        --card: #ffffff;
        --muted: #6b7280;
        --radius: 10px;
        --font: 'Poppins', sans-serif;
      }

      html,body{height:100%}
      body{
        font-family:var(--font);
        background: linear-gradient(180deg,var(--bg),#eef4fb);
        margin:0;
        -webkit-font-smoothing:antialiased;
      }

      .topbar{
        background: linear-gradient(90deg,var(--nav), #111827);
        color: #fff;
        padding: 12px 0;
        box-shadow: 0 6px 18px rgba(16,24,40,0.08);
      }

      .navbar-brand{ font-weight:700; letter-spacing:0.2px; color:#fff !important; }
      .welcome { color: rgba(255,255,255,0.9); }

      .hero {
        max-width:1100px;
        margin: 22px auto;
        background: linear-gradient(90deg, rgba(11,18,32,0.98), rgba(14,22,36,0.95));
        color: #fff;
        border-radius: 12px;
        padding: 20px 22px;
        display:flex;
        align-items:center;
        justify-content:space-between;
        gap:12px;
      }
      .hero h1 { margin:0; font-size:20px; font-weight:700; }
      .hero p { margin:6px 0 0; color: rgba(255,255,255,0.85); }

      .container-cards{ max-width:1100px; margin: 18px auto; }

      .card {
        border: none;
        border-radius: var(--radius);
        box-shadow: 0 6px 20px rgba(17,24,39,0.06);
      }
      .card .card-body { padding:18px; }
      .card-title { font-weight:700; margin-bottom:6px; }
      .muted { color: var(--muted); font-size:13px; }

      .icon {
        width:46px; height:46px; border-radius:10px; display:inline-flex; align-items:center; justify-content:center;
        background: linear-gradient(180deg, rgba(11,132,255,0.12), rgba(11,132,255,0.06));
        color: var(--accent);
        font-size:18px; margin-right:12px;
      }

      .btn-accent {
        background: var(--accent);
        color: #fff;
        border-radius:10px;
        font-weight:600;
        border: none;
      }
      .btn-accent:focus { box-shadow: 0 0 0 4px rgba(11,132,255,0.12); }

      @media (max-width:768px){
        .hero { flex-direction:column; align-items:flex-start; }
      }
    </style>
  </head>

  <body>
    <%
        // PRESERVED: role check must remain exactly as before (functionality unchanged)
        if (session.getAttribute("username") == null || !"it_admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }
    %>

    <!-- Top navigation -->
    <nav class="topbar">
      <div class="container d-flex align-items-center">
        <a class="navbar-brand d-flex align-items-center" href="#">
          <i class="bi bi-shield-lock-fill me-2" aria-hidden="true"></i>
          SkyLink IT Admin
        </a>

        <div class="ms-auto d-flex align-items-center">
          <div class="me-3 welcome" aria-live="polite">Welcome, <strong><%= session.getAttribute("username") %></strong></div>
          <a href="logout" class="btn btn-outline-light btn-sm d-flex align-items-center">
            <i class="bi bi-box-arrow-right me-1" aria-hidden="true"></i> Logout
          </a>
        </div>
      </div>
    </nav>

    <!-- Hero -->
    <section class="hero" role="region" aria-label="Dashboard header">
      <div>
        <h1>IT Administrator Dashboard</h1>
        <p>Manage users, backups, and performance logs — quick access to common admin tasks.</p>
      </div>

      <div class="text-end">
        <div class="small muted">Role</div>
        <div style="font-weight:700">IT Administrator</div>
      </div>
    </section>

    <!-- Main -->
    <main class="container-cards">
      <div class="container">
        <div class="row g-4">

          <!-- Primary actions -->
          <div class="col-12 col-lg-8">
            <div class="card">
              <div class="card-body">
                <div class="d-flex align-items-center mb-3">
                  <span class="icon" aria-hidden="true"><i class="bi bi-people-fill"></i></span>
                  <div>
                    <h5 class="card-title mb-0">Administrator Actions</h5>
                    <div class="muted">Quick links to frequently used admin pages</div>
                  </div>
                </div>

                <!-- ✅ Your original button added here -->
                      <div class="mb-3">
                        <a href="manage_users.jsp" class="btn btn-primary">Manage User Accounts</a>
                      </div>




                <div class="row g-2 mt-3">
                  <div class="col-12 col-sm-6 col-md-4">
                    <a href="manage_users.jsp" class="btn btn-accent w-100 d-flex align-items-center justify-content-center" role="button" aria-label="Manage user accounts">
                      <i class="bi bi-person-lines-fill me-2" aria-hidden="true"></i> Manage User Accounts
                    </a>
                  </div>

                  <div class="col-12 col-sm-6 col-md-4">
                    <a href="schedule_backups.jsp" class="btn btn-outline-secondary w-100 d-flex align-items-center justify-content-center" role="button" aria-label="Schedule backups">
                      <i class="bi bi-clock-history me-2" aria-hidden="true"></i> Schedule Backups
                    </a>
                  </div>

                  <div class="col-12 col-sm-6 col-md-4">
                    <a href="monitor_logs.jsp" class="btn btn-outline-secondary w-100 d-flex align-items-center justify-content-center" role="button" aria-label="Monitor performance logs">
                      <i class="bi bi-file-earmark-text me-2" aria-hidden="true"></i> Monitor Performance Logs
                    </a>
                  </div>
                </div>

                <div class="mt-4 muted">Tip: All actions are audited. Use the links above to perform the same tasks as before — only the look changed.</div>
              </div>
            </div>
          </div>

          <!-- Status / quick info -->
          <div class="col-12 col-lg-4">
            <div class="card h-100">
              <div class="card-body">
                <h6 class="card-title">Quick Status</h6>
                <div class="row">
                  <div class="col-6">
                    <div class="muted">Users</div>
                    <div style="font-weight:700; font-size:18px;">—</div>
                  </div>
                  <div class="col-6">
                    <div class="muted">Backups</div>
                    <div style="font-weight:700; font-size:18px;">—</div>
                  </div>
                </div>

                <hr />

                <div class="d-grid gap-2">
                  <a href="manage_users.jsp" class="btn btn-sm btn-outline-primary" role="button"><i class="bi bi-gear-fill me-1"></i> User Tools</a>
                  <a href="schedule_backups.jsp" class="btn btn-sm btn-outline-primary" role="button"><i class="bi bi-hdd-stack me-1"></i> Backup Console</a>
                  <a href="monitor_logs.jsp" class="btn btn-sm btn-outline-primary" role="button"><i class="bi bi-search me-1"></i> Log Viewer</a>
                </div>
              </div>
            </div>
          </div>

        </div>

        <div class="text-center muted mt-4">If you want a darker theme, compact layout, or to include small status widgets (users/backup history), I can add that next — functionality will remain unchanged.</div>
      </div>
    </main>

    <footer class="container text-center mt-4 mb-4 muted">
      &copy; <%= java.time.Year.now() %> SkyLink IT · All admin actions are logged.
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
