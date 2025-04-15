<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정</title>
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
        font-size: 2.8em;
        margin-top: 60px;
        font-weight: bold;
        color: #34495e;
    }

    form {
        margin-top: 40px;
    }

    table {
        margin: 0 auto;
        border-collapse: separate;
        border-spacing: 15px;
        background-color: #fff;
        padding: 30px 40px;
        border-radius: 10px;
        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
        width: 400px;
    }

    th {
        text-align: left;
        font-size: 1.1em;
        color: #34495e;
        padding-bottom: 5px;
    }

    td {
        text-align: left;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 12px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1em;
        background-color: #fafafa;
    }

    button {
        margin-top: 30px;
        background-color: #4CAF50;
        color: white;
        border: none;
        padding: 14px 35px;
        border-radius: 6px;
        font-size: 1.2em;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
    <h1>🔐 비밀번호 수정</h1>
    <form action="/cashbook/login&pw/updateAdminPwAction.jsp" method="post">
        <table>
            <tr>
                <th>사용자 아이디</th>
                <td><input type="text" name="id" required></td>
            </tr>
            <tr>
                <th>기존 비밀번호</th>
                <td><input type="password" name="prePw" required></td>
            </tr>
            <tr>
                <th>변경할 비밀번호</th>
                <td><input type="password" name="newPw" required></td>
            </tr>
        </table>
        <button type="submit">비밀번호 변경</button>
    </form>
</body>
</html>
