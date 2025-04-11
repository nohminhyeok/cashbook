<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String fullDate = request.getParameter("fullDate");
	Cash cash = new Cash();
	CashDao cashDao = new CashDao();
	System.out.println("cashByDate.fullDate : "+fullDate);
	
	
	ArrayList<Cash> list = cashDao.selectCashByDay(fullDate);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>지출 상세페이지</h1>
	<table border="1">
		<tr>
			<td>cash_no</td>
			<td>category_no</td>
			<td>cash_date</td>
			<td>amount</td>
			<td>memo</td>
			<td>color</td>
			<td>createdate</td>
			<td>updatedate</td>
		<tr>
		<%
			for(Cash c : list){
		%>
			<tr>
				<td><%=c.getCash_no()%></td>
				<td><%=c.getCategory_no()%></td>
				<td><%=c.getCash_date()%></td>
				<td><%=c.getAmount()%></td>
				<td><%=c.getMemo()%></td>
				<td><%=c.getColor()%></td>
				<td><%=c.getCreatedate()%></td>
				<td><%=c.getUpdatedate()%></td>
			</tr>
		<%		
			}
		%>				
	</table>
</body>
</html>