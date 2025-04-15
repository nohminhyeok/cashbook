<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/login&pw/loginForm.jsp");
	    return;
	}
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	System.out.println("cash_no : "+ cash_no);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	body {
		font-family: "Noto Sans KR", sans-serif;
		background-color: #fff8f8;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
	}

	form {
		background-color: #ffffff;
		padding: 30px 40px;
		border: 1px solid #ffdddd;
		border-radius: 12px;
		box-shadow: 0 4px 12px rgba(255, 0, 0, 0.1);
		text-align: center;
	}

	h2 {
		color: #d32f2f;
		margin-bottom: 20px;
	}

	button {
		background-color: #e53935;
		color: white;
		padding: 12px 24px;
		font-size: 16px;
		border: none;
		border-radius: 8px;
		cursor: pointer;
		transition: background-color 0.3s;
	}

	button:hover {
		background-color: #c62828;
	}
</style>
</head>
<body>
	<form action="/cashbook/cash/deleteCashAction.jsp" method="post">
		<h2>정말 삭제하시겠습니까?</h2>
		<input type="hidden" name="cash_no" value="<%=cash_no %>">
		<button type="submit">진짜 삭제하기</button>
	</form>
</body>
</html>