<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset tài khoản</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

<style>

/* RESET */
*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'DM Sans', sans-serif;
}

body{
    background:#0a0a0a;
    color:#fff;
}

/* CENTER */
.wrapper{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

/* CARD */
.card{
    width:360px;
    background:#181818;
    padding:28px;
    border-radius:14px;
    text-align:center;
    box-shadow:0 20px 60px rgba(0,0,0,0.6);
}

/* TITLE */
h2{
    color:#1db954;
    margin-bottom:18px;
}

/* INPUT */
.input{
    width:100%;
    padding:12px;
    margin-bottom:10px;
    border:none;
    border-radius:8px;
    background:#222;
    color:#fff;
}

.input:focus{
    outline:2px solid #1db954;
}

/* BUTTON */
.btn{
    width:100%;
    padding:12px;
    border:none;
    border-radius:999px;
    background:#1db954;
    color:#000;
    font-weight:700;
    cursor:pointer;
    transition:.2s;
}

.btn:hover{
    background:#20d45f;
    transform:scale(1.03);
}

/* ERROR */
.error{
    margin-top:10px;
    color:#ff4d4d;
    font-size:13px;
}

/* BACK */
.back{
    display:block;
    margin-top:12px;
    font-size:13px;
    color:#b3b3b3;
    text-decoration:none;
}

.back:hover{
    color:#1db954;
}

</style>
</head>

<body>

<div class="wrapper">

    <div class="card">

        <h2>🔑 Reset tài khoản</h2>

        <form action="${pageContext.request.contextPath}/reset-password"
              method="post">

            <input class="input"
                   type="text"
                   name="username"
                   placeholder="Nhập tên tài khoản"
                   required>

            <button class="btn" type="submit">
                Tiếp tục
            </button>

        </form>

        <!-- ERROR -->
        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <!-- BACK BUTTON -->
        <a class="back"
           href="${pageContext.request.contextPath}/login">
            ← Quay lại đăng nhập
        </a>

    </div>

</div>

</body>
</html>