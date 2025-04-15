<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
    Calendar firstDate = Calendar.getInstance();

    String targetYear = request.getParameter("targetYear");
    String targetMonth = request.getParameter("targetMonth");
/*
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String todayDate = sdf.format(Calendar.getInstance().getTime());
    System.out.println("todayDate : " +todayDate);
*/    

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
    
    Cash cash = new Cash();
    CashDao cashDao = new CashDao();

   	ArrayList<Cash> list = cashDao.selectCashListByMonth(targetYear, targetMonth);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 가계부</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #eef2f7;
        margin: 0;
        padding: 20px;
        color: #333;
    }

    h1 {
        text-align: center;
        font-size: 2.5em;
        color: #2c3e50;
        margin-bottom: 10px;
    }

    h2 {
        text-align: center;
        font-size: 1.3em;
        color: #555;
        margin-bottom: 30px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
        border-radius: 12px;
        overflow: hidden;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    th, td {
        width: 14.28%;
        height: 100px;
        border: 1px solid #ddd;
        vertical-align: top;
        padding: 8px;
        background-color: #fdfdfd;
        position: relative;
    }

    th {
        background-color: #4CAF50;
        color: white;
        font-weight: bold;
        font-size: 1em;
        text-align: center;
    }

    td a {
        font-weight: bold;
        font-size: 0.95em;
        text-decoration: none;
        color: #2c3e50;
    }

    td a:hover {
        color: #007bff;
    }

    td div {
        font-size: 0.8em;
        margin-top: 4px;
    }

    p {
        text-align: center;
        margin-top: 30px;
    }

    a {
        text-decoration: none;
        color: #3498db;
        font-weight: bold;
    }

    a:hover {
        color: #1d6fa5;
    }
    td:hover {
    background-color: #f0f0f0; /* 연한 회색 */
    cursor: pointer;
}
</style>
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
    for (int c = 1; c <= totalCell; c++) {
        if (c - startBlank < 1 || c - startBlank > lastDate) {
%>
        <td>&nbsp;</td>
<%
        } else {
            int day = c - startBlank;
            String formattedMonth = String.format("%02d", Integer.parseInt(targetMonth) + 1); // 0~11 → 01~12
            String formattedDay = String.format("%02d", day);
            String fullDate = targetYear + "-" + formattedMonth + "-" + formattedDay;

            // 날짜에 해당하는 cash 내역 출력
            ArrayList<Cash> dayCashList = new ArrayList<>();
            for (Cash cs : list) {
                if (cs.getCash_date().equals(fullDate)) {
                    dayCashList.add(cs);
                }
            }
%>
        <td valign="top">
            <a href="/cashbook/cash/cashByDate.jsp?fullDate=<%=fullDate%>">
                <strong><%= day %></strong>
            </a><br>
<%
            for (Cash cs : dayCashList) {
%>
            <div style="font-size: 10px; color: <%= cs.getColor() %>;">
                <%= cs.getMemo() %> (<%= cs.getAmount() %>)
            </div>
<%
            }
%>
        </td>
<%
        }
        if (c % 7 == 0) {
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

<p><a href="/cashbook/index.jsp">🏠 Index 페이지로 이동</a></p>

</body>
</html>
