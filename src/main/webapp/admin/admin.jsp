<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Tool - MusicWeb</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>

/* ══════════════════════════════════════════
   TOKENS & RESET
══════════════════════════════════════════ */
*, *::before, *::after {
    margin: 0; padding: 0;
    box-sizing: border-box;
}

:root {
    --accent:          #1db954;
    --accent-dim:      rgba(29,185,84,.18);
    --accent-glow:     rgba(29,185,84,.32);
    --accent-soft:     rgba(29,185,84,.08);
    --danger:          #f44336;
    --danger-dim:      rgba(244,67,54,.18);
    --info:            #2196f3;
    --info-dim:        rgba(33,150,243,.18);
    --warning:         #ff9800;
    --warning-dim:     rgba(255,152,0,.18);
    --success:         #4caf50;
    --success-dim:     rgba(76,175,80,.18);
    --bg:              #0f0f0f;
    --bg-card:         rgba(20,20,20,.72);
    --bg-row-hover:    rgba(29,185,84,.07);
    --bg-input:        rgba(255,255,255,.05);
    --border:          rgba(29,185,84,.18);
    --border-subtle:   rgba(255,255,255,.06);
    --text:            #ffffff;
    --text-2:          #b3b3b3;
    --text-muted:      #555;
    --r-lg:            18px;
    --r-md:            12px;
    --r-sm:            8px;
    --r-pill:          999px;
    --tr:              .28s cubic-bezier(.4,0,.2,1);
}

::-webkit-scrollbar { width: 5px; height: 5px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: rgba(29,185,84,.28); border-radius: 4px; }
::-webkit-scrollbar-thumb:hover { background: var(--accent); }

body {
    font-family: 'Inter', 'Segoe UI', sans-serif;
    background: var(--bg);
    color: var(--text);
    min-height: 100vh;
    overflow-x: hidden;
    position: relative;
}

