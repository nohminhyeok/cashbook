<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*"%>
<%
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	Cash cash = new Cash();
	CashDao cashDao = new CashDao();
	cashDao.deleteCash(cash_no);
	
	response.sendRedirect("/cashbook/monthList.jsp");
%>