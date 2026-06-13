<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cài đặt</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/assets/css/style.css">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">

<style>

    /* ── RESET & TOKENS ── */
    *, *::before, *::after {
        margin: 0; padding: 0;
        box-sizing: border-box;
    }

    :root {
        --accent:         #1db954;
        --accent-dim:     rgba(29,185,84,0.18);
        --accent-glow:    rgba(29,185,84,0.30);
        --accent-soft:    rgba(29,185,84,0.08);
        --bg-base:        #0f0f0f;
        --bg-card:        rgba(22,22,22,0.70);
        --bg-item-hover:  rgba(29,185,84,0.09);
        --bg-sub-hover:   rgba(29,185,84,0.12);
        --border:         rgba(29,185,84,0.18);
        --border-strong:  rgba(29,185,84,0.38);
        --text-primary:   #ffffff;
        --text-secondary: #b3b3b3;
        --text-muted:     #555;
        --divider:        rgba(255,255,255,0.07);
        --radius-lg:      20px;
        --radius-md:      12px;
        --radius-sm:      8px;
        --radius-pill:    999px;
        --tr:             0.28s cubic-bezier(0.4,0,0.2,1);
    }

    /* ── SCROLLBAR ── */
    ::-webkit-scrollbar { width: 5px; }
    ::-webkit-scrollbar-track { background: transparent; }
    ::-webkit-scrollbar-thumb { background: rgba(29,185,84,0.28); border-radius: 4px; }
    ::-webkit-scrollbar-thumb:hover { background: var(--accent); }

    /* ── BODY ── */
    body {
        font-family: 'Inter', 'Segoe UI', Arial, sans-serif;
        background: var(--bg-base);
        color: var(--text-primary);
        min-height: 100vh;
        overflow-x: hidden;
        position: relative;
    }

    /* ── ANIMATED GRADIENT BACKGROUND ── */
    .bg-layer {
        position: fixed;
        inset: 0;
        z-index: 0;
        background: linear-gradient(-48deg, #0f0f0f, #121212, #0b1e10, #111, #0d190b, #0f0f0f);
        background-size: 500% 500%;
        animation: bgDrift 20s ease infinite;
    }

    @keyframes bgDrift {
        0%   { background-position: 0%   50%; }
        33%  { background-position: 100% 20%; }
        66%  { background-position: 50%  100%; }
        100% { background-position: 0%   50%; }
    }

    /* ── FLOATING ORB CIRCLES ── */
    .orb {
        position: fixed;
        border-radius: 50%;
        filter: blur(88px);
        pointer-events: none;
        z-index: 0;
    }

    .orb-1 {
        width: 500px; height: 500px;
        background: radial-gradient(circle, rgba(29,185,84,0.10) 0%, transparent 68%);
        top: -160px; left: -140px;
        animation: orbA 24s ease-in-out infinite;
    }

    .orb-2 {
        width: 340px; height: 340px;
        background: radial-gradient(circle, rgba(29,185,84,0.07) 0%, transparent 68%);
        bottom: -100px; right: -100px;
        animation: orbA 30s ease-in-out infinite reverse;
        animation-delay: -10s;
    }

    .orb-3 {
        width: 200px; height: 200px;
        background: radial-gradient(circle, rgba(29,185,84,0.05) 0%, transparent 68%);
        top: 45%; left: 60%;
        animation: orbA 18s ease-in-out infinite;
        animation-delay: -5s;
    }

    @keyframes orbA {
        0%,100% { transform: translate(0,0) scale(1); }
        40%     { transform: translate(35px,-25px) scale(1.06); }
        70%     { transform: translate(-18px,18px) scale(0.96); }
    }

    /* ── MAIN LAYOUT ── */
   .main {
    position: relative;
    z-index: 1;
    padding: 80px 32px 48px; /* 80px để chừa header */
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: flex-start;
	}

    /* ── SETTINGS CARD ── */
    .settings-card {
        width: 100%;
        max-width:700px;
        background: var(--bg-card);
        backdrop-filter: blur(24px);
        -webkit-backdrop-filter: blur(24px);
        border-radius: var(--radius-lg);
        border: 1px solid var(--border);
        box-shadow:
            0 12px 48px rgba(0,0,0,0.6),
            0 0 0 0.5px rgba(255,255,255,0.04) inset;
        overflow: hidden;
        animation: cardFadeUp 0.55s 0.05s cubic-bezier(0.4,0,0.2,1) both;
        transition: box-shadow var(--tr);
    }

    .settings-card:hover {
        box-shadow:
            0 16px 56px rgba(0,0,0,0.7),
            0 0 32px rgba(29,185,84,0.06),
            0 0 0 0.5px rgba(255,255,255,0.05) inset;
    }

    @keyframes cardFadeUp {
        from { opacity: 0; transform: translateY(24px); }
        to   { opacity: 1; transform: translateY(0); }
    }

    /* ── CARD HEADER ── */
    .card-header {
        display: flex;
        align-items: center;
        gap: 12px;
        padding: 26px 26px 22px;
        border-bottom: 1px solid var(--divider);
    }

    .card-header-icon {
        width: 40px; height: 40px;
        background: var(--accent-dim);
        border: 1px solid var(--border);
        border-radius: var(--radius-sm);
        display: flex; align-items: center; justify-content: center;
        font-size: 18px;
        flex-shrink: 0;
        box-shadow: 0 0 16px rgba(29,185,84,0.15);
    }

    .card-header h1 {
        font-size: 20px;
        font-weight: 700;
        color: var(--accent);
        letter-spacing: -0.3px;
        /* preserve original h1 color intent */
    }

    .card-header-sub {
        font-size: 12px;
        color: var(--text-muted);
        margin-left: auto;
        font-weight: 400;
    }

    /* ── SETTING ITEMS WRAPPER ── */
    .settings-list {
        padding: 10px 0 14px;
    }

    /* ── SETTING ITEM ── */
    .setting-item {
        padding: 15px 24px;
        border-bottom: 1px solid var(--divider);
        color: var(--text-primary);
        display: block;
        text-decoration: none;
        cursor: pointer;
        transition: background var(--tr), box-shadow var(--tr), transform var(--tr);
        position: relative;
        font-size: 14.5px;
        font-weight: 500;
        letter-spacing: -0.1px;
        user-select: none;
    }

    /* left accent bar on hover */
    .setting-item::before {
        content: '';
        position: absolute;
        left: 0; top: 8px; bottom: 8px;
        width: 3px;
        background: var(--accent);
        border-radius: 0 2px 2px 0;
        opacity: 0;
        transition: opacity var(--tr);
    }

    .setting-item:hover {
        background: var(--bg-item-hover);
        box-shadow: inset 0 0 0 1px rgba(29,185,84,0.08);
        transform: translateX(4px);
    }

    .setting-item:hover::before {
        opacity: 1;
    }

    .setting-item:last-child {
        border-bottom: none;
    }

    /* item icon + label row */
    .item-row {
        display: flex;
        align-items: center;
        gap: 12px;
        pointer-events: none; /* clicks go to parent */
    }

    .item-icon {
        width: 34px; height: 34px;
        background: var(--accent-soft);
        border: 1px solid var(--border);
        border-radius: var(--radius-sm);
        display: flex; align-items: center; justify-content: center;
        font-size: 15px;
        flex-shrink: 0;
        transition: background var(--tr), border-color var(--tr);
    }

    .setting-item:hover .item-icon {
        background: var(--accent-dim);
        border-color: var(--border-strong);
    }

    .item-label {
        flex: 1;
        font-size: 14.5px;
        font-weight: 500;
    }

    .item-chevron {
        color: var(--text-muted);
        font-size: 11px;
        transition: transform var(--tr), color var(--tr);
        pointer-events: none;
    }

    .item-chevron.open {
        transform: rotate(180deg);
        color: var(--accent);
    }

    /* ── PASSWORD SUBMENU ── */
    .password-menu {
        margin-top: 0;
        padding-left: 0;
        border-left: none;
        overflow: hidden;
        max-height: 0;
        opacity: 0;
        transform: translateY(-6px);
        transition:
            max-height 0.38s cubic-bezier(0.4,0,0.2,1),
            opacity    0.28s ease,
            transform  0.28s ease;
        pointer-events: none;
    }

    .password-menu.expanded {
        max-height: 200px;
        opacity: 1;
        transform: translateY(0);
        pointer-events: auto;
    }

    .password-menu-inner {
        margin: 6px 24px 8px 24px;
        background: rgba(0,0,0,0.28);
        border: 1px solid var(--border);
        border-radius: var(--radius-md);
        overflow: hidden;
    }

    .password-menu a {
        display: flex;
        align-items: center;
        gap: 10px;
        color: var(--text-secondary);
        padding: 11px 16px;
        text-decoration: none;
        font-size: 13.5px;
        font-weight: 400;
        border-bottom: 1px solid var(--divider);
        transition: background var(--tr), color var(--tr), transform var(--tr);
        position: relative;
    }

    .password-menu a:last-child {
        border-bottom: none;
    }

    .password-menu a::before {
        content: '';
        width: 5px; height: 5px;
        border-radius: 50%;
        background: var(--accent);
        opacity: 0.4;
        flex-shrink: 0;
        transition: opacity var(--tr), box-shadow var(--tr);
    }

    .password-menu a:hover {
        background: var(--bg-sub-hover);
        color: var(--text-primary);
        transform: translateX(4px);
    }

    .password-menu a:hover::before {
        opacity: 1;
        box-shadow: 0 0 6px var(--accent);
    }

    /* ── SECTION LABEL (decorative divider between groups) ── */
    .section-label {
        font-size: 10.5px;
        font-weight: 700;
        letter-spacing: 1px;
        text-transform: uppercase;
        color: var(--text-muted);
        padding: 14px 24px 6px;
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 860px) {
        .main {
            margin-left: 0;
            padding: 24px 16px 40px;
        }
    }

    @media (max-width: 480px) {
        .card-header { padding: 20px 18px 16px; }
        .setting-item { padding: 14px 18px; }
        .password-menu-inner { margin: 6px 18px 8px; }
        .section-label { padding: 12px 18px 4px; }
    }

    /* ── REDUCED MOTION ── */
    @media (prefers-reduced-motion: reduce) {
        *, *::before, *::after { animation: none !important; transition: none !important; }
    }

</style>
</head>

<body>

<!-- Layers -->
<div class="bg-layer"></div>
<div class="orb orb-1"></div>
<div class="orb orb-2"></div>
<div class="orb orb-3"></div>

<!-- MAIN -->
<main class="main">

    <!-- CONTENT -->
    <div class="settings-card">

        <!-- Header -->
        <div class="card-header">
            <div class="card-header-icon">⚙️</div>
            <h1>Cài đặt</h1>
            <span class="card-header-sub">Tài khoản của bạn</span>
        </div>

        <div class="settings-list">

            <p class="section-label">Chung</p>

            <!-- Thông báo -->
            <a href="${pageContext.request.contextPath}/user/Mess.jsp"
               class="setting-item">
                <span class="item-row">
                    <span class="item-icon">🔔</span>
                    <span class="item-label">Thông báo</span>
                    <span class="item-chevron">›</span>
                </span>
            </a>

            <p class="section-label">Bảo mật</p>

            <!-- Mật khẩu -->
            <div class="setting-item" onclick="togglePasswordMenu()">
                <span class="item-row">
                    <span class="item-icon">🔒</span>
                    <span class="item-label">Mật khẩu</span>
                    <span class="item-chevron" id="pwChevron">▾</span>
                </span>
            </div>

            <!-- Password submenu — logic: display:none toggled by JS, CSS animates via class -->
            <div id="passwordMenu" class="password-menu" style="display:none;">
                <div class="password-menu-inner">
                    <a href="${pageContext.request.contextPath}/forgot-password">Quên mật khẩu</a>
                    <a href="${pageContext.request.contextPath}/change-password">Cập nhật mật khẩu</a>
                    <a href="${pageContext.request.contextPath}/reset-password">Đặt lại mật khẩu</a>
                </div>
            </div>

        </div>

    </div>

</main>

<script>
/* ── Original toggle function — logic unchanged ── */
function togglePasswordMenu() {
    const menu = document.getElementById("passwordMenu");
    const chevron = document.getElementById("pwChevron");

    if (menu.style.display === "block") {
        /* collapse */
        menu.classList.remove("expanded");
        chevron && chevron.classList.remove("open");
        /* wait for CSS transition before hiding */
        setTimeout(function () {
            if (!menu.classList.contains("expanded")) {
                menu.style.display = "none";
            }
        }, 380);
    } else {
        /* expand */
        menu.style.display = "block";
        /* force reflow so transition plays */
        void menu.offsetWidth;
        menu.classList.add("expanded");
        chevron && chevron.classList.add("open");
    }
}
</script>

</body>
</html>
