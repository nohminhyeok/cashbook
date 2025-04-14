<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%
	int no = Integer.parseInt(request.getParameter("no"));
	Category category = new Category();
	CategoryDao categoryDao = new CategoryDao();
	categoryDao.deleteCategory(no);
	
	response.sendRedirect("/cashbook/category/categoryList.jsp");
%>