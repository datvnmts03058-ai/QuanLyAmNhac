<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Song Activity Dashboard - Spotify Analytics Style</title>
    <style>
        /* --- SYSTEM DESIGN VARIABLES --- */
        :root {
            --bg-main: #09090b;
            --bg-gradient: linear-gradient(135deg, #09090b 0%, #121212 100%);
            --card-glow: rgba(29, 185, 84, 0.15);
            
            /* Core Palette */
            --primary: #1db954;
            --primary-hover: #1ed760;
            --info: #2196F3;
            --warning: #FF9800;
            --danger: #F44336;
            
            /* Glassmorphism Configuration */
            --glass-bg: rgba(18, 18, 18, 0.6);
            --glass-border: rgba(255, 255, 255, 0.08);
            --spotify-border-glow: rgba(29, 185, 84, 0.25);
            
            /* Typography */
            --text-main: #ffffff;
            --text-muted: #a7a7a7;
            --text-subtle: #727272;
            
            /* Utilities */
            --radius-lg: 20px;
            --radius-md: 12px;
            --transition-smooth: all 0.4s cubic-bezier(0.16, 1, 0.3, 1);
        }

        /* --- RESET & BASE STYLES --- */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            background: var(--bg-main);
            background-image: var(--bg-gradient);
            color: var(--text-main);
            min-height: 100vh;
            padding: 40px 24px;
            overflow-x: hidden;
            position: relative;
        }

        /* --- AMBIENT GLOW BACKGROUND EFFECT --- */
        body::before, body::after {
            content: "";
            position: fixed;
            width: 400px;
            height: 400px;
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
            filter: blur(130px);
            opacity: 0.4;
            animation: ambientFloat 16s ease-in-out infinite;
        }

        body::before {
            background: radial-gradient(circle, var(--primary) 0%, transparent 70%);
            top: -150px;
            left: -100px;
        }

        body::after {
            background: radial-gradient(circle, #0d84a7 0%, transparent 70%);
            bottom: -150px;
            right: -100px;
            animation-delay: -4s;
        }

        @keyframes ambientFloat {
            0%, 100% { transform: translateY(0) scale(1) rotate(0deg); }
            50% { transform: translateY(50px) scale(1.1) rotate(180deg); }
        }

        /* --- DASHBOARD CONTAINER & ANIMATION --- */
        .dashboard-container {
            max-width: 1400px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
            animation: dashboardIntro 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }

        @keyframes dashboardIntro {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* --- HEADER STYLING --- */
        .dashboard-header {
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .dashboard-title-wrapper {
            display: flex;
            align-items: center;
            gap: 16px;
        }

        .dashboard-icon-main {
            background: rgba(29, 185, 84, 0.1);
            border: 1px solid rgba(29, 185, 84, 0.2);
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            box-shadow: 0 0 20px rgba(29, 185, 84, 0.15);
        }

        .dashboard-header h1 {
            font-size: 32px;
            font-weight: 800;
            letter-spacing: -0.5px;
            background: linear-gradient(120deg, #ffffff 40%, #1ed760 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .live-badge {
            display: flex;
            align-items: center;
            gap: 8px;
            background: rgba(255, 255, 255, 0.05);
            padding: 8px 16px;
            border-radius: 20px;
            border: 1px solid var(--glass-border);
            font-size: 13px;
            font-weight: 500;
            color: var(--text-muted);
        }

        .live-dot {
            width: 8px;
            height: 8px;
            background-color: var(--primary);
            border-radius: 50%;
            position: relative;
        }

        .live-dot::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: var(--primary);
            border-radius: 50%;
            animation: pulse 1.8s infinite;
            left: 0; top: 0;
        }

        @keyframes pulse {
            0% { transform: scale(1); opacity: 1; }
            100% { transform: scale(3); opacity: 0; }
        }

        /* --- ANALYTICS CARDS GRID (STAGGERED ANIMATION) --- */
        .analytics-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 24px;
            margin-bottom: 40px;
        }

        .metric-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-lg);
            padding: 24px;
            position: relative;
            overflow: hidden;
            transition: var(--transition-smooth);
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            opacity: 0;
            animation: cardFadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1) forwards;
        }

        @keyframes cardFadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* Stagger Delays */
        .metric-card:nth-child(1) { animation-delay: 0.1s; --accent-color: var(--primary); }
        .metric-card:nth-child(2) { animation-delay: 0.2s; --accent-color: var(--info); }
        .metric-card:nth-child(3) { animation-delay: 0.3s; --accent-color: var(--warning); }
        .metric-card:nth-child(4) { animation-delay: 0.4s; --accent-color: var(--danger); }

        /* Card Hover Effects */
        .metric-card:hover {
            transform: translateY(-6px);
            border-color: var(--accent-color);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.4), 0 0 20px calc(var(--accent-color) * 0.15);
        }

        .metric-card::before {
            content: '';
            position: absolute;
            top: 0; right: 0;
            width: 120px; height: 120px;
            background: radial-gradient(circle, var(--accent-color) 0%, transparent 70%);
            opacity: 0.08;
            pointer-events: none;
            transition: var(--transition-smooth);
        }

        .metric-card:hover::before {
            opacity: 0.18;
            transform: scale(1.2);
        }

        .card-header-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .card-icon {
            width: 42px;
            height: 42px;
            border-radius: 10px;
            background: rgba(255, 255, 255, 0.03);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-color);
            border: 1px solid rgba(255, 255, 255, 0.05);
        }

        .card-value {
            font-size: 38px;
            font-weight: 800;
            letter-spacing: -1px;
            background: linear-gradient(110deg, #ffffff 60%, rgba(255,255,255,0.7));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            line-height: 1.2;
        }

        /* --- ANALYTICS DATA SECTIONS --- */
        .data-section {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--radius-lg);
            padding: 28px;
            margin-bottom: 32px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            transition: var(--transition-smooth);
        }

        .data-section:hover {
            border-color: rgba(255, 255, 255, 0.12);
            box-shadow: 0 15px 50px rgba(0, 0, 0, 0.35);
        }

        /* Section Heading Design */
        .section-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 24px;
            position: relative;
        }

        .section-header h2 {
            font-size: 20px;
            font-weight: 700;
            color: var(--text-main);
            letter-spacing: -0.3px;
        }

        .section-header svg {
            color: var(--primary);
        }

        /* Custom underline glow */
        .section-header::after {
            content: '';
            position: absolute;
            bottom: -8px; left: 0;
            width: 40px; height: 3px;
            background: var(--primary);
            border-radius: 2px;
            box-shadow: 0 0 10px var(--primary);
            animation: lineExpand 3s ease infinite alternate;
        }

        @keyframes lineExpand {
            0% { width: 40px; opacity: 0.6; }
            100% { width: 70px; opacity: 1; }
        }

        /* --- PREMIUM MODERN DATA TABLES --- */
        .table-responsive-wrapper {
            max-height: 400px;
            overflow-y: auto;
            overflow-x: auto;
            border-radius: var(--radius-md);
            border: 1px solid rgba(255, 255, 255, 0.05);
            background: rgba(0, 0, 0, 0.15);
        }

        .custom-dashboard-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            text-align: left;
        }

        /* Sticky Headers */
        .custom-dashboard-table th {
            position: sticky;
            top: 0;
            z-index: 10;
            background: #161618;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 16px 24px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        }

        .custom-dashboard-table td {
            padding: 16px 24px;
            font-size: 14px;
            color: rgba(255, 255, 255, 0.85);
            border-bottom: 1px solid rgba(255, 255, 255, 0.04);
            transition: var(--transition-smooth);
        }

        /* Row Interactivity */
        .custom-dashboard-table tbody tr {
            transition: var(--transition-smooth);
        }

        .custom-dashboard-table tbody tr:hover {
            background: rgba(29, 185, 84, 0.06);
            cursor: pointer;
        }

        .custom-dashboard-table tbody tr:hover td {
            color: #ffffff;
            transform: translateX(4px);
        }

        /* Highlight styling for important columns */
        .text-highlight-spotify {
            color: var(--primary-hover) !important;
            font-weight: 600;
        }
        
        .text-timestamp {
            font-family: monospace;
            color: var(--text-muted);
        }

        /* --- CUSTOM SPOTIFY SCROLLBAR --- */
        .table-responsive-wrapper::-webkit-scrollbar {
            width: 6px;
            height: 6px;
        }

        .table-responsive-wrapper::-webkit-scrollbar-thumb {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            transition: var(--transition-smooth);
        }

        .table-responsive-wrapper::-webkit-scrollbar-thumb:hover {
            background: var(--primary);
        }

        .table-responsive-wrapper::-webkit-scrollbar-track {
            background: transparent;
        }

        /* --- RESPONSIVE BREAKPOINTS --- */
        @media (max-width: 1024px) {
            body { padding: 24px 16px; }
            .dashboard-header h1 { font-size: 28px; }
            .metric-card { padding: 20px; }
            .card-value { font-size: 32px; }
        }

        @media (max-width: 768px) {
            .analytics-grid { grid-template-columns: 1fr; gap: 16px; }
            .dashboard-header { flex-direction: column; align-items: flex-start; gap: 16px; }
            .data-section { padding: 20px; }
            .custom-dashboard-table th, .custom-dashboard-table td { padding: 12px 16px; }
        }
    </style>
</head>
<body>

<div class="dashboard-container">

    <header class="dashboard-header">
        <div class="dashboard-title-wrapper">
            <div class="dashboard-icon-main">
                <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="20" x2="18" y2="10"></line><line x1="12" y1="20" x2="12" y2="4"></line><line x1="6" y1="20" x2="6" y2="14"></line></svg>
            </div>
            <h1>Song Activity Dashboard</h1>
        </div>
        <div class="live-badge">
            <span class="live-dot"></span>
            Studio Live Analytics
        </div>
    </header>

    <section class="analytics-grid">

        <div class="metric-card">
            <div class="card-header-meta">
                <span class="card-title">Tổng bài hát</span>
                <div class="card-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 18V5l12-2v13"></path><circle cx="6" cy="18" r="3"></circle><circle cx="18" cy="16" r="3"></circle></svg>
                </div>
            </div>
            <div class="card-value">${totalSongs}</div>
        </div>

        <div class="metric-card">
            <div class="card-header-meta">
                <span class="card-title">Tổng người dùng</span>
                <div class="card-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
                </div>
            </div>
            <div class="card-value">${totalUsers}</div>
        </div>

        <div class="metric-card">
            <div class="card-header-meta">
                <span class="card-title">Tổng lượt nghe</span>
                <div class="card-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3-7 10-7 10 7 10 7-3 7-10 7-10-7-10-7z"></path><circle cx="12" cy="12" r="3"></circle></svg>
                </div>
            </div>
            <div class="card-value">${totalViews}</div>
        </div>

        <div class="metric-card">
            <div class="card-header-meta">
                <span class="card-title">TB Bài / User</span>
                <div class="card-icon">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
                </div>
            </div>
            <div class="card-value">${avgSongsPerUser}</div>
        </div>

    </section>

    <section class="data-section">
        <div class="section-header">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"></path></svg>
            <h2>Top User Upload</h2>
        </div>
        <div class="table-responsive-wrapper">
            <table class="custom-dashboard-table">
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Số bài hát</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topUploaders}" var="row">
                        <tr>
                            <td>${row[0]}</td>
                            <td class="text-highlight-spotify">${row[1]}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <section class="data-section">
        <div class="section-header">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
            <h2>Upload Gần Đây</h2>
        </div>
        <div class="table-responsive-wrapper">
            <table class="custom-dashboard-table">
                <thead>
                    <tr>
                        <th>User</th>
                        <th>Bài hát</th>
                        <th>Ngày đăng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${uploadHistory}" var="row">
                        <tr>
                            <td>${row[0]}</td>
                            <td style="font-weight: 500;">${row[1]}</td>
                            <td class="text-timestamp">
                                <fmt:formatDate value="${row[2]}" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

    <section class="data-section">
        <div class="section-header">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
            <h2>Top Bài Hát Nhiều View</h2>
        </div>
        <div class="table-responsive-wrapper">
            <table class="custom-dashboard-table">
                <thead>
                    <tr>
                        <th>Bài hát</th>
                        <th>Ca sĩ</th>
                        <th>Views</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${topSongs}" var="song">
                        <tr>
                            <td style="font-weight: 600; color: #fff;">${song.title}</td>
                            <td style="color: var(--text-muted);">${song.artist}</td>
                            <td class="text-highlight-spotify">${song.views}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

</div>

</body>
</html>