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
<title>통계 선택</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f5f7fa;
        margin: 0;
        padding: 0;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
    }

    h1 {
        color: #2c3e50;
        margin-bottom: 40px;
    }

    form {
        margin: 10px;
    }

    button {
        padding: 12px 24px;
        font-size: 1.1em;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    button:hover {
        background-color: #2980b9;
    }
</style>
</head>
<body>
    <h1>통계 보기 선택</h1>

    <form action="/cashbook/category/totalAmountCategoryYearForm.jsp">
        <button type="submit">한 해 통계</button>		
    </form>

    <form action="/cashbook/category/totalAmountForm.jsp">
        <button type="submit">전체 통계</button>		
    </form>
    <form action="/cashbook/index.jsp">
    	<button>🏠 Index 페이지로 이동</button>
    </form>
</body>
</html>
