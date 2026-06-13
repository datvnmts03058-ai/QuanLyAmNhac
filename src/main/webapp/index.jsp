<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="Model.User"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>WebMusic – Âm Nhạc Kết Nối Cảm Xúc</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800;900&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
<style>
/* =========================================================
   CSS VARIABLES
========================================================= */
:root {
  --black:      #0A0A0A;
  --dark:       #161616;
  --dark2:      #1a1a1a;
  --panel:      rgba(255,255,255,0.04);
  --panel2:     rgba(255,255,255,0.07);
  --border:     rgba(255,255,255,0.07);
  --green:      #1DB954;
  --neon:       #32FF7E;
  --neon-dim:   rgba(50,255,126,0.18);
  --neon-glow:  rgba(50,255,126,0.35);
  --neon-hard:  rgba(50,255,126,0.6);
  --text:       #EFEFEF;
  --muted:      #888;
  --muted2:     #555;
  --font-head:  'Outfit', sans-serif;
  --font-mono:  'Space Mono', monospace;
}

/* =========================================================
   RESET & BASE
========================================================= */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; font-size: 16px; }
body {
  background: var(--black);
  color: var(--text);
  font-family: var(--font-head);
  overflow-x: hidden;
  -webkit-font-smoothing: antialiased;
}

/* custom scrollbar */
::-webkit-scrollbar { width: 4px; }
::-webkit-scrollbar-track { background: var(--black); }
::-webkit-scrollbar-thumb { background: var(--green); border-radius: 2px; }

/* =========================================================
   CANVAS
========================================================= */
#bgCanvas {
  position: fixed; inset: 0; z-index: 0;
  pointer-events: none;
}

/* =========================================================
   NOISE OVERLAY
========================================================= */
body::after {
  content: '';
  position: fixed; inset: 0; z-index: 1;
  pointer-events: none;
  opacity: .025;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)'/%3E%3C/svg%3E");
  background-size: 200px;
}

/* =========================================================
   NAV
========================================================= */
#nav {
  position: fixed; top: 0; left: 0; right: 0; z-index: 200;
  height: 72px;
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 clamp(20px, 5vw, 60px);
  background: rgba(10,10,10,0.55);
  backdrop-filter: blur(24px) saturate(180%);
  -webkit-backdrop-filter: blur(24px) saturate(180%);
  border-bottom: 1px solid var(--border);
  transition: background .3s, box-shadow .3s;
  animation: fadeDown .7s ease both;
}
#nav.scrolled {
  background: rgba(10,10,10,0.85);
  box-shadow: 0 4px 40px rgba(0,0,0,.6);
}
@keyframes fadeDown { from{opacity:0;transform:translateY(-24px)} to{opacity:1;transform:translateY(0)} }

/* Logo */
.logo {
  display: flex; align-items: center; gap: 11px;
  text-decoration: none;
  cursor: pointer;
}
.logo-icon-wrap {
  position: relative;
  width: 40px; height: 40px;
}
.logo-icon-wrap svg {
  width: 40px; height: 40px;
  transition: transform .5s cubic-bezier(.34,1.56,.64,1), filter .3s;
  filter: drop-shadow(0 0 0px var(--neon));
}
.logo:hover .logo-icon-wrap svg {
  transform: rotate(20deg) scale(1.08);
  filter: drop-shadow(0 0 10px var(--neon));
}
.logo-text {
  font-family: var(--font-head);
  font-size: 1.25rem;
  font-weight: 800;
  letter-spacing: .12em;
  color: var(--neon);
  text-shadow: 0 0 20px var(--neon-glow);
  transition: text-shadow .3s;
}
.logo:hover .logo-text {
  text-shadow: 0 0 30px var(--neon-hard), 0 0 60px var(--neon-glow);
}

/* Nav buttons */
.nav-btns { display: flex; gap: 12px; align-items: center; }

.btn-login {
  font-family: var(--font-head);
  font-size: .875rem; font-weight: 600;
  color: var(--neon);
  background: transparent;
  border: 1.5px solid var(--green);
  border-radius: 50px;
  padding: 8px 22px;
  cursor: pointer;
  letter-spacing: .03em;
  transition: all .25s;
}
.btn-login:hover {
  background: rgba(29,185,84,.1);
  border-color: var(--neon);
  box-shadow: 0 0 16px var(--neon-glow), 0 0 32px rgba(29,185,84,.15);
  transform: translateY(-2px);
}

