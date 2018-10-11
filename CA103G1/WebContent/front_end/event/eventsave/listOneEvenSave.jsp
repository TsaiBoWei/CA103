<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.eventsave.model.*"%>

<%
	EventSaveVO eventsaveVO = (EventSaveVO) request.getAttribute("eventsaveVO"); //FriendListServlet.java(Concroller), 存入req的empVO物件
%>

<html>
<head>
<title>會員的活動收藏狀態 - listOneEvenSave.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

</head>
<body bgcolor='white'>

	<h4>此頁暫練習採用 Script 的寫法取值:</h4>
	<table id="table-1">
		<tr><td>
		 <h3>會員資料 - listOneEvenSave.jsp</h3>
			<h4><a href="<%=request.getContextPath() %>/front_end/event/eventsave/select_eventsave_page.jsp">
			<img src="<%=request.getContextPath() %>/front_end/event/eventsave/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
		</td></tr>
	</table>
	<table>
		<tr>
			<th>會員編號</th>
			<th>活動編號</th>
			<th>收藏狀態</th>
		</tr>
		<tr>
			<td><%=eventsaveVO.getMem_id()%></td>
			<td><%=eventsaveVO.getEve_id()%></td>
			<td><%=eventsaveVO.getEs_status()%></td>
		</tr>
	</table>

</body>
</html>