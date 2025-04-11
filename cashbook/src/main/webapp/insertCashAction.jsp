<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%
	int category_no = Integer.parseInt(request.getParameter("category_no"));
	String cash_date = request.getParameter("fullDate");
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	int amount = Integer.parseInt(request.getParameter("amount"));
	
	Cash c = new Cash();
	c.setCash_date(cash_date);
	c.setCategory_no(category_no);
	c.setAmount(amount);
	c.setMemo(memo);
	c.setColor(color);
	
	CashDao cashDao = new CashDao();
	cashDao.insertCash(c);
	
	response.sendRedirect("/cashbook/monthList.jsp");
%>