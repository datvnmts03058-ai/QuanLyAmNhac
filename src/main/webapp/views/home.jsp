<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%
    User currentUser = (User) session.getAttribute("user");
    String fullname   = (currentUser != null && currentUser.getFullname() != null
                         && !currentUser.getFullname().isEmpty())
                        ? currentUser.getFullname() : "Khách";
    String avatarChar = String.valueOf(fullname.charAt(0)).toUpperCase();
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Music Web – Trang Chủ</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@700;800&family=DM+Sans:ital,wght@0,300;0,400;0,500;0,600;1,400&display=swap" rel="stylesheet">
    <style>
    /* ═══════════════════════════════════════════════════════════════
       WEBMUSIC 2025 — PREMIUM DARK UI
       ═══════════════════════════════════════════════════════════════ */
    :root {
        --bg-base:        #0A0A0A;
        --bg-card:        #161616;
        --bg-card-hover:  #1e1e1e;
        --bg-glass:       rgba(255,255,255,.04);
        --bg-glass-hover: rgba(255,255,255,.08);
        --bg-header:      rgba(10,10,10,.82);

        --accent:         #1DB954;
        --accent-neon:    #32FF7E;
        --accent-glow:    rgba(50,255,126,.16);
        --accent-glow-lg: rgba(29,185,84,.35);

        --text-primary:   #ffffff;
        --text-secondary: #a0a0a0;
        --text-muted:     #484848;

        --border:         rgba(255,255,255,.06);
        --border-accent:  rgba(50,255,126,.2);

        --radius-card:    14px;
        --radius-btn:     500px;

        --sidebar-w:      240px;
        --header-h:       64px;
        --player-h:       84px;

        --font-display:   'Syne', sans-serif;
        --font-body:      'DM Sans', sans-serif;

        --ease:           cubic-bezier(.4,0,.2,1);
        --t:              .25s cubic-bezier(.4,0,.2,1);
        --ts:             .45s cubic-bezier(.4,0,.2,1);
    }

    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
    html { font-size: 15px; }
    body {
        font-family: var(--font-body);
        background: var(--bg-base);
        color: var(--text-primary);
        display: grid;
        grid-template-columns: var(--sidebar-w) 1fr;
        height: 100vh;
        overflow: hidden;
    }
    a { color: inherit; text-decoration: none; }
    button { cursor: pointer; border: none; background: none; color: inherit; font-family: inherit; }
    img { display: block; }

    ::-webkit-scrollbar            { width: 5px; }
    ::-webkit-scrollbar-track      { background: transparent; }
    ::-webkit-scrollbar-thumb      { background: rgba(255,255,255,.1); border-radius: 10px; }
    ::-webkit-scrollbar-thumb:hover{ background: var(--accent); }

    /* ── Animations ── */
    @keyframes fadeInUp  { from{opacity:0;transform:translateY(18px)} to{opacity:1;transform:translateY(0)} }
    @keyframes fadeDown  { from{opacity:0;transform:translateY(-8px)} to{opacity:1;transform:translateY(0)} }
    @keyframes shimmer   { 0%{background-position:-200% center} 100%{background-position:200% center} }
    @keyframes pulseRing { 0%{box-shadow:0 0 0 0 var(--accent-glow)} 70%{box-shadow:0 0 0 10px transparent} 100%{box-shadow:0 0 0 0 transparent} }
    @keyframes eq        { 0%,100%{transform:scaleY(1)} 50%{transform:scaleY(.22)} }
    @keyframes neonPulse { 0%,100%{text-shadow:0 0 8px var(--accent-neon),0 0 24px var(--accent-glow)} 50%{text-shadow:0 0 20px var(--accent-neon),0 0 50px var(--accent-glow-lg)} }

    .main-content > * { animation: fadeInUp .4s var(--ease) both; }
    .main-content > *:nth-child(1){animation-delay:.04s}
    .main-content > *:nth-child(2){animation-delay:.09s}
    .main-content > *:nth-child(3){animation-delay:.14s}
    .main-content > *:nth-child(4){animation-delay:.19s}
    .main-content > *:nth-child(5){animation-delay:.24s}

    /* ══════════════ SIDEBAR ══════════════ */
    .sidebar {
        background: linear-gradient(180deg,#0f0f0f 0%,#0a0a0a 100%);
        display: flex;
        flex-direction: column;
        padding: 22px 10px 16px;
        overflow-y: auto;
        border-right: 1px solid var(--border);
        position: relative;
    }
    .sidebar::before {
        content:'';position:absolute;top:0;left:0;right:0;height:1px;
        background:linear-gradient(90deg,transparent,var(--border-accent),transparent);
    }

    .sidebar-logo { display:flex;align-items:center;gap:10px;padding:4px 10px 26px; }
    .sidebar-logo-icon {
        width:36px;height:36px;
        background:linear-gradient(135deg,var(--accent),var(--accent-neon));
        border-radius:10px;
        display:flex;align-items:center;justify-content:center;
        font-size:15px;flex-shrink:0;
        box-shadow:0 4px 16px var(--accent-glow);
    }
    .sidebar-logo-text {
        font-family:var(--font-display);font-size:1.1rem;font-weight:800;letter-spacing:-.5px;
        background:linear-gradient(90deg,#fff 55%,var(--accent-neon));
        -webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;
    }

    .sidebar-nav { flex:1; }
    .nav-group   { margin-bottom:22px; }
    .nav-label   {
        font-size:.6rem;font-weight:700;letter-spacing:.14em;text-transform:uppercase;
        color:var(--text-muted);padding:0 10px 8px;
    }
    .nav-item {
        display:flex;align-items:center;gap:12px;
        padding:10px 10px;border-radius:8px;
        font-size:.875rem;font-weight:500;color:var(--text-secondary);
        transition:all var(--t);position:relative;overflow:hidden;
    }
    .nav-item::after {
        content:'';position:absolute;inset:0;
        background:linear-gradient(90deg,var(--accent-glow),transparent);
        opacity:0;transition:opacity var(--t);
    }
    .nav-item:hover { color:var(--text-primary);transform:translateX(4px);background:var(--bg-glass); }
    .nav-item:hover::after { opacity:1; }
    .nav-item.active { color:var(--text-primary);background:var(--bg-glass-hover); }
    .nav-item.active::before {
        content:'';position:absolute;left:0;top:18%;bottom:18%;
        width:3px;border-radius:0 2px 2px 0;
        background:linear-gradient(180deg,var(--accent-neon),var(--accent));
        box-shadow:0 0 8px var(--accent-glow);
    }
    .nav-item.active::after { opacity:.5; }
    .nav-item i { width:18px;text-align:center;font-size:.95rem;color:var(--text-muted);transition:color var(--t);position:relative;z-index:1; }
    .nav-item:hover i, .nav-item.active i { color:var(--accent); }
    .nav-item span { position:relative;z-index:1; }

    .sidebar-divider { height:1px;background:linear-gradient(90deg,transparent,var(--border),transparent);margin:6px 10px 14px; }

    /* Admin */
    .sidebar-section-label.admin-label {
        font-size:.6rem;font-weight:700;letter-spacing:.16em;text-transform:uppercase;
        color:#f97316;padding:0 10px 10px;opacity:.85;display:block;
    }
    .admin-section { display:flex;flex-direction:column;gap:6px; }
    .admin-menu {
        display:flex;align-items:center;gap:12px;padding:10px 10px;border-radius:8px;
        font-size:.875rem;font-weight:500;color:var(--text-secondary);
        background:rgba(249,115,22,.05);border:1px solid rgba(249,115,22,.1);transition:all var(--t);
    }
    .admin-menu i { color:#f97316;width:18px;text-align:center;transition:filter var(--t); }
    .admin-menu:hover { background:rgba(249,115,22,.1);color:var(--text-primary);transform:translateX(4px); }
    .admin-menu:hover i { filter:drop-shadow(0 0 6px #f97316); }

    .sidebar-bottom { margin-top:auto;padding-top:16px; }
    .logout-link {
        display:flex;align-items:center;gap:12px;padding:11px 14px;border-radius:10px;
        font-weight:600;font-size:.875rem;color:#fff;
        background:rgba(239,68,68,.1);border:1px solid rgba(239,68,68,.18);transition:all var(--t);
    }
    .logout-link:hover { background:rgba(239,68,68,.22);transform:translateY(-2px);box-shadow:0 6px 20px rgba(239,68,68,.2); }
    .logout-link i { font-size:15px;color:#f87171; }

    .sidebar-footer { font-size:.7rem;color:var(--text-muted);padding:12px 10px 0;line-height:1.6; }

    /* ══════════════ MAIN ══════════════ */
    .main { display:flex;flex-direction:column;min-height:0;overflow:hidden; }
    .main-content { flex:1;min-height:0;overflow-y:auto;padding:28px 28px calc(44px + var(--player-h)); }

    /* ── Header ── */
    .header {
        position:sticky;top:0;z-index:50;height:var(--header-h);
        background:var(--bg-header);
        backdrop-filter:blur(24px) saturate(1.6);-webkit-backdrop-filter:blur(24px) saturate(1.6);
        border-bottom:1px solid var(--border);
        display:flex;align-items:center;padding:0 24px;gap:14px;flex-shrink:0;
    }
    .header-nav-btns { display:flex;gap:6px; }
    .header-nav-btn {
        width:32px;height:32px;border-radius:50%;
        background:var(--bg-glass);border:1px solid var(--border);
        display:flex;align-items:center;justify-content:center;font-size:.78rem;color:var(--text-secondary);
        transition:all var(--t);
    }
    .header-nav-btn:hover { background:var(--bg-glass-hover);color:var(--text-primary);border-color:var(--border-accent); }

    .header-search { flex:1;max-width:380px;position:relative; }
    .header-search i { position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--text-muted);font-size:.82rem;pointer-events:none;transition:color var(--t); }
    .header-search input {
        width:100%;background:var(--bg-glass);border:1px solid var(--border);
        border-radius:var(--radius-btn);padding:9px 18px 9px 38px;
        font-family:var(--font-body);font-size:.875rem;color:var(--text-primary);
        transition:all var(--t);outline:none;
    }
    .header-search input::placeholder { color:var(--text-muted); }
    .header-search input:focus { background:rgba(255,255,255,.08);border-color:var(--accent);box-shadow:0 0 0 3px var(--accent-glow); }

    .header-spacer { flex:1; }

    /* Notification */
    .notification-wrapper { position:relative; }
    .notification-btn {
        width:36px;height:36px;border-radius:50%;
        background:var(--bg-glass);border:1px solid var(--border);
        display:flex;align-items:center;justify-content:center;font-size:.95rem;transition:all var(--t);
    }
    .notification-btn:hover { background:var(--bg-glass-hover);border-color:var(--border-accent);animation:pulseRing 1.5s infinite; }
    .notification-box {
        display:none;position:absolute;top:calc(100% + 12px);right:0;width:310px;
        background:rgba(16,16,16,.97);backdrop-filter:blur(20px);
        border:1px solid var(--border);border-radius:14px;overflow:hidden;
        box-shadow:0 20px 60px rgba(0,0,0,.7);z-index:200;animation:fadeDown .2s var(--ease);
    }
    .notification-header { padding:14px 18px;font-weight:700;font-size:.85rem;border-bottom:1px solid var(--border);color:var(--text-primary); }
    .notification-item { padding:12px 18px;font-size:.83rem;border-bottom:1px solid var(--border);color:var(--text-secondary);transition:background var(--t); }
    .notification-item:last-child { border-bottom:none; }
    .notification-item:hover { background:var(--bg-glass); }
    .notification-item strong { color:var(--text-primary);display:block;margin-bottom:2px;font-size:.875rem; }

    /* User menu */
    .user-menu-wrapper { position:relative; }
    .user-name-badge {
        display:flex;align-items:center;gap:9px;
        background:var(--bg-glass);border:1px solid var(--border);border-radius:var(--radius-btn);
        padding:4px 14px 4px 4px;cursor:pointer;transition:all var(--t);
    }
    .user-name-badge:hover { background:var(--bg-glass-hover);border-color:var(--border-accent);box-shadow:0 0 0 2px var(--accent-glow); }
    .user-avatar {
        width:28px;height:28px;border-radius:50%;
        background:linear-gradient(135deg,var(--accent),var(--accent-neon));
        color:#000;font-weight:800;font-size:.78rem;
        display:flex;align-items:center;justify-content:center;flex-shrink:0;
        box-shadow:0 0 12px var(--accent-glow);
    }
    .user-name-badge span { font-size:.82rem;font-weight:600; }
    .user-dropdown {
        display:none;position:absolute;top:calc(100% + 10px);right:0;width:188px;
        background:rgba(16,16,16,.97);backdrop-filter:blur(20px);
        border:1px solid var(--border);border-radius:12px;overflow:hidden;
        box-shadow:0 16px 40px rgba(0,0,0,.6);z-index:200;animation:fadeDown .2s var(--ease);
    }
    .user-dropdown a { display:flex;align-items:center;gap:12px;padding:11px 16px;font-size:.875rem;color:var(--text-secondary);transition:all var(--t); }
    .user-dropdown a:hover { background:var(--bg-glass);color:var(--text-primary);padding-left:20px; }
    .user-dropdown a i { opacity:.5;transition:all var(--t); }
    .user-dropdown a:hover i { opacity:1;color:var(--accent); }

    /* ── Banner ── */
    .banner {
        background:linear-gradient(135deg,#0d2018 0%,#0a1910 55%,rgba(10,10,10,0) 100%);
        border:1px solid rgba(29,185,84,.1);border-radius:20px;
        padding:34px 28px 26px;margin-bottom:28px;position:relative;overflow:hidden;
    }
    .banner::before {
        content:'';position:absolute;top:-30%;right:-5%;
        width:320px;height:320px;
        background:radial-gradient(circle,rgba(50,255,126,.06) 0%,transparent 70%);pointer-events:none;
    }
    .banner::after {
        content:'';position:absolute;inset:0;
        background:url("data:image/svg+xml,%3Csvg width='40' height='40' viewBox='0 0 40 40' xmlns='http://www.w3.org/2000/svg'%3E%3Ccircle cx='20' cy='20' r='1' fill='%231db954' fill-opacity='0.025'/%3E%3C/svg%3E") repeat;
        pointer-events:none;
    }
    .greeting-time {
        font-family:var(--font-display);font-size:2.1rem;font-weight:800;letter-spacing:-.05em;
        margin-bottom:20px;position:relative;z-index:1;
        animation:neonPulse 4s ease-in-out infinite;
    }

    /* Quick plays */
    .quick-play-wrapper { position:relative;z-index:1; }
    .quick-plays { display:flex;gap:10px;overflow-x:auto;overflow-y:hidden;flex-wrap:nowrap;scroll-behavior:smooth;padding-bottom:4px;scrollbar-width:none; }
    .quick-plays::-webkit-scrollbar { display:none; }
    .quick-play-card {
        min-width:258px;max-width:258px;display:flex;align-items:center;gap:12px;
        background:rgba(255,255,255,.06);backdrop-filter:blur(10px);
        border:1px solid var(--border);border-radius:10px;
        overflow:hidden;cursor:pointer;transition:all var(--t);position:relative;flex-shrink:0;padding-right:12px;
    }
    .quick-play-card:hover { background:rgba(255,255,255,.12);border-color:var(--border-accent);transform:translateY(-3px);box-shadow:0 8px 24px rgba(0,0,0,.4); }
    .quick-play-img { width:60px;height:60px;object-fit:cover;flex-shrink:0; }
    .quick-play-title { flex:1;font-size:.875rem;font-weight:700;white-space:nowrap;overflow:hidden;text-overflow:ellipsis; }
    .quick-play-btn {
        width:38px;height:38px;border-radius:50%;flex-shrink:0;
        background:linear-gradient(135deg,var(--accent),var(--accent-neon));color:#000;font-size:.85rem;
        display:flex;align-items:center;justify-content:center;
        opacity:0;transform:translateY(8px) scale(.8);transition:all var(--t);
        box-shadow:0 4px 16px var(--accent-glow-lg);
    }
    .quick-play-card:hover .quick-play-btn { opacity:1;transform:translateY(0) scale(1); }
    .quick-play-btn:hover { transform:scale(1.12) !important; }

    .scroll-btn {
        position:absolute;top:50%;transform:translateY(-50%);
        width:40px;height:40px;border-radius:50%;border:1px solid var(--border);
        background:rgba(20,20,20,.9);backdrop-filter:blur(10px);
        color:var(--text-primary);cursor:pointer;z-index:20;opacity:0;transition:all var(--t);
        display:flex;align-items:center;justify-content:center;
    }
    .quick-play-wrapper:hover .scroll-btn { opacity:1; }
    .scroll-btn.left  { left:-18px; }
    .scroll-btn.right { right:-18px; }
    .scroll-btn:hover { background:var(--accent);color:#000;border-color:var(--accent);box-shadow:0 0 16px var(--accent-glow-lg); }

    /* ── Add Song ── */
    .add-song-btn {
        display:inline-flex;align-items:center;gap:8px;
        background:linear-gradient(135deg,var(--accent),var(--accent-neon));
        color:#000;border-radius:var(--radius-btn);padding:10px 24px;
        font-size:.875rem;font-weight:700;transition:all var(--t);margin-bottom:20px;
        box-shadow:0 4px 16px var(--accent-glow-lg);position:relative;overflow:hidden;
    }
    .add-song-btn::before {
        content:'';position:absolute;inset:0;
        background:linear-gradient(90deg,transparent,rgba(255,255,255,.25),transparent);
        background-size:200% auto;opacity:0;animation:shimmer 2s linear infinite;
        transition:opacity var(--t);
    }
    .add-song-btn:hover { transform:translateY(-2px) scale(1.03);box-shadow:0 8px 28px var(--accent-glow-lg); }
    .add-song-btn:hover::before { opacity:1; }

    #addSongForm {
        display:none;background:rgba(16,16,16,.97);backdrop-filter:blur(20px);
        border:1px solid var(--border-accent);border-radius:18px;padding:28px;margin-bottom:28px;
        animation:fadeDown .25s var(--ease);box-shadow:0 20px 60px rgba(0,0,0,.5);
    }
    .form-title { font-family:var(--font-display);font-size:1.1rem;font-weight:800;margin-bottom:20px;color:var(--accent-neon);letter-spacing:-.02em; }
    .form-grid  { display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:14px; }
    .form-files { display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-bottom:20px; }
    .form-field { display:flex;flex-direction:column;gap:7px; }
    .form-field label { font-size:.72rem;font-weight:700;color:var(--text-muted);letter-spacing:.08em;text-transform:uppercase; }
    .form-input {
        background:var(--bg-glass);border:1px solid var(--border);border-radius:8px;
        padding:10px 14px;font-family:var(--font-body);font-size:.875rem;color:var(--text-primary);
        outline:none;transition:all var(--t);
    }
    .form-input:focus { border-color:var(--accent);background:rgba(29,185,84,.04);box-shadow:0 0 0 3px var(--accent-glow); }
    .form-input::placeholder { color:var(--text-muted); }
    .file-upload-area { border:1.5px dashed rgba(255,255,255,.1);border-radius:10px;padding:18px;transition:all var(--t);cursor:pointer;background:var(--bg-glass); }
    .file-upload-area:hover { border-color:var(--accent);background:rgba(29,185,84,.04);box-shadow:0 0 20px var(--accent-glow); }
    .file-upload-wrapper { display:flex;flex-direction:column;align-items:center;gap:8px;position:relative; }
    .file-upload-wrapper i { font-size:1.5rem;color:var(--accent);transition:all var(--t); }
    .file-upload-area:hover .file-upload-wrapper i { transform:scale(1.2);filter:drop-shadow(0 0 8px var(--accent)); }
    .file-label-text { font-size:.8rem;color:var(--text-muted);text-align:center; }
    .file-upload-wrapper input[type="file"] { position:absolute;inset:0;opacity:0;cursor:pointer; }
    .form-submit-btn {
        background:linear-gradient(135deg,var(--accent),var(--accent-neon));color:#000;
        font-family:var(--font-body);font-weight:800;font-size:.875rem;
        border:none;border-radius:var(--radius-btn);padding:12px 32px;cursor:pointer;
        transition:all var(--t);box-shadow:0 4px 16px var(--accent-glow-lg);
    }
    .form-submit-btn:hover { transform:translateY(-2px) scale(1.03);box-shadow:0 8px 28px var(--accent-glow-lg); }

    /* ── Section ── */
    .section-header { display:flex;align-items:baseline;justify-content:space-between;margin-bottom:16px; }
    .section-title  { font-family:var(--font-display);font-size:1.3rem;font-weight:800;letter-spacing:-.04em;color:var(--text-primary);margin:20px 0 10px; }
    .section-see-all { font-size:.72rem;font-weight:700;letter-spacing:.1em;text-transform:uppercase;color:var(--text-muted);transition:color var(--t); }
    .section-see-all:hover { color:var(--accent); }
    .section-divider { border:none;height:1px;background:linear-gradient(90deg,transparent,var(--border),transparent);margin:24px 0; }

    /* ── Artists ── */
    .artist-row { display:flex;gap:14px;overflow-x:auto;padding:8px 2px 12px;scrollbar-width:none; }
    .artist-row::-webkit-scrollbar { display:none; }
    .artist-card {
        width:140px;flex-shrink:0;background:var(--bg-glass);backdrop-filter:blur(10px);
        border:1px solid var(--border);padding:18px 12px 14px;border-radius:16px;
        text-align:center;cursor:pointer;transition:all var(--ts);
    }
    .artist-card:hover { background:var(--bg-glass-hover);border-color:var(--border-accent);transform:translateY(-6px) scale(1.04);box-shadow:0 16px 40px rgba(0,0,0,.4),0 0 20px var(--accent-glow); }
    .artist-card img { width:84px;height:84px;border-radius:50%;object-fit:cover;margin:0 auto 12px;border:2px solid var(--border);transition:all var(--ts); }
    .artist-card:hover img { border-color:var(--accent);box-shadow:0 0 0 4px var(--accent-glow),0 0 24px var(--accent-glow-lg); }
    .artist-name { font-size:.8rem;font-weight:600;color:var(--text-secondary);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;transition:color var(--t); }
    .artist-card:hover .artist-name { color:var(--text-primary); }

    /* ── Song Grid ── */
    .song-grid { display:grid;grid-template-columns:repeat(auto-fill,minmax(166px,1fr));gap:14px; }
    .song-card {
        background:var(--bg-card);border:1px solid var(--border);border-radius:var(--radius-card);
        padding:14px;cursor:pointer;transition:all var(--ts);position:relative;overflow:hidden;
    }
    .song-card::before {
        content:'';position:absolute;inset:0;border-radius:inherit;
        background:linear-gradient(135deg,var(--accent-glow),transparent 60%);
        opacity:0;transition:opacity var(--t);pointer-events:none;
    }
    .song-card:hover { background:var(--bg-card-hover);border-color:var(--border-accent);transform:translateY(-8px);box-shadow:0 20px 50px rgba(0,0,0,.5),0 0 30px var(--accent-glow); }
    .song-card:hover::before { opacity:1; }
    .song-card.is-playing { background:#0d2018;border-color:rgba(29,185,84,.3);box-shadow:0 0 20px var(--accent-glow); }

    .song-img-wrapper { position:relative;width:100%;aspect-ratio:1;border-radius:8px;overflow:hidden;margin-bottom:12px;display:flex;flex-direction:column;background:#1a1a1a; }
    .song-img { width:100%;height:100%;object-fit:cover;transition:transform var(--ts); }
    .song-card:hover .song-img { transform:scale(1.09); }

    .card-play-btn,.favorite-btn,.card-delete-btn { position:absolute;display:flex;align-items:center;justify-content:center;border-radius:50%;transition:all var(--t);opacity:0; }
    .song-card:hover .card-play-btn,.song-card:hover .favorite-btn,.song-card:hover .card-delete-btn { opacity:1; }

    .card-play-btn {
        bottom:10px;right:10px;width:44px;height:44px;
        background:linear-gradient(135deg,var(--accent),var(--accent-neon));color:#000;font-size:.9rem;
        box-shadow:0 6px 20px var(--accent-glow-lg);transform:translateY(10px) scale(.8);border:none;cursor:pointer;
    }
    .song-card:hover .card-play-btn { transform:translateY(0) scale(1); }
    .card-play-btn:hover { transform:scale(1.12) !important;box-shadow:0 8px 28px var(--accent-glow-lg); }

    .favorite-btn { top:8px;right:8px;width:30px;height:30px;background:rgba(0,0,0,.7);backdrop-filter:blur(8px);color:#fff;font-size:.75rem;transform:scale(.7);border:1px solid var(--border); }
    .song-card:hover .favorite-btn { transform:scale(1); }
    .favorite-btn:hover { color:#f43f5e;border-color:#f43f5e;box-shadow:0 0 12px rgba(244,63,94,.3); }

    .card-delete-btn { top:8px;left:8px;width:28px;height:28px;background:rgba(0,0,0,.7);backdrop-filter:blur(8px);color:#fff;font-size:.72rem;transform:scale(.7);border:1px solid var(--border); }
    .song-card:hover .card-delete-btn { transform:scale(1); }
    .card-delete-btn:hover { background:rgba(239,68,68,.8);border-color:#ef4444; }

    .card-title { font-size:.875rem;font-weight:700;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;margin-bottom:4px;color:var(--text-primary); }
    .card-artist { font-size:.78rem;color:var(--text-secondary);white-space:nowrap;overflow:hidden;text-overflow:ellipsis;margin-bottom:4px;transition:color var(--t);cursor:pointer; }
    .card-artist:hover { color:var(--accent);text-decoration:underline; }
    .card-genre { display:inline-block;font-size:.62rem;font-weight:700;letter-spacing:.08em;text-transform:uppercase;background:rgba(50,255,126,.07);color:var(--accent-neon);border:1px solid rgba(50,255,126,.14);border-radius:4px;padding:2px 7px;margin-top:2px; }
    .card-uploader { font-size:.7rem;color:var(--text-muted);margin-top:5px; }
    .card-uploader a { color:var(--text-secondary);transition:color var(--t); }
    .card-uploader a:hover { color:var(--accent); }

    /* ── Empty state ── */
    .empty-state { text-align:center;padding:72px 32px;color:var(--text-muted); }
    .empty-state i { font-size:3rem;margin-bottom:18px;opacity:.2;color:var(--accent); }
    .empty-state h3 { font-family:var(--font-display);font-size:1.3rem;margin-bottom:8px;color:var(--text-secondary); }
    .empty-state p { font-size:.875rem; }

    /* ══════════════ PLAYER BAR ══════════════ */
    /* =================================================================
   SPOTIFY PREMIUM FLOATING PLAYER — PERFECT GRID PIXEL ALIGNMENT
   ================================================================= */
:root {
    --player-bg: rgba(24, 24, 24, 0.85);
    --player-border: rgba(255, 255, 255, 0.08);
    --spotify-green: #1db954;
    --spotify-neon: #1ed760;
    --spotify-glow: rgba(29, 185, 84, 0.35);
    
    --text-main: #ffffff;
    --text-sub: #b3b3b3;
    --font-premium: 'Plus Jakarta Sans', 'DM Sans', sans-serif;
    --ease-smooth: cubic-bezier(0.33, 1, 0.68, 1);
}

/* 1. KHUNG TỔNG THỂ FLOATING PLAYER (CĂN THEO TỶ LỆ GRID HOÀN HẢO CỦA TRANG) */
.player {
    position: fixed !important;
    bottom: 24px !important;
    
    /* [CĂN THẲNG LỀ PHẢI]: Khớp chính xác với lề của khối nội dung & Avatar góc trên */
    right: 32px !important; 
    left: auto !important;
    transform: none !important;
    
    /* [CĂN KHỚP LỀ TRÁI]: Tự động tính toán dựa trên chiều rộng sidebar (260px) và khoảng cách lề */
    /* Công thức này giúp mép trái Player luôn thẳng tắp với mép danh sách bài hát trên mọi màn hình máy tính */
    width: calc(100% - 260px - 64px) !important; 
    max-width: 1200px !important; 
    height: 74px !important; /* Độ cao thanh mảnh chuẩn mực */
    
    /* Phân bổ tỷ lệ các cột bên trong */
    display: grid !important;
    grid-template-columns: 1.2fr 2fr !important;
    align-items: center !important;
    gap: 20px !important;
    
    background: var(--player-bg) !important;
    backdrop-filter: blur(24px) saturate(180%) !important;
    -webkit-backdrop-filter: blur(24px) saturate(180%) !important;
    
    border: 1px solid var(--player-border) !important;
    border-radius: 14px !important;
    padding: 0 16px !important;
    
    /* Giữ z-index an toàn để menu dropdown của bạn đè lên thoải mái */
    z-index: 99 !important; 
    
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.65), 
                inset 0 1px 1px rgba(255, 255, 255, 0.08) !important;
    
    transition: all 0.3s var(--ease-smooth) !important;
}

/* Hiệu ứng thở phát quang nhẹ toàn bộ khung khi bài hát đang chạy */
.player:has(#audioPlayer:not([paused])) {
    border-color: rgba(29, 185, 84, 0.15) !important;
    box-shadow: 0 12px 35px rgba(0, 0, 0, 0.75), 
                0 0 35px rgba(29, 185, 84, 0.04) !important;
}

/* 2. CỤM THÔNG TIN BÀI HÁT (LEFT SIDE) */
.player-track-info {
    display: flex !important;
    align-items: center !important;
    gap: 12px !important;
    overflow: hidden !important;
}

.player-thumb {
    width: 44px !important;
    height: 44px !important;
    border-radius: 6px !important;
    overflow: hidden !important;
    background: rgba(255, 255, 255, 0.04) !important;
    border: 1px solid rgba(255, 255, 255, 0.06) !important;
    flex-shrink: 0 !important;
    display: flex !important;
    align-items: center !important;
    justify-content: center !important;
    color: var(--text-sub) !important;
    font-size: 14px !important;
    box-shadow: 0 4px 12px rgba(0,0,0,0.4) !important;
}
.player-thumb img {
    width: 100% !important;
    height: 100% !important;
    object-fit: cover !important;
}

.player-text {
    display: flex !important;
    flex-direction: column !important;
    gap: 2px !important;
    overflow: hidden !important;
}
#songTitle {
    font-family: var(--font-premium) !important;
    font-size: 13.5px !important;
    font-weight: 700 !important;
    color: var(--text-main) !important;
    white-space: nowrap !important;
    overflow: hidden !important;
    text-overflow: ellipsis !important;
}
.player:has(#audioPlayer[src]:not([src=""])) #songTitle {
    color: var(--spotify-neon) !important;
}

#songArtist {
    font-family: var(--font-premium) !important;
    font-size: 11px !important;
    color: var(--text-sub) !important;
    white-space: nowrap !important;
    overflow: hidden !important;
    text-overflow: ellipsis !important;
}

/* Sóng nhạc Equalizer */
.playing-indicator {
    display: flex !important;
    align-items: flex-end !important;
    gap: 2.5px !important;
    height: 11px !important;
    margin-left: 2px !important;
    flex-shrink: 0 !important;
}
.playing-bar {
    width: 2px !important;
    background: var(--spotify-neon) !important;
    border-radius: 50px !important;
    height: 30% !important;
}
.player:has(#audioPlayer:not([paused])) .playing-bar {
    animation: bounceEqualizer 1.2s infinite ease-in-out alternate !important;
}
.player:has(#audioPlayer:not([paused])) .playing-bar:nth-child(1) { animation-delay: 0.1s !important; height: 45%; }
.player:has(#audioPlayer:not([paused])) .playing-bar:nth-child(2) { animation-delay: 0.4s !important; height: 100%; }
.player:has(#audioPlayer:not([paused])) .playing-bar:nth-child(3) { animation-delay: 0.2s !important; height: 65%; }

@keyframes bounceEqualizer {
    0% { transform: scaleY(0.3); }
    100% { transform: scaleY(1); }
}

/* 3. KHU VỰC ĐIỀU KHIỂN AUDIO (RIGHT SIDE) */
.player-center {
    display: flex !important;
    flex-direction: column !important;
    align-items: center !important;
    width: 100% !important;
}
.audio-player-container {
    width: 100% !important;
}

#audioPlayer {
    width: 100% !important;
    height: 34px !important;
    outline: none !important;
    background: rgba(255, 255, 255, 0.02) !important;
    border: 1px solid rgba(255, 255, 255, 0.04) !important;
    border-radius: 500px !important;
    transition: all 0.3s var(--ease-smooth) !important;
}

#audioPlayer::-webkit-media-controls-enclosure {
    background-color: transparent !important;
    padding: 0 8px !important;
}
#audioPlayer::-webkit-media-controls-panel {
    background-color: transparent !important;
}

/* NÚT PLAY CHUẨN SPOTIFY PREMIUM */
#audioPlayer::-webkit-media-controls-play-button {
    background-color: var(--spotify-green) !important;
    border-radius: 50% !important;
    width: 22px !important;
    height: 22px !important;
    transform: scale(1.15) !important;
    cursor: pointer !important;
    margin-right: 10px !important;
    box-shadow: 0 4px 10px var(--spotify-glow) !important;
    transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275) !important;
}
#audioPlayer::-webkit-media-controls-play-button:hover {
    background-color: var(--spotify-neon) !important;
    transform: scale(1.25) !important;
    box-shadow: 0 5px 15px rgba(30, 215, 96, 0.5) !important;
}
.player:has(#audioPlayer:not([paused])) #audioPlayer::-webkit-media-controls-play-button {
    animation: neonPulsePlay 2s infinite alternate var(--ease-smooth) !important;
}

@keyframes neonPulsePlay {
    0% { box-shadow: 0 4px 10px rgba(29, 185, 84, 0.4); }
    100% { box-shadow: 0 5px 18px rgba(30, 215, 96, 0.6); }
}

#audioPlayer::-webkit-media-controls-timeline {
    background-color: rgba(255, 255, 255, 0.06) !important;
    border-radius: 20px !important;
    height: 4px !important;
}
#audioPlayer::-webkit-media-controls-current-time-display,
#audioPlayer::-webkit-media-controls-time-remaining-display {
    color: var(--text-sub) !important;
    font-family: var(--font-premium) !important;
    font-size: 10.5px !important;
}
#audioPlayer::-webkit-media-controls-mute-button {
    background-color: transparent !important;
}
#audioPlayer::-webkit-media-controls-volume-slider {
    background-color: rgba(255, 255, 255, 0.06) !important;
    border-radius: 20px !important;
    height: 4px !important;
}

/* Ẩn cụm phụ cũ */
.player-right {
    display: none !important;
}

/* 4. ĐÁP ỨNG THIẾT BỊ DI ĐỘNG (MOBILE FRIENDLY) */
@media (max-width: 992px) {
    .player {
        width: calc(100% - 48px) !important;
        right: 24px !important;
    }
}
@media (max-width: 768px) {
    .player {
        right: 12px !important;
        bottom: 12px !important;
        width: calc(100% - 24px) !important;
        grid-template-columns: 1fr !important;
        height: auto !important;
        padding: 10px 12px !important;
        gap: 6px !important;
    }
    .player-track-info { justify-content: center; }
    .playing-indicator { display: none !important; }
}
    /* ══════════════ RESPONSIVE ══════════════ */
    @media (max-width:900px) {
        :root { --sidebar-w:0px; }
        .sidebar { display:none; }
        body { grid-template-columns:1fr; }
        .main,.player { grid-column:1; }
        .form-grid,.form-files { grid-template-columns:1fr; }
    }
    @media (max-width:600px) {
        .song-grid { grid-template-columns:1fr 1fr; }
        .greeting-time { font-size:1.4rem; }
        .player { grid-template-columns:1fr;padding:0 14px; }
        .player-right { display:none; }
        .quick-play-card { min-width:220px;max-width:220px; }
    }
    @media (min-width:1400px) {
        .song-grid { grid-template-columns:repeat(auto-fill,minmax(180px,1fr)); }
    }
    
    </style>
</head>

<body>

<!-- ===================================================================
     SIDEBAR
     =================================================================== -->
<aside class="sidebar">

    <div class="sidebar-logo">
        <div class="sidebar-logo-icon"><i class="fa-solid fa-music" style="color:#000;"></i></div>
        <span class="sidebar-logo-text">MusicWeb</span>
    </div>

    <nav class="sidebar-nav">
        <div class="nav-group">
            <div class="nav-label">Menu</div>
            <a class="nav-item active" href="${pageContext.request.contextPath}/home">
                <i class="fa-solid fa-house"></i> Trang chủ
            </a>
           
           
        </div>
        <div class="sidebar-divider"></div>
        <div class="nav-group">
            <div class="nav-label">Bộ sưu tập</div>
            <a class="nav-item" href="${pageContext.request.contextPath}/share-song">
                <i class="fa-solid fa-share-nodes"></i> Share link
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/favorites">
                <i class="fa-solid fa-heart"></i> Nhạc yêu thích
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/my-music">
                <i class="fa-solid fa-compact-disc"></i> Nhạc của tôi
            </a>
            <a class="nav-item" href="${pageContext.request.contextPath}/playlist">
                <i class="fa-solid fa-list-music"></i> Danh sách phát
            </a>
            
        </div>
    </nav>
	
	<c:if test="${not empty sessionScope.user and sessionScope.user.role eq 'ADMIN'}">

    <div class="sidebar-divider"></div>

    <div class="sidebar-section-label admin-label">
        ⚡ ADMIN PANEL
    </div>

    <div class="admin-section">

        <a href="${pageContext.request.contextPath}/users"
           class="admin-menu">
            <i class="fa-solid fa-users"></i>
            <span>Manage Users</span>
        </a>

        <a href="${pageContext.request.contextPath}/AdminController"
           class="admin-menu">
            <i class="fa-solid fa-music"></i>
            <span>Manage Songs</span>
        </a>

        <a href="${pageContext.request.contextPath}/AdminController"
           class="admin-menu">
            <i class="fa-solid fa-chart-line"></i>
            <span>Reports</span>
        </a>

    </div>

</c:if>

<div class="sidebar-bottom">

    <a href="${pageContext.request.contextPath}/login"
       class="logout-link">
        <i class="fa-solid fa-right-from-bracket"></i>
        <span>Log Out</span>
    </a>

</div>
    <div class="sidebar-divider"></div>
    <div class="sidebar-footer">
        &copy; 2024 MusicWeb
    </div>

</aside>

<!-- ===================================================================
     MAIN
     =================================================================== -->
<main class="main">

    <!-- ── HEADER ──────────────────────────────────────────────────── -->
    <header class="header">

        <!-- back / forward nav -->
        <div class="header-nav-btns">
            <button class="header-nav-btn" onclick="history.back()" title="Back">
                <i class="fa-solid fa-chevron-left"></i>
            </button>
            <button class="header-nav-btn" onclick="history.forward()" title="Forward">
                <i class="fa-solid fa-chevron-right"></i>
            </button>
        </div>

        <!-- search bar -->
        <div class="header-search">
            <i class="fa-solid fa-magnifying-glass"></i>
            <input type="text" placeholder="Tìm bài hát, nghệ sĩ…"
                   onkeydown="if(event.key==='Enter') window.location='${pageContext.request.contextPath}/search?keyword='+this.value">
        </div>

        <div class="header-spacer"></div>

        <!-- ── NOTIFICATION BELL ─────────────────────────────────── -->
        <div class="notification-wrapper">
            <button class="notification-btn" onclick="toggleNotification()" title="Thông báo">
                🔔
            </button>
            <div id="notificationBox" class="notification-box">
                <div class="notification-header">🔔 Thông báo</div>
                <c:choose>
                    <c:when test="${empty notifications}">
                        <div class="notification-item">Hiện chưa có thông báo nào</div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${notifications}" var="n">
                            <div class="notification-item">
                                <strong>${n.title}</strong>
                                <small>${n.content}</small>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- ── USER MENU ─────────────────────────────────────────── -->
        <div class="user-menu-wrapper">
            <div class="user-name-badge" onclick="toggleDropdown()">
                <div class="user-avatar"><%= avatarChar %></div>
                <span><%= fullname %></span>
            </div>
            <div id="userDropdown" class="user-dropdown">
                <a href="${pageContext.request.contextPath}/profile">
                    <i class="fa-solid fa-user" style="width:14px;opacity:.6;"></i> Hồ sơ
                </a>
                <a href="${pageContext.request.contextPath}/settings">
                    <i class="fa-solid fa-gear" style="width:14px;opacity:.6;"></i> Cài đặt
                </a>
            </div>
        </div>

    </header>
    <!-- /HEADER -->

    <!-- ── SCROLLABLE CONTENT ───────────────────────────────────── -->
    <div class="main-content">

        <!-- BANNER / GREETING + QUICK PLAYS -->
        <div class="banner">
            <div class="greeting-time" id="greetingText">
                Good Evening, <%= fullname %>
            </div>
            
		<div class="quick-play-wrapper">
		    <button class="scroll-btn left" onclick="scrollQuick(-400)">
		        ❮
		    </button>
		    
            <div class="quick-plays" id="quickPlays">
                <c:forEach items="${songs}" var="s">
                    <div class="quick-play-card"
                         onclick="playSong('${pageContext.request.contextPath}/${s.audioUrl}',
                                          '${s.title}',
                                          '${s.artist}',
                                          '${pageContext.request.contextPath}/${s.imageUrl}')">
                        <img src="${pageContext.request.contextPath}/${s.imageUrl}"
                             class="quick-play-img"
                             alt="${s.title}"
                             onerror="this.src='https://placehold.co/56x56/282828/B3B3B3?text=♪'">
                        <span class="quick-play-title">${s.title}</span>
                        <button class="quick-play-btn"
                                onclick="event.stopPropagation();
                                         playSong('${pageContext.request.contextPath}/${s.audioUrl}',
                                                  '${s.title}',
                                                  '${s.artist}',
                                                  '${pageContext.request.contextPath}/${s.imageUrl}')">
                            <i class="fa-solid fa-play"></i>
                        </button>
                    </div>
                </c:forEach>
            </div>
            
             <button class="scroll-btn right" onclick="scrollQuick(400)">
		        ❯
		     </button>
            </div>
        </div>

        <!-- ADD SONG BUTTON -->
        <button class="add-song-btn" onclick="toggleAddForm()">
            <i class="fa-solid fa-plus"></i> Add Song
        </button>

        <!-- ADD SONG FORM -->
        <div id="addSongForm">
            <div class="form-title">Add New Song</div>
            <form action="${pageContext.request.contextPath}/add-song" method="post" enctype="multipart/form-data">
                <div class="form-grid">
                    <div class="form-field">
                        <label>Song Title</label>
                        <input type="text" name="title" placeholder="Enter song title" required class="form-input">
                    </div>
                    <div class="form-field">
                        <label>Artist</label>
                        <input type="text" name="artist" placeholder="Enter artist name" required class="form-input">
                    </div>
                </div>
                <div class="form-files">
                    <div class="form-field">
                        <label>Audio File</label>
                        <div class="file-upload-area">
                            <div class="file-upload-wrapper">
                                <i class="fa-solid fa-music"></i>
                                <span class="file-label-text">Choose audio file</span>
                                <input type="file" name="audioFile" accept="audio/*" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-field">
                        <label>Cover Image</label>
                        <div class="file-upload-area">
                            <div class="file-upload-wrapper">
                                <i class="fa-solid fa-image"></i>
                                <span class="file-label-text">Choose cover image</span>
                                <input type="file" name="imageFile" accept="image/*" required>
                            </div>
                        </div>
                    </div>
                </div>
                <button type="submit" class="form-submit-btn">Save Song</button>
            </form>
        </div>
<!---------- ARTISTS SECTION ------------->
<c:if test="${empty keyword}">
    <section class="featured-artists">
			<h2 class="section-title">🎤 Nghệ sĩ nổi bật</h2>

			<div class="artist-row">
			
			    <c:forEach items="${artists}" var="a">
			
			        <div class="artist-card">
			
			            <img src="${pageContext.request.contextPath}/${a.image}"
			                 class="artist-img">
			
			            <div class="artist-name">
			                ${a.name}
			            </div>
			
			        </div>
			
			    </c:forEach>
			
			</div>
	</section>
</c:if>
		
		<div id="artist-detail"></div>
		
		<hr class="section-divider">
        <!-- SONG GRID -->
        <c:choose>
    <c:when test="${not empty keyword}">
        <h2>Kết quả tìm kiếm: "${keyword}"</h2>
    </c:when>
    <c:otherwise>
        <div class="section-header">
            <h2 class="section-title">All Songs</h2>
            <a href="#" class="section-see-all">See all</a>
        </div>
    </c:otherwise>
    </c:choose>

        <div class="song-grid">
            <c:forEach items="${songs}" var="s">
                <div class="song-card"
                     id="card-${s.audioUrl}"
                     onclick="location.href='${pageContext.request.contextPath}/song?id=${s.id}'">

                    <div class="song-img-wrapper">
                        <img src="${pageContext.request.contextPath}/${s.imageUrl}"
                             class="song-img"
                             alt="${s.title}"
                             onerror="this.src='https://placehold.co/180x180/282828/B3B3B3?text=♪'">

                        <button class="card-play-btn"
                                onclick="event.stopPropagation();
                                           playSong('${s.id}',
						                          '${pageContext.request.contextPath}/${s.audioUrl}',
						                          '${s.title}',
						                          '${s.artist}',
						                          '${pageContext.request.contextPath}/${s.imageUrl}')">
                            <i class="fa-solid fa-play"></i>
                        </button>

                        <a href="${pageContext.request.contextPath}/favorite?songId=${s.id}"
                           onclick="event.stopPropagation();"
                           class="favorite-btn" title="Thêm vào yêu thích">
                            <i class="fa-solid fa-heart"></i>
                        </a>

                        <a href="${pageContext.request.contextPath}/home?action=delete&id=${s.id}"
                           class="card-delete-btn"
                           title="Xóa bài hát"
                           onclick="event.stopPropagation(); return confirm('Bạn có chắc muốn xóa bài hát này?')">
                            <i class="fa-solid fa-trash"></i>
                        </a>
                    </div>

                    <div class="card-title">${s.title}</div>
                    <div class="card-artist"
					     onclick="event.stopPropagation();
					              window.location.href='${pageContext.request.contextPath}/artist?name=${s.artist}'"
					     style="cursor:pointer;">
					    ${s.artist}
					</div>
                    <c:if test="${not empty s.genre}">
                        <div class="card-genre">${s.genre}</div>
                    </c:if>

                    <c:if test="${not empty s.user}">
                        <div class="card-uploader">
                            Đăng bởi:
                            <a href="${pageContext.request.contextPath}/user-profile?id=${s.user.id}"
                               onclick="event.stopPropagation();">
                                ${s.user.email}
                            </a>
                        </div>
                    </c:if>

                </div>
            </c:forEach>
        </div>

        <!-- EMPTY STATE -->
        <c:if test="${empty songs}">
            <div class="empty-state">
                <i class="fa-solid fa-music"></i>
                <h3>No songs yet</h3>
                <p>Add your first song to get started</p>
            </div>
        </c:if>

    </div>
    <!-- /main-content -->

</main>

<!-- ===================================================================
     PLAYER  (fixed bottom bar)
     =================================================================== -->
<div class="player">

    <!-- Track info -->
    <div class="player-track-info">
        <div class="player-thumb" id="playerThumb">
            <i class="fa-solid fa-music"></i>
        </div>
        <div class="player-text">
            <span id="songTitle">Choose a song</span>
            <span id="songArtist">---</span>
        </div>
        <div class="playing-indicator" id="playingIndicator">
            <div class="playing-bar"></div>
            <div class="playing-bar"></div>
            <div class="playing-bar"></div>
        </div>
    </div>

    <!-- Audio controls -->
    <div class="player-center">
        <div class="audio-player-container">
            <audio id="audioPlayer" controls style="width:100%; height:36px;"></audio>
        </div>
    </div>

    <!-- Right side -->
    <div class="player-right">
        <i class="fa-solid fa-volume-high volume-icon"></i>
    </div>

</div>

<!-- ===================================================================
     SCRIPTS  – UI only, no backend logic changed
     =================================================================== -->
<script>
// ================= GREETING =================
(function () {
    const hour = new Date().getHours();
    const name = "<%= fullname %>";

    let g = "Good Evening";
    if (hour >= 5 && hour < 12) g = "Good Morning";
    else if (hour >= 12 && hour < 18) g = "Good Afternoon";

    const el = document.getElementById("greetingText");
    if (el) el.textContent = g + ", " + name;
})();


// ================= PLAYER STATE =================
let currentSongId = null;
let countedView = false;


// ================= PLAY SONG =================
function playSong(id, url, title, artist, imageUrl) {

    currentSongId = id;
    countedView = false;

    const player = document.getElementById("audioPlayer");
    player.src = url;
    player.play();

    document.getElementById("songTitle").innerText = title;
    document.getElementById("songArtist").innerText = artist;

    const thumb = document.getElementById("playerThumb");

    if (imageUrl) {
        thumb.innerHTML =
            '<img src="' + imageUrl + '" alt="' + title + '" ' +
            'onerror="this.parentElement.innerHTML=\'<i class=&quot;fa-solid fa-music&quot;></i>\'">';
    } else {
        thumb.innerHTML = '<i class="fa-solid fa-music"></i>';
    }

    // indicator ON
    document.getElementById("playingIndicator").classList.add("active");

    // remove highlight
    document.querySelectorAll(".song-card.is-playing")
        .forEach(c => c.classList.remove("is-playing"));
}


// ================= AUDIO EVENTS =================
const audio = document.getElementById("audioPlayer");

audio.addEventListener("play", function () {
    document.getElementById("playingIndicator").classList.add("active");
});

audio.addEventListener("pause", function () {
    document.getElementById("playingIndicator").classList.remove("active");
});


// ================= ADD FORM =================
function toggleAddForm() {
    const form = document.getElementById("addSongForm");
    if (!form) return;

    form.style.display = (form.style.display === "block") ? "none" : "block";
}


// ================= NOTIFICATION =================
function toggleNotification() {
    const box = document.getElementById("notificationBox");
    if (!box) return;

    box.style.display = (box.style.display === "block") ? "none" : "block";
}


// ================= USER DROPDOWN =================
function toggleDropdown() {
    const dd = document.getElementById("userDropdown");
    if (!dd) return;

    dd.style.display = (dd.style.display === "block") ? "none" : "block";
}


// click outside close
window.addEventListener("click", function (e) {
    const userBox = document.querySelector(".user-menu-wrapper");
    const notiBox = document.querySelector(".notification-wrapper");

    if (userBox && !userBox.contains(e.target)) {
        const dd = document.getElementById("userDropdown");
        if (dd) dd.style.display = "none";
    }

    if (notiBox && !notiBox.contains(e.target)) {
        const box = document.getElementById("notificationBox");
        if (box) box.style.display = "none";
    }
});


// ================= QUICK SCROLL =================
function scrollQuick(amount) {
    const el = document.getElementById("quickPlays");
    if (!el) return;

    el.scrollBy({ left: amount, behavior: "smooth" });
}


// ================= TIME UPDATE (VIEW COUNT) =================
audio.addEventListener("timeupdate", function () {

    if (!currentSongId || countedView) return;

    if (this.currentTime >= 30) {
        countedView = true;

        fetch('${pageContext.request.contextPath}/song?action=view&id=' + currentSongId, {
            method: 'POST'
        })
        .then(() => console.log("View +1"))
        .catch(err => console.error(err));
    }
});
</script>
</body>
</html>
