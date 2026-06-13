<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết người dùng</title>

<style>
body{
    background:#121212;
    color:#fff;
    font-family:Arial,sans-serif;
    padding:40px;
}

.card{
    max-width:700px;
    margin:auto;
    background:#1e1e1e;
    padding:30px;
    border-radius:15px;
    box-shadow:0 0 15px rgba(0,0,0,.4);
}

.avatar{
    width:100px;
    height:100px;
    margin:0 auto 20px;
    border-radius:50%;
    background:#8e44ad;
    display:flex;
    align-items:center;
    justify-content:center;
    font-size:40px;
    font-weight:bold;
}

.title{
    text-align:center;
    margin-bottom:25px;
}

.info{
    margin-top:20px;
}

.row{
    display:flex;
    align-items:center;
    padding:14px 10px;
    border-bottom:1px solid #333;
}

.label{
    width:180px;
    font-weight:bold;
    color:#bbb;
}

.value{
    flex:1;
}

.back{
    display:inline-block;
    margin-top:25px;
    padding:10px 20px;
    background:#17a2b8;
    color:#fff;
    text-decoration:none;
    border-radius:8px;
    transition:.3s;
}

.back:hover{
    background:#138496;
}
</style>

</head>
<body>

<!-- CARD -->
<div class="card">

    <!-- AVATAR -->
    <div class="avatar">${userDetail.fullname.substring(0,1)}</div>

    <!-- TITLE -->
    <div class="title">
        <h2>${userDetail.fullname}</h2>
    </div>

    <!-- USER INFO -->
    <div class="info">

        <div class="row"><div class="label">ID</div><div class="value">${userDetail.id}</div></div>

        <div class="row"><div class="label">Username</div><div class="value">${userDetail.username}</div></div>

        <div class="row"><div class="label">Password</div><div class="value">********</div></div>

        <div class="row"><div class="label">Họ tên</div><div class="value">${userDetail.fullname}</div></div>

        <div class="row"><div class="label">Email</div><div class="value">${userDetail.email}</div></div>

        <div class="row"><div class="label">Vai trò</div><div class="value">${userDetail.role ? 'Admin' : 'User'}</div></div>

    </div>

    <!-- BACK BUTTON -->
    <a class="back" href="${pageContext.request.contextPath}/users">
        ← Quay lại danh sách
    </a>

</div>

</body>
</html>