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
<title>카테고리 작성</title>
<style>
    /* 기본 페이지 스타일 */
    body {
        background-color: #f5f5f5; /* 부드러운 회색 배경 */
        font-family: 'Arial', sans-serif;
        color: #333;
        margin: 0;
        padding: 0;
    }

    h1 {
        color: #444;
        font-size: 2.5em;
        margin-top: 50px;
        font-weight: 600;
        text-align: center;
    }

    table {
        width: 50%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #ffffff;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 15px;
        text-align: center;
    }

    th {
        background-color: #4CAF50; /* 그린 색상 */
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #e0e0e0;
    }

    .form-container {
        text-align: center;
        margin-top: 20px;
    }

    .form-container input {
        padding: 10px;
        font-size: 1em;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin: 5px 0;
    }

    .form-container button {
        padding: 10px 20px;
        font-size: 1.1em;
        border-radius: 5px;
        border: 2px solid #4CAF50;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
        transition: all 0.3s;
    }

    .form-container button:hover {
        background-color: #45a049;
        border-color: #45a049;
    }

    .radio-group {
        text-align: left;
        margin-left: 20px;
    }

    .back-link {
        display: block;
        text-align: center;
        margin-top: 20px;
    }

    .back-link a {
        font-size: 1.2em;
        color: #4CAF50;
        text-decoration: none;
        border: 2px solid #4CAF50;
        padding: 10px 20px;
        border-radius: 5px;
        transition: all 0.3s;
    }

    .back-link a:hover {
        background-color: #4CAF50;
        color: white;
    }
</style>
</head>
<body>
	<h1>카테고리 작성</h1>
	<form action="/cashbook/insertCategoryAction.jsp" method="post">
		<table>
			<tr>
				<td>분류</td>
				<td>
					<div class="radio-group">
						<input type="radio" name="kind" value="수입"> 수입
						<input type="radio" name="kind" value="지출"> 지출
					</div>
				</td>
			</tr>
			<tr>
				<td>title</td>
				<td>
					<input type="text" name="title" placeholder="카테고리 제목 입력" required>
				</td>
			</tr>
		</table>
		<div class="form-container">
			<button type="submit">작성하기</button>
		</div>
	</form>

	<div class="back-link">
		<a href="/cashbook/categoryList.jsp">뒤로 가기</a>
	</div>
</body>
</html>
