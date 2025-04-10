<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("adminId");

if(id == null) { // 로그인 상태가 아니면
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
    /* 배경색, 폰트, 텍스트 정렬 */
    body {
        background-color: #f5f5f5; /* 부드러운 회색 배경 */
        font-family: 'Arial', sans-serif;
        color: #333;
        text-align: center;
        margin: 0;
        padding: 0;
    }

    h1 {
        color: #444; /* 어두운 회색 */
        font-size: 2.5em;
        margin-top: 50px;
        font-weight: 600;
    }

    ul {
        list-style-type: none;
        padding: 0;
    }

    li {
        margin: 20px 0;
    }

    a {
        text-decoration: none;
        font-size: 1.2em;
        color: #4CAF50; /* 그린 색상 */
        padding: 10px 20px;
        border-radius: 5px;
        background-color: #ffffff;
        border: 2px solid #4CAF50;
        transition: all 0.3s;
    }

    a:hover {
        background-color: #4CAF50; /* 그린 색상 */
        color: white;
        border-color: #4CAF50;
    }

</style>
</head>
<body>
	<h1>Index</h1>
	<ul>
		<li>
			<a href="/cashbook/updateAdminPwForm.jsp">비밀번호 수정</a>
		</li>
		<li>
			<a href="/cashbook/categoryList.jsp">카테고리</a>
		</li>
		<li>
			<a href="/cashbook/monthList.jsp">가계부</a>
		</li>
	</ul>
	<form action="/cashbook/logout.jsp">
		<button type="submit">로그아웃</button>
	</form>
</body>
</html>
