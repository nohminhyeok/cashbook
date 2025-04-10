<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
    request.setCharacterEncoding("UTF-8");

    String kind = request.getParameter("kind");
    String title = request.getParameter("title");

    CategoryDao categoryDao = new CategoryDao();

    if (categoryDao.isDuplicateCategory(kind, title)) {
        // 중복이면 경고창 띄우고 다시 작성 폼으로
%>
        <script>
            alert("같은 분류와 제목의 카테고리가 이미 존재합니다.");
            history.back();
        </script>
<% 
    } else {
        Category category = new Category();
        category.setKind(kind);
        category.setTitle(title);

        categoryDao.insertCategory(category);
        response.sendRedirect("/cashbook/categoryList.jsp");
    }
%>