/* ══════════════════════════════════════════
   ANIMATED BACKGROUND
══════════════════════════════════════════ */
.bg-layer {
    position: fixed; inset: 0; z-index: 0;
    background: linear-gradient(-48deg,
        #0f0f0f, #121212, #0b1e10,
        #111,    #0d190b, #0f0f0f);
    background-size: 500% 500%;
    animation: bgDrift 22s ease infinite;
}

@keyframes bgDrift {
    0%   { background-position: 0%   50%; }
    33%  { background-position: 100% 20%; }
    66%  { background-position: 50%  100%; }
    100% { background-position: 0%   50%; }
}

.orb {
    position: fixed; border-radius: 50%;
    filter: blur(90px); pointer-events: none; z-index: 0;
}
.orb-1 {
    width: 560px; height: 560px;
    background: radial-gradient(circle, rgba(29,185,84,.10) 0%, transparent 68%);
    top: -180px; left: -160px;
    animation: orbA 26s ease-in-out infinite;
}
.orb-2 {
    width: 380px; height: 380px;
    background: radial-gradient(circle, rgba(29,185,84,.07) 0%, transparent 68%);
    bottom: -120px; right: -120px;
    animation: orbA 32s ease-in-out infinite reverse;
    animation-delay: -12s;
}
.orb-3 {
    width: 220px; height: 220px;
    background: radial-gradient(circle, rgba(29,185,84,.05) 0%, transparent 68%);
    top: 42%; left: 62%;
    animation: orbA 19s ease-in-out infinite;
    animation-delay: -6s;
}

@keyframes orbA {
    0%,100% { transform: translate(0,0) scale(1); }
    40%     { transform: translate(40px,-28px) scale(1.06); }
    70%     { transform: translate(-20px,20px) scale(0.96); }
}

/* ══════════════════════════════════════════
   PAGE SHELL
══════════════════════════════════════════ */
.page-shell {
    position: relative; z-index: 1;
    display: flex; flex-direction: column;
    min-height: 100vh;
    padding: 18px 22px 32px;
    gap: 16px;
}

/* ══════════════════════════════════════════
   TOP NAV
══════════════════════════════════════════ */
.admin-tabs {
    display: flex;
    justify-content: space-between;
    align-items: center;
    gap: 10px;
    background: rgba(16,16,16,.75);
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid var(--border-subtle);
    border-radius: var(--r-lg);
    padding: 10px 14px;
    animation: fadeDown .5s ease both;
}

@keyframes fadeDown {
    from { opacity: 0; transform: translateY(-14px); }
    to   { opacity: 1; transform: translateY(0); }
}

.nav-brand {
    display: flex; align-items: center; gap: 10px;
    flex-shrink: 0;
}

.nav-logo {
    width: 32px; height: 32px;
    background: var(--accent);
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    box-shadow: 0 0 16px rgba(29,185,84,.5);
    flex-shrink: 0;
}
.nav-logo svg { width: 17px; height: 17px; fill: #000; }

.nav-title {
    font-size: 15px; font-weight: 700;
    letter-spacing: -.3px;
    color: var(--text);
}

.left-tabs {
    display: flex; gap: 6px;
    flex-wrap: wrap;
}

.left-tabs button {
    background: transparent;
    color: var(--text-2);
    border: 1px solid transparent;
    padding: 9px 18px;
    border-radius: var(--r-pill);
    cursor: pointer;
    font-size: 13.5px; font-weight: 500;
    font-family: inherit;
    transition: background var(--tr), color var(--tr),
                border-color var(--tr), box-shadow var(--tr),
                transform var(--tr);
}

.left-tabs button:hover {
    background: var(--accent-soft);
    color: var(--text);
    border-color: var(--border);
    transform: translateY(-1px);
}

.left-tabs button.active {
    background: var(--accent-dim);
    color: var(--accent);
    border-color: rgba(29,185,84,.35);
    box-shadow: 0 0 14px rgba(29,185,84,.2);
}

.right-tabs button {
    background: rgba(33,150,243,.15);
    color: #63b3ff;
    border: 1px solid rgba(33,150,243,.28);
    padding: 9px 18px;
    border-radius: var(--r-pill);
    cursor: pointer;
    font-size: 13.5px; font-weight: 500;
    font-family: inherit;
    transition: background var(--tr), box-shadow var(--tr), transform var(--tr);
}

.right-tabs button:hover {
    background: rgba(33,150,243,.25);
    box-shadow: 0 0 16px rgba(33,150,243,.3);
    transform: translateY(-2px);
}

/* ══════════════════════════════════════════
   TAB CONTENT (glass card)
══════════════════════════════════════════ */
.tab-content {
    display: none;
    background: var(--bg-card);
    backdrop-filter: blur(22px);
    -webkit-backdrop-filter: blur(22px);
    border: 1px solid var(--border);
    border-radius: var(--r-lg);
    box-shadow:
        0 12px 48px rgba(0,0,0,.6),
        0 0 0 .5px rgba(255,255,255,.04) inset;
    overflow: hidden;
    animation: fadeUp .45s ease both;
    transition: box-shadow var(--tr);
}

.tab-content:hover {
    box-shadow:
        0 16px 56px rgba(0,0,0,.7),
        0 0 28px rgba(29,185,84,.05),
        0 0 0 .5px rgba(255,255,255,.05) inset;
}

@keyframes fadeUp {
    from { opacity: 0; transform: translateY(20px); }
    to   { opacity: 1; transform: translateY(0); }
}

/* ══════════════════════════════════════════
   SUB-TABS
══════════════════════════════════════════ */
.sub-tabs {
    display: flex; gap: 8px;
    padding: 20px 22px 0;
    border-bottom: 1px solid var(--border-subtle);
    padding-bottom: 14px;
    margin-bottom: 20px;
}

.sub-tabs button {
    background: transparent;
    color: var(--text-2);
    border: 1px solid var(--border-subtle);
    padding: 8px 20px;
    border-radius: var(--r-pill);
    cursor: pointer;
    font-size: 13px; font-weight: 500;
    font-family: inherit;
    transition: background var(--tr), color var(--tr),
                border-color var(--tr), box-shadow var(--tr);
}

.sub-tabs button:hover {
    background: var(--accent-soft);
    color: var(--accent);
    border-color: var(--border);
}

.sub-tabs button.active-sub {
    background: var(--accent-dim);
    color: var(--accent);
    border-color: rgba(29,185,84,.35);
    box-shadow: 0 0 12px rgba(29,185,84,.18);
}

/* ══════════════════════════════════════════
   SONG FORM
══════════════════════════════════════════ */
#edit-area {
    padding: 0 22px 24px;
}

#songForm {
    display: flex;
    flex-direction: column;
    gap: 13px;
    max-width: 500px;
}

