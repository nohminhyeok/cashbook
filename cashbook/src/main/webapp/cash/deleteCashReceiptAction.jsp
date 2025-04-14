<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import = "java.io.*" %>
<%
	String filename = request.getParameter("filename");
	System.out.println("filename.deleteAction : "+ filename);
	String fullDate = request.getParameter("fullDate");
	System.out.println("fullDate.deleteForm : "+fullDate);
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	System.out.println("cash_no.deleteAction : "+ cash_no);
	
	ReceiptDao recDao = new ReceiptDao();
	recDao.deleteReceipt(cash_no);
	
	String path = request.getServletContext().getRealPath("upload");
	File file = new File(path, filename); // new File 경로에 파일이 없으면 빈파일을 생성
	
	// int row = 1이면 삭제
	if(file.exists()){ // 빈 파일이 아니라면
		file.delete(); // 삭제
	}
	
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cash_no=" + cash_no + "&fullDate=" + fullDate);
%>