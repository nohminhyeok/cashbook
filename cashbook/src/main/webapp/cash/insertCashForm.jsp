<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	String id = (String) session.getAttribute("adminId");
	if(id == null) {
	    response.sendRedirect("/cashbook/loginForm.jsp");
	    return;
	}
    String fullDate = request.getParameter("fullDate");
    System.out.println("fullDate : "+fullDate);

    String kind = request.getParameter("kind");
    ArrayList<Category> list = null;
    if(kind != null) {
        CategoryDao categoryDao = new CategoryDao();
        list = categoryDao.selectCategoryListBykind(kind);
    }

    int category_no = 0;
    if ("수입".equals(kind)) {
        category_no = 1;
    } else if ("지출".equals(kind)) {
        category_no = 2;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수입/지출 입력</title>
<style>
    body {
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background-color: #eef2f7;
        margin: 0;
        padding: 0;
        color: #333;
    }

    .container {
        max-width: 600px;
        margin: 50px auto;
        background-color: #fff;
        border-radius: 12px;
        padding: 30px 40px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        color: #2c3e50;
        margin-bottom: 30px;
    }

    form {
        margin-bottom: 30px;
    }

    label {
        display: block;
        font-weight: bold;
        margin: 12px 0 6px;
        color: #555;
    }

    select, input[type="text"], input[type="color"] {
        width: 100%;
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 6px;
        font-size: 1em;
        box-sizing: border-box;
    }

    .date-label {
        margin: 10px 0;
        font-size: 1.1em;
        font-weight: bold;
        color: #444;
    }

    button {
        margin-top: 20px;
        padding: 12px 20px;
        background-color: #3498db;
        color: white;
        font-size: 1em;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    button:hover {
        background-color: #2980b9;
    }

    hr {
        border: none;
        height: 1px;
        background-color: #ccc;
        margin: 30px 0;
    }
</style>
</head>
<body>

<div class="container">
    <h1>수입/지출 선택</h1>
    <form method="get" action="/cashbook/cash/insertCashForm.jsp">
        <input type="hidden" name="fullDate" value="<%=fullDate%>">
        <label for="kind">종류 선택</label>
        <select name="kind" id="kind">
            <option value="">:::선택:::</option>
            <option value="수입" <%= "수입".equals(kind) ? "selected" : "" %>>수입</option>
            <option value="지출" <%= "지출".equals(kind) ? "selected" : "" %>>지출</option>
        </select>
        <button type="submit">선택</button>
    </form>

    <hr>

    <h1>수입/지출 추가</h1>
    <form method="get" action="/cashbook/cash/insertCashAction.jsp">
        <input type="hidden" name="fullDate" value="<%=fullDate%>">

        <div class="date-label">날짜 : <%=fullDate %></div>

        <label for="category_no">내용</label>
        <select name="category_no" id="category_no">
            <% if(list != null) {
                for(Category c : list) { %>
                    <option value="<%=c.getCategory_no()%>"><%=c.getTitle()%></option>
			<%
					}
                } 
			%>
        </select>

        <label for="memo">메모</label>
        <input type="text" name="memo" id="memo">

        <label for="amount">금액</label>
        <input type="text" name="amount" id="amount">

        <label for="color">색상</label>
        <input type="color" name="color" id="color">

        <button type="submit">수입/지출 입력</button>
    </form>
</div>

</body>
</html>