.btn-signup {
  font-family: var(--font-head);
  font-size: .875rem; font-weight: 700;
  color: var(--black);
  background: linear-gradient(115deg, var(--green), var(--neon));
  border: none;
  border-radius: 50px;
  padding: 9px 24px;
  cursor: pointer;
  letter-spacing: .03em;
  position: relative; overflow: hidden;
  transition: transform .25s, box-shadow .25s;
}
.btn-signup::before {
  content: '';
  position: absolute; top: 0; left: -100%;
  width: 60%; height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,.35), transparent);
  transition: left .4s;
}
.btn-signup:hover::before { left: 150%; }
.btn-signup:hover {
  transform: scale(1.06) translateY(-2px);
  box-shadow: 0 0 28px var(--neon-glow), 0 0 56px rgba(29,185,84,.25);
}

/* =========================================================
   HERO
========================================================= */
#hero {
  position: relative; z-index: 2;
  min-height: 100vh;
  display: flex; flex-direction: column;
  align-items: center; justify-content: center;
  text-align: center;
  padding: 80px clamp(20px,5vw,80px) 60px;
  overflow: hidden;
}

/* live indicator badge */
.hero-badge {
  display: inline-flex; align-items: center; gap: 8px;
  background: rgba(29,185,84,.1);
  border: 1px solid rgba(29,185,84,.3);
  border-radius: 50px;
  padding: 6px 18px;
  font-size: .72rem; font-weight: 600;
  letter-spacing: .1em; text-transform: uppercase;
  color: var(--neon);
  margin-bottom: 32px;
  animation: fadeUp .6s .1s ease both;
}
.badge-dot {
  width: 7px; height: 7px; border-radius: 50%;
  background: var(--neon);
  box-shadow: 0 0 8px var(--neon);
  animation: blink 1.6s ease-in-out infinite;
}
@keyframes blink { 0%,100%{opacity:1} 50%{opacity:.3} }

/* title */
.hero-title {
  font-family: var(--font-head);
  font-size: clamp(2.6rem, 7.5vw, 6.5rem);
  font-weight: 900;
  line-height: 1.02;
  letter-spacing: -.04em;
  margin-bottom: 26px;
  animation: fadeUp .65s .25s ease both;
}
.title-white { color: var(--text); display: block; }
.title-green {
  display: block;
  background: linear-gradient(100deg, var(--green) 0%, var(--neon) 55%, #7fffb6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
  filter: drop-shadow(0 0 28px rgba(50,255,126,.4));
}

/* desc */
.hero-desc {
  font-size: clamp(.95rem, 2vw, 1.15rem);
  color: var(--muted);
  max-width: 500px;
  line-height: 1.75;
  margin-bottom: 44px;
  font-weight: 400;
  animation: fadeUp .65s .4s ease both;
}

/* hero action buttons */
.hero-actions {
  display: flex; gap: 16px; flex-wrap: wrap; justify-content: center;
  animation: fadeUp .65s .55s ease both;
}

.btn-hero-explore {
  font-family: var(--font-head);
  font-size: 1rem; font-weight: 700;
  color: var(--black);
  background: linear-gradient(115deg, var(--green), var(--neon));
  border: none; border-radius: 50px;
  padding: 15px 38px; cursor: pointer;
  position: relative; overflow: hidden;
  letter-spacing: .02em;
  transition: transform .25s, box-shadow .25s;
}
.btn-hero-explore::before {
  content: '';
  position: absolute; top: 0; left: -100%;
  width: 60%; height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,.4), transparent);
  transition: left .45s;
}
.btn-hero-explore:hover::before { left: 150%; }
.btn-hero-explore:hover {
  transform: translateY(-3px);
  box-shadow: 0 0 36px var(--neon-glow), 0 16px 40px rgba(29,185,84,.25);
}

.btn-hero-listen {
  font-family: var(--font-head);
  font-size: 1rem; font-weight: 600;
  color: var(--text);
  background: rgba(255,255,255,.06);
  border: 1px solid rgba(255,255,255,.12);
  border-radius: 50px;
  padding: 14px 32px; cursor: pointer;
  backdrop-filter: blur(12px);
  display: flex; align-items: center; gap: 10px;
  letter-spacing: .01em;
  transition: all .25s;
}
.btn-hero-listen:hover {
  background: rgba(29,185,84,.1);
  border-color: rgba(29,185,84,.4);
  box-shadow: 0 0 20px rgba(29,185,84,.2);
  transform: translateY(-2px);
}
.play-circle {
  width: 32px; height: 32px; border-radius: 50%;
  background: linear-gradient(135deg, var(--green), var(--neon));
  display: grid; place-items: center;
  font-size: .6rem; color: var(--black);
  flex-shrink: 0;
  box-shadow: 0 0 12px var(--neon-glow);
}

