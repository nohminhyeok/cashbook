<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String fullDate = request.getParameter("fullDate");
	if (fullDate == null || fullDate.isEmpty()) {
	    response.sendRedirect("/cashbook/monthCash.jsp");
	    return;
	}
	Cash cash = new Cash();
	CashDao cashDao = new CashDao();
	System.out.println("cashByDate.fullDate : " + fullDate);

	ArrayList<Cash> list = cashDao.selectCashByDay(fullDate);

	CategoryDao categoryDao = new CategoryDao();
	ArrayList<Category> categoryList = categoryDao.selectCategoryList();
	HashMap<Integer, String> categoryMap = new HashMap<>();

	for (Category cat : categoryList) {
	    categoryMap.put(cat.getCategory_no(), cat.getKind() + " - " + cat.getTitle());
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지출 상세페이지</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #eef1f5;
        color: #333;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        font-size: 2.8em;
        margin-top: 40px;
    }

    .button-link, button {
        display: block;
        margin: 30px auto;
        padding: 12px 24px;
        font-size: 1.1em;
        background-color: #3498db;
        color: white;
        border: none;
        border-radius: 6px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        transition: background-color 0.3s ease;
        width: fit-content;
    }

    .button-link:hover,
    button:hover {
        background-color: #2980b9;
    }

    table {
        width: 90%;
        margin: 0 auto 40px auto;
        border-collapse: collapse;
        background-color: #ffffff;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 16px;
        text-align: center;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #2ecc71;
        color: white;
        font-size: 1.1em;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #ecf0f1;
    }
</style>
</head>
<body>
    <h1>지출 상세페이지</h1>

    <a href="/cashbook/cash/insertCashForm.jsp?fullDate=<%=fullDate%>" class="button-link">작성하기</a>

    <table>
        <tr>
            <th>번호</th>
            <th>수입/지출</th>
            <th>날짜</th>
            <th>금액</th>
            <th>메모</th>
        </tr>
        <%
            for(Cash c : list){
        %>
        <tr>
            <td>
       			<a href="/cashbook/cash/cashOne.jsp?cash_no=<%=c.getCash_no()%>&fullDate=<%=fullDate%>">
       	     		<%=c.getCash_no()%>
		        </a>
            </td>
            <td><%= categoryMap.get(c.getCategory_no()) %></td>
            <td><%=c.getCash_date()%></td>
            <td><%=c.getAmount()%></td>
            <td><%=c.getMemo()%></td>
        </tr>
        <%
        	} 
        %>				
    </table>

    <form action="/cashbook/monthList.jsp">
        <button type="submit">달력으로 돌아가기</button>
    </form>
</body>
</html>
