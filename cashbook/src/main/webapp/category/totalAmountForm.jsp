<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
		// 세션에 admin 아이디가 없으면 로그인 페이지로
	}
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> list = categoryDao.selectTotalAll(); // kind별 총 건수/금액 가져오기
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>전체 수입/지출 통계</title>
	<style>
		body {
			font-family: Arial, sans-serif;
			margin: 30px;
			background-color: #f9f9f9;
		}
		h1 {
			color: #333;
		}
		table {
			width: 60%;
			border-collapse: collapse;
			margin-top: 20px;
			background-color: #fff;
			box-shadow: 0 0 10px rgba(0,0,0,0.05);
		}
		th, td {
			border: 1px solid #ccc;
			padding: 12px;
			text-align: center;
		}
		th {
			background-color: #007bff;
			color: white;
		}
		tr:nth-child(even) {
			background-color: #f2f2f2;
		}
		button {
			padding: 6px 12px;
			background-color: #007bff;
			color: white;
			border: none;
			border-radius: 4px;
			cursor: pointer;
		}
		button:hover {
			background-color: #0056b3;
		}
		.top-right-button {
			position: absolute;
			top: 20px;
			right: 30px;
		}
	</style>
</head>
<body>
	<div class="top-right-button">
	    <form action="/cashbook/index.jsp">
	        <button type="submit">🏠 Index 페이지로 이동</button>
	    </form>
	</div>
	<div class="top-left-button">
	    <form action="/cashbook/category/amountView.jsp">
	        <button type="submit">통계 페이지</button>
	    </form>
	</div>

	<h1>전체 수입/지출 통계</h1>

	<table>
		<tr>
			<th>수입/지출</th>
			<th>건수</th>
			<th colspan="2">총 액</th>
		</tr>
		<%
			int totalIncome = 0;
			int totalExpense = 0;

			for (Category c : list) {
		%>
		<tr>
			<td><%= c.getKind() %></td>
			<td><%= c.getCount() %></td>
			<td colspan="2"><%= c.getAmount() %> 원</td>
		</tr>
		<%
				if ("수입".equals(c.getKind())) {
					totalIncome += c.getAmount();
				} else if ("지출".equals(c.getKind())) {
					totalExpense += c.getAmount();
				}
			}

			int total = totalIncome - totalExpense;
		%>
		<tr>
			<th>잔 액</th>
			<td><%= total %>원</td>
			<th>재정상태</th>
			<td>
				<%
					if (total < 0) {
				%>
					적자(라면만 먹고 살아야 합니다.)
				<%
					} else {
				%>
					흑자(외식해도 됨 ㅎ)
				<%
					}
				%>
			</td>
		</tr>
	</table>
</body>
</html>
