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
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f5f5f5;
        color: #333;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: #444;
        font-size: 2.5em;
        margin-top: 50px;
    }

    table {
        width: 100%;
        margin: 0 auto;
        border-collapse: collapse;
        background-color: #fff;
        position: relative;
    }

    th, td {
        width: 14.28%;
        padding: 40px 0;
        text-align: center;
        border: 1px solid #ddd;
        position: relative;
    }

    th {
        background-color: #4CAF50;
        color: white;
    }

    td {
        background-color: #fff;
    }

    td:hover {
        background-color: #f0f0f0;
    }

    .sunday {
        color: red;
    }

    .saturday {
        color: blue;
    }

    .empty {
        background-color: #f0f0f0;
    }

    .day-number {
        position: absolute;
        top: 5px;
        left: 5px;
        font-size: 20px;
        font-weight: bold;
    }

    .table-container {
        max-width: 90%;
        margin: 0 auto;
        position: relative;
        padding-bottom: 120px;
    }

    .index-link {
        position: absolute;
        right: 0;
        bottom: 10px;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 1.2em;
        transition: background-color 0.3s;
        text-align: center;
    }

    .index-link:hover {
        background-color: #45a049;
    }

    .month-btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 1.2em;
        transition: background-color 0.3s;
        margin-top: 20px;
        text-align: center;
    }

    .month-btn:hover {
        background-color: #45a049;
    }
</style>
</head>
<body>
<h1>월별 가계부</h1>

<h2 style="text-align:center;">
    <%= targetYear %>년 <%= currentMonthLabel %>
</h2>

<div class="table-container">
    <table>
    <tr>
        <th class="sunday">일</th>
        <th>월</th>
        <th>화</th>
        <th>수</th>
        <th>목</th>
        <th>금</th>
        <th class="saturday">토</th>
    </tr>
    <tr>
        <%
            for(int c = 1; c <= totalCell; c++) {
                if(c - startBlank < 1 || c - startBlank > lastDate) {
        %>
                    <td class="empty">&nbsp;</td>
        <%
                } else {
                    int currentDayOfWeek = (c - startBlank + dayOfWeek - 1) % 7;
                    if(currentDayOfWeek == 1) {
        %>
                        <td class="sunday">
                            <div class="day-number"><%= c - startBlank %></div>
                        </td>
        <%  
                    } else if(currentDayOfWeek == 0) {
        %>
                        <td class="saturday">
                            <div class="day-number"><%= c - startBlank %></div>
                        </td>
        <%  
                    } else {
        %>
                        <td>
                            <div class="day-number"><%= c - startBlank %></div>
                        </td>
        <%  
                    }
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

    <a href="?targetYear=<%= prevYear %>&targetMonth=<%= prevMonth %>" class="month-btn">이전 달</a>
    <a href="?targetYear=<%= nextYear %>&targetMonth=<%= nextMonth %>" class="month-btn">다음 달</a>
    <a href="/cashbook/index.jsp" class="index-link">Index 페이지로 이동</a>
</div>
</body>
</html>
