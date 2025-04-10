<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Calendar" %>
<%
    // 세션에서 adminId를 가져옵니다. 로그인 상태인지 확인하기 위한 변수입니다.
    String id = (String) session.getAttribute("adminId");

    // 만약 adminId가 null이면 로그인되지 않은 상태이므로 로그인 페이지로 리디렉션합니다.
    if(id == null) { 
        response.sendRedirect("/cashbook/loginForm.jsp"); // 로그인 페이지로 리디렉션
        return; // 이후 코드를 실행하지 않도록 종료
    }

    // 첫 번째 날을 설정 (현재 달의 첫 번째 날)
    Calendar firstDate = Calendar.getInstance(); // 현재 날짜를 기준으로 Calendar 객체 생성
    firstDate.set(Calendar.DATE, 1); // 날짜를 1일로 설정하여 첫 번째 날로 변경

    // 요청 파라미터로 'targetYear'와 'targetMonth'를 가져옵니다. 월과 년을 선택할 수 있도록 합니다.
    String targetYear = request.getParameter("targetYear");
    String targetMonth = request.getParameter("targetMonth");

    // 만약 targetMonth가 null이 아니라면, 해당 월을 설정합니다.
    if(targetMonth != null){
        firstDate.set(Calendar.MONTH, Integer.parseInt(targetMonth)); // 선택한 월을 설정
    }

    // 해당 월의 마지막 날짜를 계산합니다.
    int lastDate = firstDate.getActualMaximum(Calendar.DATE); // 해당 월의 마지막 날짜를 구함
    System.out.println("lastDate : "+lastDate); // 마지막 날짜 출력 (디버깅용)

    // 첫 번째 날의 요일을 구합니다. (일요일=1, 월요일=2, ... 토요일=7)
    int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);

    // 첫 번째 날이 속한 주의 공백 셀을 계산합니다.
    int startBlank = dayOfWeek - 1; // 첫 번째 날이 속한 주의 공백 날짜 (예: 월요일이면 1, 일요일이면 0)

    // 마지막 날 이후의 공백 셀 (일주일을 채우기 위해)
    int endBlank = 0;

    // 전체 셀 수를 계산합니다. (빈 셀 + 실제 날짜 + 마지막 빈 셀)
    int totalCell = startBlank + lastDate + endBlank;

    // 만약 totalCell이 7의 배수가 아니면, 마지막 빈 셀을 추가하여 7의 배수가 되도록 합니다.
    if(totalCell % 7 != 0){
        endBlank = 7 - (totalCell % 7); // 마지막 빈 셀을 계산
        totalCell = startBlank + lastDate + endBlank; // 총 셀 수를 다시 계산
    }

    // 디버깅용으로 계산된 값 출력
    System.out.println("startBlank : "+startBlank); // 첫 번째 날의 공백 셀 수 출력
    System.out.println("endBlank : "+endBlank); // 마지막 날의 공백 셀 수 출력
    System.out.println("totalCell : "+totalCell); // 전체 셀 수 출력

    int date = 0; // 날짜를 저장하는 변수 (실제로 사용되지 않음)
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>월별 가계부</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f5f5f5; /* 부드러운 회색 배경 */
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

    /* 날짜 테이블 스타일 */
    table {
        width: 100%;
        margin: 0 auto;
        border-collapse: collapse;
        background-color: #fff;
        position: relative; /* 버튼을 우측 하단에 고정할 때 필요 */
    }

    th, td {
        width: 14.28%; /* 7개 열을 균등하게 분배 */
        padding: 40px 0;
        text-align: center;
        border: 1px solid #ddd;
        position: relative; /* 날짜를 상단 우측으로 배치할 때 필수 */
    }

    th {
        background-color: #4CAF50; /* 그린 색상 */
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
        background-color: #f0f0f0; /* 공백 셀 배경 색상 */
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
        position: relative; /* 버튼을 이 컨테이너에 고정할 때 필요 */
        padding-bottom: 80px; /* 버튼이 겹치지 않도록 충분한 공간을 남깁니다. */
    }

    /* Index 링크 버튼 스타일 */
    .index-link {
        position: absolute;
        right: 0; /* 오른쪽에 배치 */
        bottom: 10px; /* 아래쪽에 배치 */
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
</style>
</head>
<body>
<h1>월별 가계부</h1>

<!-- 날짜 테이블을 우측 상단에 고정 -->
<div class="table-container">
    <table>
    <tr> <!-- 테이블의 첫 번째 행 (요일 제목) -->
        <th class="sunday">일</th> <!-- 일요일은 빨간색 -->
        <th>월</th>
        <th>화</th>
        <th>수</th>
        <th>목</th>
        <th>금</th>
        <th class="saturday">토</th> <!-- 토요일은 파란색 -->
    </tr>
    <tr> <!-- 날짜를 표시하는 테이블의 두 번째 행 시작 -->
        <%
                // 총 셀 수만큼 반복하면서 날짜를 채운다.
                for(int c = 1; c <= totalCell; c++) {
                    // 현재 날짜가 첫 번째 날 이전이거나 마지막 날짜 이후인 경우 공백을 출력
                    if(c - startBlank < 1 || c - startBlank > lastDate) {
            %>
                        <td class="empty">&nbsp;</td> <!-- 공백 -->
            <%		
                    } else {
                        // 날짜가 일요일이면 빨간색, 토요일이면 파란색, 나머지 요일은 기본 색상
                        int currentDayOfWeek = (c - startBlank + dayOfWeek - 1) % 7; // 현재 날짜의 요일 계산
                        
                        // 요일에 따라 색깔을 다르게 지정
                        if(currentDayOfWeek == 1) { // 일요일
            %>
                            <td class="sunday">
                                <div class="day-number"><%= c - startBlank %></div>
                            </td>
            <%  
                        } else if(currentDayOfWeek == 0) { // 토요일
            %>
                            <td class="saturday">
                                <div class="day-number"><%= c - startBlank %></div>
                            </td>
            <%  
                        } else { // 월~금은 기본 색상
            %>
                            <td>
                                <div class="day-number"><%= c - startBlank %></div>
                            </td>
            <%  
                        }
                    }
                    
                    // 7개의 셀을 다 채운 후, 새로운 행을 시작
                    if(c % 7 == 0) {
            %>
                        </tr><tr>
            <%			
                    }
                }
            %>
    </tr>
    </table>

    <!-- index.jsp로 가는 링크 추가 -->
    <a href="/cashbook/index.jsp" class="index-link">Index 페이지로 이동</a>
</div>

</body>
</html>