/* waveform visual below hero */
.hero-waveform {
  position: absolute; bottom: 0; left: 0; right: 0;
  height: 80px; pointer-events: none;
  display: flex; align-items: flex-end; justify-content: center;
  gap: 3px; padding: 0 10%;
  animation: fadeUp .8s .7s ease both;
  opacity: .25;
}
.wave-bar {
  width: 3px; border-radius: 2px;
  background: linear-gradient(to top, var(--green), var(--neon));
  animation: waveDance var(--d, 1.2s) ease-in-out infinite alternate;
}
@keyframes waveDance {
  from { height: var(--hmin, 8px); }
  to   { height: var(--hmax, 40px); }
}

/* scroll cue */
.scroll-cue {
  position: absolute; bottom: 28px;
  display: flex; flex-direction: column; align-items: center; gap: 5px;
  font-size: .68rem; letter-spacing: .1em; color: var(--muted2);
  text-transform: uppercase;
  animation: fadeUp .6s .9s ease both;
}
.scroll-line {
  width: 1px; height: 40px;
  background: linear-gradient(to bottom, var(--green), transparent);
  animation: scrollPulse 2s ease-in-out infinite;
}
@keyframes scrollPulse { 0%,100%{transform:scaleY(1);opacity:.4} 50%{transform:scaleY(1.3);opacity:1} }

@keyframes fadeUp { from{opacity:0;transform:translateY(28px)} to{opacity:1;transform:translateY(0)} }

/* =========================================================
   FEATURES
========================================================= */
#features {
  position: relative; z-index: 2;
  padding: 110px clamp(20px,5vw,80px);
}

.section-eyebrow {
  text-align: center;
  font-family: var(--font-mono);
  font-size: .72rem; letter-spacing: .18em; text-transform: uppercase;
  color: var(--green);
  margin-bottom: 14px;
}

.section-title {
  text-align: center;
  font-family: var(--font-head);
  font-size: clamp(1.7rem, 4vw, 2.8rem);
  font-weight: 800;
  letter-spacing: -.025em;
  margin-bottom: 64px;
  line-height: 1.15;
}
.section-title span {
  background: linear-gradient(100deg, var(--green), var(--neon));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.cards-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
  gap: 24px;
  max-width: 1000px; margin: 0 auto;
}

.feat-card {
  background: rgba(22,22,22,0.7);
  border: 1px solid rgba(29,185,84,.12);
  border-radius: 24px;
  padding: 40px 32px;
  position: relative; overflow: hidden;
  backdrop-filter: blur(20px);
  cursor: default;
  transition: transform .35s cubic-bezier(.34,1.56,.64,1),
              box-shadow .35s,
              border-color .35s;
  opacity: 0;
  transform: translateY(30px);
}
.feat-card.visible {
  animation: cardReveal .55s ease forwards;
}
.feat-card:nth-child(2) { animation-delay: .12s !important; }
.feat-card:nth-child(3) { animation-delay: .24s !important; }
@keyframes cardReveal { to{opacity:1;transform:translateY(0)} }

/* glow top edge */
.feat-card::before {
  content: '';
  position: absolute; top: 0; left: 20%; right: 20%;
  height: 1px;
  background: linear-gradient(90deg, transparent, var(--neon), transparent);
  opacity: 0; transition: opacity .35s;
}
.feat-card:hover::before { opacity: 1; }

/* ambient bg glow */
.feat-card::after {
  content: '';
  position: absolute; bottom: -40px; left: 50%;
  transform: translateX(-50%);
  width: 160px; height: 160px; border-radius: 50%;
  background: radial-gradient(circle, rgba(29,185,84,.08), transparent 70%);
  opacity: 0; transition: opacity .35s;
}
.feat-card:hover::after { opacity: 1; }

.feat-card:hover {
  transform: translateY(-10px) scale(1.02);
  border-color: rgba(29,185,84,.35);
  box-shadow: 0 24px 64px rgba(0,0,0,.5), 0 0 0 1px rgba(29,185,84,.12),
              0 0 40px rgba(29,185,84,.08);
}

