<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	}
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	CashDao cashDao = new CashDao();
	Cash cash = cashDao.selectCashOne(cash_no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지출 수정</title>
<style>
	body {
		font-family: "Noto Sans KR", sans-serif;
		background-color: #f9f9f9;
		padding: 40px;
	}

	h1 {
		text-align: center;
		color: #333;
	}

	form {
		max-width: 500px;
		margin: 0 auto;
		background-color: #fff;
		padding: 30px;
		border-radius: 12px;
		box-shadow: 0 4px 10px rgba(0,0,0,0.1);
	}

	table {
		width: 100%;
		border-collapse: collapse;
		margin-bottom: 20px;
	}

	td {
		padding: 12px 8px;
		font-size: 16px;
		color: #444;
	}

	td:first-child {
		font-weight: bold;
		width: 30%;
	}

	input[type="text"],
	input[type="date"],
	input[type="color"] {
		width: 100%;
		padding: 10px;
		border: 1px solid #ccc;
		border-radius: 8px;
		font-size: 16px;
		box-sizing: border-box;
	}

	button {
		width: 100%;
		padding: 12px;
		background-color: #4CAF50;
		color: white;
		border: none;
		border-radius: 8px;
		font-size: 18px;
		cursor: pointer;
		transition: background-color 0.3s;
	}

	button:hover {
		background-color: #45a049;
	}
</style>
</head>
<body>
	<h1>지출 수정 페이지</h1>
	<form action="/cashbook/cash/updateCashAction.jsp" method="post">
	<table>
		<tr>
			<td>날짜</td>
			<td>
				<input type="date" name="cash_date" value="<%=cash.getCash_date()%>">
			</td>
		</tr>
		<tr>
			<td>금액</td>
			<td>
				<input type="text" name="amount" value="<%=cash.getAmount()%>">
			</td>
		</tr>
		<tr>
			<td>메모</td>
			<td>
				<input type="text" name="memo" value="<%=cash.getMemo()%>">
			</td>
		</tr>
		<tr>
			<td>색상</td>
			<td>
				<input type="color" name="color" value="<%=cash.getColor()%>">
			</td>
		</tr>
	</table>
	<input type="hidden" name="cash_no" value="<%=cash_no%>">
	<button type="submit">변경하기</button>
	</form>
</body>
</html>
