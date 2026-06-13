<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Notifications</title>

    <style>
        body {
            font-family: Arial;
            margin: 30px;
            background: #f5f6f8;
        }

        .container {
            width: 700px;
            margin: auto;
        }

        .box {
            background: white;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        input, textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 6px;
        }

        button {
            padding: 10px 15px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        button:hover {
            background: #0056b3;
        }

        .item {
            padding: 12px;
            border-bottom: 1px solid #eee;
            cursor: pointer;
        }

        .item:hover {
            background: #f1f1f1;
        }

        .unread {
            background: #e8f3ff;
        }

        .title {
            font-weight: bold;
        }

        .time {
            font-size: 12px;
            color: gray;
        }

        .badge {
            background: red;
            color: white;
            padding: 2px 6px;
            border-radius: 50%;
            font-size: 12px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- HEADER -->
    <div class="box header">
        <h2>🔔 Notifications</h2>

        <c:if test="${unreadCount > 0}">
            <span class="badge">${unreadCount}</span>
        </c:if>
    </div>

    <!-- FORM GỬI THÔNG BÁO -->
    <div class="box">
        <h3>Send Notification</h3>

        <form action="send-mess" method="post">

            <label>Title</label>
            <input type="text" name="title" required>

            <label>Content</label>
            <textarea name="content" rows="4" required></textarea>

            <label>User ID (để trống = gửi ALL)</label>
            <input type="text" name="userId" placeholder="vd: 1">

            <button type="submit">Send</button>

        </form>
    </div>

    <!-- LIST NOTIFICATIONS -->
    <div class="box">

        <h3>List Notifications</h3>

        <c:forEach var="n" items="${notifications}">

            <div class="item ${n.isRead ? '' : 'unread'}"
                 onclick="markRead(${n.id})">

                <div class="title">${n.title}</div>

                <div>${n.content}</div>

                <div class="time">
                    ${n.createdAt}
                </div>

                <c:if test="${!n.isRead}">
                    <small style="color:red;">● new</small>
                </c:if>

            </div>

        </c:forEach>

    </div>

</div>

<script>
function markRead(id) {
    fetch("mark-read?id=" + id)
        .then(res => res.text())
        .then(() => {
            location.reload();
        });
}
</script>

</body>
</html>