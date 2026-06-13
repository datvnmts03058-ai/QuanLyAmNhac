<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Music — Premium Library Collection</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&family=Syne:wght@700;800&display=swap" rel="stylesheet">

<style>
/* =================================================================
   SPOTIFY PREMIUM RE-DESIGN STYLING ENGINE (GLASSMORPHISM DARK LUXURY)
   ================================================================= */
:root {
    --bg-deep: #060606;
    --bg-base: #0d0d0d;
    --bg-card: rgba(24, 24, 24, 0.55);
    --bg-card-hover: rgba(36, 36, 36, 0.8);
    --bg-glass: rgba(255, 255, 255, 0.03);
    --bg-glass-hover: rgba(255, 255, 255, 0.08);
    --border-glass: rgba(255, 255, 255, 0.07);
    --border-glow: rgba(29, 185, 84, 0.3);
    
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

/* Ambient Streaming Background Fluid Motion Light Circles */
.ambient-bg {
    position: fixed;
    inset: 0;
    z-index: -1;
    background: var(--bg-deep);
    overflow: hidden;
    pointer-events: none;
}
.blur-circle {
    position: absolute;
    width: 600px;
    height: 600px;
    border-radius: 50%;
    background: radial-gradient(circle, rgba(29, 185, 84, 0.09) 0%, transparent 68%);
    filter: blur(90px);
    animation: floatGlow 15s infinite alternate ease-in-out;
}
.circle-1 { top: -15%; right: -10%; animation-delay: 0s; }
.circle-2 { bottom: -15%; left: -10%; background: radial-gradient(circle, rgba(30, 215, 96, 0.06) 0%, transparent 68%); animation-delay: 4.5s; }

@keyframes floatGlow {
    0% { transform: translate(0, 0) scale(1); }
    100% { transform: translate(-40px, 50px) scale(1.12); }
}

/* Core Reset & UI Framework Rules */
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
    overflow-x: hidden;
    -webkit-font-smoothing: antialiased;
}

/* Custom Webkit Music App Scrollbar */
::-webkit-scrollbar { width: 6px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: rgba(255, 255, 255, 0.12); border-radius: 20px; }
::-webkit-scrollbar-thumb:hover { background: var(--primary); }

