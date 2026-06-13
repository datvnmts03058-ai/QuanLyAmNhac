<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reports Management</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>

/* ─── RESET & BASE ─────────────────────────────────────────── */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --bg:           #0f0f0f;
  --bg2:          #121212;
  --card:         rgba(24,24,24,0.72);
  --card-border:  rgba(29,185,84,0.18);
  --green:        #1db954;
  --green-dim:    rgba(29,185,84,0.15);
  --green-glow:   rgba(29,185,84,0.35);
  --success:      #4CAF50;
  --danger:       #F44336;
  --danger-dim:   rgba(244,67,54,0.15);
  --warning:      #FF9800;
  --info:         #2196F3;
  --text:         #ffffff;
  --text2:        #b3b3b3;
  --text3:        #6b6b6b;
  --row-hover:    rgba(29,185,84,0.07);
  --zebra:        rgba(255,255,255,0.025);
  --radius:       14px;
  --radius-sm:    8px;
  --transition:   0.3s cubic-bezier(.4,0,.2,1);
}

body {
  font-family: 'Inter', sans-serif;
  background: var(--bg);
  color: var(--text);
  min-height: 100vh;
  position: relative;
  overflow-x: hidden;
}

/* ─── ANIMATED BACKGROUND ──────────────────────────────────── */
body::before,
body::after {
  content: '';
  position: fixed;
  border-radius: 50%;
  filter: blur(120px);
  pointer-events: none;
  animation: drift 18s ease-in-out infinite alternate;
  z-index: 0;
}
body::before {
  width: 600px; height: 600px;
  background: radial-gradient(circle, rgba(29,185,84,0.12) 0%, transparent 70%);
  top: -180px; left: -180px;
}
body::after {
  width: 500px; height: 500px;
  background: radial-gradient(circle, rgba(29,185,84,0.08) 0%, transparent 70%);
  bottom: -150px; right: -150px;
  animation-delay: -9s;
}

.bg-orb {
  position: fixed;
  width: 300px; height: 300px;
  background: radial-gradient(circle, rgba(29,185,84,0.06) 0%, transparent 70%);
  border-radius: 50%;
  filter: blur(80px);
  top: 50%; left: 50%;
  transform: translate(-50%,-50%);
  animation: drift 25s ease-in-out infinite alternate-reverse;
  pointer-events: none;
  z-index: 0;
}

@keyframes drift {
  0%   { transform: translate(0,0) scale(1); }
  33%  { transform: translate(40px,-30px) scale(1.08); }
  66%  { transform: translate(-30px,20px) scale(0.95); }
  100% { transform: translate(20px,40px) scale(1.05); }
}

/* ─── WRAPPER ──────────────────────────────────────────────── */
.rm-wrapper {
  position: relative;
  z-index: 1;
  padding: 28px 24px 48px;
  max-width: 1200px;
  margin: 0 auto;
  animation: fadeUp 0.55s var(--transition) both;
}

@keyframes fadeUp {
  from { opacity: 0; transform: translateY(24px); }
  to   { opacity: 1; transform: translateY(0); }
}

