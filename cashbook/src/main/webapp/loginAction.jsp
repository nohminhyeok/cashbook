<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "model.*" %>
<%@ page import= "dto.*" %>
<%
	String id = request.getParameter("id");
	System.out.println("id : "+id);
	String pw = request.getParameter("pw");
	System.out.println("pw : "+pw);
	
	Admin admin = new Admin();
	AdminDao adminDao = new AdminDao();
	admin = adminDao.selectAdmin(id, pw);
	
    int loginResult = adminDao.loginck(id, pw, session);

    if (loginResult == 1) { 
        // 로그인 성공
        response.sendRedirect("/cashbook/index.jsp");
    } else { 
        // 로그인 실패
        response.sendRedirect("/cashbook/loginForm.jsp");
    }
%>
	