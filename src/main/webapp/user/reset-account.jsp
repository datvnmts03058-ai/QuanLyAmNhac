<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cập nhật tài khoản</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

<style>

/* RESET */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'DM Sans', sans-serif;
}

body {
    background: #0a0a0a;
    color: #fff;
}

/* CENTER */
.wrapper {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* CARD */
.card {
    width: 380px;
    background: #181818;
    padding: 28px;
    border-radius: 14px;
    text-align: center;
    box-shadow: 0 20px 60px rgba(0,0,0,0.6);
}

/* TITLE */
.card h2 {
    color: #1db954;
    margin-bottom: 18px;
}

/* INPUT */
.input {
    width: 100%;
    padding: 12px;
    margin-bottom: 10px;
    border: none;
    border-radius: 8px;
    background: #222;
    color: #fff;
}

.input:focus {
    outline: 2px solid #1db954;
}

/* CHECKBOX */
.check {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 13px;
    color: #b3b3b3;
    margin: 10px 0;
}

/* BUTTON */
.btn {
    width: 100%;
    padding: 12px;
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

/* BACK BUTTON */
.back {
    display: block;
    margin-top: 12px;
    font-size: 13px;
    color: #b3b3b3;
    text-decoration: none;
}

.back:hover {
    color: #1db954;
}

</style>

</head>

<body>

<div class="wrapper">

    <div class="card">

        <h2>🛠 Cập nhật tài khoản</h2>

        <form action="${pageContext.request.contextPath}/reset-account"
              method="post">

            <input type="hidden" name="id" value="${user.id}">

            <input class="input"
                   type="text"
                   name="username"
                   value="${user.username}"
                   placeholder="Username"
                   required>

            <input class="input"
                   type="password"
                   name="password"
                   placeholder="Mật khẩu mới"
                   required>

            <input class="input"
                   type="text"
                   name="fullname"
                   value="${user.fullname}"
                   placeholder="Họ tên"
                   required>

            <input class="input"
                   type="email"
                   name="email"
                   value="${user.email}"
                   placeholder="Email"
                   required>

            <label class="check">
                <input type="checkbox" name="confirm" required>
                Tôi xác nhận thay đổi thông tin
            </label>

            <button class="btn" type="submit">
                Lưu thay đổi
            </button>

        </form>

        <!-- BACK BUTTON -->
        <a class="back"
           href="${pageContext.request.contextPath}/reset-password">
            ← Quay lại Reset Password
        </a>

    </div>

</div>

</body>
</html>