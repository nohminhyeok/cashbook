<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%
    int no = Integer.parseInt(request.getParameter("no"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리 삭제</title>
<script type="text/javascript">
    function confirmDelete() {
        // 사용자에게 삭제 여부를 확인하는 경고창 띄우기
        var result = confirm("정말로 삭제하시겠습니까?");
        if (result) {
            // 삭제 확인시, 해당 페이지로 POST 요청을 보내 삭제 진행
            window.location.href = "/cashbook/deleteCategoryAction.jsp?no=<%= no %>";
        } else {
            // 취소시, 목록 페이지로 리다이렉트
            window.location.href = "/cashbook/categoryList.jsp";
        }
    }
</script>
</head>
<body onload="confirmDelete()">
    <!-- 삭제 확인 창 띄우는 함수가 onload 이벤트로 실행되므로 아무 내용이 표시되지 않음 -->
</body>
</html>
