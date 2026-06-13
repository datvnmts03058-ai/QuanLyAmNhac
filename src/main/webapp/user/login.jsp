<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login - Music Web</title>

<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
        font-family: "Segoe UI", sans-serif;
    }

    body {
        height: 100vh;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-items: center;

        background: linear-gradient(-45deg, #0f0f0f, #121212, #0a1f14, #0f0f0f);
        background-size: 400% 400%;
        animation: bgMove 12s ease infinite;
    }

    @keyframes bgMove {
        0% { background-position: 0% 50%; }
        50% { background-position: 100% 50%; }
        100% { background-position: 0% 50%; }
    }

    /* floating glow */
    .blur-circle {
        position: absolute;
        width: 300px;
        height: 300px;
        border-radius: 50%;
        filter: blur(90px);
        opacity: 0.25;
        z-index: 0;
        animation: float 8s ease-in-out infinite;
    }

    .c1 {
        background: #1db954;
        top: 10%;
        left: 15%;
    }

    .c2 {
        background: #1ed760;
        bottom: 10%;
        right: 10%;
        animation-delay: 2s;
    }

    @keyframes float {
        0%, 100% { transform: translateY(0); }
        50% { transform: translateY(-25px); }
    }

    /* CARD */
    .login-card {
        position: relative;
        z-index: 2;

        width: 380px;
        padding: 40px;

        background: rgba(24, 24, 24, 0.65);
        backdrop-filter: blur(18px);
        -webkit-backdrop-filter: blur(18px);

        border-radius: 18px;
        border: 1px solid rgba(29,185,84,0.25);

        box-shadow: 0 25px 60px rgba(0,0,0,0.7);

        text-align: center;

        opacity: 0;
        transform: translateY(30px);
        animation: fadeUp 0.8s ease forwards;
    }

    @keyframes fadeUp {
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }

    /* LOGO */
    .logo {
        font-size: 30px;
        font-weight: bold;
        color: #1db954;
        margin-bottom: 5px;
        text-shadow: 0 0 15px rgba(29,185,84,0.5);
        animation: pulse 2.5s infinite;
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }

    .subtitle {
        font-size: 13px;
        color: #b3b3b3;
        margin-bottom: 20px;
    }

    /* INPUT */
    .input-box {
        position: relative;
        margin: 10px 0;
    }

    .input-box span {
        position: absolute;
        left: 12px;
        top: 50%;
        transform: translateY(-50%);
        color: #1db954;
        font-size: 14px;
    }

    input {
        width: 100%;
        padding: 12px 12px 12px 38px;
        border: none;
        border-radius: 10px;

        background: #2a2a2a;
        color: white;

        outline: none;
        transition: 0.3s;
    }

    input::placeholder {
        color: #aaa;
    }

    input:focus {
        box-shadow: 0 0 0 2px rgba(29,185,84,0.6);
        background: #333;
    }

    /* BUTTON */
    button {
        width: 100%;
        padding: 12px;
        margin-top: 15px;

        border: none;
        border-radius: 999px;

        background: #1db954;
        color: black;
        font-weight: bold;

        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        transform: scale(1.05);
        box-shadow: 0 0 18px rgba(29,185,84,0.4);
        background: #1ed760;
    }

    /* ERROR */
    .error {
        color: #ff4d4d;
        font-size: 13px;
        margin-top: 10px;
        min-height: 18px;
    }

    /* REGISTER */
    .register {
        margin-top: 15px;
        font-size: 13px;
        color: #b3b3b3;
    }

    .register a {
        color: #1db954;
        text-decoration: none;
        transition: 0.3s;
    }

    .register a:hover {
        text-decoration: underline;
    }

    /* MOBILE */
    @media (max-width: 480px) {
        .login-card {
            width: 90%;
        }
    }
</style>

</head>

<body>

<!-- BACKGROUND EFFECT -->
<div class="blur-circle c1"></div>
<div class="blur-circle c2"></div>

<div class="login-card">

    <!-- LOGO -->
    <div class="logo">🎵 Music Web</div>
    <div class="subtitle">Đăng nhập để tiếp tục nghe nhạc</div>

    <!-- FORM (GIỮ NGUYÊN LOGIC) -->
    <form action="${pageContext.request.contextPath}/login"
          method="post">

        <div class="input-box">
            <span>👤</span>
            <input name="username" placeholder="Username">
        </div>

        <div class="input-box">
            <span>🔒</span>
            <input type="password" name="password" placeholder="Password">
        </div>

        <button type="submit">Đăng nhập</button>

    </form>

    <!-- ERROR (GIỮ NGUYÊN LOGIC) -->
    <div class="error">
        ${message}
    </div>

    <!-- REGISTER -->
    <div class="register">
        Chưa có tài khoản?
        <a href="${pageContext.request.contextPath}/register">
            Đăng ký
        </a>
    </div>

</div>

</body>
</html>