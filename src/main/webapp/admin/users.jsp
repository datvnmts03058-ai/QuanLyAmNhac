<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.functions" prefix="fn"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>User Management — Spotify Admin</title>
<link href="https://fonts.googleapis.com/css2?family=Circular+Std:wght@400;500;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  :root {
    --bg-base:       #0a0a0a;
    --bg-surface:    #121212;
    --bg-elevated:   #181818;
    --bg-overlay:    #242424;
    --bg-hover:      #2a2a2a;
    --green:         #1DB954;
    --green-dim:     #158a3e;
    --green-glow:    rgba(29,185,84,.18);
    --red:           #e5484d;
    --red-dim:       rgba(229,72,77,.15);
    --yellow:        #f1c40f;
    --yellow-dim:    rgba(241,196,15,.15);
    --blue:          #3d8ef0;
    --blue-dim:      rgba(61,142,240,.15);
    --text-primary:  #ffffff;
    --text-secondary:#b3b3b3;
    --text-muted:    #6a6a6a;
    --border:        rgba(255,255,255,.07);
    --border-hover:  rgba(255,255,255,.14);
    --radius-sm:     8px;
    --radius-md:     12px;
    --radius-lg:     20px;
    --radius-xl:     28px;
    --font:          'DM Sans', sans-serif;
    --transition:    all .2s cubic-bezier(.4,0,.2,1);
  }

  html { scroll-behavior: smooth; }

  body {
    background: var(--bg-base);
    color: var(--text-primary);
    font-family: var(--font);
    min-height: 100vh;
    padding: 0;
    overflow-x: hidden;
  }

  /* ─── SIDEBAR STRIPE ─── */
  body::before {
    content: '';
    position: fixed;
    left: 0; top: 0;
    width: 3px; height: 100%;
    background: linear-gradient(180deg, var(--green) 0%, transparent 100%);
    z-index: 100;
  }

  /* ─── MAIN WRAPPER ─── */
  .dashboard {
    max-width: 1280px;
    margin: 0 auto;
    padding: 40px 48px 80px;
  }

  /* ─── TOP HEADER ─── */
  .page-header {
    display: flex;
    align-items: flex-end;
    justify-content: space-between;
    margin-bottom: 48px;
    gap: 24px;
    flex-wrap: wrap;
  }

  .page-header__title-group {}

  .page-header__eyebrow {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: .14em;
    text-transform: uppercase;
    color: var(--green);
    margin-bottom: 10px;
  }

  .page-header__eyebrow::before {
    content: '';
    display: inline-block;
    width: 18px; height: 2px;
    background: var(--green);
    border-radius: 2px;
  }

  .page-header__title {
    font-size: clamp(28px, 4vw, 46px);
    font-weight: 700;
    letter-spacing: -.02em;
    line-height: 1.1;
    color: var(--text-primary);
  }

  .page-header__subtitle {
    font-size: 14px;
    color: var(--text-secondary);
    margin-top: 8px;
    font-weight: 400;
  }

  .page-header__actions {
    display: flex;
    gap: 10px;
    align-items: center;
    flex-shrink: 0;
  }

  .btn {
    display: inline-flex;
    align-items: center;
    gap: 7px;
    padding: 11px 22px;
    border-radius: var(--radius-xl);
    font-family: var(--font);
    font-size: 14px;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    border: none;
    transition: var(--transition);
    white-space: nowrap;
  }

  .btn-ghost {
    background: var(--bg-elevated);
    color: var(--text-primary);
    border: 1px solid var(--border);
  }
  .btn-ghost:hover {
    background: var(--bg-hover);
    border-color: var(--border-hover);
    transform: translateY(-1px);
  }

  .btn-primary {
    background: var(--green);
    color: #000;
  }
  .btn-primary:hover {
    background: #22d660;
    transform: translateY(-1px);
    box-shadow: 0 8px 24px var(--green-glow);
  }

  .btn-primary.active {
    background: var(--bg-hover);
    color: var(--text-secondary);
    border: 1px solid var(--border);
  }

  /* ─── STAT CARDS ─── */
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 16px;
    margin-bottom: 40px;
  }

  .stat-card {
    background: var(--bg-elevated);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 28px 28px 24px;
    position: relative;
    overflow: hidden;
    transition: var(--transition);
    cursor: default;
  }

  .stat-card::after {
    content: '';
    position: absolute;
    inset: 0;
    background: linear-gradient(135deg, var(--green-glow) 0%, transparent 60%);
    opacity: 0;
    transition: var(--transition);
  }

  .stat-card:hover {
    border-color: rgba(29,185,84,.3);
    transform: translateY(-3px);
    box-shadow: 0 16px 48px rgba(0,0,0,.4);
  }
  .stat-card:hover::after { opacity: 1; }

  .stat-card__icon {
    font-size: 26px;
    margin-bottom: 16px;
    display: block;
    filter: drop-shadow(0 0 12px var(--green-glow));
  }

  .stat-card__label {
    font-size: 11px;
    font-weight: 700;
    letter-spacing: .1em;
    text-transform: uppercase;
    color: var(--text-muted);
    margin-bottom: 10px;
  }

  .stat-card__value {
    font-size: 40px;
    font-weight: 700;
    color: var(--green);
    letter-spacing: -.03em;
    line-height: 1;
  }

  .stat-card__sub {
    font-size: 12px;
    color: var(--text-muted);
    margin-top: 6px;
  }

  /* ─── FORM CARD ─── */
  .form-wrapper {
    display: none;
    margin-bottom: 32px;
    animation: slideDown .25s ease;
  }

  .form-wrapper.open { display: block; }

  @keyframes slideDown {
    from { opacity: 0; transform: translateY(-12px); }
    to   { opacity: 1; transform: translateY(0); }
  }

  .form-card {
    background: var(--bg-elevated);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    padding: 36px 40px;
  }

  .form-card__title {
    font-size: 16px;
    font-weight: 700;
    color: var(--text-primary);
    margin-bottom: 28px;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .form-card__title::before {
    content: '';
    display: inline-block;
    width: 4px; height: 18px;
    background: var(--green);
    border-radius: 4px;
  }

  .form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 14px;
    margin-bottom: 14px;
  }

  .form-group { display: flex; flex-direction: column; gap: 6px; }
  .form-group.full { grid-column: 1 / -1; }

  .form-group label {
    font-size: 11px;
    font-weight: 600;
    letter-spacing: .08em;
    text-transform: uppercase;
    color: var(--text-muted);
  }

  .form-group input,
  .form-group select {
    background: var(--bg-overlay);
    color: var(--text-primary);
    border: 1px solid var(--border);
    border-radius: var(--radius-md);
    padding: 13px 16px;
    font-family: var(--font);
    font-size: 14px;
    outline: none;
    transition: var(--transition);
    width: 100%;
  }

  .form-group input::placeholder { color: var(--text-muted); }

  .form-group input:focus,
  .form-group select:focus {
    border-color: var(--green);
    box-shadow: 0 0 0 3px var(--green-glow);
    background: var(--bg-hover);
  }

  .form-group select option { background: var(--bg-elevated); }

  .form-submit {
    margin-top: 8px;
    display: flex;
    justify-content: flex-end;
  }

  .btn-save {
    padding: 13px 36px;
    font-size: 15px;
    letter-spacing: .01em;
  }

  /* ─── TABLE CARD ─── */
  .table-card {
    background: var(--bg-elevated);
    border: 1px solid var(--border);
    border-radius: var(--radius-lg);
    overflow: hidden;
  }

  .table-card__header {
    padding: 24px 32px 20px;
    border-bottom: 1px solid var(--border);
    display: flex;
    align-items: center;
    justify-content: space-between;
    gap: 16px;
  }

  .table-card__header-title {
    font-size: 15px;
    font-weight: 700;
    display: flex;
    align-items: center;
    gap: 10px;
  }

  .table-card__header-title::before {
    content: '';
    display: inline-block;
    width: 4px; height: 16px;
    background: var(--green);
    border-radius: 4px;
  }

  .table-card__count {
    font-size: 12px;
    color: var(--text-muted);
    background: var(--bg-overlay);
    border: 1px solid var(--border);
    border-radius: 20px;
    padding: 4px 12px;
  }

  /* TABLE */
  .users-table {
    width: 100%;
    border-collapse: collapse;
  }

  .users-table thead tr {
    background: var(--bg-surface);
  }

  .users-table thead th {
    padding: 14px 20px;
    font-size: 10px;
    font-weight: 700;
    letter-spacing: .12em;
    text-transform: uppercase;
    color: var(--text-muted);
    text-align: left;
    white-space: nowrap;
  }

  .users-table thead th:first-child { padding-left: 32px; }
  .users-table thead th:last-child  { padding-right: 32px; text-align: right; }

  .users-table tbody tr {
    border-top: 1px solid var(--border);
    transition: background .15s ease;
  }

  .users-table tbody tr:hover {
    background: rgba(255,255,255,.03);
  }

  .users-table tbody td {
    padding: 18px 20px;
    font-size: 14px;
    vertical-align: middle;
  }

  .users-table tbody td:first-child { padding-left: 32px; }
  .users-table tbody td:last-child  { padding-right: 32px; }

  /* ID cell */
  .cell-id {
    font-size: 12px;
    font-weight: 700;
    color: var(--text-muted);
    font-variant-numeric: tabular-nums;
    width: 60px;
  }

  /* User cell */
  .user-cell {
    display: flex;
    align-items: center;
    gap: 14px;
  }

  .user-avatar {
    width: 42px; height: 42px;
    border-radius: 50%;
    background: linear-gradient(135deg, var(--green-dim), var(--bg-overlay));
    border: 1px solid var(--border);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    font-weight: 700;
    color: var(--green);
    flex-shrink: 0;
    text-transform: uppercase;
  }

  .user-info__name {
    font-size: 14px;
    font-weight: 600;
    color: var(--text-primary);
    line-height: 1.2;
  }

  .user-info__handle {
    font-size: 12px;
    color: var(--text-muted);
    margin-top: 2px;
  }

  /* Email cell */
  .cell-email {
    color: var(--text-secondary);
    font-size: 13px;
  }

  /* Role badge */
  .badge {
    display: inline-flex;
    align-items: center;
    gap: 5px;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: .06em;
    text-transform: uppercase;
  }

  .badge-admin {
    background: var(--red-dim);
    color: var(--red);
    border: 1px solid rgba(229,72,77,.25);
  }
  .badge-admin::before { content: '●'; font-size: 7px; }

  .badge-user {
    background: var(--green-glow);
    color: var(--green);
    border: 1px solid rgba(29,185,84,.25);
  }
  .badge-user::before { content: '●'; font-size: 7px; }

  /* Actions cell */
  .actions-cell {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    gap: 8px;
  }

  .action-btn {
    width: 36px; height: 36px;
    border-radius: 50%;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    font-size: 15px;
    text-decoration: none;
    border: none;
    cursor: pointer;
    transition: var(--transition);
    position: relative;
    flex-shrink: 0;
  }

  .action-btn:hover { transform: scale(1.18); }

  .action-btn-edit {
    background: var(--yellow-dim);
    color: var(--yellow);
    border: 1px solid rgba(241,196,15,.2);
  }
  .action-btn-edit:hover {
    background: rgba(241,196,15,.25);
    box-shadow: 0 4px 16px rgba(241,196,15,.2);
  }

  .action-btn-view {
    background: var(--blue-dim);
    color: var(--blue);
    border: 1px solid rgba(61,142,240,.2);
  }
  .action-btn-view:hover {
    background: rgba(61,142,240,.25);
    box-shadow: 0 4px 16px rgba(61,142,240,.2);
  }

  .action-btn-delete {
    background: var(--red-dim);
    color: var(--red);
    border: 1px solid rgba(229,72,77,.2);
  }
  .action-btn-delete:hover {
    background: rgba(229,72,77,.25);
    box-shadow: 0 4px 16px rgba(229,72,77,.2);
  }

  /* delete form inline */
  .delete-form { display: contents; }

  /* ─── EMPTY STATE ─── */
  .empty-state {
    text-align: center;
    padding: 80px 20px;
    color: var(--text-muted);
  }
  .empty-state__icon { font-size: 48px; margin-bottom: 16px; }
  .empty-state__text { font-size: 16px; font-weight: 600; margin-bottom: 8px; color: var(--text-secondary); }
  .empty-state__sub  { font-size: 13px; }

  /* ─── SCROLLBAR ─── */
  ::-webkit-scrollbar { width: 6px; height: 6px; }
  ::-webkit-scrollbar-track { background: var(--bg-surface); }
  ::-webkit-scrollbar-thumb { background: var(--bg-hover); border-radius: 8px; }
  ::-webkit-scrollbar-thumb:hover { background: var(--text-muted); }

  /* ─── RESPONSIVE ─── */
  @media (max-width: 900px) {
    .dashboard { padding: 28px 20px 60px; }
    .form-grid { grid-template-columns: 1fr; }
    .form-card { padding: 24px 20px; }
    .table-card__header { padding: 18px 20px; }
    .users-table thead th:first-child,
    .users-table tbody td:first-child { padding-left: 20px; }
    .users-table thead th:last-child,
    .users-table tbody td:last-child  { padding-right: 20px; }
  }

  @media (max-width: 640px) {
    .page-header { flex-direction: column; align-items: flex-start; }
    .cell-email  { display: none; }
  }
