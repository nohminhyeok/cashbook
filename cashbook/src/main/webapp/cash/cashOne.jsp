<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String fullDate = request.getParameter("fullDate");
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));

	Cash cash = new Cash();
	CashDao cashDao = new CashDao();



	ArrayList<Cash> list = cashDao.selectCashByNo(cash_no);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	HashMap<Integer, String> categoryMap = new HashMap<>();

	for (Category cat : categoryList) {
	    categoryMap.put(cat.getCategory_no(), cat.getKind() + " - " + cat.getTitle());
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>cash</h1>
	<table border="1">
		<%
			for(Cash c : list){
		%>
			<tr>
				<td>번호</td>
				<td><%=c.getCash_no()%></td>
			</tr>
			<tr>
				<td>수입/지출</td>
				<td><%= categoryMap.get(c.getCategory_no()) %></td>
			</tr>
			<tr>
				<td>날짜</td>
				<td><%=c.getCash_date()%></td>
			</tr>
			<tr>
				<td>금액</td>
				<td><%=c.getAmount()%></td>
			</tr>
			<tr>
				<td>메모</td>
				<td><%=c.getMemo()%></td>
			</tr>
			<tr>
				<td>색상</td>
				<td><%=c.getColor()%></td>
			</tr>
			<tr>
				<td>만든 날짜</td>
				<td><%=c.getCreatedate()%></td>
			</tr>
			<tr>
				<td>수정한 날짜</td>
				<td><%=c.getUpdatedate()%></td>
			</tr>
		<%		
			}
		%>
	</table>
	<a href="/cashbook/cash/cashByDate.jsp?fullDate=<%=fullDate%>">
		<button type="submit">이전으로</button>
	</a>
	<form action="/cashbook/cash/updateCashForm.jsp">
		<input type="hidden" name="cash_no" value="<%=cash_no%>">
		<button type="submit">수정</button>
	</form>
	<form action="/cashbook/cash/deleteCashForm.jsp">
		<input type="hidden" name="cash_no" value="<%=cash_no%>">
		<button type="submit">삭제</button>
	</form>
	<form action="/cashbook/cash/uploadCashReceiptForm.jsp">
		<input type="hidden" name="cash_no" value="<%=cash_no%>">
		<button type="submit">영수증 등록</button>
	</form>
</body>
</html>