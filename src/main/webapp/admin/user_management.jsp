<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="sub-tabs">
    <button onclick="switchSubTab('edit')">Song Edition</button>
    <button onclick="switchSubTab('list')">Song List</button>
</div>

<div id="edit-area">
    <form id="songForm">
        <input type="hidden" id="songIdHidden" name="id">
        <div class="form-group">
            <label>Title:</label>
            <input type="text" name="title" id="titleInput" required>
        </div>
        <div class="form-group">
            <label>Artist:</label>
            <input type="text" name="artist" id="artistInput" required>
        </div>
        <div class="form-group">
            <label>Genre:</label>
            <input type="text" name="genre" id="genreInput">
        </div>
        
        <button type="button" onclick="handleSongAction('create')">Create</button>
        <button type="button" onclick="handleSongAction('update')">Update</button>
        <button type="button" onclick="handleSongAction('delete')">Delete</button>
    </form>
</div>

<div id="list-area" style="display:none;">
    <table border="1" width="100%">
        <tr>
            <th>ID</th>
            <th>Title</th>
            <th>Artist</th>
            <th>Action</th>
        </tr>
        <c:forEach items="${songs}" var="s">
            <tr>
                <td>${s.id}</td>
                <td>${s.title}</td>
                <td>${s.artist}</td>
                <td>
                    <button onclick="loadSongToForm('${s.id}', '${s.title}', '${s.artist}', '${s.genre}')">Edit</button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>

<script>
    // Hàm điền dữ liệu vào form khi nhấn Edit
    function loadSongToForm(id, title, artist, genre) {
        switchSubTab('edit');
        document.getElementById('songIdHidden').value = id;
        document.getElementById('titleInput').value = title;
        document.getElementById('artistInput').value = artist;
        document.getElementById('genreInput').value = genre;
    }
</script>
</body>
</html>