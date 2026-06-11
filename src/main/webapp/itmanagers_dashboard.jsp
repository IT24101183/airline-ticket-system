<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>IT Manager Dashboard</title>

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
        --primary: #0b1220;
        --accent: #0b84ff; /* IT blue accent */
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
        background: linear-gradient(90deg, rgba(11,18,32,0.98), rgba(16,22,36,0.95));
        color:white;
        padding:22px 22px;
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
      .card .card-body{ padding:18px }
      .card-title{ font-weight:700; margin-bottom:6px; font-size:16px }
      .card-text{ color: var(--muted); font-size:13px; margin-bottom:12px }

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
        background: linear-gradient(180deg, rgba(11,132,255,0.12), rgba(11,132,255,0.06));
        color: var(--accent);
        font-size:18px; margin-right:12px;
      }

      .container-cards{ max-width:1200px; margin:0 auto; }

      .dashboard-footer{ text-align:center; color:var(--muted); font-size:13px; margin-top:20px }

      a:focus, button:focus { outline: 3px solid rgba(11,132,255,0.18); outline-offset:2px }

      @media (max-width:768px){
        .dashboard-header{ flex-direction:column; align-items:flex-start }
        .header-stats{ width:100%; text-align:left }
      }

      /* small utility */
      .stat-big { font-size:22px; font-weight:800; }
      .muted-small { color: var(--muted); font-size:12px; }
    </style>
  </head>

  <body>
    <%
        // Role check for IT Manager (preserve behaviour: redirect to login if unauthorized)
        if (session.getAttribute("username") == null || !"it_manager".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
        }

        // Example dynamic values (replace with real queries)
        Integer serversUp = (Integer) session.getAttribute("serversUp");
        Integer serversDown = (Integer) session.getAttribute("serversDown");
        Integer openTickets = (Integer) session.getAttribute("openTickets");
        Integer pendingDeploys = (Integer) session.getAttribute("pendingDeploys");

        // fallback defaults if not set
        if (serversUp == null) serversUp = 8;
        if (serversDown == null) serversDown = 1;
        if (openTickets == null) openTickets = 14;
        if (pendingDeploys == null) pendingDeploys = 3;
    %>

    <!-- Top navigation -->
    <nav class="navbar topbar navbar-expand-lg">
      <div class="container-fluid">
        <a class="navbar-brand text-white d-flex align-items-center" href="#">
          <i class="bi bi-hdd-network me-2" aria-hidden="true"></i>
          SkyLink IT Console
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
        <h1>IT Manager Dashboard</h1>
        <p>Monitor infrastructure, deployments, incidents and backups. Quick actions for common admin tasks.</p>
      </div>

      <div class="header-stats">
        <div class="stat-big"><%= serversUp %> up / <%= serversDown %> down</div>
        <div class="muted-small">Servers status • <strong><%= openTickets %></strong> open incidents</div>
      </div>
    </div>

    <!-- Main content -->
    <main class="container-cards py-5">
      <div class="container">
        <div class="row g-4">

          <!-- View Servers -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-servers">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-server"></i></span>
                  <h5 id="card-servers" class="card-title mb-0">View Servers</h5>
                </div>
                <p class="card-text">See server health, CPU/memory, and uptime across environments.</p>
                <a href="view_servers.jsp" class="btn btn-accent mt-auto w-100" aria-label="View Servers">Open</a>
              </div>
            </div>
          </div>

          <!-- User & Access Management -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-users">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-people"></i></span>
                  <h5 id="card-users" class="card-title mb-0">User Management</h5>
                </div>
                <p class="card-text">Create users, assign roles, reset passwords and review access logs.</p>
                <a href="user_management.jsp" class="btn btn-accent mt-auto w-100" aria-label="Manage Users">Open</a>
              </div>
            </div>
          </div>

          <!-- Deployments -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-deploys">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-cloud-upload"></i></span>
                  <h5 id="card-deploys" class="card-title mb-0">Deployments</h5>
                </div>
                <p class="card-text">Manage and approve pending deployments to staging/production.</p>
                <a href="deploys.jsp" class="btn btn-accent mt-auto w-100" aria-label="View Deployments">
                  <span class="me-2"><i class="bi bi-clock-history"></i></span>
                  <span><%= pendingDeploys %> pending</span>
                </a>
              </div>
            </div>
          </div>

          <!-- Logs & Monitoring -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-logs">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-file-earmark-text"></i></span>
                  <h5 id="card-logs" class="card-title mb-0">Logs & Alerts</h5>
                </div>
                <p class="card-text">Search logs, inspect error traces and manage alert rules.</p>
                <a href="logs.jsp" class="btn btn-accent mt-auto w-100" aria-label="Open Logs">Open</a>
              </div>
            </div>
          </div>

          <!-- Backups -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-backups">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-database-fill-gear"></i></span>
                  <h5 id="card-backups" class="card-title mb-0">Backups</h5>
                </div>
                <p class="card-text">Schedule or run on-demand backups; verify restore points.</p>
                <a href="backups.jsp" class="btn btn-accent mt-auto w-100" aria-label="Open Backups">Open</a>
              </div>
            </div>
          </div>

          <!-- Network Monitor -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-network">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-wifi"></i></span>
                  <h5 id="card-network" class="card-title mb-0">Network Monitor</h5>
                </div>
                <p class="card-text">Live network stats, latency, bandwidth and interface health.</p>
                <a href="network_monitor.jsp" class="btn btn-accent mt-auto w-100" aria-label="Open Network Monitor">Open</a>
              </div>
            </div>
          </div>

          <!-- Incident Tickets -->
          <div class="col-12 col-sm-6 col-lg-3">
            <div class="card h-100" role="region" aria-labelledby="card-tickets">
              <div class="card-body d-flex flex-column">
                <div class="d-flex align-items-center mb-2">
                  <span class="icon-circle" aria-hidden="true"><i class="bi bi-exclamation-triangle"></i></span>
                  <h5 id="card-tickets" class="card-title mb-0">Incident Tickets</h5>
                </div>
                <p class="card-text">Track and assign incident tickets, SLA statuses and escalations.</p>
                <a href="tickets.jsp" class="btn btn-accent mt-auto w-100" aria-label="Open Tickets">
                  <span class="me-2"><i class="bi bi-envelope-open"></i></span>
                  <span><%= openTickets %> open</span>
                </a>
              </div>
            </div>
          </div>

          <!-- Quick Actions card -->
          <div class="col-12 col-lg-6">
            <div class="card h-100" role="region" aria-labelledby="card-quick-actions">
              <div class="card-body">
                <div class="d-flex align-items-center mb-3">
                  <h5 id="card-quick-actions" class="card-title mb-0">Quick Actions</h5>
                </div>

                <div class="row g-2">
                  <div class="col-6 col-sm-4 col-md-3">
                    <a href="restart_service.jsp" class="btn btn-outline-secondary w-100" role="button">
                      <i class="bi bi-arrow-repeat me-1"></i> Restart Service
                    </a>
                  </div>
                  <div class="col-6 col-sm-4 col-md-3">
                    <a href="run_backup.jsp" class="btn btn-outline-secondary w-100" role="button">
                      <i class="bi bi-cloud-arrow-up me-1"></i> Run Backup
                    </a>
                  </div>
                  <div class="col-6 col-sm-4 col-md-3">
                    <a href="create_user.jsp" class="btn btn-outline-secondary w-100" role="button">
                      <i class="bi bi-person-plus me-1"></i> Create User
                    </a>
                  </div>
                  <div class="col-6 col-sm-4 col-md-3">
                    <a href="run_diagnostics.jsp" class="btn btn-outline-secondary w-100" role="button">
                      <i class="bi bi-activity me-1"></i> Run Diagnostics
                    </a>
                  </div>
                </div>

                <p class="card-text mt-3 muted-small">Use the quick actions for common admin tasks. Actions are audited.</p>
              </div>
            </div>
          </div>

        </div>

        <div class="dashboard-footer mt-4">Only authorized IT managers can perform infrastructure changes. All actions are logged for audit and compliance.</div>
      </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  </body>
</html>