/* ─── PAGE HEADER ──────────────────────────────────────────── */
.rm-header {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-bottom: 28px;
}
.rm-header-icon {
  width: 42px; height: 42px;
  background: var(--green-dim);
  border: 1px solid var(--card-border);
  border-radius: var(--radius-sm);
  display: flex; align-items: center; justify-content: center;
  font-size: 20px;
  box-shadow: 0 0 18px var(--green-glow);
}
.rm-header h1 {
  font-size: 1.45rem;
  font-weight: 700;
  letter-spacing: -0.02em;
  background: linear-gradient(90deg, #fff 0%, #b3b3b3 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
.rm-header span {
  font-size: 0.78rem;
  color: var(--text3);
  font-weight: 400;
  -webkit-text-fill-color: var(--text3);
}

/* ─── SUB-TABS NAV ─────────────────────────────────────────── */
.sub-tabs {
  display: flex;
  gap: 8px;
  padding: 6px;
  background: rgba(255,255,255,0.04);
  border: 1px solid rgba(255,255,255,0.07);
  border-radius: calc(var(--radius) + 2px);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  margin-bottom: 24px;
  width: fit-content;
}

.sub-tabs button {
  position: relative;
  padding: 9px 22px;
  background: transparent;
  border: none;
  border-radius: var(--radius-sm);
  color: var(--text2);
  font-family: 'Inter', sans-serif;
  font-size: 0.875rem;
  font-weight: 500;
  cursor: pointer;
  transition: all var(--transition);
  white-space: nowrap;
  letter-spacing: 0.01em;
}

.sub-tabs button::after {
  content: '';
  position: absolute;
  bottom: 4px; left: 20%; right: 20%;
  height: 2px;
  background: var(--green);
  border-radius: 2px;
  opacity: 0;
  transform: scaleX(0);
  transition: all var(--transition);
}

.sub-tabs button:hover {
  color: var(--text);
  background: rgba(255,255,255,0.06);
  transform: scale(1.04);
}

.sub-tabs button.active-sub {
  color: var(--green);
  background: var(--green-dim);
  box-shadow: 0 0 20px var(--green-glow), inset 0 1px 0 rgba(29,185,84,0.3);
}
.sub-tabs button.active-sub::after {
  opacity: 1;
  transform: scaleX(1);
}

/* ─── REPORT AREA PANEL ────────────────────────────────────── */
.report-area {
  background: var(--card);
  border: 1px solid var(--card-border);
  border-radius: var(--radius);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  padding: 28px;
  box-shadow: 0 8px 40px rgba(0,0,0,0.4), 0 0 0 1px rgba(29,185,84,0.06);
  animation: panelIn 0.4s var(--transition) both;
  overflow: hidden;
}

@keyframes panelIn {
  from { opacity: 0; transform: translateY(14px); }
  to   { opacity: 1; transform: translateY(0); }
}

.report-area h3 {
  font-size: 1rem;
  font-weight: 600;
  color: var(--text);
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 8px;
}
.report-area h3::before {
  content: '';
  display: inline-block;
  width: 3px; height: 18px;
  background: var(--green);
  border-radius: 2px;
  box-shadow: 0 0 8px var(--green);
}

/* ─── SECTION TITLE ────────────────────────────────────────── */
.section-label {
  font-size: 0.72rem;
  font-weight: 600;
  letter-spacing: 0.12em;
  text-transform: uppercase;
  color: var(--green);
  margin-bottom: 14px;
  display: flex;
  align-items: center;
  gap: 8px;
}
.section-label::after {
  content: '';
  flex: 1;
  height: 1px;
  background: linear-gradient(90deg, var(--card-border), transparent);
}

/* ─── TABLES ───────────────────────────────────────────────── */
.rm-table-wrap {
  overflow-x: auto;
  border-radius: var(--radius-sm);
  /* custom scrollbar */
  scrollbar-width: thin;
  scrollbar-color: var(--green) transparent;
}
.rm-table-wrap::-webkit-scrollbar { height: 5px; }
.rm-table-wrap::-webkit-scrollbar-track { background: transparent; }
.rm-table-wrap::-webkit-scrollbar-thumb { background: var(--green); border-radius: 10px; }

table {
  width: 100%;
  border-collapse: separate;
  border-spacing: 0;
  font-size: 0.875rem;
}

thead tr {
  background: linear-gradient(90deg, rgba(29,185,84,0.22) 0%, rgba(29,185,84,0.08) 100%);
}
thead th {
  padding: 13px 16px;
  text-align: left;
  font-size: 0.72rem;
  font-weight: 600;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: var(--green);
  white-space: nowrap;
  border-bottom: 1px solid var(--card-border);
}
thead th:first-child { border-radius: var(--radius-sm) 0 0 0; }
thead th:last-child  { border-radius: 0 var(--radius-sm) 0 0; }

tbody tr {
  transition: background var(--transition), box-shadow var(--transition);
  border-bottom: 1px solid rgba(255,255,255,0.04);
}
tbody tr:nth-child(even) { background: var(--zebra); }
tbody tr:hover {
  background: var(--row-hover);
  box-shadow: inset 3px 0 0 var(--green);
}

tbody td {
  padding: 13px 16px;
  color: var(--text2);
  vertical-align: middle;
  white-space: nowrap;
}
tbody td:first-child { color: var(--text); font-weight: 500; }

/* ─── EMPTY STATE ──────────────────────────────────────────── */
.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 56px 24px;
  gap: 12px;
}
.empty-state-icon {
  font-size: 3rem;
  opacity: 0.25;
  filter: grayscale(1);
}
.empty-state p {
  color: var(--text3);
  font-size: 0.9rem;
  text-align: center;
}

/* ─── FAV-USERS FORM ───────────────────────────────────────── */
.fav-filter {
  display: flex;
  align-items: center;
  gap: 12px;
  margin-bottom: 22px;
  flex-wrap: wrap;
}

.fav-filter select {
  flex: 1;
  min-width: 220px;
  padding: 11px 16px;
  background: rgba(255,255,255,0.06);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 100px;
  color: var(--text);
  font-family: 'Inter', sans-serif;
  font-size: 0.875rem;
  cursor: pointer;
  transition: all var(--transition);
  outline: none;
  appearance: none;
  -webkit-appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%231db954' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
  background-repeat: no-repeat;
  background-position: right 16px center;
  padding-right: 40px;
}
.fav-filter select:focus,
.fav-filter select:hover {
  border-color: var(--green);
  box-shadow: 0 0 0 3px var(--green-dim);
  background-color: rgba(29,185,84,0.07);
}
.fav-filter select option {
  background: #1a1a1a;
  color: var(--text);
}

.btn-view {
  padding: 11px 28px;
  background: var(--green);
  border: none;
  border-radius: 100px;
  color: #000;
  font-family: 'Inter', sans-serif;
  font-size: 0.875rem;
  font-weight: 700;
  cursor: pointer;
  transition: all var(--transition);
  white-space: nowrap;
  box-shadow: 0 4px 16px rgba(29,185,84,0.35);
  letter-spacing: 0.02em;
}
.btn-view:hover {
  background: #22d65f;
  transform: scale(1.06) translateY(-1px);
  box-shadow: 0 8px 28px rgba(29,185,84,0.55);
}
.btn-view:active { transform: scale(0.98); }

/* ─── SONG APPROVAL CONTROLS ───────────────────────────────── */
.approval-controls {
  display: flex;
  align-items: center;
  gap: 10px;
  margin-bottom: 20px;
  flex-wrap: wrap;
  padding: 14px 18px;
  background: rgba(255,255,255,0.03);
  border: 1px solid rgba(255,255,255,0.06);
  border-radius: var(--radius-sm);
}

/* custom checkbox */
.check-all-label {
  display: flex;
  align-items: center;
  gap: 9px;
  cursor: pointer;
  font-size: 0.875rem;
  color: var(--text2);
  transition: color var(--transition);
  user-select: none;
  margin-right: 6px;
}
.check-all-label:hover { color: var(--text); }

.check-all-label input[type="checkbox"] {
  appearance: none;
  -webkit-appearance: none;
  width: 18px; height: 18px;
  border: 2px solid rgba(255,255,255,0.2);
  border-radius: 5px;
  background: transparent;
  cursor: pointer;
  transition: all var(--transition);
  position: relative;
  flex-shrink: 0;
}
.check-all-label input[type="checkbox"]:checked {
  background: var(--green);
  border-color: var(--green);
  box-shadow: 0 0 10px var(--green-glow);
}
.check-all-label input[type="checkbox"]:checked::after {
  content: '';
  position: absolute;
  top: 2px; left: 5px;
  width: 5px; height: 9px;
  border: 2px solid #000;
  border-top: none; border-left: none;
  transform: rotate(45deg);
}
.check-all-label input[type="checkbox"]:hover {
  border-color: var(--green);
}

/* song-checkbox inside table */
tbody input[type="checkbox"].song-checkbox {
  appearance: none;
  -webkit-appearance: none;
  width: 17px; height: 17px;
  border: 2px solid rgba(255,255,255,0.2);
  border-radius: 5px;
  background: transparent;
  cursor: pointer;
  transition: all var(--transition);
  position: relative;
  vertical-align: middle;
}
tbody input[type="checkbox"].song-checkbox:checked {
  background: var(--green);
  border-color: var(--green);
  box-shadow: 0 0 8px var(--green-glow);
}
tbody input[type="checkbox"].song-checkbox:checked::after {
  content: '';
  position: absolute;
  top: 1px; left: 4px;
  width: 5px; height: 8px;
  border: 2px solid #000;
  border-top: none; border-left: none;
  transform: rotate(45deg);
}
tbody input[type="checkbox"].song-checkbox:hover {
  border-color: var(--green);
}

/* action buttons */
.btn-bulk-approve,
.btn-bulk-reject,
.btn-approve,
.btn-reject {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 9px 18px;
  border: none;
  border-radius: 100px;
  font-family: 'Inter', sans-serif;
  font-size: 0.8rem;
  font-weight: 600;
  cursor: pointer;
  transition: all var(--transition);
  letter-spacing: 0.01em;
  white-space: nowrap;
}
.btn-bulk-approve,
.btn-approve {
  background: rgba(76,175,80,0.15);
  color: #4CAF50;
  border: 1px solid rgba(76,175,80,0.3);
}
.btn-bulk-approve:hover,
.btn-approve:hover {
  background: rgba(76,175,80,0.25);
  box-shadow: 0 4px 16px rgba(76,175,80,0.3);
  transform: scale(1.05) translateY(-1px);
}

.btn-bulk-reject,
.btn-reject {
  background: rgba(244,67,54,0.12);
  color: #F44336;
  border: 1px solid rgba(244,67,54,0.25);
}
.btn-bulk-reject:hover,
.btn-reject:hover {
  background: rgba(244,67,54,0.22);
  box-shadow: 0 4px 16px rgba(244,67,54,0.28);
  transform: scale(1.05) translateY(-1px);
}
.btn-bulk-approve:active,
.btn-bulk-reject:active,
.btn-approve:active,
.btn-reject:active { transform: scale(0.97); }

.btn-approve,
.btn-reject {
  padding: 7px 14px;
  font-size: 0.76rem;
}

.td-actions { display: flex; gap: 6px; align-items: center; }

/* ─── FAVORITES STATS BADGE ────────────────────────────────── */
.count-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 28px;
  padding: 3px 9px;
  background: var(--green-dim);
  border: 1px solid var(--card-border);
  border-radius: 100px;
  color: var(--green);
  font-size: 0.78rem;
  font-weight: 700;
  letter-spacing: 0.01em;
}

