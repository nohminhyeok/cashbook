<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String year = request.getParameter("year");
	if (year == null) {
	    Calendar cal = Calendar.getInstance();
	    year = String.valueOf(cal.get(Calendar.YEAR));
	}

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> List = categoryDao.selectTotalMonthByYear(year);

	int selectedYear = Integer.parseInt(year);
	int currentYear = Calendar.getInstance().get(Calendar.YEAR);
	int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
	int maxMonth = (selectedYear == currentYear) ? currentMonth : 12;
	
	Map<Integer, Category[]> monthMap = new LinkedHashMap<>();

	for (Category c : List) {
	    int m = c.getMonth();
	    String kind = c.getKind();

	    if (!monthMap.containsKey(m)) {
	        monthMap.put(m, new Category[2]); // [0] = 수입, [1] = 지출
	    }

	    if ("수입".equals(kind)) {
	        monthMap.get(m)[0] = c;
	    } else if ("지출".equals(kind)) {
	        monthMap.get(m)[1] = c;
	    }
	}
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title><%= year %>년 월별 수입/지출 통계</title>
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
			width: 80%;
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
		form {
			margin-bottom: 20px;
		}
		select, button {
			padding: 6px 10px;
			margin-right: 10px;
		}
		button {
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

	<!-- 우측 상단 인덱스 이동 버튼 -->
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

	<h1><%= year %>년 월별 수입/지출 통계</h1>

	<form method="get" action="">
		<label for="year">연도 선택:</label>
		<select name="year" id="year">
			<% for (int y = currentYear; y >= 2000; y--) { %>
				<option value="<%= y %>" <%= (String.valueOf(y).equals(year)) ? "selected" : "" %>><%= y %></option>
			<% } %>
		</select>
		<button type="submit">조회</button>
	</form>

	<table>
		<tr>
			<th>월</th>
			<th>수입 (건수/총액)</th>
			<th>지출 (건수/총액)</th>
		</tr>
		<%
			int totalIncomeCount = 0;
			int totalIncomeAmount = 0;
			int totalExpenseCount = 0;
			int totalExpenseAmount = 0;

			for (int m = 1; m <= maxMonth; m++) {
			    Category[] pair = monthMap.get(m);
			    Category income = pair != null ? pair[0] : null;
			    Category expense = pair != null ? pair[1] : null;

			    if (income != null) {
			        totalIncomeCount += income.getCount();
			        totalIncomeAmount += income.getAmount();
			    }

			    if (expense != null) {
			        totalExpenseCount += expense.getCount();
			        totalExpenseAmount += expense.getAmount();
			    }
		%>
		<tr>
			<td><%= m %>월</td>
			<td><%= (income != null) ? income.getCount() + "건 / " + income.getAmount() + "원" : "-" %></td>
			<td><%= (expense != null) ? expense.getCount() + "건 / " + expense.getAmount() + "원" : "-" %></td>
		</tr>
		<% } %>
		<tr style="background-color: #dff0d8; font-weight: bold;">
			<td>총합계</td>
			<td><%= totalIncomeCount %>건 / <%= totalIncomeAmount %>원</td>
			<td><%= totalExpenseCount %>건 / <%= totalExpenseAmount %>원</td>
		</tr>
		<tr>
			<td>잔 액</td>
			<td><%= totalIncomeAmount - totalExpenseAmount %>원</td>
			<td>
				<%
					if((totalIncomeAmount - totalExpenseAmount)<0){
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