.card-icon-wrap {
  width: 58px; height: 58px; border-radius: 16px;
  display: grid; place-items: center;
  font-size: 1.6rem; margin-bottom: 24px;
  background: rgba(29,185,84,.1);
  border: 1px solid rgba(29,185,84,.2);
  transition: box-shadow .3s, transform .3s;
}
.feat-card:hover .card-icon-wrap {
  box-shadow: 0 0 20px rgba(29,185,84,.25);
  transform: scale(1.08);
}

.card-num {
  position: absolute; top: 20px; right: 24px;
  font-family: var(--font-mono); font-size: 3rem; font-weight: 700;
  color: rgba(29,185,84,.06); line-height: 1; user-select: none;
}

.feat-card h3 {
  font-family: var(--font-head);
  font-size: 1.18rem; font-weight: 700;
  margin-bottom: 12px; letter-spacing: -.01em;
}
.feat-card p {
  font-size: .9rem; color: var(--muted); line-height: 1.7;
}
.card-tag {
  display: inline-block; margin-top: 20px;
  font-family: var(--font-mono);
  font-size: .68rem; letter-spacing: .08em;
  color: var(--green); background: rgba(29,185,84,.08);
  border: 1px solid rgba(29,185,84,.2);
  padding: 4px 11px; border-radius: 50px;
}

/* =========================================================
   FOOTER
========================================================= */
footer {
  position: relative; z-index: 2;
  background: #080808;
  border-top: 1px solid var(--border);
  padding: 44px clamp(20px,5vw,80px);
  display: flex; align-items: center; justify-content: space-between;
  flex-wrap: wrap; gap: 24px;
}

.footer-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
.footer-logo .logo-icon-wrap svg { width: 32px; height: 32px; }
.footer-logo .logo-text { font-size: 1rem; }

.footer-copy {
  font-size: .8rem; color: var(--muted2);
  font-family: var(--font-mono);
  letter-spacing: .04em;
}

.social-row { display: flex; gap: 12px; }
.soc-btn {
  width: 38px; height: 38px; border-radius: 50%;
  background: var(--panel);
  border: 1px solid var(--border);
  display: grid; place-items: center;
  cursor: pointer; text-decoration: none;
  color: var(--muted);
  transition: all .25s;
  font-size: .95rem;
}
.soc-btn:hover {
  color: var(--neon);
  border-color: rgba(29,185,84,.4);
  background: rgba(29,185,84,.08);
  box-shadow: 0 0 14px var(--neon-glow);
  transform: rotate(8deg) scale(1.12);
}

/* =========================================================
   FLOATING NOTES
========================================================= */
.note-float {
  position: fixed;
  pointer-events: none;
  z-index: 3;
  opacity: 0;
  color: var(--neon);
  font-size: 1rem;
  animation: noteRise linear forwards;
  filter: drop-shadow(0 0 6px var(--neon-glow));
}
@keyframes noteRise {
  0%   { opacity: 0; transform: translateY(0) rotate(0deg) scale(.5); }
  12%  { opacity: .8; }
  88%  { opacity: .2; }
  100% { opacity: 0; transform: translateY(-280px) rotate(25deg) scale(1.15); }
}

/* =========================================================
   RIPPLE
========================================================= */
.ripple-host { position: relative; overflow: hidden; }
.ripple-ring {
  position: absolute; border-radius: 50%;
  background: rgba(50,255,126,.3);
  width: 0; height: 0;
  transform: translate(-50%,-50%);
  animation: rippleOut .55s ease-out forwards;
  pointer-events: none;
}
@keyframes rippleOut {
  to { width: 260px; height: 260px; opacity: 0; }
}

/* =========================================================
   RESPONSIVE
========================================================= */
@media(max-width:640px){
  .hero-actions { flex-direction: column; align-items: stretch; }
  .btn-hero-explore, .btn-hero-listen { justify-content: center; }
  footer { flex-direction: column; align-items: center; text-align: center; }
  .hero-waveform { display: none; }
}
</style>
</head>
<body>

<!-- ═══ CANVAS BACKGROUND ═══ -->
<canvas id="bgCanvas"></canvas>

