<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import= "model.*" %>
<%@ page import= "dto.*" %>
<%
	String id = request.getParameter("id");
	String prePw = request.getParameter("prePw");
	String newPw = request.getParameter("newPw");
	
	AdminDao adminDao = new AdminDao();
	
	Admin admin = adminDao.updateAdminPw(id, prePw, newPw);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정 결과</title>
<script type="text/javascript">
    // 페이지가 자동으로 리다이렉트되도록 하기 위한 함수
    function redirectToPage(url) {
        setTimeout(function() {
            window.location.href = url;
        }, 2000); // 2초 후에 페이지 리다이렉트
    }
</script>
<style>
    body {
        font-family: Arial, sans-serif;
        text-align: center;
        background-color: #f0f0f0;
        padding: 50px;
    }

    h2 {
        color: #333;
        font-size: 1.5em;
    }

    .message-success {
        color: green;
    }

    .message-fail {
        color: red;
    }

    .redirect-info {
        font-size: 1.1em;
        color: #555;
    }
</style>
</head>
<body>
<%
    if (admin != null) {
%>
        <h2 class="message-success">비밀번호 변경 완료</h2>
        <p class="redirect-info">2초 후, 메인 페이지로 이동합니다...</p>
        <script type="text/javascript">
            redirectToPage("/cashbook/index.jsp"); // 성공 시 index.jsp로 리다이렉트
        </script>
<%
    } else {
%>
        <h2 class="message-fail">비밀번호 변경 실패! 사용자 정보를 확인해주세요.</h2>
        <p class="redirect-info">2초 후, 로그인 페이지로 이동합니다...</p>
        <script type="text/javascript">
            redirectToPage("/cashbook/loginForm.jsp"); // 실패 시 loginForm.jsp로 리다이렉트
        </script>
<%
    }
%>
</body>
</html>