/* ─── HIDDEN INPUTS ────────────────────────────────────────── */
input[type="hidden"] { display: none; }

/* ─── SCROLLBAR (webkit) ───────────────────────────────────── */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: rgba(29,185,84,0.4); border-radius: 10px; }
::-webkit-scrollbar-thumb:hover { background: var(--green); }

/* ─── RESPONSIVE ───────────────────────────────────────────── */
@media (max-width: 768px) {
  .rm-wrapper { padding: 16px 14px 40px; }
  .sub-tabs { width: 100%; }
  .sub-tabs button { flex: 1; padding: 9px 10px; font-size: 0.78rem; }
  .report-area { padding: 18px 14px; }
  .fav-filter { flex-direction: column; align-items: stretch; }
  .fav-filter select { min-width: 0; }
  .approval-controls { gap: 8px; }
  .btn-bulk-approve, .btn-bulk-reject { font-size: 0.74rem; padding: 8px 12px; }
}

@media (max-width: 480px) {
  .rm-header h1 { font-size: 1.15rem; }
  .sub-tabs { gap: 4px; padding: 4px; }
}

/* ─── REDUCED MOTION ───────────────────────────────────────── */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation: none !important; transition: none !important; }
}

</style>
</head>
<body>

<div class="bg-orb"></div>