.form-section-label {
    font-size: 11px; font-weight: 700;
    letter-spacing: .9px; text-transform: uppercase;
    color: var(--text-muted);
    margin-top: 4px;
}

#songForm input[type="text"],
#songForm input[type="hidden"] {
    padding: 12px 16px;
    border: 1px solid var(--border-subtle);
    border-radius: var(--r-sm);
    background: var(--bg-input);
    color: var(--text);
    font-size: 14px; font-family: inherit;
    transition: border-color var(--tr), box-shadow var(--tr), background var(--tr);
    outline: none;
}

#songForm input[type="text"]:focus {
    border-color: rgba(29,185,84,.50);
    background: rgba(29,185,84,.06);
    box-shadow: 0 0 0 3px rgba(29,185,84,.12);
}

#songForm input[type="text"]::placeholder { color: var(--text-muted); }

/* file inputs */
.file-field {
    display: flex; flex-direction: column; gap: 6px;
}

.file-field label {
    font-size: 12px; font-weight: 600;
    color: var(--text-2);
    letter-spacing: .3px;
}

#songForm input[type="file"] {
    padding: 10px 14px;
    border: 1px dashed rgba(29,185,84,.30);
    border-radius: var(--r-sm);
    background: rgba(29,185,84,.04);
    color: var(--text-2);
    font-size: 13px; font-family: inherit;
    cursor: pointer;
    transition: border-color var(--tr), background var(--tr);
    outline: none;
}

#songForm input[type="file"]:hover {
    border-color: rgba(29,185,84,.55);
    background: rgba(29,185,84,.08);
}

/* action buttons */
.form-actions {
    display: flex; gap: 10px; flex-wrap: wrap;
    padding-top: 4px;
}

.btn {
    display: inline-flex; align-items: center; gap: 7px;
    padding: 11px 22px;
    border: none; border-radius: var(--r-pill);
    cursor: pointer;
    font-size: 13.5px; font-weight: 600; font-family: inherit;
    transition: background var(--tr), box-shadow var(--tr),
                transform var(--tr), filter var(--tr);
    white-space: nowrap;
}

.btn:hover { transform: translateY(-2px); filter: brightness(1.1); }
.btn:active { transform: translateY(0); filter: brightness(.95); }

.btn-create  { background: var(--accent);  color: #000;
               box-shadow: 0 4px 18px rgba(29,185,84,.30); }
.btn-create:hover  { box-shadow: 0 6px 24px rgba(29,185,84,.45); }

.btn-update  { background: var(--info);    color: #fff;
               box-shadow: 0 4px 18px rgba(33,150,243,.28); }
.btn-update:hover  { box-shadow: 0 6px 24px rgba(33,150,243,.42); }

.btn-delete  { background: var(--danger);  color: #fff;
               box-shadow: 0 4px 18px rgba(244,67,54,.28); }
.btn-delete:hover  { box-shadow: 0 6px 24px rgba(244,67,54,.42); }

/* ══════════════════════════════════════════
   TABLE
══════════════════════════════════════════ */
#list-area {
    padding: 0 0 4px;
}

.table-wrap {
    overflow-x: auto;
    padding: 0 22px 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
    font-size: 13.5px;
}

thead th {
    background: rgba(29,185,84,.12);
    color: var(--accent);
    font-size: 11px; font-weight: 700;
    letter-spacing: .8px; text-transform: uppercase;
    padding: 13px 16px;
    text-align: left;
    border-bottom: 1px solid rgba(29,185,84,.22);
    white-space: nowrap;
    position: sticky; top: 0; z-index: 2;
    backdrop-filter: blur(12px);
}

tbody tr {
    transition: background var(--tr), box-shadow var(--tr);
    position: relative;
}