<!-- ═══ NAV ═══ -->
<nav id="nav">
  <a href="#" class="logo" aria-label="WebMusic Home">
    <div class="logo-icon-wrap">
      <!-- SVG: musical note + wave -->
      <svg viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="lg1" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stop-color="#1DB954"/>
            <stop offset="100%" stop-color="#32FF7E"/>
          </linearGradient>
        </defs>
        <!-- note head -->
        <ellipse cx="14" cy="28" rx="5" ry="3.5" fill="url(#lg1)" opacity=".9"/>
        <!-- stem -->
        <rect x="18.4" y="10" width="2.2" height="18" rx="1.1" fill="url(#lg1)"/>
        <!-- flag -->
        <path d="M20.6 10 Q30 14 26 22" stroke="url(#lg1)" stroke-width="2.2" stroke-linecap="round" fill="none"/>
        <!-- small wave arcs -->
        <path d="M26 29 Q29 26 32 29" stroke="#32FF7E" stroke-width="1.5" stroke-linecap="round" fill="none" opacity=".7"/>
        <path d="M26 32.5 Q30 28 35 32.5" stroke="#1DB954" stroke-width="1.4" stroke-linecap="round" fill="none" opacity=".5"/>
      </svg>
    </div>
    <span class="logo-text">WEBMUSIC</span>
  </a>
<div class="nav-btns">
    <button class="btn-login ripple-host"
            onclick="addRipple(event,this); location.href='${pageContext.request.contextPath}/login';">
        Đăng Nhập
    </button>

    <button class="btn-signup ripple-host"
            onclick="addRipple(event,this); location.href='${pageContext.request.contextPath}/register';">
        Đăng Ký
    </button>
</div>
</nav>

<!-- ═══ HERO ═══ -->
<section id="hero">
  <div class="hero-badge"><span class="badge-dot"></span>Premium Music Platform 2025</div>

  <h1 class="hero-title">
    <span class="title-white">Âm Nhạc</span>
    <span class="title-green">Kết Nối Cảm Xúc</span>
  </h1>

  <p class="hero-desc">Khám phá hàng ngàn bài hát, nghệ sĩ và playlist yêu thích mọi lúc mọi nơi.</p>

  <div class="hero-actions">
    <button class="btn-hero-explore ripple-host" onclick="addRipple(event,this)">✦ Khám phá ngay</button>
    <button class="btn-hero-listen ripple-host" onclick="addRipple(event,this)" >
      <div class="play-circle">▶</div>
      Nghe thử
    </button>
  </div>

  <!-- animated waveform bar deco -->
  <div class="hero-waveform" id="heroWave"></div>

  <div class="scroll-cue">
    <div class="scroll-line"></div>
    Cuộn xuống
  </div>
</section>

<!-- ═══ FEATURES ═══ -->
<section id="features">
  <p class="section-eyebrow">// tại sao chọn chúng tôi</p>
  <h2 class="section-title">Tại sao chọn <span>WebMusic?</span></h2>

  <div class="cards-row">
    <div class="feat-card">
      <span class="card-num">01</span>
      <div class="card-icon-wrap">🎵</div>
      <h3>Hàng ngàn bài hát</h3>
      <p>Kho nhạc phong phú với hàng triệu bản nhạc từ mọi thể loại, cập nhật liên tục mỗi ngày.</p>
      <span class="card-tag">50M+ TRACKS</span>
    </div>

    <div class="feat-card">
      <span class="card-num">02</span>
      <div class="card-icon-wrap">❤️</div>
      <h3>Playlist cá nhân</h3>
      <p>Tạo và quản lý danh sách phát theo sở thích riêng. AI gợi ý nhạc phù hợp tâm trạng của bạn.</p>
      <span class="card-tag">AI POWERED</span>
    </div>

    <div class="feat-card">
      <span class="card-num">03</span>
      <div class="card-icon-wrap">🔊</div>
      <h3>Âm thanh chất lượng cao</h3>
      <p>Trải nghiệm âm nhạc vượt trội với chất lượng lossless HiFi 320kbps và âm thanh không gian 3D.</p>
      <span class="card-tag">HIFI 320KBPS</span>
    </div>
  </div>
</section>

