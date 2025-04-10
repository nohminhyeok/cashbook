<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
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

    table {
        margin: 30px auto;
        border-collapse: collapse;
        width: 50%;
        background-color: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 15px;
        text-align: center;
        font-size: 1.1em;
    }

    th {
        background-color: #eeeeee; /* 연한 회색 */
        color: #333;
    }

    td {
        background-color: #ffffff;
        border: 1px solid #ddd;
    }

    input[type="text"], input[type="password"] {
        padding: 12px;
        width: 85%;
        border: 1px solid #ccc; /* 회색 테두리 */
        border-radius: 5px;
        font-size: 1em;
        color: #333;
    }

    button {
        background-color: #4CAF50; /* 그린 색상 */
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 5px;
        font-size: 1.2em;
        cursor: pointer;
        margin-top: 20px;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #45a049; /* 버튼 호버 시 조금 더 어두운 그린 */
    }

</style>
</head>
<body>
	<h1>비밀번호 수정</h1>
	<form action="/cashbook/updateAdminPwAction.jsp" method="post">
	<table>
		<tr>
			<th>사용자 아이디</th>
			<td>
				<input type="text" name="id" required>
			</td>
		</tr>
		<tr>
			<th>기존 비밀번호</th>
			<td>
				<input type="password" name="prePw" required>
			</td>
		</tr>
		<tr>
			<th>변경할 비밀번호</th>
			<td>
				<input type="password" name="newPw" required>
			</td>
		</tr>
	</table>
	<button type="submit">변경하기</button>
	</form>
</body>
</html>
