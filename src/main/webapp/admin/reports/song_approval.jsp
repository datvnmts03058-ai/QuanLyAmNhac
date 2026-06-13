<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Kiểm duyệt bài hát</title>

<style>

.approval-container{
    padding:20px;
}

.approval-header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:20px;
}

.pending-count{
    background:rgba(255,152,0,.15);
    color:#ffb347;
    padding:8px 14px;
    border-radius:999px;
    font-weight:600;
}

.approval-toolbar{
    display:flex;
    gap:12px;
    align-items:center;
    margin-bottom:20px;
    flex-wrap:wrap;
}

.approval-toolbar label{
    display:flex;
    align-items:center;
    gap:8px;
    font-weight:600;
}

.bulk-btn{
    border:none;
    border-radius:999px;
    padding:10px 18px;
    cursor:pointer;
    font-weight:600;
    transition:.3s;
}

.bulk-approve{
    background:#1DB954;
    color:black;
}

.bulk-approve:hover{
    transform:translateY(-2px);
}

.bulk-reject{
    background:#e53935;
    color:white;
}

.bulk-reject:hover{
    transform:translateY(-2px);
}

.approval-table{
    width:100%;
    border-collapse:collapse;
}

.approval-table th{
    padding:14px;
    text-align:left;
    background:#f5f5f5;
}

.approval-table td{
    padding:14px;
    border-bottom:1px solid #ddd;
}

.approval-table tr:hover{
    background:#f9f9f9;
}

.action-cell{
    display:flex;
    gap:10px;
}

.single-btn{
    border:none;
    padding:8px 14px;
    border-radius:999px;
    cursor:pointer;
    font-weight:600;
}

.single-approve{
    background:#1DB954;
    color:white;
}

.single-reject{
    background:#e53935;
    color:white;
}

.empty-row{
    text-align:center;
    padding:30px;
    color:#888;
}

</style>

</head>

<body>

<div class="approval-container">

    <form action="${pageContext.request.contextPath}/approval"
          method="post">

        <div class="approval-header">

            <h2>🎵 Kiểm duyệt bài hát</h2>

            <div class="pending-count">
                ${pendingSongs.size()} bài chờ duyệt
            </div>

        </div>

        <div class="approval-toolbar">

            <label>
                <input type="checkbox"
                       id="selectAll"
                       onclick="toggleAll(this)">
                Chọn tất cả
            </label>

            <button type="submit"
                    name="action"
                    value="approveSelected"
                    class="bulk-btn bulk-approve"
                    onclick="return confirmSelected('duyệt')">

                ✅ Duyệt đã chọn

            </button>

            <button type="submit"
                    name="action"
                    value="rejectSelected"
                    class="bulk-btn bulk-reject"
                    onclick="return confirmSelected('từ chối')">

                ❌ Từ chối đã chọn

            </button>

        </div>

        <table class="approval-table">

            <thead>

                <tr>

                    <th width="50"></th>

                    <th>Bài hát</th>

                    <th>Ca sĩ</th>

                    <th>Thể loại</th>

                    <th>Người đăng</th>

                    <th>Hành động</th>

                </tr>

            </thead>

            <tbody>

                <c:forEach items="${pendingSongs}" var="song">

                    <tr>

                        <td>

                            <input type="checkbox"
                                   name="songIds"
                                   value="${song.id}">

                        </td>

                        <td>${song.title}</td>

                        <td>${song.artist}</td>

                        <td>${song.genre}</td>

                        <td>${song.user.username}</td>

                        <td>

                            <div class="action-cell">

                                <button type="submit"
                                        name="action"
                                        value="approve_${song.id}"
                                        class="single-btn single-approve"
                                        onclick="return confirm('Duyệt bài hát này?')">

                                    ✅ Duyệt

                                </button>

                                <button type="submit"
                                        name="action"
                                        value="reject_${song.id}"
                                        class="single-btn single-reject"
                                        onclick="return confirm('Từ chối bài hát này?')">

                                    ❌ Từ chối

                                </button>

                            </div>

                        </td>

                    </tr>

                </c:forEach>

                <c:if test="${empty pendingSongs}">

                    <tr>

                        <td colspan="6"
                            class="empty-row">

                            🎉 Không có bài hát nào cần kiểm duyệt.

                        </td>

                    </tr>

                </c:if>

            </tbody>

        </table>

    </form>

</div>

<script>

function toggleAll(source){

    const checkboxes =
        document.querySelectorAll(
            "input[name='songIds']"
        );

    checkboxes.forEach(function(cb){

        cb.checked = source.checked;

    });
}

function confirmSelected(action){

    const checked =
        document.querySelectorAll(
            "input[name='songIds']:checked"
        );

    if(checked.length === 0){

        alert("Vui lòng chọn ít nhất 1 bài hát.");

        return false;
    }

    return confirm(
        "Bạn có chắc muốn "
        + action
        + " "
        + checked.length
        + " bài hát?"
    );
}

</script>

</body>
</html>