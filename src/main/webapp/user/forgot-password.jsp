<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quên mật khẩu</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;600;700&display=swap" rel="stylesheet">

<style>

body {
    margin: 0;
    font-family: 'DM Sans', sans-serif;
    background: #0a0a0a;
    color: #fff;
}

/* CENTER FORM */
.wrapper {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* CARD */
.form-container {
    width: 380px;
    background: #181818;
    padding: 30px;
    border-radius: 12px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.6);
    text-align: center;
}

/* TITLE */
.form-container h2 {
    margin-bottom: 20px;
    color: #1db954;
}

/* INPUT */
.form-container input {
    width: 100%;
    padding: 12px;
    margin: 8px 0;
    border-radius: 8px;
    border: none;
    outline: none;
    background: #222;
    color: #fff;
}

.form-container input:focus {
    outline: 2px solid #1db954;
}

/* BUTTON */
.form-container button {
    width: 100%;
    padding: 12px;
    margin-top: 10px;
    border: none;
    border-radius: 999px;
    background: #1db954;
    color: #000;
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s;
}

.form-container button:hover {
    background: #20d45f;
    transform: scale(1.03);
}

/* MESSAGE */
.error {
    color: #ff4d4d;
    margin-top: 10px;
}

.success {
    margin-top: 15px;
    padding: 12px;
    background: #1a1a1a;
    border-left: 3px solid #1db954;
    color: #1db954;
    border-radius: 8px;
}

/* BACK BUTTON */
.back-btn {
    margin-top: 15px;
    display: inline-block;
    padding: 10px 16px;
    border-radius: 999px;
    background: transparent;
    border: 1px solid #555;
    color: #fff;
    text-decoration: none;
    transition: 0.2s;
}

.back-btn:hover {
    border-color: #1db954;
    color: #1db954;
}

</style>
</head>

<body>

<div class="wrapper">

    <div class="form-container">

        <h2>❓ Quên mật khẩu</h2>

        <form action="${pageContext.request.contextPath}/forgot-password"
              method="post">

            <input type="text"
                   name="username"
                   placeholder="Tên đăng nhập"
                   required>

            <input type="email"
                   name="email"
                   placeholder="Email"
                   required>

            <button type="submit">Tìm mật khẩu</button>

        </form>

        <!-- ERROR -->
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <!-- SUCCESS -->
        <c:if test="${not empty password}">
            <div class="success">
                <strong>Mật khẩu:</strong> ${password}
            </div>
        </c:if>

        <!-- BACK BUTTON -->
        <a href="${pageContext.request.contextPath}/settings"
           class="back-btn">
           ← Quay lại 
        </a>

    </div>

</div>

</body>
</html>