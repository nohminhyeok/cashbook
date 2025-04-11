<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	CashDao cashDao = new CashDao();

	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(5);

	int totalRow = cashDao.countCash(); // ← cash_no 없이 전체 count로

	ArrayList<Cash> list = cashDao.selectCash(p); // ← 전체 select로
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
		<tr>
			<td>cash_no</td>
			<td>category_no</td>
			<td>cash_date</td>
			<td>amount</td>
			<td>memo</td>
			<td>color</td>
			<td>createdate</td>
			<td>updatedate</td>
		</tr>
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