<div class="rm-wrapper">

  <!-- Page Header -->
  <div class="rm-header">
    <div class="rm-header-icon">🎵</div>
    <div>
      <h1>Reports Management</h1>
      <span>Music Admin Dashboard</span>
    </div>
  </div>

  <!-- ── TAB NAV ── (original IDs & onclick preserved) -->
  <div class="sub-tabs">

    <button type="button"
            id="report-btn-favorites"
            onclick="switchReportTab('favorites')">
      📊 Favorites
    </button>

    <button type="button"
            id="report-btn-fav-users"
            onclick="switchReportTab('fav-users')">
      👥 Favorite Users
    </button>

    <button type="button"
            id="report-btn-song-approval"
            onclick="switchReportTab('song-approval')">
      🎧 Kiểm Duyệt
    </button>

  </div>


  <!-- ════════════════════════════════════════════════
       TAB 1 — FAVORITES
  ════════════════════════════════════════════════ -->
  <div id="report-favorites" class="report-area">

    <div class="section-label">Top Favorites</div>

    <div class="rm-table-wrap">
      <table>
        <thead>
          <tr>
            <th>Video Title</th>
            <th>Favorite Count</th>
            <th>Latest Date</th>
            <th>Oldest Date</th>
          </tr>
        </thead>
        <tbody>

          <c:forEach items="${stats}" var="row">
            <tr>
              <td>${row[0]}</td>
              <td><span class="count-badge">${row[1]}</span></td>
              <td>${row[2]}</td>
              <td>${row[3]}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty stats}">
            <tr>
              <td colspan="4">
                <div class="empty-state">
                  <div class="empty-state-icon">📭</div>
                  <p>Chưa có dữ liệu favorites</p>
                </div>
              </td>
            </tr>
          </c:if>

        </tbody>
      </table>
    </div>

  </div>


  <!-- ════════════════════════════════════════════════
       TAB 2 — FAVORITE USERS
  ════════════════════════════════════════════════ -->
  <div id="report-fav-users"
       class="report-area"
       style="display:none;">

    <h3>Favorite Users</h3>

    <form method="post"
          action="${pageContext.request.contextPath}/AdminController">

      <input type="hidden"
             name="activeTab"
             value="report">

      <input type="hidden"
             name="reportTab"
             value="fav-users">

      <div class="fav-filter">

        <select name="songId">
          <option value="">-- Chọn bài hát --</option>
          <c:forEach items="${songs}" var="s">
            <option value="${s.id}"
                ${selectedSongId == s.id ? 'selected' : ''}>
              ${s.title}
            </option>
          </c:forEach>
        </select>

        <button type="submit" class="btn-view">Xem →</button>

      </div>

    </form>

    <div class="section-label">Danh sách người yêu thích</div>

    <div class="rm-table-wrap">
      <table>
        <thead>
          <tr>
            <th>Username</th>
            <th>Fullname</th>
            <th>Email</th>
            <th>Date</th>
          </tr>
        </thead>
        <tbody>

          <c:forEach items="${favUsers}" var="f">
            <tr>
              <td>${f.user.username}</td>
              <td>${f.user.fullname}</td>
              <td>${f.user.email}</td>
              <td>${f.likeDate}</td>
            </tr>
          </c:forEach>

          <c:if test="${empty favUsers}">
            <tr>
              <td colspan="4">
                <div class="empty-state">
                  <div class="empty-state-icon">🎶</div>
                  <p>Chọn một bài hát để xem danh sách người yêu thích</p>
                </div>
              </td>
            </tr>
          </c:if>

        </tbody>
      </table>
    </div>

  </div>


  <!-- ════════════════════════════════════════════════
       TAB 3 — SONG APPROVAL
  ════════════════════════════════════════════════ -->
  <div id="report-song-approval"
       class="report-area"
       style="display:none;">

    <h3>Kiểm duyệt bài hát</h3>

    <form method="post"
          action="${pageContext.request.contextPath}/AdminController">

      <div class="approval-controls">

        <label class="check-all-label">
          <input type="checkbox"
                 id="checkAll"
                 onclick="toggleAllSongs(this)">
          Chọn tất cả
        </label>

        <button type="submit"
                class="btn-bulk-approve"
                name="action"
                value="approveSelected"
                onclick="return confirmBulk('duyệt')">
          ✅ Duyệt đã chọn
        </button>

        <button type="submit"
                class="btn-bulk-reject"
                name="action"
                value="rejectSelected"
                onclick="return confirmBulk('từ chối')">
          ❌ Từ chối đã chọn
        </button>

      </div>

      <div class="section-label">Chờ kiểm duyệt</div>

      <div class="rm-table-wrap">
        <table>
          <thead>
            <tr>
              <th width="50">✔</th>
              <th>Bài hát</th>
              <th>Ca sĩ</th>
              <th>Thể loại</th>
              <th>Người đăng</th>
              <th>Hành động</th>
            </tr>
          </thead>
          <tbody>

            <c:forEach items="${pendingSongs}" var="song">
              <tr>
                <td>
                  <input type="checkbox"
                         name="songIds"
                         value="${song.id}"
                         class="song-checkbox">
                </td>
                <td>${song.title}</td>
                <td>${song.artist}</td>
                <td>${song.genre}</td>
                <td>${song.user.username}</td>
                <td>
                  <div class="td-actions">

                    <button type="submit"
                            class="btn-approve"
                            name="action"
                            value="approve_${song.id}">
                      ✅ Duyệt
                    </button>

                    <button type="submit"
                            class="btn-reject"
                            name="action"
                            value="reject_${song.id}"
                            onclick="return confirm('Từ chối bài hát này?')">
                      ❌ Từ chối
                    </button>

                  </div>
                </td>
              </tr>
            </c:forEach>

            <c:if test="${empty pendingSongs}">
              <tr>
                <td colspan="6">
                  <div class="empty-state">
                    <div class="empty-state-icon">🎉</div>
                    <p>Không có bài hát nào cần kiểm duyệt</p>
                  </div>
                </td>
              </tr>
            </c:if>

          </tbody>
        </table>
      </div>

    </form>

  </div>

