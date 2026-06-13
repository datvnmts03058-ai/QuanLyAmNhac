<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.song-select{
    padding:10px 15px;
    border-radius:8px;
    background:#202020;
    color:white;
    border:1px solid #1DB954;
    margin-bottom:20px;
}

.fav-table{
    width:100%;
    border-collapse:collapse;
    background:#181818;
}

.fav-table th{
    background:#1DB954;
    color:white;
    padding:12px;
}

.fav-table td{
    padding:12px;
    border-bottom:1px solid #333;
    color:white;
}

.fav-table tr:hover{
    background:#252525;
}

.empty-row{
    text-align:center;
    color:#999;
}
</style>
</head>
<body>
<h2>👥 Người dùng yêu thích bài hát</h2>

<select class="song-select"
        id="songSelect"
        onchange="loadFavUsers(this.value)">

    <option value="">
        -- Chọn bài hát --
    </option>

    <c:forEach items="${songs}" var="s">

        <option value="${s.id}">
            ${s.title}
        </option>

    </c:forEach>

</select>

<table class="fav-table" id="favUsersTable">

    <thead>

        <tr>
            <th>Username</th>
            <th>Fullname</th>
            <th>Email</th>
            <th>Ngày thích</th>
        </tr>

    </thead>

    <tbody id="favUsersBody">

        <tr>

            <td colspan="4" class="empty-row">

                Chọn bài hát để xem dữ liệu

            </td>

        </tr>

    </tbody>

</table>
<script>

function loadFavUsers(songId){

    if(!songId){

        document.getElementById("favUsersBody").innerHTML =
            `<tr>
                <td colspan="4" class="empty-row">
                    Chọn bài hát để xem dữ liệu
                </td>
            </tr>`;

        return;
    }

    fetch(
        '${pageContext.request.contextPath}/report-fav-users?songId=' + songId
    )
    .then(response => response.json())

    .then(data => {

        let html = "";

        if(data.length === 0){

            html =
                `<tr>
                    <td colspan="4" class="empty-row">
                        Chưa có ai yêu thích bài hát này
                    </td>
                </tr>`;
        }
        else{

            data.forEach(user => {

                html +=
                    `<tr>

                        <td>${user.username}</td>

                        <td>${user.fullname}</td>

                        <td>${user.email}</td>

                        <td>${user.likeDate}</td>

                    </tr>`;
            });
        }

        document.getElementById("favUsersBody").innerHTML = html;
    })

    .catch(error => {

        console.error(error);

        alert("Lỗi tải dữ liệu");
    });
}

</script>
</body>
</html>