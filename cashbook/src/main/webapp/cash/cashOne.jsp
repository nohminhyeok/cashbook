<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/login&pw/loginForm.jsp");
	    return;
	}

	String fullDate = request.getParameter("fullDate");
	System.out.println("fullDate.cashOne : "+ fullDate);
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	System.out.println("cash_no.cashOne : "+ cash_no);

	CashDao cashDao = new CashDao();
	ArrayList<Cash> list = cashDao.selectCashByNo(cash_no);
	
	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	HashMap<Integer, String> categoryMap = new HashMap<>();

	for (Category ct : categoryList) {
	    categoryMap.put(ct.getCategory_no(), ct.getKind() + " - " + ct.getTitle());
	}

	ReceiptDao receiptDao = new ReceiptDao();
	ArrayList<Receipt> receiptList = receiptDao.selectReceiptListByCashNo(cash_no);
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>cash 상세 보기</title>
	<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #f8f9fa;
			margin: 30px;
			position: relative;
		}

		h1, h2 {
			color: #343a40;
		}

		table {
			width: 100%;
			border-collapse: collapse;
			margin-bottom: 20px;
			background-color: #ffffff;
			box-shadow: 0 0 10px rgba(0, 0, 0, 0.05);
		}

		th, td {
			padding: 12px 15px;
			text-align: left;
			border-bottom: 1px solid #dee2e6;
		}

		th {
			background-color: #007bff;
			color: #fff;
		}

		tr:nth-child(even) {
			background-color: #f2f2f2;
		}

		button {
			background-color: #007bff;
			color: white;
			border: none;
			padding: 10px 20px;
			margin: 5px 5px 15px 0;
			border-radius: 5px;
			cursor: pointer;
			transition: background-color 0.3s ease;
		}

		button:hover {
			background-color: #0056b3;
		}

		img {
			border: 1px solid #ccc;
			border-radius: 5px;
		}

		form {
			display: inline-block;
			margin-right: 10px;
		}

		.top-right {
			position: absolute;
			top: 20px;
			right: 20px;
		}
	</style>
</head>
<body>

	<!-- 달력으로 돌아가기 버튼 -->
	<div class="top-right">
		<form action="/cashbook/monthList.jsp" method="get">
			<button type="submit">달력으로</button>
		</form>
	</div>

	<h1>cash</h1>
	<table>
		<% for(Cash c : list){ %>
			<tr>
				<th>번호</th>
				<td><%=c.getCash_no()%></td>
			</tr>
			<tr>
				<th>수입/지출</th>
				<td><%= categoryMap.get(c.getCategory_no()) %></td>
			</tr>
			<tr>
				<th>날짜</th>
				<td><%=c.getCash_date()%></td>
			</tr>
			<tr>
				<th>금액</th>
				<td><%=c.getAmount()%></td>
			</tr>
			<tr>
				<th>메모</th>
				<td><%=c.getMemo()%></td>
			</tr>
			<tr>
				<th>색상</th>
				<td>
					<div style="width: 30px; height: 30px; background-color: <%=c.getColor()%>; border: 1px solid #ccc;"></div>
					(<%=c.getColor()%>)
				</td>
			</tr>
			<tr>
				<th>만든 날짜</th>
				<td><%=c.getCreatedate()%></td>
			</tr>
			<tr>
				<th>수정한 날짜</th>
				<td><%=c.getUpdatedate()%></td>
			</tr>
		<% } %>
	</table>

	<form action="/cashbook/cash/cashByDate.jsp">
		<input type="hidden" name="fullDate" value="<%=fullDate%>">
		<button type="submit">이전으로</button>
	</form>

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
		<input type="hidden" name="fullDate" value="<%=fullDate%>">
		<button type="submit">영수증 등록</button>
	</form>

	<h2>영수증</h2>

	<% if(receiptList.size() == 0) { %>
		<p style="color:gray;">등록된 영수증이 없습니다.</p>
	<% } else { %>
		<form action="/cashbook/cash/deleteCashReceiptForm.jsp">
			<table>
				<tr>
					<th>영수증</th>
					<th>업로드 날짜</th>
				</tr>
				<% for(Receipt r : receiptList){ %>
					<tr>
						<td>
							<img src="/cashbook/upload/<%=r.getFilename()%>" width="200px">
							<input type="hidden" name="filename" value="<%=r.getFilename()%>">
						</td>
						<td><%=r.getCreatedate()%></td>
					</tr>
				<% } %>
			</table>
			<input type="hidden" name="fullDate" value="<%=fullDate %>">
			<input type="hidden" name="cash_no" value="<%=cash_no %>">
			<button type="submit">영수증 삭제</button>
		</form>
	<% } %>
</body>
</html>
