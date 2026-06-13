<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Share Music</title>

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

/* WRAPPER */
.wrapper{
    max-width:600px;
    margin:40px auto;
    padding:24px;
    background:#121212;
    border-radius:16px;
    border:1px solid rgba(255,255,255,0.06);
    box-shadow:0 20px 60px rgba(0,0,0,0.6);
}

/* BACK BUTTON */
.back-btn{
    display:inline-block;
    margin-bottom:14px;
    font-size:13px;
    color:#b3b3b3;
    text-decoration:none;
    transition:0.2s;
}

.back-btn:hover{
    color:#1db954;
}

/* TITLE */
h2{
    color:#1db954;
    margin-bottom:20px;
}

/* INPUT */
input, select{
    width:100%;
    padding:12px;
    margin-bottom:12px;
    border:none;
    border-radius:8px;
    background:#222;
    color:#fff;
    font-size:14px;
}

input:focus, select:focus{
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
    transition:0.2s;
}

.btn:hover{
    background:#20d45f;
    transform:scale(1.03);
}

/* SONG PREVIEW */
.song-preview{
    background:#181818;
    padding:10px;
    border-radius:10px;
    margin-bottom:12px;
    display:flex;
    gap:10px;
    align-items:center;
}

.song-preview img{
    width:50px;
    height:50px;
    border-radius:6px;
    object-fit:cover;
}

.song-info{
    font-size:13px;
}

.song-title{
    font-weight:700;
}

.song-artist{
    color:#b3b3b3;
    font-size:12px;
}

</style>

</head>

<body>

<div class="wrapper">

    <!-- BACK -->
    <a class="back-btn" href="${pageContext.request.contextPath}/home">
        ← Quay lại trang chủ
    </a>

    <h2>📤 Share Music</h2>

    <!-- SONG PREVIEW -->
    <c:if test="${not empty song}">
        <div class="song-preview">
            <img src="${pageContext.request.contextPath}/${song.imageUrl}">
            <div class="song-info">
                <div class="song-title">${song.title}</div>
                <div class="song-artist">${song.artist}</div>
            </div>
        </div>
    </c:if>

    <!-- FORM -->
    <form action="${pageContext.request.contextPath}/share-song" method="post">

        <!-- song id hidden -->
        <input type="hidden" name="songId" value="${song.id}">

        <!-- email -->
        <input type="email"
               name="email"
               placeholder="Nhập email người nhận"
               required>

        <!-- message optional -->
        <input type="text"
               name="message"
               placeholder="Lời nhắn (tuỳ chọn)">

        <button class="btn" type="submit">
            Gửi bài hát
        </button>

    </form>
	<c:if test="${not empty msg}">
    <p style="color:#1db954; margin-top:10px;">
        ${msg}
    </p>
</c:if>
</div>

</body>
</html>