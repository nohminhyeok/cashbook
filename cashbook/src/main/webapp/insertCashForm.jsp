<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	// dateList.jsp -> 수입/지출 입력(String cashDate날짜 값 전달) -> 
	String cashDate = request.getParameter("cashDate");
	cashDate ="2025-04-11";
	// insertCashForm.jsp -> kind 선택(String kind)
	String kind = request.getParameter("kind");
	ArrayList<Category> list = null;
	if(kind != null) { // insertCashForm.jsp에서 kind 선택 후 재요청
		// DB : 선택된 kind의 title 목록
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListBykind(kind);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>수입/지출 선택</h1>
	<form method="post" action="/cashbook/insertCashForm.jsp">
		<input type="hidden" name="cashDate" value="<%=cashDate%>">
		kind
		<select name="kind">
			<option value="">:::선택:::</option>
			<option value="수입">수입</option> <!-- 옵션 뒤에 values값을 생략하면 스트링 값이 value값됨 -->
			<option value="지출">지출</option>
		</select>
		<button type="submit">수입/지출 선택</button>
	</form>
	
	<hr>
	
	<h1>CASH이력 추가</h1>
	<form method="post" action="/cashbook/insertCashForm.jsp">
		cashDate : <input type="text" name="cashDate" value="<%=cashDate%>" readonly><br>
		category :
		<select name="category_no">
			<%	
				if(list != null){
				
					for(Category c : list){
					
			%>
				<option value="<%=c.getCategory_no()%>"><%=c.getTitle()%>>title</option>
			<%
				}
			}
			%>
		</select>
		<button type="submit">수입/지출 입력</button>
	</form>
</body>
</html>