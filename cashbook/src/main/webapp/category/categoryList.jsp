<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%	
	String id = (String) session.getAttribute("adminId");
	
	if(id == null) { // 로그인 상태가 아니면
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	    // 로그인 상태가 아니면 로그인페이지로
	}

	String searchWord = request.getParameter("searchWord");
	if(searchWord == null) {
		searchWord = "";
		// 검색단어가 없다면 공백처리
	}
	System.out.println("searchWord : "+searchWord);

	int currentPage = 1; // 현재 페이지 기본값 설정 1
	if(request.getParameter("currentPage") != null){
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		// 사용자가 요청한 페이지 출력
	}
	// request -> http 요청 객체

	Category category = new Category();
	CategoryDao categoryDao = new CategoryDao();

	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(5);
	int rowPerPage = p.getRowPerPage();
	int totalCnt = categoryDao.totalCountCategory(searchWord);
	// 전체 카테고리의 수(검색 단어에 따라)
	int lastPage = totalCnt / rowPerPage;
	// 마지막 페이지는 총 카테고리 수 / 출력할 행
	if(totalCnt % rowPerPage != 0) {
		lastPage = lastPage + 1;
	}

	ArrayList<Category> list = categoryDao.selectCategory(p,searchWord);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 관리</title>
<style>
    body {
        background-color: #eef2f7;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        color: #2c3e50;
        margin: 0;
        padding: 0;
    }

    .top-right {
        position: absolute;
        top: 20px;
        right: 30px;
    }

    .top-right a {
        font-size: 1em;
        padding: 8px 16px;
        border: 2px solid #4CAF50;
        border-radius: 5px;
        text-decoration: none;
        color: #4CAF50;
        background-color: #fff;
        transition: 0.3s;
    }

    .top-right a:hover {
        background-color: #4CAF50;
        color: white;
    }

    h1 {
        font-size: 2.5em;
        margin-top: 60px;
        font-weight: bold;
        text-align: center;
        color: #34495e;
    }

    table {
        width: 90%;
        margin: 30px auto;
        border-collapse: collapse;
        background-color: #fff;
        border-radius: 8px;
        overflow: hidden;
        box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }

    th, td {
        padding: 14px 18px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #4CAF50;
        color: white;
        font-size: 1em;
    }

    tr:nth-child(even) {
        background-color: #f8f8f8;
    }

    tr:hover {
        background-color: #e0f7df;
    }

    a {
        text-decoration: none;
        font-weight: 500;
    }

    .pagination, .form-container, .insert-link {
        text-align: center;
        margin-top: 25px;
    }

    .pagination a,
    .insert-link a,
    .form-container button {
        margin: 0 5px;
        padding: 10px 18px;
        font-size: 1em;
        border-radius: 5px;
        border: 2px solid #4CAF50;
        background-color: white;
        color: #4CAF50;
        transition: 0.3s;
        text-decoration: none;
    }

    .pagination a:hover,
    .insert-link a:hover,
    .form-container button:hover {
        background-color: #4CAF50;
        color: white;
    }

    .form-container input[type="text"] {
        padding: 10px;
        width: 250px;
        font-size: 1em;
        border: 1px solid #ccc;
        border-radius: 5px;
        margin-right: 8px;
    }
</style>
</head>
<body>
	<div class="top-right">
		<a href="/cashbook/index.jsp">🏠 Index 페이지로 이동</a>
	</div>

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
				<td style="color:<%= c.getKind().equals("수입") ? "blue" : "red" %>; font-weight: bold;">
					<%= c.getKind() %>
				</td>
				<td><%=c.getTitle()%></td>
				<td><%=c.getCreatedate()%></td>
				<td><a href="/cashbook/category/updateCategoryForm.jsp?no=<%=c.getCategory_no()%>">수정</a></td>
				<td><a href="/cashbook/category/deleteCategoryForm.jsp?no=<%=c.getCategory_no()%>">삭제</a></td>
			</tr>
		<%
			}
		%>				
	</table>
	<div class="insert-link">
		<a href="/cashbook/category/insertCategoryForm.jsp">작성하기</a>
	</div>

	<div class="form-container">
		<form action="/cashbook/category/categoryList.jsp" method="get">
			<input type="text" name="searchWord" value="<%=searchWord%>" placeholder="검색어 입력"> 
			<button type="submit">검색</button>
		</form>
	</div>

	<div class="pagination">
    <%
        // 처음 & 이전 페이지 링크는 currentPage > 1 일 때만 출력
        if(currentPage > 1) {
    %>
        <a href="/cashbook/category/categoryList.jsp?currentPage=1&searchWord=<%=searchWord%>">처음</a>
        <a href="/cashbook/category/categoryList.jsp?currentPage=<%=currentPage - 1%>&searchWord=<%=searchWord%>">이전</a>
    <%
        }

        // 다음 & 마지막 페이지 링크는 currentPage < lastPage 일 때만 출력
        if(currentPage < lastPage) {
    %>
        <a href="/cashbook/category/categoryList.jsp?currentPage=<%=currentPage + 1%>&searchWord=<%=searchWord%>">다음</a>
        <a href="/cashbook/category/categoryList.jsp?currentPage=<%=lastPage%>&searchWord=<%=searchWord%>">마지막</a>
    <%
        }
    %>
	</div>
</body>
</html>
