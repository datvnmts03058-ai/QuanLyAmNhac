<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Liked Songs</title>

<link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;700&display=swap" rel="stylesheet">

<style>
body{
    background:#0a0a0a;
    color:#fff;
}


































++++++++



/* KHUNG CHÍNH */
.page-wrapper{
    max-width:1100px;
    margin:30px auto;
    padding:24px;
    background:#121212;
    border:1px solid rgba(255,255,255,0.06);
    border-radius:16px;
    box-shadow:0 20px 60px rgba(0,0,0,0.6);
}

/* TITLE */
h2{
    color:#1db954;
    margin:10px 0 20px;
}

/* BACK BUTTON */
.back-home-btn{
    display:inline-flex;
    align-items:center;
    gap:8px;

    padding:10px 16px;
    margin-bottom:16px;

    background:#181818;
    border:1px solid rgba(255,255,255,0.12);
    border-radius:999px;

    color:#b3b3b3;
    font-size:13px;
    font-weight:600;
    text-decoration:none;

    transition:0.2s;
}

/* hover xanh Spotify */
.back-home-btn:hover{
    color:#1db954;
    border-color:#1db954;
    background:#202020;
    transform:translateX(-2px);
}

/* GRID */
.container{
    display:grid;
    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
    gap:16px;
}

/* CARD */
.card{
    background:#181818;
    padding:14px;
    border-radius:12px;
    transition:.2s;
}

.card:hover{
    background:#232323;
    transform:translateY(-4px);
}

/* IMAGE */
.card img{
    width:100%;
    height:180px;
    object-fit:cover;
    border-radius:8px;
    margin-bottom:10px;
}

/* TEXT */
.title{
    font-size:15px;
    font-weight:700;
}

.artist{
    font-size:13px;
    color:#b3b3b3;
}

.uploader{
    font-size:12px;
    color:#777;
}

/* REMOVE */
.remove{
    display:inline-block;
    margin-top:10px;
    font-size:13px;
    color:#ff4d4d;
    text-decoration:none;
}

.remove:hover{
    color:#ff1a1a;
}

/* EMPTY */
.empty{
    color:#b3b3b3;
    margin-top:20px;
}
</style>

</head>

<body>
<div class ="page-wrapper">
<a class="back-home-btn" href="${pageContext.request.contextPath}/home">
    ← Quay lại trang chủ
</a>
<h2>❤️ Bài hát yêu thích</h2>

<c:if test="${empty favorites}">
    <div class="empty">
        Chưa có bài hát yêu thích nào.
    </div>
</c:if>

<div class="container">

    <c:forEach items="${favorites}" var="f">

        <div class="card">

            <img src="${pageContext.request.contextPath}/${f.song.imageUrl}">

            <div class="title">${f.song.title}</div>

            <div class="artist">${f.song.artist}</div>

            <div class="uploader">
                Đăng bởi: ${f.song.user.fullname}
            </div>

            <a class="remove"
               href="${pageContext.request.contextPath}/favorite?songId=${f.song.id}">
                💔 Bỏ thích
            </a>

        </div>

    </c:forEach>

</div>
</div>
</body>
</html>