/* Master Page Content Wrapper Node */
.wrapper {
    max-width: 1280px;
    margin: 40px auto;
    padding: 32px;
    background: rgba(18, 18, 18, 0.4);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid var(--border-glass);
    border-radius: 24px;
    box-shadow: 0 30px 70px rgba(0, 0, 0, 0.6);
    animation: layoutReveal 0.7s var(--ease-main) both;
}
@keyframes layoutReveal {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* =================================================================
   PREMIUM PLATFORM NAV / BACK ACTION CONTROL BUTTON
   ================================================================= */
.back-btn {
    display: inline-flex;
    align-items: center;
    gap: 10px;
    padding: 10px 24px;
    background: rgba(255, 255, 255, 0.04);
    border: 1px solid var(--border-glass);
    border-radius: 500px;
    color: var(--text-main);
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1px;
    text-decoration: none;
    transition: all 0.3s var(--ease-main);
    margin-bottom: 32px;
}
.back-btn i {
    font-size: 14px;
    transition: transform 0.3s var(--ease-main);
}
.back-btn:hover {
    background: rgba(255, 255, 255, 0.08);
    border-color: var(--primary);
    color: var(--primary-neon);
    transform: scale(1.03);
    box-shadow: 0 0 20px rgba(29, 185, 84, 0.15);
}
.back-btn:hover i {
    transform: translateX(-4px);
}

/* =================================================================
   LUXURY HERO BANNER HEADER MODULE
   ================================================================= */
.library-hero-banner {
    position: relative;
    background: linear-gradient(135deg, rgba(29, 185, 84, 0.14) 0%, rgba(18, 18, 18, 0) 100%);
    border: 1px solid var(--border-glass);
    border-radius: 20px;
    padding: 40px;
    margin-bottom: 40px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: space-between;
}
.library-hero-banner::after {
    content: '';
    position: absolute;
    inset: 0;
    background: radial-gradient(circle at top left, var(--border-glow), transparent 65%);
    pointer-events: none;
}
.hero-content-left h1 {
    font-family: var(--font-display);
    font-size: 42px;
    font-weight: 800;
    letter-spacing: -1.5px;
    line-height: 1.1;
    margin-bottom: 8px;
    background: linear-gradient(90deg, #ffffff, #b3b3b3);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
.hero-content-left p {
    font-size: 15px;
    color: var(--text-sub);
    font-weight: 400;
}
.hero-badge-count {
    background: rgba(255, 255, 255, 0.06);
    border: 1px solid var(--border-glass);
    padding: 8px 18px;
    border-radius: 12px;
    font-size: 13px;
    font-weight: 600;
    color: var(--primary-neon);
    display: flex;
    align-items: center;
    gap: 8px;
}

/* =================================================================
   RESPONSIVE MUSIC GALLERY SONG GRID ENGINE
   ================================================================= */
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 28px;
}

/* Premium Music Card Container Structure Layout */
.song-card {
    background: var(--bg-card);
    border: 1px solid var(--border-glass);
    border-radius: 18px;
    padding: 16px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
    transition: all 0.35s cubic-bezier(0.33, 1, 0.68, 1);
    
    /* Core Staggered Loading Simulation View Effects */
    animation: cardReveal 0.6s var(--ease-main) both;
}
@keyframes cardReveal {
    from { opacity: 0; transform: translateY(24px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Micro-interaction Stagger delay for elements loop rendering blocks */
.song-card:nth-child(1) { animation-delay: 0.05s; }
.song-card:nth-child(2) { animation-delay: 0.1s; }
.song-card:nth-child(3) { animation-delay: 0.15s; }
.song-card:nth-child(4) { animation-delay: 0.2s; }
.song-card:nth-child(5) { animation-delay: 0.25s; }
.song-card:nth-child(6) { animation-delay: 0.3s; }
.song-card:nth-child(7) { animation-delay: 0.35s; }
.song-card:nth-child(8) { animation-delay: 0.4s; }

/* Cover Art Asset View Layer Engine */
.cover-art-container {
    position: relative;
    width: 100%;
    aspect-ratio: 1;
    border-radius: 12px;
    overflow: hidden;
    margin-bottom: 16px;
    box-shadow: 0 10px 24px rgba(0, 0, 0, 0.45);
}
.song-img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 12px;
    margin-bottom: 0px;
    transition: transform 0.5s var(--ease-main), filter 0.4s;
}

/* Spotify Floating Circle Play Action Controller Button */
.spotify-play-btn-float {
    position: absolute;
    bottom: 12px;
    right: 12px;
    width: 46px;
    height: 46px;
    border-radius: 50%;
    background: var(--primary);
    color: #000000;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 14px;
    padding-left: 2px;
    opacity: 0;
    transform: translateY(14px) scale(0.85);
    transition: all 0.3s var(--ease-main);
    box-shadow: 0 8px 20px var(--primary-glow);
    z-index: 5;
}

/* Card Text Typography Metadata Details Nodes */
.card-title {
    font-size: 15px;
    font-weight: 700;
    color: var(--text-main);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    margin-bottom: 4px;
    transition: color 0.25s;
}
.card-artist {
    font-size: 13px;
    color: var(--text-sub);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

/* Hover Interactive Global Animation Status Triggers */
.song-card:hover {
    background: var(--bg-card-hover);
    border-color: rgba(29, 185, 84, 0.35);
    transform: translateY(-6px);
    box-shadow: 0 16px 35px rgba(0, 0, 0, 0.55), 0 0 25px rgba(29, 185, 84, 0.08);
}
.song-card:hover .song-img {
    transform: scale(1.06);
    filter: brightness(1.1);
}
.song-card:hover .spotify-play-btn-float {
    opacity: 1;
    transform: translateY(0) scale(1);
}
.song-card:hover .card-title {
    color: var(--primary-neon);
}
.spotify-play-btn-float:hover {
    background: var(--primary-neon);
    transform: scale(1.08) !important;
    box-shadow: 0 8px 24px rgba(30, 215, 96, 0.6);
}

/* =================================================================
   SPOTIFY EMPTY LIBRARY FALLBACK VIEWPORT COMPONENT
   ================================================================= */
.empty {
    margin-top: 0px;
    text-align: center;
    padding: 60px 24px;
    background: var(--bg-card);
    border: 1px dashed var(--border-glass);
    border-radius: 20px;
    max-width: 500px;
    margin: 40px auto;
    animation: layoutReveal 0.6s var(--ease-main) both;
}
.empty-icon-hub {
    width: 80px;
    height: 80px;
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid var(--border-glass);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 20px;
    color: var(--text-muted);
    font-size: 28px;
}
.empty h3 {
    font-family: var(--font-display);
    font-size: 20px;
    font-weight: 800;
    margin-bottom: 8px;
    color: var(--text-main);
}
.empty p {
    font-size: 14px;
    color: var(--text-sub);
    margin-bottom: 24px;
    line-height: 1.5;
}
.btn-upload-redirect {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background: #ffffff;
    color: #000000;
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 12px 28px;
    border-radius: 500px;
    text-decoration: none;
    transition: all 0.3s var(--ease-main);
}
.btn-upload-redirect:hover {
    background: var(--primary-neon);
    transform: scale(1.03);
    box-shadow: 0 8px 20px rgba(30, 215, 96, 0.3);
}

/* =================================================================
   DYNAMIC RESPONSIVE MULTI-AXIS BREAKPOINTS MEDIA QUERIES
   ================================================================= */
@media (max-width: 768px) {
    .wrapper { padding: 20px; margin: 20px auto; }
    .library-hero-banner { flex-direction: column; align-items: flex-start; gap: 16px; padding: 24px; }
    .hero-content-left h1 { font-size: 32px; }
    .grid { grid-template-columns: repeat(auto-fill, minmax(150px, 1fr)); gap: 16px; }
    .song-card { padding: 12px; border-radius: 14px; }
    .card-title { font-size: 14px; }
    .card-artist { font-size: 12px; }
    .spotify-play-btn-float { width: 38px; height: 38px; font-size: 12px; bottom: 8px; right: 8px; opacity: 1; transform: none; }
}
@media (max-width: 480px) {
    .grid { grid-template-columns: repeat(auto-fill, minmax(135px, 1fr)); gap: 12px; }
}
</style>
</head>

<body>

<div class="ambient-bg">
    <div class="blur-circle circle-1"></div>
    <div class="blur-circle circle-2"></div>
</div>

<div class="wrapper">

    <a href="home" class="back-btn">
        <i class="fa-solid fa-arrow-left"></i> Quay lại trang chủ
    </a>

    <header class="library-hero-banner">
        <div class="hero-content-left">
            <h1>My Music Library</h1>
            <p>Bộ sưu tập không gian âm nhạc cá nhân hóa của riêng bạn</p>
        </div>
        
        <c:if test="${not empty songs}">
            <div class="hero-badge-count">
                <i class="fa-solid fa-compact-disc fa-spin" style="--fa-animation-duration: 4s;"></i> 
                <span>${songs.size()} Tác phẩm</span>
            </div>
        </c:if>
    </header>

    <c:if test="${not empty songs}">
        <div class="grid">
            <c:forEach items="${songs}" var="s">
                <div class="song-card">
                    
                    <div class="cover-art-container">
                        <img class="song-img" src="${s.imageUrl}" alt="${s.title}">
                        
                        <div class="spotify-play-btn-float">
                            <i class="fa-solid fa-play"></i>
                        </div>
                    </div>

                    <div class="card-title">${s.title}</div>
                    <div class="card-artist">${s.artist}</div>
                    
                </div>
            </c:forEach>
        </div>
    </c:if>

    <c:if test="${empty songs}">
        <div class="empty">
            <div class="empty-icon-hub">
                <i class="fa-solid fa-music"></i>
            </div>
            <h3>Thư viện của bạn đang trống</h3>
            <p>Có vẻ như chưa có giai điệu nào được lưu trữ tại đây. Hãy tải lên những bài hát đầu tiên để bắt đầu trải nghiệm nhé!</p>
            <a href="home" class="btn-upload-redirect">
                <i class="fa-solid fa-cloud-arrow-up"></i> Tải nhạc ngay
            </a>
        </div>
    </c:if>

</div>

</body>
</html>