</div><!-- /.rm-wrapper -->


<script>

function switchReportTab(tab) {

    document.querySelectorAll(".report-area")
            .forEach(function(el) {
                el.style.display = "none";
            });

    document.querySelectorAll(".sub-tabs button")
            .forEach(function(btn) {
                btn.classList.remove("active-sub");
            });

    var panel = document.getElementById("report-" + tab);
    if (panel) {
        panel.style.display = "block";
        panel.style.animation = "none";
        panel.offsetHeight; /* reflow */
        panel.style.animation = "panelIn 0.35s cubic-bezier(.4,0,.2,1) both";
    }

    document.getElementById(
        "report-btn-" + tab
    ).classList.add("active-sub");
}

/* ===== CHỌN TẤT CẢ ===== */

function toggleAllSongs(source) {
    document.querySelectorAll(
        "input[name='songIds']"
    ).forEach(function(cb) {
        cb.checked = source.checked;
    });
}

/* ===== TỰ ĐỘNG TICK CHỌN TẤT CẢ ===== */

document.addEventListener("change", function(e) {
    if(e.target.classList.contains("song-checkbox")) {
        const all =
            document.querySelectorAll(".song-checkbox");
        const checked =
            document.querySelectorAll(".song-checkbox:checked");
        document.getElementById("checkAll")
                .checked =
                    all.length > 0 &&
                    all.length === checked.length;
    }
});

/* ===== XÁC NHẬN DUYỆT/TỪ CHỐI HÀNG LOẠT ===== */

function confirmBulk(action) {
    const checked =
        document.querySelectorAll(
            "input[name='songIds']:checked"
        );
    if(checked.length === 0) {
        alert("Vui lòng chọn ít nhất 1 bài hát.");
        return false;
    }
    return confirm(
        "Bạn có chắc muốn "
        + action
        + " "
        + checked.length
        + " bài hát?"
    );
}

/* ===== TAB MẶC ĐỊNH ===== */

window.addEventListener("load", function () {

    <c:choose>

        <c:when test="${reportTab == 'fav-users'}">
            switchReportTab('fav-users');
        </c:when>

        <c:when test="${reportTab == 'song-approval'}">
            switchReportTab('song-approval');
        </c:when>

        <c:otherwise>
            switchReportTab('favorites');
        </c:otherwise>

    </c:choose>

});

</script>
</body>
</html>
