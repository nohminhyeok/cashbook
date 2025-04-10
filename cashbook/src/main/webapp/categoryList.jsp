<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%	
	String id = (String) session.getAttribute("adminId");
	
	if(id == null) { // 로그인 상태가 아니면
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	}

	
	String searchWord = request.getParameter("searchWord");
	if(searchWord == null) {
		searchWord = "";
	}
	System.out.println("searchWord : "+searchWord);
	
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}

	
	Category category = new Category();
	CategoryDao categoryDao = new CategoryDao();

	
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(5);
	int rowPerPage = p.getRowPerPage();
	int totalCnt = categoryDao.totalCountCategory(searchWord);
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}

	
	categoryDao.totalCountCategory(searchWord);
	ArrayList<Category> list = categoryDao.selectCategory(p,searchWord);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<style>
    /* 기본 페이지 스타일 */
    body {
        background-color: #f5f5f5; /* 부드러운 회색 배경 */
        font-family: 'Arial', sans-serif;
        color: #333;
        margin: 0;
        padding: 0;
    }

	h1 {
	    color: #444;
	    font-size: 2.5em;
	    margin-top: 50px;
	    font-weight: 600;
	    text-align: center; /* 제목을 수평으로 중앙 정렬 */
	}

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        background-color: #ffffff;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 15px;
        text-align: center;
    }

    th {
        background-color: #4CAF50; /* 그린 색상 */
        color: white;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #e0e0e0;
    }

    a {
        text-decoration: none;
        font-size: 1.2em;
        color: #4CAF50; /* 그린 색상 */
        padding: 10px 20px;
        border-radius: 5px;
        background-color: #ffffff;
        border: 2px solid #4CAF50;
        transition: all 0.3s;
    }

    a:hover {
        background-color: #4CAF50;
        color: white;
        border-color: #4CAF50;
    }

    .pagination {
        text-align: center;
        margin-top: 20px;
    }

    .pagination a {
        margin: 0 5px;
        padding: 10px 20px;
        border-radius: 5px;
        border: 2px solid #4CAF50;
        color: #4CAF50;
        font-size: 1.1em;
        text-decoration: none;
    }

    .pagination a:hover {
        background-color: #4CAF50;
        color: white;
    }

    .form-container {
        text-align: center;
        margin-top: 20px;
    }

    .form-container input {
        padding: 10px;
        font-size: 1em;
        border-radius: 5px;
        border: 1px solid #ccc;
        margin-right: 10px;
    }

    .form-container button {
        padding: 10px 20px;
        font-size: 1.1em;
        border-radius: 5px;
        border: 2px solid #4CAF50;
        background-color: #4CAF50;
        color: white;
        cursor: pointer;
        transition: all 0.3s;
    }

    .form-container button:hover {
        background-color: #45a049;
        border-color: #45a049;
    }

    .insert-link {
        margin-top: 20px;
        text-align: center;
    }
</style>
</head>
<body>
	<h1>카테고리 관리</h1>
	<table>
		<tr>
			<th>번호</th>
			<th>분류</th>
			<th>제목</th>
			<th>생성일자</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(Category c : list){
		%>
			<tr>
				<td><%=c.getCategory_no()%></td>
				<td style="color:<%= c.getKind().equals("수입") ? "red" : "blue" %>; font-weight: bold;">
					<%= c.getKind() %>
				</td>
				<td><%=c.getTitle()%></td>
				<td><%=c.getCreatedate()%></td>
				<td><a href="/cashbook/updateCategoryForm.jsp?no=<%=c.getCategory_no()%>">수정</a></td>
				<td><a href="/cashbook/deleteCategoryForm.jsp?no=<%=c.getCategory_no()%>">삭제</a></td>
			</tr>
		<%
			}
		%>				
	</table>
	<div class="insert-link">
		<a href="/cashbook/insertCategoryForm.jsp">작성하기</a>
	</div>

	<div class="form-container">
		<form action="/cashbook/categoryList.jsp" method="get">
			<input type="text" name="searchWord" value="<%=searchWord%>" placeholder="검색어 입력"> 
			<button type="submit">검색</button>
		</form>
	</div>

	<div class="pagination">
		<%
			if(currentPage > 1) {
		%>
			<a href="/cashbook/categoryList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음</a>
		<%
			} 
		%>
		<a href="/cashbook/categoryList.jsp?currentPage=<%=currentPage-1%>&searchWord=<%=searchWord%>">이전</a>
		<a href="/cashbook/categoryList.jsp?currentPage=<%=currentPage+1%>&searchWord=<%=searchWord%>">다음</a>
		<%
			if(currentPage < lastPage) {
		%>
			<a href="/cashbook/categoryList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>
		<%
			}
		%>
	</div>
</body>
</html>
