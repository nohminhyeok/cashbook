<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	String fullDate = request.getParameter("fullDate");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>영수증 업로드</title>
	<style>
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background-color: #f5f5f5;
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100vh;
			margin: 0;
		}
		.upload-container {
			background-color: white;
			padding: 30px;
			border-radius: 12px;
			box-shadow: 0 4px 8px rgba(0,0,0,0.1);
			width: 400px;
		}
		h2 {
			text-align: center;
			margin-bottom: 20px;
		}
		input[type="file"] {
			width: 100%;
			padding: 8px;
			margin: 12px 0;
			border: 1px solid #ccc;
			border-radius: 6px;
		}
		.button-wrapper {
			text-align: center;
		}
		button {
			background-color: #4CAF50;
			color: white;
			padding: 10px 20px;
			border: none;
			border-radius: 6px;
			cursor: pointer;
			font-size: 16px;
		}
		button:hover {
			background-color: #45a049;
		}
		.msg {
			color: red;
			text-align: center;
			margin-bottom: 10px;
		}
	</style>
</head>
<body>
	<%
		if(request.getParameter("msg") != null){ // insertImageAction에서 png파일이 아니여서 redirect로 넘어왔을때
	%>
		<div><%=request.getParameter("msg")%></div>
	<%	
		}
	%>
	<form action="/cashbook/cash/uploadCashReceiptAction.jsp" method="post" enctype="multipart/form-data">
	<div>
		파일: <input type="file" name="imageFile">
			<input type="hidden" name="cash_no" value="<%=Integer.parseInt(request.getParameter("cash_no"))%>">
			<input type="hidden" name="fullDate" value="<%=request.getParameter("fullDate")%>">
			<% 
				System.out.println("fullDate.ReceiptForm : "+ fullDate);
				System.out.println("cash_no.ReceiptForm : "+ cash_no);
			%>	
		</div>
			<button type="submit">업로드</button>
	</form>
</body>
</html>
