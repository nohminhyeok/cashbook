<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("adminId");
if(id == null) {
    response.sendRedirect("/cashbook/loginForm.jsp");
    return;
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Index</title>
<style>
    body {
        background-color: #eef2f7;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #2c3e50;
        margin: 0;
        padding: 0;
        text-align: center;
    }

    h1 {
        font-size: 3em;
        margin-top: 60px;
        font-weight: 700;
        color: #34495e;
    }

    ul {
        list-style-type: none;
        padding: 0;
        margin-top: 50px;
    }

    li {
        margin: 20px 0;
    }

    .menu-link {
        font-size: 1.2em;
        text-decoration: none;
        color: #3498db;
        background-color: #fff;
        border: 2px solid #3498db;
        border-radius: 8px;
        padding: 12px 30px;
        transition: all 0.3s ease;
        display: inline-block;
    }

    .menu-link:hover {
        background-color: #3498db;
        color: #fff;
    }

    .logout-btn {
        margin-top: 40px;
        font-size: 1em;
        padding: 12px 30px;
        border-radius: 8px;
        border: 2px solid #e74c3c;
        background-color: #fff;
        color: #e74c3c;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .logout-btn:hover {
        background-color: #e74c3c;
        color: #fff;
    }
</style>
</head>
<body>
    <h1>📊 Index</h1>
    <ul>
        <li>
            <a class="menu-link" href="/cashbook/login&pw/updateAdminPwForm.jsp">비밀번호 수정</a>
        </li>
        <li>
            <a class="menu-link" href="/cashbook/category/categoryList.jsp">카테고리 관리</a>
        </li>
        <li>
            <a class="menu-link" href="/cashbook/monthList.jsp">가계부 보기</a>
        </li>
        <li>
        	<a class="menu-link" href="/cashbook/category/amountView.jsp">수입/지출 통계</a>
        </li>
    </ul>

    <form action="/cashbook/login&pw/logout.jsp" method="post">
        <button class="logout-btn" type="submit">🔓 로그아웃</button>
    </form>
</body>
</html>
