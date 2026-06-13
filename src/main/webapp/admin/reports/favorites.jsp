<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

.report-table {
    width: 100%;
    border-collapse: collapse;
    background: #181818;
    border-radius: 12px;
    overflow: hidden;
}

.report-table th {
    background: rgba(29,185,84,.15);
    color: #1DB954;
    padding: 14px;
    text-align: left;
    font-size: 13px;
    text-transform: uppercase;
}

.report-table td {
    padding: 14px;
    border-bottom: 1px solid #333;
    color: #e0e0e0;
}

.report-table tr:hover {
    background: rgba(29,185,84,.08);
}

.report-empty {
    text-align: center;
    padding: 30px;
    color: #999;
}

.favorite-badge {
    background: rgba(29,185,84,.15);
    color: #1DB954;
    padding: 4px 10px;
    border-radius: 999px;
    font-weight: 600;
}

</style>
</head>
<body>


<h2 style="margin-bottom:20px;color:#1DB954;">
    ❤️ Thống kê yêu thích
</h2>

<table class="report-table">

    <thead>

        <tr>
            <th>Bài hát</th>
            <th>Số lượt thích</th>
            <th>Thích gần nhất</th>
            <th>Thích đầu tiên</th>
        </tr>

    </thead>

    <tbody>

        <c:choose>

            <c:when test="${not empty stats}">

                <c:forEach items="${stats}" var="row">

                    <tr>

                        <td>${row[0]}</td>

                        <td>
                            <span class="favorite-badge">
                                ❤️ ${row[1]}
                            </span>
                        </td>

                        <td>${row[2]}</td>

                        <td>${row[3]}</td>

                    </tr>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <tr>

                    <td colspan="4" class="report-empty">

                        Chưa có dữ liệu thống kê.

                    </td>

                </tr>

            </c:otherwise>

        </c:choose>

    </tbody>

</table>
</body>
</html>