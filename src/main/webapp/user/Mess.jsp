<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Notifications - Music Web</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>
    *, *::before, *::after {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    :root {
        --accent:        #1db954;
        --accent-dim:    rgba(29, 185, 84, 0.18);
        --accent-glow:   rgba(29, 185, 84, 0.35);
        --accent-soft:   rgba(29, 185, 84, 0.08);
        --bg-base:       #0f0f0f;
        --bg-card:       rgba(22, 22, 22, 0.72);
        --bg-row-hover:  rgba(29, 185, 84, 0.09);
        --border:        rgba(29, 185, 84, 0.18);
        --border-strong: rgba(29, 185, 84, 0.40);
        --text-primary:  #ffffff;
        --text-secondary:#b3b3b3;
        --text-muted:    #5a5a5a;
        --divider:       rgba(255,255,255,0.06);
        --radius-lg:     20px;
        --radius-md:     12px;
        --radius-sm:     8px;
        --radius-pill:   999px;
        --transition:    0.28s cubic-bezier(0.4, 0, 0.2, 1);
    }

    /* ── SCROLLBAR ── */
    ::-webkit-scrollbar { width: 5px; }
    ::-webkit-scrollbar-track { background: transparent; }
    ::-webkit-scrollbar-thumb { background: rgba(29,185,84,0.3); border-radius: 4px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--accent); }

    /* ── BODY + ANIMATED BACKGROUND ── */
    body {
        font-family: 'Inter', 'Segoe UI', sans-serif;
        background: var(--bg-base);
        color: var(--text-primary);
        min-height: 100vh;
        overflow-x: hidden;
        position: relative;
    }

    .bg-gradient {
        position: fixed;
        inset: 0;
        z-index: 0;
        background: linear-gradient(-50deg, #0f0f0f, #121212, #0b1e10, #111, #0f1a0c, #0f0f0f);
        background-size: 500% 500%;
        animation: bgDrift 18s ease infinite;
    }

    @keyframes bgDrift {
        0%   { background-position: 0%   50%; }
        33%  { background-position: 100% 20%; }
        66%  { background-position: 50%  100%; }
        100% { background-position: 0%   50%; }
    }

    /* ── FLOATING BLUR ORBS ── */
    .orb {
        position: fixed;
        border-radius: 50%;
        filter: blur(90px);
        pointer-events: none;
        z-index: 0;
        animation: orbFloat 20s ease-in-out infinite;
    }

    .orb-1 {
        width: 420px; height: 420px;
        background: radial-gradient(circle, rgba(29,185,84,0.12) 0%, transparent 70%);
        top: -100px; left: -100px;
        animation-duration: 22s;
    }

    .orb-2 {
        width: 320px; height: 320px;
        background: radial-gradient(circle, rgba(29,185,84,0.08) 0%, transparent 70%);
        bottom: -80px; right: -80px;
        animation-duration: 28s;
        animation-delay: -8s;
    }

    .orb-3 {
        width: 180px; height: 180px;
        background: radial-gradient(circle, rgba(29,185,84,0.06) 0%, transparent 70%);
        top: 50%; left: 55%;
        animation-duration: 16s;
        animation-delay: -4s;
    }

    @keyframes orbFloat {
        0%,100% { transform: translate(0, 0) scale(1); }
        33%      { transform: translate(40px, -30px) scale(1.07); }
        66%      { transform: translate(-20px, 20px) scale(0.95); }
    }

    /* ── PAGE LAYOUT ── */
    .notification-page {
        position: relative;
        z-index: 1;
        display: flex;
        flex-direction: column;
        gap: 0;
        min-height: 100vh;
    }

    /* ── TOP NAV BAR ── */
    .topbar {
        display: flex;
        align-items: center;
        gap: 14px;
        padding: 18px 28px 16px;
        border-bottom: 1px solid var(--divider);
        background: rgba(15,15,15,0.6);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        animation: fadeDown 0.5s ease both;
    }

    @keyframes fadeDown {
        from { opacity: 0; transform: translateY(-12px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .topbar-logo {
        width: 32px; height: 32px;
        background: var(--accent);
        border-radius: 50%;
        display: flex; align-items: center; justify-content: center;
        flex-shrink: 0;
        box-shadow: 0 0 16px rgba(29,185,84,0.5);
    }

    .topbar-logo svg { width: 18px; height: 18px; fill: #000; }

    .topbar-title {
        font-size: 17px;
        font-weight: 700;
        letter-spacing: -0.3px;
        color: var(--text-primary);
    }

    .topbar-subtitle {
        font-size: 12px;
        color: var(--text-muted);
        margin-left: auto;
        font-weight: 400;
    }

    /* ── MAIN CONTENT AREA ── */
    .main-content {
        display: flex;
        gap: 16px;
        padding: 20px 24px 24px;
        flex: 1;
        min-height: 0;
    }

    /* ── GLASS PANELS ── */
    .panel {
        background: var(--bg-card);
        backdrop-filter: blur(22px);
        -webkit-backdrop-filter: blur(22px);
        border-radius: var(--radius-lg);
        border: 1px solid var(--border);
        box-shadow:
            0 8px 32px rgba(0,0,0,0.55),
            0 0 0 0.5px rgba(255,255,255,0.04) inset;
        display: flex;
        flex-direction: column;
        overflow: hidden;
        transition: box-shadow var(--transition);
    }

    .panel:hover {
        box-shadow:
            0 8px 40px rgba(0,0,0,0.65),
            0 0 24px rgba(29,185,84,0.07),
            0 0 0 0.5px rgba(255,255,255,0.05) inset;
    }

    .panel-left  { flex: 1.1; animation: fadeUp 0.55s 0.1s ease both; }
    .panel-right { flex: 0.9; animation: fadeUp 0.55s 0.2s ease both; }

    @keyframes fadeUp {
        from { opacity: 0; transform: translateY(22px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    /* ── PANEL HEADER ── */
    .panel-header {
        display: flex;
        align-items: center;
        gap: 10px;
        padding: 20px 22px 16px;
        border-bottom: 1px solid var(--divider);
        flex-shrink: 0;
    }

    .panel-icon {
        width: 34px; height: 34px;
        background: var(--accent-dim);
        border: 1px solid var(--border);
        border-radius: var(--radius-sm);
        display: flex; align-items: center; justify-content: center;
        font-size: 16px;
        flex-shrink: 0;
    }

    .panel-title {
        font-size: 15px;
        font-weight: 600;
        color: var(--text-primary);
        letter-spacing: -0.2px;
    }

    .notif-count {
        margin-left: auto;
        font-size: 11px;
        font-weight: 600;
        color: var(--accent);
        background: var(--accent-soft);
        border: 1px solid var(--accent-dim);
        border-radius: var(--radius-pill);
        padding: 3px 10px;
        letter-spacing: 0.2px;
    }

    /* ── TABLE SCROLL WRAPPER ── */
    .table-wrap {
        flex: 1;
        overflow-y: auto;
        padding: 8px 0 12px;
    }

    /* ── TABLE ── */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    thead th {
        text-align: left;
        font-size: 11px;
        font-weight: 600;
        color: var(--text-muted);
        letter-spacing: 0.8px;
        text-transform: uppercase;
        padding: 8px 22px 10px;
        border-bottom: 1px solid var(--divider);
        position: sticky;
        top: 0;
        background: rgba(22,22,22,0.9);
        backdrop-filter: blur(12px);
        z-index: 2;
    }

    tbody tr {
        cursor: pointer;
        transition:
            background var(--transition),
            box-shadow var(--transition);
        position: relative;
    }

    tbody tr::before {
        content: '';
        position: absolute;
        left: 0; top: 0; bottom: 0;
        width: 3px;
        background: var(--accent);
        border-radius: 0 2px 2px 0;
        opacity: 0;
        transition: opacity var(--transition);
    }

    tbody tr:hover {
        background: var(--bg-row-hover);
    }

    tbody tr:hover::before {
        opacity: 1;
    }

    tbody tr.active {
        background: rgba(29,185,84,0.12);
    }

    tbody tr.active::before {
        opacity: 1;
    }

    tbody td {
        padding: 13px 22px;
        font-size: 13.5px;
        color: var(--text-secondary);
        border-bottom: 1px solid var(--divider);
        vertical-align: middle;
        transition: color var(--transition);
    }

    tbody tr:hover td,
    tbody tr.active td {
        color: var(--text-primary);
    }

    tbody tr:last-child td {
        border-bottom: none;
    }

    .td-title {
        font-weight: 500;
        max-width: 200px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }

    .td-date {
        font-size: 12px;
        color: var(--text-muted);
        white-space: nowrap;
    }

    /* ── BADGE ── */
    .badge {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-width: 28px;
        height: 22px;
        padding: 0 8px;
        font-size: 11px;
        font-weight: 700;
        border-radius: var(--radius-pill);
        background: rgba(29,185,84,0.15);
        color: var(--accent);
        border: 1px solid rgba(29,185,84,0.3);
        letter-spacing: 0.2px;
        transition: background var(--transition), border-color var(--transition);
    }

    tbody tr:hover .badge,
    tbody tr.active .badge {
        background: rgba(29,185,84,0.25);
        border-color: rgba(29,185,84,0.55);
    }

    /* ── EMPTY STATE ── */
    .empty-state {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 10px;
        padding: 60px 24px;
        color: var(--text-muted);
    }

    .empty-state-icon {
        font-size: 36px;
        opacity: 0.4;
        filter: grayscale(1);
    }

    .empty-state p {
        font-size: 14px;
        font-weight: 500;
    }

    .empty-state small {
        font-size: 12px;
        opacity: 0.6;
    }

    /* ── DETAIL PANEL BODY ── */
    .detail-body {
        flex: 1;
        overflow-y: auto;
        padding: 20px 22px;
        display: flex;
        flex-direction: column;
        gap: 0;
    }

    /* ── PLACEHOLDER STATE ── */
    .detail-placeholder {
        flex: 1;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        gap: 12px;
        padding: 40px 24px;
        text-align: center;
        animation: fadeIn 0.3s ease;
    }

    .detail-placeholder-ring {
        width: 64px; height: 64px;
        border-radius: 50%;
        border: 2px dashed rgba(29,185,84,0.25);
        display: flex; align-items: center; justify-content: center;
        font-size: 26px;
        color: var(--text-muted);
        animation: spinRing 8s linear infinite;
    }

    @keyframes spinRing {
        from { transform: rotate(0deg); }
        to   { transform: rotate(360deg); }
    }

    .detail-placeholder h3 {
        font-size: 14px;
        font-weight: 500;
        color: var(--text-muted);
    }

    .detail-placeholder p {
        font-size: 12px;
        color: var(--text-muted);
        opacity: 0.6;
    }

    /* ── DETAIL CONTENT ── */
    .detail-content {
        display: none;
        flex-direction: column;
        gap: 16px;
        animation: detailFadeIn 0.35s cubic-bezier(0.4, 0, 0.2, 1) both;
    }

    .detail-content.visible {
        display: flex;
    }

    @keyframes detailFadeIn {
        from { opacity: 0; transform: translateY(12px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    .detail-tag {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 11px;
        font-weight: 600;
        letter-spacing: 0.8px;
        text-transform: uppercase;
        color: var(--accent);
        background: var(--accent-soft);
        border: 1px solid var(--accent-dim);
        border-radius: var(--radius-pill);
        padding: 4px 12px;
        width: fit-content;
    }

    .detail-tag::before {
        content: '';
        width: 6px; height: 6px;
        border-radius: 50%;
        background: var(--accent);
        box-shadow: 0 0 6px var(--accent);
        animation: pulse 2s ease infinite;
    }

    @keyframes pulse {
        0%,100% { opacity: 1; transform: scale(1); }
        50%      { opacity: 0.5; transform: scale(0.85); }
    }

    .detail-title {
        font-size: 18px;
        font-weight: 700;
        color: var(--text-primary);
        line-height: 1.3;
        letter-spacing: -0.3px;
    }

    .detail-divider {
        height: 1px;
        background: var(--divider);
        border: none;
        margin: 0;
    }

    .detail-body-text {
        font-size: 14px;
        color: var(--text-secondary);
        line-height: 1.75;
    }

    .detail-meta {
        display: flex;
        align-items: center;
        gap: 8px;
        font-size: 11.5px;
        color: var(--text-muted);
        padding-top: 4px;
        border-top: 1px solid var(--divider);
        margin-top: 4px;
    }

    .detail-meta svg {
        width: 13px; height: 13px;
        opacity: 0.6;
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 860px) {
        .main-content {
            flex-direction: column;
            padding: 16px;
            gap: 14px;
        }

        .panel-left, .panel-right {
            flex: none;
            height: auto;
        }

        .panel-left  { min-height: 300px; }
        .panel-right { min-height: 240px; }

        body { overflow-y: auto; }
    }

    @media (max-width: 480px) {
        .topbar { padding: 14px 16px; }
        .main-content { padding: 12px; }
        .panel-header { padding: 16px 16px 12px; }
        thead th, tbody td { padding-left: 16px; padding-right: 16px; }
    }

    /* ── REDUCED MOTION ── */
    @media (prefers-reduced-motion: reduce) {
        *, *::before, *::after { animation: none !important; transition: none !important; }
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to   { opacity: 1; }
    }
</style>
</head>

<body>

<!-- Animated background -->
<div class="bg-gradient"></div>
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>
<div class="orb orb-3"></div>

<div class="notification-page">

  

    <!-- MAIN CONTENT -->
    <div class="main-content">

        <!-- LEFT PANEL: Notification list -->
        <div class="panel panel-left">

            <div class="panel-header">
                <div class="panel-icon">🔔</div>
                <span class="panel-title">Thông báo hệ thống</span>
                <c:if test="${not empty notifications}">
                    <span class="notif-count" id="notifCount">...</span>
                </c:if>
            </div>

            <div class="table-wrap">

                <c:choose>

                    <c:when test="${empty notifications}">
                        <div class="empty-state">
                            <div class="empty-state-icon">🔕</div>
                            <p>Chưa có thông báo nào</p>
                            <small>Quay lại sau để xem cập nhật mới</small>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <table>
                            <thead>
                                <tr>
                                    <th style="width:52px">#</th>
                                    <th>Tiêu đề</th>
                                    <th style="width:110px">Ngày tạo</th>
                                </tr>
                            </thead>
                            <tbody id="notifTableBody">

                                <c:forEach items="${notifications}" var="n">
                                    <tr onclick="showNotification(
                                            '${n.id}',
                                            '${n.title}',
                                            '${n.content}',
                                            '${n.createdAt}',
                                            this
                                        )">
                                        <td><span class="badge">${n.id}</span></td>
                                        <td class="td-title">${n.title}</td>
                                        <td class="td-date">${n.createdAt}</td>
                                    </tr>
                                </c:forEach>

                            </tbody>
                        </table>
                    </c:otherwise>

                </c:choose>

            </div>
        </div>

        <!-- RIGHT PANEL: Detail view -->
        <div class="panel panel-right">

            <div class="panel-header">
                <div class="panel-icon">💬</div>
                <span class="panel-title">Chi tiết thông báo</span>
            </div>

            <div class="detail-body">

                <!-- Placeholder -->
                <div class="detail-placeholder" id="detailPlaceholder">
                    <div class="detail-placeholder-ring">📭</div>
                    <h3>Chưa chọn thông báo</h3>
                    <p>Chọn một mục bên trái để xem nội dung</p>
                </div>

                <!-- Detail content (hidden until selection) -->
                <div class="detail-content" id="detailContent">
                    <span class="detail-tag" id="detailTag">THÔNG BÁO</span>
                    <h2 class="detail-title" id="detailTitle"></h2>
                    <hr class="detail-divider">
                    <p class="detail-body-text" id="detailBody"></p>
                    <div class="detail-meta" id="detailMeta">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="12" cy="12" r="10"/><path d="M12 6v6l4 2"/>
                        </svg>
                        <span id="detailDate"></span>
                    </div>
                </div>

            </div>
        </div>

    </div><!-- /main-content -->
</div><!-- /notification-page -->

<!-- JS: preserve original function signature, extend with animation -->
<script>
    /* ── Count badge ── */
    (function () {
        var rows = document.querySelectorAll('#notifTableBody tr');
        var el = document.getElementById('notifCount');
        if (el && rows.length) el.textContent = rows.length + ' mới';
    })();

    /* ── Show notification detail ── */
    var _activeRow = null;

    function showNotification(id, title, content, createdAt, rowEl) {
        /* highlight row */
        if (_activeRow) _activeRow.classList.remove('active');
        _activeRow = rowEl;
        rowEl.classList.add('active');

        /* hide placeholder, show detail with fresh animation */
        var placeholder = document.getElementById('detailPlaceholder');
        var detail      = document.getElementById('detailContent');

        placeholder.style.display = 'none';

        /* force re-trigger animation */
        detail.classList.remove('visible');
        void detail.offsetWidth; /* reflow */
        detail.classList.add('visible');

        /* fill data */
        document.getElementById('detailTag').lastChild.textContent
            = ' #' + id;
        document.getElementById('detailTitle').textContent = title;
        document.getElementById('detailBody').textContent  = content;
        document.getElementById('detailDate').textContent  = createdAt || '—';
    }
</script>

</body>
</html>
