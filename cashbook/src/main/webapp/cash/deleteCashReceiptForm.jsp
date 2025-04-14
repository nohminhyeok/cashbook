<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String filename = request.getParameter("filename");
	System.out.println("filename.deleteForm : "+ filename);
	String fullDate = request.getParameter("fullDate");
	System.out.println("fullDate.deleteForm : "+fullDate);
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	System.out.println("cash_no.deleteForm : "+ cash_no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영수증 삭제 확인</title>
<style>
	body {
		font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
		background-color: #fefefe;
		display: flex;
		justify-content: center;
		align-items: center;
		height: 100vh;
		margin: 0;
	}
	.delete-container {
		background-color: white;
		border: 2px solid #ff4d4d;
		padding: 30px;
		border-radius: 10px;
		box-shadow: 0 0 10px rgba(255, 77, 77, 0.3);
		width: 400px;
		text-align: center;
	}
	h1 {
		color: #cc0000;
		margin-bottom: 20px;
	}
	button {
		background-color: #ff4d4d;
		color: white;
		padding: 10px 20px;
		font-size: 16px;
		border: none;
		border-radius: 5px;
		cursor: pointer;
	}
	button:hover {
		background-color: #cc0000;
	}
</style>
</head>
<body>
	<div class="delete-container">
		<h1>정말 삭제하시겠습니까?</h1>
		<form action="/cashbook/cash/deleteCashReceiptAction.jsp" method="get">
			<input type="hidden" name="cash_no" value="<%=cash_no %>">
			<input type="hidden" name="fullDate" value="<%=fullDate %>">
			<input type="hidden" name="filename" value="<%=filename%>">
			<button type="submit">삭제하기</button>
		</form>
	</div>
</body>
</html>