<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đổi mật khẩu</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

<style>

/* RESET */
* {
    box-sizing: border-box;
    margin: 0;
    padding: 0;
    font-family: 'DM Sans', sans-serif;
}

body {
    background: #0a0a0a;
    color: #fff;
}

/* CENTER WRAPPER */
.wrapper {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* CARD */
.card {
    width: 360px;
    background: #181818;
    padding: 28px;
    border-radius: 14px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.6);
}

/* TITLE */
.card h2 {
    text-align: center;
    margin-bottom: 18px;
    color: #1db954;
    font-size: 22px;
}

/* INPUT */
.input {
    width: 100%;
    padding: 11px 12px;
    margin-bottom: 10px;
    border-radius: 8px;
    border: none;
    outline: none;
    background: #222;
    color: #fff;
    font-size: 14px;
}

.input:focus {
    outline: 2px solid #1db954;
}

/* BUTTON */
.btn {
    width: 100%;
    padding: 12px;
    margin-top: 8px;
    border: none;
    border-radius: 999px;
    background: #1db954;
    color: #000;
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s;
}

.btn:hover {
    background: #20d45f;
    transform: scale(1.03);
}

/* MESSAGE */
.error {
    margin-top: 10px;
    color: #ff4d4d;
    font-size: 13px;
    text-align: center;
}

.success {
    margin-top: 10px;
    color: #1db954;
    font-size: 13px;
    text-align: center;
    background: #1a1a1a;
    padding: 10px;
    border-radius: 8px;
    border-left: 3px solid #1db954;
}

/* BACK BUTTON */
.back {
    display: block;
    text-align: center;
    margin-top: 14px;
    font-size: 13px;
    color: #b3b3b3;
    text-decoration: none;
    transition: 0.2s;
}

.back:hover {
    color: #1db954;
}

</style>
</head>

<body>

<div class="wrapper">

    <div class="card">

        <h2>🔒 Đổi mật khẩu</h2>

        <form action="${pageContext.request.contextPath}/change-password"
              method="post">

            <input class="input" type="text" name="username" placeholder="Tên đăng nhập" required>

            <input class="input" type="password" name="oldPassword" placeholder="Mật khẩu cũ" required>

            <input class="input" type="password" name="newPassword" placeholder="Mật khẩu mới" required>

            <input class="input" type="password" name="confirmPassword" placeholder="Xác nhận mật khẩu" required>

            <button class="btn" type="submit">Đổi mật khẩu</button>

        </form>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <c:if test="${not empty success}">
            <div class="success">${success}</div>
        </c:if>

        <a class="back" href="${pageContext.request.contextPath}/login">
            ← Quay lại đăng nhập
        </a>

    </div>

</div>

</body>
</html>