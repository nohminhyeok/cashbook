<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%
	String cash_date = request.getParameter("cash_date");
	int amount = Integer.parseInt(request.getParameter("amount"));
	String memo = request.getParameter("memo");
	String color = request.getParameter("color");
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	
	Cash cash = new Cash();
	CashDao cashDao = new CashDao();

	cash = cashDao.updateCash(cash_date, amount, memo, color, cash_no);
	
	response.sendRedirect("/cashbook/monthList.jsp");
%>