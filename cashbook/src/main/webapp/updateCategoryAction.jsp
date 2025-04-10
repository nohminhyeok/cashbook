<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String kind = request.getParameter("kind");
	String title = request.getParameter("title");
	int category_no = Integer.parseInt(request.getParameter("no"));
	
	System.out.println("no : "+category_no);
	Category category = new Category();
	CategoryDao categoryDao = new CategoryDao();
	
	category = categoryDao.updateCategory(category_no, kind, title);
	
	response.sendRedirect("/cashbook/categoryList.jsp");
%>