tbody tr::after {
    content: '';
    position: absolute; inset: 0;
    border-left: 3px solid var(--accent);
    border-radius: 2px;
    opacity: 0;
    transition: opacity var(--tr);
    pointer-events: none;
}

tbody tr:hover {
    background: var(--bg-row-hover);
}

tbody tr:hover::after { opacity: 1; }

tbody td {
    padding: 13px 16px;
    border-bottom: 1px solid var(--border-subtle);
    color: var(--text-2);
    vertical-align: middle;
    transition: color var(--tr);
}

tbody tr:hover td { color: var(--text); }
tbody tr:last-child td { border-bottom: none; }

/* ── role badge ── */
.role-badge {
    display: inline-flex; align-items: center;
    padding: 3px 11px;
    border-radius: var(--r-pill);
    font-size: 11px; font-weight: 700;
    letter-spacing: .4px; text-transform: uppercase;
}

.role-ADMIN  { background: var(--danger-dim);   color: #ff7066;
               border: 1px solid rgba(244,67,54,.30); }
.role-USER   { background: var(--info-dim);      color: #63b3ff;
               border: 1px solid rgba(33,150,243,.30); }
.role-ARTIST { background: var(--accent-dim);    color: var(--accent);
               border: 1px solid rgba(29,185,84,.30); }

/* ── status ── */
.status-active {
    display: inline-flex; align-items: center; gap: 5px;
    color: #4ade80; font-weight: 600; font-size: 13px;
}

.status-active::before {
    content: '';
    width: 7px; height: 7px; border-radius: 50%;
    background: #4ade80;
    box-shadow: 0 0 6px #4ade80;
    animation: statusPulse 2s ease infinite;
}

.status-locked {
    display: inline-flex; align-items: center; gap: 5px;
    color: #f87171; font-weight: 600; font-size: 13px;
}

.status-locked::before {
    content: '';
    width: 7px; height: 7px; border-radius: 50%;
    background: #f87171;
}

