<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>
<%@ page import="com.eventsave.model.*"%>


<%
	EventSaveService eventSaveSvc = new EventSaveService();
	List<EventSaveVO> list = eventSaveSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>所有會員的活動收藏 - listAllEventSave.jsp</title>

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
	width: 800px;
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


	<h4>此頁練習採用 EL 的寫法取值:</h4>
	<table id="table-1">
		<tr>
			<td>
				<h3>所有員工資料 - listAllEventSave.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front_end/event/eventsave/selec_eventsave_page.jsp">
					<img src="<%=request.getContextPath()%>/front_end/event/eventsave/images/back1.gif" width="100" height="32" border="0">回首頁</a>>
				</h4>
			</td>
		</tr>
	</table>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>會員編號</th>
			<th>活動編號</th>
			<th>活動收藏狀態</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		
		<%@ include file="page1.file"%>
		<c:forEach var="eventsaveVO" items="${list}"
			begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${eventsaveVO.mem_id}</td>
				<td>${eventsaveVO.eve_id}</td>
				<td>${eventsaveVO.es_status}</td>


				<td>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/eventsave/eventsave.do" style="margin-bottom: 0px;">
						<input type="submit" value="修改">
						<input type="hidden" name="mem_id" value="${eventsaveVO.mem_id}">
						<input type="hidden" name="eve_id" value="${eventsaveVO.eve_id}">
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				
								<td>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/eventsave/eventsave.do" style="margin-bottom: 0px;">
						<input type="submit" value="刪除">
						<input type="hidden" name="mem_id" value="${eventsaveVO.mem_id}">
						<input type="hidden" name="eve_id" value="${eventsaveVO.eve_id}">
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>