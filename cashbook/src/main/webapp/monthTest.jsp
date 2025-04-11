<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Calendar" %>	
<%
    String id = (String) session.getAttribute("adminId");
    if(id == null) { 
        response.sendRedirect("/cashbook/loginForm.jsp");
        return;
    }

    Calendar firstDate = Calendar.getInstance();

    String targetYear = request.getParameter("targetYear");
    String targetMonth = request.getParameter("targetMonth");

    if(targetMonth == null || targetYear == null){
        targetYear = String.valueOf(firstDate.get(Calendar.YEAR));
        targetMonth = String.valueOf(firstDate.get(Calendar.MONTH));
    }

    firstDate.set(Calendar.YEAR, Integer.parseInt(targetYear));
    firstDate.set(Calendar.MONTH, Integer.parseInt(targetMonth));
    firstDate.set(Calendar.DATE, 1);

    int lastDate = firstDate.getActualMaximum(Calendar.DATE);
    int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
    int startBlank = dayOfWeek - 1;
    int endBlank = 0;
    int totalCell = startBlank + lastDate + endBlank;

    if(totalCell % 7 != 0){
        endBlank = 7 - (totalCell % 7);
        totalCell = startBlank + lastDate + endBlank;
    }

    int nextMonth = Integer.parseInt(targetMonth);
    int nextYear = Integer.parseInt(targetYear);
    if(nextMonth == 11) {
        nextMonth = 0;
        nextYear++;
    } else {
        nextMonth++;
    }

    int prevMonth = Integer.parseInt(targetMonth);
    int prevYear = Integer.parseInt(targetYear);
    if(prevMonth == 0) {
        prevMonth = 11;
        prevYear--;
    } else {
        prevMonth--;
    }

    String[] monthNames = { "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" };
    String currentMonthLabel = monthNames[Integer.parseInt(targetMonth)];
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 가계부</title>
</head>
<body>
<h1>월별 가계부</h1>

<h2><%= targetYear %>년 <%= currentMonthLabel %></h2>

<table border="1">
    <tr>
        <th>일</th>
        <th>월</th>
        <th>화</th>
        <th>수</th>
        <th>목</th>
        <th>금</th>
        <th>토</th>
    </tr>
    <tr>
        <%
            for(int c = 1; c <= totalCell; c++) {
                if(c - startBlank < 1 || c - startBlank > lastDate) {
        %>
                    <td>&nbsp;</td>
        <%
                } else {
        %>
                    <td>
                    	<a href="/cashbook/cashOne.jsp">
                    		<%= c - startBlank %>
                    	</a>
                    </td>
        <%
                }
                if(c % 7 == 0) {
        %>
    </tr><tr>
        <%
                }
            }
        %>
    </tr>
</table>

<p>
    <a href="?targetYear=<%= prevYear %>&targetMonth=<%= prevMonth %>">이전 달</a> |
    <a href="?targetYear=<%= nextYear %>&targetMonth=<%= nextMonth %>">다음 달</a>
</p>

<p><a href="/cashbook/index.jsp">Index 페이지로 이동</a></p>

</body>
</html>
