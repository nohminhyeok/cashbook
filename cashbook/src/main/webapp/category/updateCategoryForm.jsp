<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%  
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	}
    int no = Integer.parseInt(request.getParameter("no"));
    System.out.println("no : "+no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 페이지</title>
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

    /* 폼 스타일 */
    form {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        width: 60%;
        margin: 0 auto;
        text-align: center;
    }

    table {
        width: 100%;
        margin: 20px 0;
        border-collapse: collapse;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 15px;
        text-align: center;
    }

    th {
        background-color: #4CAF50;
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    /* 입력란 스타일 */
    input[type="text"] {
        padding: 10px;
        width: 100%;
        font-size: 1em;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    input[type="radio"] {
        margin-right: 5px;
    }

    button {
        padding: 10px 20px;
        font-size: 1.1em;
        border-radius: 5px;
        border: 2px solid #4CAF50;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
        transition: all 0.3s;
        margin-top: 20px;
    }

    button:hover {
        background-color: #45a049;
        border-color: #45a049;
    }

    .form-container {
        margin-top: 30px;
    }

    .form-container input[type="text"] {
        padding: 10px;
        width: 300px;
        font-size: 1em;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin-right: 10px;
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

    .form-container .cancel-btn {
        background-color: #f44336;
        border-color: #f44336;
    }

    .form-container .cancel-btn:hover {
        background-color: #d32f2f;
        border-color: #d32f2f;
    }
</style>
</head>
<body>

    <form action="/cashbook/category/updateCategoryAction.jsp?no=<%=no%>" method="post">
        <h1>수정 페이지</h1>
        <table>
            <tr>
                <td>분류</td>
                <td>제목</td>			
            </tr>
            <tr>
                <td>
                    <input type="radio" name="kind" value="수입">수입
                    <input type="radio" name="kind" value="지출">지출
                </td>
                <td><input type="text" name="title"></td>
            </tr>
        </table>
        <input type="hidden" name="no" value="<%=no%>">
        <button type="submit">수정하기</button>
        <button type="button" class="cancel-btn" onclick="window.history.back();">취소</button>
    </form>

</body>
</html>
