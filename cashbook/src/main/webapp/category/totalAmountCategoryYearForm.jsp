<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/login&pw/loginForm.jsp");
	    return;
		// 세션에 admin 아이디가 없으면 로그인 페이지로
	}
	String year = request.getParameter("year"); // 년도 값을 viewLayer에서 받아옴
	if (year == null) {
	    Calendar cal = Calendar.getInstance();  // 현재의 날짜를 가져오고
	    year = String.valueOf(cal.get(Calendar.YEAR));
	    // year는 문자열 형태로 받아와야 하니까 value of를 사용해서 현재의 날짜에서 년도만 받아옴
	    // year 값이 null이면 현재 년도로 설정
	}

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> List = categoryDao.selectTotalMonthByYear(year);

	int selectedYear = Integer.parseInt(year); //선택한 년도
	int currentYear = Calendar.getInstance().get(Calendar.YEAR); 
	int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
	int maxMonth = (selectedYear == currentYear) ? currentMonth : 12;
	// 선택한 년도가 현재 연도랑 같으면 현재 월까지만 표시하고 아니면 12월까지 표시 삼항연산자 사용
	// ex = a-b > c : d
	// a-b의 값이 참이면 c 아니면 d
	
	Map<Integer, Category[]> monthMap = new LinkedHashMap<>();

	for (Category c : List) {
	    int m = c.getMonth();  // 몇월에 해당하는 데이터인지 가져옴
	    String kind = c.getKind(); // 수입인지 지출인지

	    if (!monthMap.containsKey(m)) { 
	        monthMap.put(m, new Category[2]); // [0] = 수입, [1] = 지출
	    } // 

	    if ("수입".equals(kind)) {
	        monthMap.get(m)[0] = c; // kind가 수입이면 0번 인덱스에 저장
	    } else if ("지출".equals(kind)) {
	        monthMap.get(m)[1] = c; // kind가 지출이면 1번 인덱스에 저장
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
			<% 
				for (int y = currentYear; y >= 2000; y--) {
			%>
				<option value="<%= y %>" <%= (String.valueOf(y).equals(year)) ? "selected" : "" %>><%= y %></option>
			<% 
				}
			%>
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
			// 값을 담을 변수 설정

			for (int m = 1; m <= maxMonth; m++) {
			    Category[] pair = monthMap.get(m);
			    Category income = pair != null ? pair[0] : null; // pair 0 - 수입
			    Category expense = pair != null ? pair[1] : null; // pair 1 - 지출

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
			<!-- 해당 월에 수입이나 지출에 대한 값이 있으면 건,액 표시 없으면 - 표시 -->
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
