<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Premium Playlist Hub</title>
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">

    <style>
        /* =================================================================
           SPOTIFY PREMIUM DARK GLASSMORPHISM STYLING SYSTEM
           ================================================================= */
        :root {
            --bg-deep: #060606;
            --bg-main: #0d0d0d;
            --bg-card: rgba(24, 24, 24, 0.45);
            --bg-card-hover: rgba(36, 36, 36, 0.75);
            --bg-glass: rgba(255, 255, 255, 0.03);
            --bg-glass-player: rgba(18, 18, 18, 0.75);
            --border-glass: rgba(255, 255, 255, 0.06);
            --border-glow: rgba(29, 185, 84, 0.25);
            
            --primary: #1db954;
            --primary-neon: #1ed760;
            --primary-glow: rgba(29, 185, 84, 0.4);
            
            --text-main: #ffffff;
            --text-sub: #b3b3b3;
            --text-muted: #5e5e5e;
            
            --font-display: 'Syne', sans-serif;
            --font-body: 'Plus Jakarta Sans', sans-serif;
            --ease-main: cubic-bezier(0.33, 1, 0.68, 1);
        }

        /* Ambient Fluid Background Lights Animation */
        .ambient-glow-wrapper {
            position: fixed;
            inset: 0;
            z-index: -1;
            background: var(--bg-deep);
            overflow: hidden;
            pointer-events: none;
        }
        .blur-light {
            position: absolute;
            width: 550px;
            height: 550px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(29, 185, 84, 0.08) 0%, transparent 70%);
            filter: blur(80px);
            animation: floatAmbient 12s infinite alternate ease-in-out;
        }
        .light-1 { top: -10%; left: -5%; animation-delay: 0s; }
        .light-2 { bottom: -10%; right: -5%; background: radial-gradient(circle, rgba(30, 215, 96, 0.06) 0%, transparent 70%); animation-delay: 4s; }

        @keyframes floatAmbient {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(40px, 30px) scale(1.15); }
        }

        /* Reset & Base System UI Styles */
        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }
        body {
            font-family: var(--font-body);
            background: var(--bg-deep);
            color: var(--text-main);
            min-height: 100vh;
            padding-bottom: 140px; /* Safe padding spacing for floating absolute bottom audio deck player */
            overflow-x: hidden;
            -webkit-font-smoothing: antialiased;
        }

        /* Custom Scrollbar Interface Engine */
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.1); border-radius: 20px; }
        ::-webkit-scrollbar-thumb:hover { background: var(--primary); }

        /* Container Layout Structure */
        .container {
            max-width: 1240px;
            margin: 0 auto;
            padding: 40px 24px;
            animation: pageFadeIn 0.8s var(--ease-main) both;
        }
        @keyframes pageFadeIn {
            from { opacity: 0; transform: translateY(15px); }
            to { opacity: 1; transform: translateY(0); }
        }

        /* =================================================================
           PLAYLIST HERO BANNER HEADER COMPONENT
           ================================================================= */
        .playlist-header {
            position: relative;
            background: linear-gradient(135deg, rgba(29, 185, 84, 0.15) 0%, rgba(18, 18, 18, 0.2) 100%);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass);
            padding: 40px;
            border-radius: 24px;
            margin-bottom: 40px;
            display: flex;
            align-items: center;
            gap: 32px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.5);
            overflow: hidden;
        }
        .playlist-header::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(circle at top left, var(--border-glow), transparent 60%);
            pointer-events: none;
        }

        /* Luxury Interactive Avatar Image Stack Styling */
        .header-cover-frame {
            position: relative;
            width: 220px;
            height: 220px;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6);
            flex-shrink: 0;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .header-cover-frame img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.6s var(--ease-main);
        }
        .playlist-header:hover .header-cover-frame img {
            transform: scale(1.05);
        }

        /* Metadata Text Typography Node Layout */
        .header-meta-details {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .meta-badge {
            font-size: 11px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--primary-neon);
            margin-bottom: 8px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .playlist-header h1 {
            font-family: var(--font-display);
            font-size: 48px;
            font-weight: 800;
            letter-spacing: -1.5px;
            line-height: 1.1;
            margin-bottom: 12px;
            background: linear-gradient(135deg, #ffffff 0%, #b3b3b3 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .playlist-desc {
            color: var(--text-sub);
            font-size: 15px;
            font-weight: 400;
            line-height: 1.5;
            margin-bottom: 24px;
            max-width: 650px;
        }

        /* Premium Floating Core Play All Pill Action Button Container */
        .play-all-btn {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            background: var(--primary);
            color: #000000;
            font-family: var(--font-body);
            font-size: 14px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 1px;
            padding: 14px 36px;
            border: none;
            border-radius: 500px;
            cursor: pointer;
            box-shadow: 0 8px 25px var(--primary-glow);
            transition: all 0.35s var(--ease-main);
            position: relative;
            overflow: hidden;
        }
        .play-all-btn i { font-size: 16px; }
        .play-all-btn:hover {
            transform: scale(1.06);
            background: var(--primary-neon);
            box-shadow: 0 12px 30px rgba(29, 185, 84, 0.55);
        }
        .play-all-btn:active { transform: scale(0.98); }

        /* =================================================================
           PREMIUM MUSIC SONG LIST ENGINE CARDS GRID
           ================================================================= */
        .song-list-title-label {
            font-family: var(--font-display);
            font-size: 20px;
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 20px;
            color: var(--text-main);
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .song-list-wrapper {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        /* Creative Music Streaming Track Responsive Card Row Node */
        .song-card {
            background: var(--bg-card);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid var(--border-glass);
            border-radius: 14px;
            padding: 12px 24px 12px 16px;
            display: grid;
            grid-template-columns: 40px 60px 1fr 60px;
            align-items: center;
            gap: 20px;
            cursor: pointer;
            transition: all 0.3s var(--ease-main);
            position: relative;
        }
        
        /* Auto Incrementing Automation Counter Staggered Effects List */
        .index-number {
            font-size: 14px;
            font-weight: 600;
            color: var(--text-muted);
            text-align: center;
            transition: opacity 0.2s;
        }
        .card-play-trigger-icon {
            position: absolute;
            left: 26px;
            font-size: 12px;
            color: var(--primary-neon);
            opacity: 0;
            transform: scale(0.7) translateY(-50%);
            top: 50%;
            transition: all 0.2s var(--ease-main);
        }

        /* Thumb Layout Context Block Row Asset Engine */
        .song-thumb-box {
            position: relative;
            width: 60px;
            height: 60px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 6px 14px rgba(0,0,0,0.3);
            border: 1px solid rgba(255,255,255,0.05);
        }
        .song-thumb-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s var(--ease-main);
        }

        /* Meta Content Node Typography Titles */
        .song-details-meta {
            display: flex;
            flex-direction: column;
            gap: 4px;
            overflow: hidden;
        }
        .song-title-text {
            font-size: 16px;
            font-weight: 700;
            color: var(--text-main);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            transition: color 0.25s;
        }
        .song-artist-text {
            font-size: 13px;
            color: var(--text-sub);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Right Panel Dedicated Hover Play Circular Embedded Nodes */
        .play-icon-circle-trigger {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: #ffffff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            padding-left: 2px; /* Center adjustment for play geometry triangle */
            transition: all 0.3s var(--ease-main);
            margin-left: auto;
        }

        /* Hover Interaction Telemetry States Management Classes */
        .song-card:hover {
            background: var(--bg-card-hover);
            border-color: var(--border-glow);
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.4), 0 0 15px rgba(29,185,84,0.05);
        }
        .song-card:hover .index-number { opacity: 0; }
        .song-card:hover .card-play-trigger-icon { opacity: 1; transform: scale(1) translateY(-50%); }
        .song-card:hover .song-thumb-box img { transform: scale(1.08); }
        .song-card:hover .song-title-text { color: var(--primary-neon); }
        .song-card:hover .play-icon-circle-trigger {
            background: var(--primary);
            color: #000000;
            border-color: transparent;
            transform: scale(1.1);
            box-shadow: 0 4px 12px var(--primary-glow);
        }

        /* Active Selected State Target Tracking Configs */
        .song-card.is-currently-playing {
            background: rgba(29, 185, 84, 0.08);
            border-color: var(--primary);
        }
        .song-card.is-currently-playing .index-number { display: none; }
        .song-card.is-currently-playing .card-play-trigger-icon {
            opacity: 1 !important;
            transform: scale(1) translateY(-50%) !important;
            color: var(--primary-neon);
        }
        .song-card.is-currently-playing .song-title-text { color: var(--primary-neon); font-weight: 800; }

        /* =================================================================
           FLOATING GLASSMORPHISM BOTTOM AUDIO DOCK MASTER CONTROLLER PLAYER
           ================================================================= */
        .premium-floating-player-bar {
            position: fixed;
            bottom: 24px;
            left: 50%;
            transform: translateX(-50%) translateY(30px);
            width: calc(100% - 48px);
            max-width: 1000px;
            background: var(--bg-glass-player);
            backdrop-filter: blur(30px);
            -webkit-backdrop-filter: blur(30px);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            padding: 16px 28px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.7), 0 0 30px rgba(29, 185, 84, 0.03);
            z-index: 999;
            display: grid;
            grid-template-columns: 1.2fr 2fr 1fr;
            align-items: center;
            gap: 24px;
            opacity: 0;
            transition: all 0.6s cubic-bezier(0.34, 1.56, 0.64, 1);
            pointer-events: none;
        }
        
        /* Active Display Class Triggered dynamically by event listener closures */
        .premium-floating-player-bar.system-player-active {
            transform: translateX(-50%) translateY(0);
            opacity: 1;
            pointer-events: auto;
        }

        /* Player Left Metadata Block Area Context */
        .player-identity-panel {
            display: flex;
            align-items: center;
            gap: 14px;
            overflow: hidden;
        }
        .player-avatar-wrapper {
            width: 52px;
            height: 52px;
            border-radius: 8px;
            overflow: hidden;
            background: #242424;
            flex-shrink: 0;
            border: 1px solid rgba(255,255,255,0.05);
        }
        .player-avatar-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .player-meta-info-strings {
            display: flex;
            flex-direction: column;
            gap: 2px;
            overflow: hidden;
        }
        .player-meta-info-strings h4 {
            font-size: 14px;
            font-weight: 700;
            color: var(--text-main);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .player-meta-info-strings p {
            font-size: 12px;
            color: var(--text-sub);
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Equalizer Animation Audio Wave Indicator Bars Components */
        .equalizer-wave-hub {
            display: flex;
            align-items: flex-end;
            gap: 3px;
            height: 14px;
            margin-left: 8px;
            flex-shrink: 0;
        }
        .eq-bar {
            width: 3px;
            background: var(--primary-neon);
            border-radius: 2px;
            height: 30%;
            animation: bounceEQ 1.2s infinite ease-in-out alternate;
            animation-play-state: paused; /* Toggled dynamically through main DOM events processing blocks */
        }
        .eq-bar:nth-child(1) { animation-delay: 0.1s; height: 40%; }
        .eq-bar:nth-child(2) { animation-delay: 0.4s; height: 90%; }
        .eq-bar:nth-child(3) { animation-delay: 0.2s; height: 60%; }

        @keyframes bounceEQ {
            0% { transform: scaleY(0.3); }
            100% { transform: scaleY(1); }
        }
        .premium-floating-player-bar.music-is-playing .eq-bar {
            animation-play-state: running;
        }

        /* Player Center Tracking Hub Component */
        .player-center-dashboard {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .now-playing-label-badge {
            font-size: 13px;
            font-weight: 600;
            color: var(--primary-neon);
            text-shadow: 0 0 10px rgba(29,185,84,0.2);
            text-align: center;
            letter-spacing: 0.5px;
            max-width: 400px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        /* Player Right Side Utilities */
        .player-right-utilities {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            gap: 16px;
        }
        .native-audio-element-node {
            width: 100%;
            outline: none;
            height: 32px;
            background: transparent;
        }
        
        /* Webkit custom integration targeting embedded control bars layout look styling */
        audio::-webkit-media-controls-enclosure {
            background-color: rgba(255, 255, 255, 0.06) !important;
            border-radius: 10px;
        }
        audio::-webkit-media-controls-panel {
            background-color: rgba(255, 255, 255, 0.06) !important;
        }

        /* Empty State Fallback Screen View Styles */
        .empty-playlist-state {
            text-align: center;
            padding: 80px 20px;
            background: var(--bg-card);
            border: 1px dashed var(--border-glass);
            border-radius: 20px;
        }
        .empty-playlist-state i {
            font-size: 48px;
            color: var(--text-muted);
            margin-bottom: 16px;
        }
        .empty-playlist-state h3 {
            font-family: var(--font-display);
            font-size: 20px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .empty-playlist-state p {
            font-size: 14px;
            color: var(--text-sub);
        }

        /* =================================================================
           RESPONSIVE VIEWPORT CO-ORDINATION MEDIA QUERY GRID BREAKPOINTS
           ================================================================= */
        @media (max-width: 992px) {
            .premium-floating-player-bar {
                grid-template-columns: 1.5fr 2fr;
                padding: 14px 20px;
            }
            .player-right-utilities { display: none; }
        }

        @media (max-width: 768px) {
            .playlist-header {
                flex-direction: column;
                align-items: center;
                text-align: center;
                padding: 24px;
                gap: 20px;
            }
            .header-cover-frame {
                width: 160px;
                height: 160px;
            }
            .playlist-header h1 {
                font-size: 32px;
            }
            .song-card {
                grid-template-columns: 30px 50px 1fr 40px;
                gap: 12px;
                padding: 10px 16px 10px 10px;
            }
            .song-thumb-box {
                width: 50px;
                height: 50px;
            }
            .song-title-text { font-size: 14px; }
            .song-artist-text { font-size: 12px; }
            .premium-floating-player-bar {
                grid-template-columns: 1fr;
                bottom: 12px;
                width: calc(100% - 24px);
                gap: 12px;
                padding: 12px 16px;
            }
            .player-identity-panel { justify-content: center; }
            .now-playing-label-badge { font-size: 12px; }
        }
    </style>
</head>
<body>

    <div class="ambient-glow-wrapper">
        <div class="blur-light light-1"></div>
        <div class="blur-light light-2"></div>
    </div>

    <div class="container">

        <header class="playlist-header">
            <div class="header-cover-frame">
                <c:choose>
                    <c:when test="${not empty playlist}">
                        <img src="${playlist[0].song.imageUrl}" alt="Playlist Cover Art">
                    </c:when>
                    <c:otherwise>
                        <img src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='200' height='200' viewBox='0 0 100 100'><rect width='100%25' height='100%25' fill='%231f1f1f'/><text x='50%25' y='55%25' font-family='sans-serif' font-size='10' fill='%23555' text-anchor='middle'>No Cover</text></svg>" alt="Default Cover Asset">
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="header-meta-details">
                <div class="meta-badge">
                    <i class="fa-solid fa-bolt-lightning"></i> Premium Playlist Collection
                </div>
                <h1>Danh Sách Phát</h1>
                <p class="playlist-desc">
                    Trải nghiệm không gian âm nhạc chất lượng cao đỉnh cao. Các giai điệu yêu thích của bạn được tối ưu hóa mượt mà với giao diện Glassmorphism độc đáo.
                </p>
                <div>
                    <button class="play-all-btn" onclick="playAll()">
                        <i class="fa-solid fa-play"></i> Phát toàn bộ danh sách
                    </button>
                </div>
            </div>
        </header>

        <section>
            <h3 class="song-list-title-label">
                <i class="fa-solid fa-music" style="color: var(--primary-neon); font-size: 16px;"></i> 
                Tất Cả Giai Điệu (${playlist.size()})
            </h3>
            
            <div class="song-list-wrapper">
                <c:forEach items="${playlist}" var="item" varStatus="s">
                    <div class="song-card" id="song-row-${s.index}" onclick="playSong(${s.index})">
                        
                        <div style="position: relative; display: flex; align-items: center; justify-content: center;">
                            <span class="index-number">${s.index + 1}</span>
                            <i class="fa-solid fa-volume-high card-play-trigger-icon"></i>
                        </div>
                        
                        <div class="song-thumb-box">
                            <img src="${item.song.imageUrl}" alt="${item.song.title}">
                        </div>
                        
                        <div class="song-details-meta">
                            <div class="song-title-text">${item.song.title}</div>
                            <div class="song-artist-text">${item.song.artist}</div>
                        </div>
                        
                        <div class="play-icon-circle-trigger">
                            <i class="fa-solid fa-play"></i>
                        </div>
                        
                    </div>
                </c:forEach>
            </div>

            <c:if test="${empty playlist}">
                <div class="empty-playlist-state">
                    <i class="fa-solid fa-compact-disc"></i>
                    <h3>Danh sách trống rỗng</h3>
                    <p>Chưa có bài hát nào được thêm vào danh sách phát này. Hãy tiếp tục khám phá thêm nhé!</p>
                </div>
            </c:if>
        </section>

    </div>

    <div class="premium-floating-player-bar" id="premiumDockPlayer">
        
        <div class="player-identity-panel">
            <div class="player-avatar-wrapper">
                <img id="dockTrackCoverArt" src="data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='60' height='60'></svg>" alt="Active Thumbnail">
            </div>
            <div class="player-meta-info-strings">
                <h4 id="dockTrackTitleStr">Tên Bài Hát</h4>
                <p id="dockTrackArtistStr">Nghệ Sĩ</p>
            </div>
            
            <div class="equalizer-wave-hub">
                <div class="eq-bar"></div>
                <div class="eq-bar"></div>
                <div class="eq-bar"></div>
            </div>
        </div>

        <div class="player-center-dashboard">
            <div class="now-playing-label-badge" id="nowPlaying">
                🎶 Đang phát: Sẵn sàng trải nghiệm âm nhạc
            </div>
        </div>

        <div class="player-right-utilities">
            <audio id="player" controls class="native-audio-element-node"></audio>
        </div>
        
    </div>


    <script>
    // BẢO TOÀN 100% MẢNG PLAYLIST DỮ LIỆU TỪ BACKEND CỦA BẠN
    const playlist = [
    <c:forEach items="${playlist}" var="item" varStatus="s">
    {
        title: "${item.song.title}",
        artist: "${item.song.artist}",
        src: "${item.song.audioUrl}",
        imageUrl: "${item.song.imageUrl}" // Đọc thêm thuộc tính ảnh phục vụ UI Docker chuyên nghiệp
    }
    <c:if test="${!s.last}">,</c:if>
    </c:forEach>
    ];

    // Khởi tạo các Element Node DOM Objects Core Frameworks
    const player = document.getElementById("player");
    const nowPlaying = document.getElementById("nowPlaying");
    const premiumDockPlayer = document.getElementById("premiumDockPlayer");
    const dockTrackCoverArt = document.getElementById("dockTrackCoverArt");
    const dockTrackTitleStr = document.getElementById("dockTrackTitleStr");
    const dockTrackArtistStr = document.getElementById("dockTrackArtistStr");

    let currentIndex = 0;

    // GIỮ NGUYÊN LOGIC HÀM: updateNowPlaying()
    function updateNowPlaying(){
        if(playlist.length === 0) return;

        nowPlaying.innerHTML =
            "🎶 Đang phát: " +
            playlist[currentIndex].title +
            " - " +
            playlist[currentIndex].artist;
            
        // Xử lý Render thêm giao diện Premium Dock Layer bổ trợ bên ngoài, không can thiệp logic gốc
        dockTrackTitleStr.innerText = playlist[currentIndex].title;
        dockTrackArtistStr.innerText = playlist[currentIndex].artist;
        if(playlist[currentIndex].imageUrl) {
            dockTrackCoverArt.src = playlist[currentIndex].imageUrl;
        }
        
        // Kích hoạt hiển thị thanh dock bar khi có bài hát chạy qua
        premiumDockPlayer.classList.add("system-player-active");
        
        // Quản lý chuyển đổi CSS class highlight dòng nhạc đang phát trong Grid
        document.querySelectorAll('.song-card').forEach(card => card.classList.remove('is-currently-playing'));
        const activeCardRow = document.getElementById('song-row-' + currentIndex);
        if(activeCardRow) {
            activeCardRow.classList.add('is-currently-playing');
        }
    }

    // GIỮ NGUYÊN LOGIC HÀM: playSong(index)
    function playSong(index){
        currentIndex = index;

        player.src = playlist[index].src;

        updateNowPlaying();

        player.play();
    }

    // GIỮ NGUYÊN LOGIC HÀM: playAll()
    function playAll(){
        if(playlist.length === 0) return;

        currentIndex = 0;

        player.src = playlist[0].src;

        updateNowPlaying();

        player.play();
    }

    // GIỮ NGUYÊN EVENT LISTENER GỐC: Tự động chuyển bài khi kết thúc ("ended")
    player.addEventListener("ended", function(){
        currentIndex++;
        if(currentIndex >= playlist.length){
            currentIndex = 0; // lặp lại từ đầu danh sách bài hát
        }
        playSong(currentIndex);
    });
    
    // Tích hợp thêm các sub-micro interaction bổ trợ giám sát hiệu ứng Equalizer chuyển động
    player.addEventListener("play", function() {
        premiumDockPlayer.classList.add("music-is-playing");
    });
    player.addEventListener("pause", function() {
        premiumDockPlayer.classList.remove("music-is-playing");
    });
    </script>
</body>
</html>