<!-- ═══ FOOTER ═══ -->
<footer>
  <a href="#" class="footer-logo logo" aria-label="WebMusic">
    <div class="logo-icon-wrap">
      <svg viewBox="0 0 40 40" fill="none" xmlns="http://www.w3.org/2000/svg">
        <defs>
          <linearGradient id="lg2" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stop-color="#1DB954"/>
            <stop offset="100%" stop-color="#32FF7E"/>
          </linearGradient>
        </defs>
        <ellipse cx="14" cy="28" rx="5" ry="3.5" fill="url(#lg2)" opacity=".9"/>
        <rect x="18.4" y="10" width="2.2" height="18" rx="1.1" fill="url(#lg2)"/>
        <path d="M20.6 10 Q30 14 26 22" stroke="url(#lg2)" stroke-width="2.2" stroke-linecap="round" fill="none"/>
        <path d="M26 29 Q29 26 32 29" stroke="#32FF7E" stroke-width="1.5" stroke-linecap="round" fill="none" opacity=".7"/>
        <path d="M26 32.5 Q30 28 35 32.5" stroke="#1DB954" stroke-width="1.4" stroke-linecap="round" fill="none" opacity=".5"/>
      </svg>
    </div>
    <span class="logo-text">WEBMUSIC</span>
  </a>

  <p class="footer-copy">© 2025 WebMusic. All Rights Reserved.</p>

  <div class="social-row">
    <a href="#" class="soc-btn" title="Facebook" aria-label="Facebook">f</a>
    <a href="#" class="soc-btn" title="Instagram" aria-label="Instagram">◎</a>
    <a href="#" class="soc-btn" title="YouTube" aria-label="YouTube">▶</a>
    <a href="#" class="soc-btn" title="TikTok" aria-label="TikTok">♪</a>
  </div>
</footer>

<!-- ═══════════════════════════════════════════
     JAVASCRIPT
════════════════════════════════════════════ -->
<script>
/* ── CANVAS: particles + waves + glow mesh ── */
const canvas = document.getElementById('bgCanvas');
const ctx = canvas.getContext('2d');
let W, H;

function resize() {
  W = canvas.width  = window.innerWidth;
  H = canvas.height = window.innerHeight;
}
resize();
window.addEventListener('resize', resize);

/* Particles */
const PCOUNT = 70;
const pts = Array.from({length: PCOUNT}, () => ({
  x:  Math.random(),
  y:  Math.random(),
  r:  .5 + Math.random() * 1.4,
  vx: (Math.random()-.5) * .00025,
  vy: (Math.random()-.5) * .00025,
  a:  Math.random() * Math.PI * 2,
  va: (Math.random()-.5) * .012,
}));

/* Wave layers */
let t = 0;

function wave(yFrac, amp, freq, speed, alpha, color) {
  ctx.beginPath();
  const seg = 160;
  for (let i = 0; i <= seg; i++) {
    const x = (i/seg)*W;
    const y = H*yFrac + Math.sin(i*freq + t*speed)*amp
                      + Math.sin(i*freq*1.9 + t*speed*.65)*amp*.35;
    i===0 ? ctx.moveTo(x,y) : ctx.lineTo(x,y);
  }
  ctx.strokeStyle = color;
  ctx.lineWidth = 1.3;
  ctx.globalAlpha = alpha;
  ctx.stroke();
  ctx.globalAlpha = 1;
}

/* Ambient glow mesh */
let gT = 0;
function drawMesh() {
  const cx = W*(.3 + .2*Math.sin(gT*.4));
  const cy = H*(.4 + .15*Math.cos(gT*.3));
  const g = ctx.createRadialGradient(cx, cy, 0, W*.5, H*.5, Math.max(W,H)*.9);
  g.addColorStop(0,  `rgba(29,185,84,${.06+.025*Math.sin(gT)})`);
  g.addColorStop(.35,`rgba(50,255,126,${.025+.01*Math.cos(gT*.7)})`);
  g.addColorStop(1,  'rgba(10,10,10,0)');
  ctx.fillStyle = g;
  ctx.fillRect(0,0,W,H);

  // second blob
  const cx2 = W*(.7 + .15*Math.cos(gT*.5));
  const cy2 = H*(.6 + .1*Math.sin(gT*.45));
  const g2 = ctx.createRadialGradient(cx2,cy2,0,cx2,cy2,W*.5);
  g2.addColorStop(0, `rgba(29,185,84,${.04+.015*Math.cos(gT)})`);
  g2.addColorStop(1, 'rgba(10,10,10,0)');
  ctx.fillStyle = g2;
  ctx.fillRect(0,0,W,H);
}