</style>
</head>
<body>

<main class="dashboard">

  <!-- ══════════ HEADER ══════════ -->
  <header class="page-header">
    <div class="page-header__title-group">
      <div class="page-header__eyebrow">Admin Dashboard</div>
      <h1 class="page-header__title">User Management</h1>
      <p class="page-header__subtitle">Manage listeners, roles, and account access across your platform.</p>
    </div>

    <div class="page-header__actions">
      <a href="${pageContext.request.contextPath}/home" class="btn btn-ghost">
        🏠 Home
      </a>
      <button id="toggleFormBtn" class="btn btn-primary">
        ➕ Add User
      </button>
    </div>
  </header>

  <!-- ══════════ STAT CARDS ══════════ -->
  <section class="stats-grid">

    <div class="stat-card">
      <span class="stat-card__icon">🎧</span>
      <div class="stat-card__label">Active Listeners</div>
      <div class="stat-card__value">${activeUsers}</div>
      <div class="stat-card__sub">currently streaming</div>
    </div>

    <div class="stat-card">
      <span class="stat-card__icon">👥</span>
      <div class="stat-card__label">Total Users</div>
      <div class="stat-card__value">${totalUsers}</div>
      <div class="stat-card__sub">registered accounts</div>
    </div>

  </section>

  <!-- ══════════ ADD USER FORM ══════════ -->
  <div id="userFormContainer" class="form-wrapper">
    <div class="form-card">
      <div class="form-card__title">New User Account</div>

      <form method="post" action="${pageContext.request.contextPath}/users">
        <input type="hidden" name="id" value="${form.id}">

        <div class="form-grid">
          <div class="form-group">
            <label for="f-username">Username</label>
            <input type="text" id="f-username" name="username" placeholder="e.g. john_doe">
          </div>
          <div class="form-group">
            <label for="f-password">Password</label>
            <input type="password" id="f-password" name="password" placeholder="••••••••">
          </div>
          <div class="form-group">
            <label for="f-fullname">Full Name</label>
            <input type="text" id="f-fullname" name="fullname" placeholder="e.g. John Doe">
          </div>
          <div class="form-group">
            <label for="f-email">Email</label>
            <input type="email" id="f-email" name="email" placeholder="e.g. john@example.com">
          </div>
          <div class="form-group">
            <label for="f-role">Role</label>
            <select id="f-role" name="role">
              <option value="USER">USER</option>
              <option value="ADMIN">ADMIN</option>
            </select>
          </div>
        </div>

        <div class="form-submit">
          <button type="submit" class="btn btn-primary btn-save">💾 Save User</button>
        </div>
      </form>
    </div>
  </div>

  <!-- ══════════ USERS TABLE ══════════ -->
  <div class="table-card">
    <div class="table-card__header">
      <span class="table-card__header-title">All Accounts</span>
      <span class="table-card__count">${totalUsers} users</span>
    </div>

    <table class="users-table">
      <thead>
        <tr>
          <th>#</th>
          <th>User</th>
          <th>Email</th>
          <th>Role</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty users}">
            <tr>
              <td colspan="5">
                <div class="empty-state">
                  <div class="empty-state__icon">🎵</div>
                  <div class="empty-state__text">No users found</div>
                  <div class="empty-state__sub">Add your first user with the button above.</div>
                </div>
              </td>
            </tr>
          </c:when>
          <c:otherwise>
            <c:forEach items="${users}" var="u">
              <tr>

                <!-- ID -->
                <td class="cell-id">${u.id}</td>

                <!-- User -->
                <td>
                  <div class="user-cell">
                    <div class="user-avatar">
                      ${fn:substring(u.fullname, 0, 1)}
                    </div>
                    <div>
                      <div class="user-info__name">${u.fullname}</div>
                      <div class="user-info__handle">@${u.username}</div>
                    </div>
                  </div>
                </td>

                <!-- Email -->
                <td class="cell-email">${u.email}</td>

                <!-- Role -->
                <td>
                  <c:choose>
                    <c:when test="${u.role == 'ADMIN'}">
                      <span class="badge badge-admin">ADMIN</span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge badge-user">USER</span>
                    </c:otherwise>
                  </c:choose>
                </td>

                <!-- Actions -->
                <td>
    			<div class="actions-cell">
        		<c:choose>
            <c:when test="${u.role == 'ADMIN'}">

                <span style="color: var(--text-muted); font-size:12px;">
                    🔒 Locked
                </span>

            </c:when>

            <c:otherwise>

                <a href="${pageContext.request.contextPath}/users?action=edit&id=${u.id}"
                   class="action-btn action-btn-edit"
                   title="Edit">✏️</a>
                   
                <a href="${pageContext.request.contextPath}/users?action=detail&id=${u.id}"
                   class="action-btn action-btn-view"
                   title="View">👁️</a>
                   
                <form method="post"
                      action="${pageContext.request.contextPath}/users"
                      class="delete-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="${u.id}">
                    <button type="submit"
                            class="action-btn action-btn-delete"
                            title="Delete"
                            onclick="return confirm('Delete user ${u.fullname}?')">🗑️</button>

                </form>
            </c:otherwise>
        </c:choose>

		    </div>
		</td>

              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>

</main>

<script>
  const toggleBtn       = document.getElementById("toggleFormBtn");
  const formContainer   = document.getElementById("userFormContainer");

  toggleBtn.onclick = () => {
    const show = !formContainer.classList.contains("open");
    formContainer.classList.toggle("open", show);
    toggleBtn.textContent = show ? "❌ Close" : "➕ Add User";
    toggleBtn.classList.toggle("active", show);
    if (show) formContainer.scrollIntoView({ behavior: "smooth", block: "nearest" });
  };
</script>

</body>
</html>
