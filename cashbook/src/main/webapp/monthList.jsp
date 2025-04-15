<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
		// 세션에 admin 아이디가 없으면 로그인 페이지로
	}
	
    Calendar firstDate = Calendar.getInstance();
    // 현재 날짜에 대한 정보
	
    String targetYear = request.getParameter("targetYear");
    String targetMonth = request.getParameter("targetMonth");
    if(targetMonth == null || targetYear == null){
        targetYear = String.valueOf(firstDate.get(Calendar.YEAR));
        targetMonth = String.valueOf(firstDate.get(Calendar.MONTH));
    }
    // 년 월을 지정하지 않았으면 현재 년, 월을 받아온다.

    firstDate.set(Calendar.YEAR, Integer.parseInt(targetYear));
    firstDate.set(Calendar.MONTH, Integer.parseInt(targetMonth));
    firstDate.set(Calendar.DATE, 1);
    // firstDate를 Calendar에서 현재 기준 년, 월을 받고 1일을 기준으로 맞춘다.

    int lastDate = firstDate.getActualMaximum(Calendar.DATE); // lastDate는 현재 월 기준 마지막 날짜 (ex 3.31)
    int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);	 // 1일이 무슨 요일인지 확인 일요일(1) ~ 토요일 (7)
    int startBlank = dayOfWeek - 1; 						// 해당 달이 무슨 요일에 시작하는지에 따른 빈칸 계산 토요일 시작이면 빈칸은 6개
    int endBlank = 0;
    
    int totalCell = startBlank + lastDate + endBlank;		// 달력에 필요한 총 셀 개수 구하기
    if(totalCell % 7 != 0){
        endBlank = 7 - (totalCell % 7); // 마지막 주의 빈칸을 계산
        totalCell = startBlank + lastDate + endBlank;
    }
    // 달력의 총 칸수 = 첫주의 빈칸 + 월의 마지막 날짜 + 마지막 주의 빈칸

    int nextMonth = Integer.parseInt(targetMonth);
    int nextYear = Integer.parseInt(targetYear);
    if(nextMonth == 11) { // month의 값이 11(12월)이면 다음달은 0(1월), 년도 1년 증가
        nextMonth = 0;
        nextYear++;
    } else {			// 값이 11이 아니면 월만 + 1
        nextMonth++;
    }

    int prevMonth = Integer.parseInt(targetMonth);
    int prevYear = Integer.parseInt(targetYear);
    if(prevMonth == 0) { // month의 값이 0(1월)이면 이전 달은 11(12월), 년도 1년 감소
        prevMonth = 11;
        prevYear--;
    } else {			// 값이 0이 아니면 월만 -1
        prevMonth--; 
    }

    
    String[] monthNames = { "1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월" };
    String currentMonthLabel = monthNames[Integer.parseInt(targetMonth)];
    // 월을 배열로 받아서 선택한 월을 출력
    
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
    for (int c = 1; c <= totalCell; c++) { // 달력의 실제 칸 개수를 구하고
        if (c - startBlank < 1 || c - startBlank > lastDate) { // 첫주와 마지막 주의 공백을 계산하는 방법(공백 셀 계산)
        	// 셀 - 첫주의 공백이 1보다 작다 || 셀 - 첫주의 공백이 마지막 날보다 크다 >> 빈 칸으로 입력
%>
        <td>&nbsp;</td>
<%
        } else { // 실제 날자 셀 계산
            int day = c - startBlank; // 시작일자
    		// c-startBlank 로 첫 날짜 구하기
            String formattedMonth = String.format("%02d", Integer.parseInt(targetMonth) + 1); // targetMonth의 값이 0~11 이니 + 1 해서 → 01~12
            String formattedDay = String.format("%02d", day); 
            // String.format("%02d", ...) > 2자리수 만들어주는 방법 01,02 등등..
            String fullDate = targetYear + "-" + formattedMonth + "-" + formattedDay;
            // fullDate = 0000-00-00

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