@keyframes statusPulse {
    0%,100% { opacity: 1; box-shadow: 0 0 6px #4ade80; }
    50%     { opacity: .5; box-shadow: 0 0 10px #4ade80; }
}

/* ── table action buttons ── */
.tbl-btn {
    display: inline-flex; align-items: center; gap: 5px;
    padding: 6px 13px;
    border: none; border-radius: var(--r-pill);
    cursor: pointer;
    font-size: 12px; font-weight: 600; font-family: inherit;
    transition: box-shadow var(--tr), transform var(--tr), filter var(--tr);
    white-space: nowrap;
}

.tbl-btn:hover  { transform: translateY(-1px); filter: brightness(1.12); }
.tbl-btn:active { transform: translateY(0); }

.tbl-btn-edit   { background: var(--info-dim);    color: #63b3ff;
                  border: 1px solid rgba(33,150,243,.30); }
.tbl-btn-edit:hover   { box-shadow: 0 0 12px rgba(33,150,243,.35); }

.tbl-btn-lock   { background: var(--warning-dim); color: #ffb347;
                  border: 1px solid rgba(255,152,0,.30); }
.tbl-btn-lock:hover   { box-shadow: 0 0 12px rgba(255,152,0,.35); }

.tbl-btn-unlock { background: var(--success-dim); color: #6ee07f;
                  border: 1px solid rgba(76,175,80,.30); }
.tbl-btn-unlock:hover { box-shadow: 0 0 12px rgba(76,175,80,.35); }

.action-cell { display: flex; gap: 6px; flex-wrap: wrap; align-items: center; }

/* ══════════════════════════════════════════
   SECTION HEADER (inside tabs)
══════════════════════════════════════════ */
.section-header {
    display: flex; align-items: center; gap: 12px;
    padding: 20px 22px 0;
}

.section-icon {
    width: 36px; height: 36px;
    background: var(--accent-dim);
    border: 1px solid var(--border);
    border-radius: var(--r-sm);
    display: flex; align-items: center; justify-content: center;
    font-size: 16px; flex-shrink: 0;
}

.section-title {
    font-size: 16px; font-weight: 700;
    color: var(--text);
    letter-spacing: -.2px;
}

.section-divider {
    height: 1px;
    background: var(--border-subtle);
    border: none;
    margin: 14px 22px 0;
}

/* ══════════════════════════════════════════
   RESPONSIVE
══════════════════════════════════════════ */
@media (max-width: 768px) {
    .page-shell { padding: 12px 12px 28px; }
    .admin-tabs { flex-wrap: wrap; gap: 8px; }
    .left-tabs  { flex-wrap: wrap; }
    #songForm   { max-width: 100%; }
    .form-actions { flex-direction: column; }
    .form-actions .btn { justify-content: center; }
    thead th, tbody td { padding: 11px 12px; }
}

@media (prefers-reduced-motion: reduce) {
    *, *::before, *::after { animation: none !important; transition: none !important; }
}
.search-box{
    padding: 0 22px 20px;
}

.search-box input{
    width: 300px;
    max-width: 100%;
    padding: 12px 16px;
    border: 1px solid var(--border-subtle);
    border-radius: var(--r-pill);
    background: var(--bg-input);
    color: var(--text);
    font-size: 14px;
    outline: none;
    transition: all var(--tr);
}

.search-box input:focus{
    border-color: rgba(29,185,84,.5);
    box-shadow: 0 0 0 3px rgba(29,185,84,.12);
    background: rgba(29,185,84,.05);
}

.search-box input::placeholder{
    color: var(--text-muted);
}
.table-wrapper {
    max-height: 450px;   /* cao tối đa */
    overflow-y: auto;    /* hiện thanh cuộn khi vượt quá */
}

.table-wrapper::-webkit-scrollbar {
    width: 6px;
}

.table-wrapper::-webkit-scrollbar-thumb {
    background: #1DB954;
    border-radius: 10px;
}

.table-wrapper::-webkit-scrollbar-track {
    background: #181818;
}

/* Header cố định khi cuộn */
.table-wrapper th {
    position: sticky;
    top: 0;
    background: #1DB954;
    z-index: 1;
}

    </style>
</head>
<body>

<!-- ── Background layers ── -->
<div class="bg-layer"></div>
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>
<div class="orb orb-3"></div>

<div class="page-shell">

<!-- ══════════════════════════════════════════
     TOP NAV / ADMIN TABS
══════════════════════════════════════════ -->
<div class="admin-tabs">

    <div class="nav-brand">
        <div class="nav-logo">
            <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                <path d="M12 2C6.477 2 2 6.477 2 12s4.477 10 10 10 10-4.477 10-10S17.523 2 12 2zm4.536 14.424a.623.623 0 0 1-.858.208c-2.352-1.438-5.313-1.762-8.799-.965a.623.623 0 1 1-.277-1.215c3.818-.872 7.094-.497 9.726 1.115a.625.625 0 0 1 .208.857zm1.21-2.692a.78.78 0 0 1-1.073.257c-2.692-1.655-6.797-2.135-9.981-1.168a.78.78 0 0 1-.453-1.492c3.638-1.104 8.16-.569 11.249 1.33a.78.78 0 0 1 .258 1.073zm.104-2.803c-3.23-1.918-8.561-2.094-11.64-1.158a.936.936 0 0 1-.544-1.79c3.541-1.076 9.428-.868 13.148 1.34a.936.936 0 0 1-.964 1.608z"/>
            </svg>
        </div>
        <span class="nav-title">Admin</span>
    </div>

    <div class="left-tabs">
        <button type="button" id="nav-song"     onclick="openTab('song-tab')">🎵 Bài hát</button>
        <button type="button" id="nav-report"   onclick="openTab('report-tab')">📊 Báo cáo</button>
        <button type="button" id="nav-activity" onclick="openTab('activity-tab')">📈 Activity</button>
    </div>

    <div class="right-tabs">
        <button type="button"
                onclick="location.href='${pageContext.request.contextPath}/home'">🏠 Home</button>
    </div>

</div>

<!-- ══════════════════════════════════════════
     REPORT TAB
══════════════════════════════════════════ -->
<div id="report-tab" class="tab-content" style="display:none;">
    <div class="section-header">
        <div class="section-icon">📊</div>
        <span class="section-title">Báo cáo &amp; Thống kê</span>
    </div>
    <hr class="section-divider">
    <div style="padding:22px;">
        <jsp:include page="/admin/reports_management.jsp"/>
    </div>
</div>

<!-- ══════════════════════════════════════════
     ACTIVITY TAB
══════════════════════════════════════════ -->
<div id="activity-tab" class="tab-content" style="display:none;">
    <div class="section-header">
        <div class="section-icon">📈</div>
        <span class="section-title">Song Activity</span>
    </div>
    <hr class="section-divider">
    <div style="padding:22px;">
        <jsp:include page="/admin/activity_management.jsp"/>
    </div>
</div>

<!-- ══════════════════════════════════════════
     SONG TAB
══════════════════════════════════════════ -->
<div id="song-tab" class="tab-content">

    <!-- Sub-tab bar -->
    <div class="sub-tabs">
        <button type="button" id="sub-edit" onclick="switchSubTab('edit')">✏️ Song Edition</button>
        <button type="button" id="sub-list" onclick="switchSubTab('list')">🎵 Song List</button>
    </div>

    <!-- ── EDIT AREA ── -->
    <div id="edit-area" style="display:none;">

        <form id="songForm" enctype="multipart/form-data">

            <input type="hidden" id="songIdHidden" name="id">

            <p class="form-section-label">Thông tin bài hát</p>

            <input type="text" id="songTitle"  name="title"  placeholder="Tên bài hát">
            <input type="text" id="songArtist" name="artist" placeholder="Nghệ sĩ">
            <input type="text" id="songGenre"  name="genre"  placeholder="Thể loại">

            <p class="form-section-label">Media</p>

            <div class="file-field">
                <label>🖼 Ảnh bài hát</label>
                <input type="file" id="songImage" name="imageFile" accept="image/*">
            </div>

            <div class="file-field">
                <label>🎵 File MP3</label>
                <input type="file" id="songAudio" name="audioFile" accept=".mp3,audio/*">
            </div>

            <div class="form-actions">
                <button type="button" class="btn btn-create" onclick="handleSongAction('create')">
                    ✦ Create
                </button>
                <button type="button" class="btn btn-update" onclick="handleSongAction('update')">
                    ↑ Update
                </button>
                <button type="button" class="btn btn-delete" onclick="handleSongAction('delete')">
                    ✕ Delete
                </button>
            </div>

        </form>

    </div>

    <!-- ── LIST AREA ── -->
    <div id="list-area">
    	<div class="search-box">
    		<input type="text"
           id="userSearch"
           placeholder="🔍 Tìm theo tên người đăng..."
           onkeyup="searchByUser()">
		</div>
        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Artist</th>
                        <th>Genre</th>
                        <th>Uploaded By</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>

                    <c:forEach items="${songs}" var="s">
                        <tr>

                            <td>${s.title}</td>

                            <td>${s.artist}</td>

                            <td>${s.genre}</td>

                            <td>${s.user.username}</td>

                            <td>
                                <span class="role-badge role-${s.user.role}">
                                    ${s.user.role}
                                </span>
                            </td>

                            <td>
                                <c:choose>
                                    <c:when test="${s.active}">
                                        <span class="status-active">Active</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="status-locked">Locked</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <td>
                                <div class="action-cell">
									<div class="table-wrapper">
							    <button type="button" class="tbl-btn tbl-btn-edit"
							        onclick="loadSongToForm(
							            '${s.id}',
							            '${s.title}',
							            '${s.artist}',
							            '${s.genre}',
							            '${s.imageUrl}',
							            '${s.audioUrl}'
							        )">
							        ✎ Edit
							    </button>						
							    <c:choose>					
							        <c:when test="${s.active}">
							            <button type="button"
							                    class="tbl-btn tbl-btn-lock"
							                    onclick="handleLock('${s.id}')">
							                🔒 Lock
							            </button>
							        </c:when>
							
							        <c:otherwise>
							            <button type="button"
							                    class="tbl-btn tbl-btn-unlock"
							                    onclick="handleUnlock('${s.id}')">
							                🔓 Unlock
							            </button>
							        </c:otherwise>							
							    </c:choose>
							</div>
							</div>
                            </td>

                        </tr>
                    </c:forEach>

                </tbody>
            </table>
        </div>
    </div>

</div>
<!-- /song-tab -->

</div>
<!-- /page-shell -->

<!-- ══════════════════════════════════════════
     JAVASCRIPT — 100% logic unchanged
══════════════════════════════════════════ -->
<script>

/* ── openTab ── */
function openTab(tabName) {
    document.querySelectorAll('.tab-content').forEach(el => {
        el.style.display = 'none';
    });
    document.getElementById(tabName).style.display = 'block';

    /* nav button active state (UI only) */
    document.querySelectorAll('.left-tabs button').forEach(b => b.classList.remove('active'));
    const map = { 'song-tab': 'nav-song', 'report-tab': 'nav-report', 'activity-tab': 'nav-activity' };
    const btn = document.getElementById(map[tabName]);
    if (btn) btn.classList.add('active');
}

/* ── switchSubTab ── */
function switchSubTab(tab) {
    document.getElementById('edit-area').style.display =
        (tab === 'edit') ? 'block' : 'none';
    document.getElementById('list-area').style.display =
        (tab === 'list') ? 'block' : 'none';

    /* sub-tab active state (UI only) */
    document.getElementById('sub-edit').classList.toggle('active-sub', tab === 'edit');
    document.getElementById('sub-list').classList.toggle('active-sub', tab === 'list');
}

/* ── loadSongToForm ── */
function loadSongToForm(id, title, artist, genre, imageUrl, audioUrl) {
    switchSubTab('edit');
    document.getElementById('songIdHidden').value  = id;
    document.getElementById('songTitle').value     = title;
    document.getElementById('songArtist').value    = artist;
    document.getElementById('songGenre').value     = genre;
    document.getElementById('songImageUrl').value  = imageUrl;
    document.getElementById('songAudioUrl').value  = audioUrl;
}

/* ── handleSongAction ── */
function handleSongAction(action) {
    const formData = new FormData(document.getElementById('songForm'));
    fetch(
        '${pageContext.request.contextPath}/AdminController?action=' + action,
        { method: 'POST', body: formData }
    )
    .then(res => {
        if (!res.ok) throw new Error("Server Error");
        return res.json();
    })
    .then(() => {
        alert("Thực hiện thành công!");
        location.reload();
    })
    .catch(err => {
        console.error(err);
        alert("Có lỗi xảy ra!");
    });
}

/* ── handleLock ── */
function handleLock(id) {
    fetch(
        '${pageContext.request.contextPath}/AdminController?action=lock&id=' + id,
        { method: 'POST' }
    )
    .then(res => {
        if (!res.ok) throw new Error("Server Error");
        alert("Đã khóa bài hát");
        location.reload();
    });
}

/* ── handleUnlock ── */
function handleUnlock(id) {
    fetch(
        '${pageContext.request.contextPath}/AdminController?action=unlock&id=' + id,
        { method: 'POST' }
    )
    .then(res => {
        if (!res.ok) throw new Error("Server Error");
        alert("Đã mở khóa bài hát");
        location.reload();
    });
}

/* ── window.onload ── */
window.addEventListener("load", function () {

    <c:choose>

        <c:when test="${activeTab == 'report'}">

            openTab('report-tab');

        </c:when>

        <c:when test="${activeTab == 'activity'}">

            openTab('activity-tab');

        </c:when>

        <c:otherwise>

            openTab('song-tab');

        </c:otherwise>

    </c:choose>

    switchSubTab('list');

});
function searchByUser() {

    const keyword = document.getElementById("userSearch")
                    .value
                    .toLowerCase();

    const rows = document.querySelectorAll("#list-area tbody tr");

    rows.forEach(row => {

        // Cột Uploaded By là cột thứ 4 (index = 3)
        const username = row.cells[3].textContent.toLowerCase();

        if (username.includes(keyword)) {
            row.style.display = "";
        } else {
            row.style.display = "none";
        }

    });

}
</script>

</body>
</html>