function raf() {
  ctx.clearRect(0,0,W,H);
  ctx.fillStyle = '#0A0A0A';
  ctx.fillRect(0,0,W,H);

  gT += .006; t += .014;
  drawMesh();

  /* waves */
  wave(.68, 45, .042, .55, .1,  'rgba(29,185,84,.9)');
  wave(.72, 32, .058, .75, .08, 'rgba(50,255,126,.9)');
  wave(.76, 24, .078, .45, .06, 'rgba(29,185,84,.9)');
  wave(.62, 55, .033, .35, .05, 'rgba(50,255,126,.9)');

  /* particles */
  pts.forEach(p => {
    p.x += p.vx; p.y += p.vy; p.a += p.va;
    if(p.x<0) p.x=1; if(p.x>1) p.x=0;
    if(p.y<0) p.y=1; if(p.y>1) p.y=0;
    const alpha = .1 + .3*Math.abs(Math.sin(p.a));
    ctx.beginPath();
    ctx.arc(p.x*W, p.y*H, p.r, 0, Math.PI*2);
    ctx.fillStyle = `rgba(50,255,126,${alpha})`;
    ctx.fill();
  });

  requestAnimationFrame(raf);
}
raf();

/* ── NAV SCROLL ── */
const navEl = document.getElementById('nav');
window.addEventListener('scroll', () =>
  navEl.classList.toggle('scrolled', window.scrollY > 50)
);

/* ── PARALLAX HERO TITLE ── */
const heroTitle = document.querySelector('.hero-title');
window.addEventListener('mousemove', e => {
  const mx = (e.clientX/innerWidth  - .5) * 14;
  const my = (e.clientY/innerHeight - .5) * 8;
  heroTitle.style.transform = `translate(${mx*.4}px,${my*.4}px)`;
});

/* ── HERO WAVEFORM BARS ── */
const heroWave = document.getElementById('heroWave');
const BAR_COUNT = 48;
for(let i=0; i<BAR_COUNT; i++) {
  const b = document.createElement('div');
  b.className = 'wave-bar';
  const hmin = 6 + Math.random()*10;
  const hmax = 18 + Math.random()*38;
  const dur  = (.8 + Math.random()*1.2).toFixed(2)+'s';
  const delay= (Math.random()*1).toFixed(2)+'s';
  b.style.cssText = `--hmin:${hmin}px;--hmax:${hmax}px;--d:${dur};animation-delay:${delay};height:${hmin}px;`;
  heroWave.appendChild(b);
}

/* ── FLOATING NOTES ── */
const noteSyms = ['♩','♪','♫','♬','𝄞','𝅘𝅥𝅮'];
function spawnNote() {
  const el = document.createElement('div');
  el.className = 'note-float';
  el.textContent = noteSyms[Math.floor(Math.random()*noteSyms.length)];
  const left = 4 + Math.random()*92;
  const bot  = 5 + Math.random()*55;
  const dur  = (2.5 + Math.random()*2.2).toFixed(1);
  el.style.cssText = `left:${left}vw;bottom:${bot}vh;font-size:${.75+Math.random()*.75}rem;animation-duration:${dur}s;`;
  document.body.appendChild(el);
  setTimeout(() => el.remove(), +dur*1000+300);
}
setInterval(spawnNote, 650);

/* ── RIPPLE EFFECT ── */
function addRipple(e, btn) {
  const r = btn.getBoundingClientRect();
  const ring = document.createElement('span');
  ring.className = 'ripple-ring';
  ring.style.left = (e.clientX - r.left)+'px';
  ring.style.top  = (e.clientY - r.top)+'px';
  btn.appendChild(ring);
  setTimeout(()=>ring.remove(), 600);
}

/* ── INTERSECTION OBSERVER: cards ── */
const cards = document.querySelectorAll('.feat-card');
const io = new IntersectionObserver(entries => {
  entries.forEach(entry => {
    if(entry.isIntersecting) {
      entry.target.classList.add('visible');
      io.unobserve(entry.target);
    }
  });
}, { threshold: .18 });
cards.forEach(c => io.observe(c));

/* ── 3D TILT on cards ── */
cards.forEach(card => {
  card.addEventListener('mousemove', e => {
    const r  = card.getBoundingClientRect();
    const mx = (e.clientX - r.left)/r.width  - .5;
    const my = (e.clientY - r.top )/r.height - .5;
    card.style.transform = `translateY(-10px) scale(1.02) rotateY(${mx*7}deg) rotateX(${-my*5}deg)`;
  });
  card.addEventListener('mouseleave', () => {
    card.style.transform = '';
  });
});
</script>
</body>
</html>