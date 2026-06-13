<%@ page contentType="text/html;charset=UTF-8"%>

<%@ page import="Model.User"%>

<%
User user = (User) session.getAttribute("user");

if(user == null){
    response.sendRedirect(
        request.getContextPath() + "/login"
    );
    return;
}
%>
<<style>
body {
    margin: 0;
    font-family: 'DM Sans', sans-serif;
    background: #0a0a0a;
    color: #fff;
}

/* center page */
.profile-wrapper {
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 40px;
}

/* card */
.profile-card {
    width: 380px;
    background: #181818;
    border-radius: 16px;
    padding: 30px;
    text-align: center;
    box-shadow: 0 20px 60px rgba(0,0,0,0.6);
    border: 1px solid rgba(255,255,255,0.08);
    transition: 0.3s;
}

.profile-card:hover {
    transform: translateY(-5px);
}

/* avatar */
.avatar {
    width: 80px;
    height: 80px;
    margin: 0 auto 15px;
    background: #1db954;
    color: #000;
    font-size: 32px;
    font-weight: 800;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
}

/* title */
.profile-card h1 {
    font-size: 22px;
    margin-bottom: 20px;
}

/* info */
.info {
    text-align: left;
    margin-bottom: 20px;
}

.info p {
    padding: 10px;
    margin: 8px 0;
    background: #222;
    border-radius: 8px;
    font-size: 14px;
}

.info span {
    color: #1db954;
    font-weight: 600;
}

/* back button */
.back-btn {
    width: 100%;
    padding: 10px;
    border-radius: 999px;
    border: none;
    background: #1db954;
    color: #000;
    font-weight: 700;
    cursor: pointer;
    transition: 0.2s;
}

.back-btn:hover {
    background: #20d45f;
    transform: scale(1.03);
}

</style>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hồ sơ cá nhân</title>

<body>



<div class="profile-wrapper">

    <div class="profile-card">

        <div class="avatar">
            <%= user.getFullname().charAt(0) %>
        </div>

        <h1>Hồ sơ cá nhân</h1>

        <div class="info">
            <p><span>Họ tên:</span> <%= user.getFullname() %></p>
            <p><span>Tài khoản:</span> <%= user.getUsername() %></p>
            <p><span>Email:</span> <%= user.getEmail() %></p>
            <p><span>Vai trò:</span> <%= user.getRole() %></p>
        </div>

        <button class="back-btn" onclick="history.back()">
            ← Quay lại
        </button>

    </div>

</div>

</body>
</html>