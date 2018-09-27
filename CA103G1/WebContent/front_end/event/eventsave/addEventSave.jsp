<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.eventsave.model.*"%>

<%
	EventSaveVO eventsaveVO = (EventSaveVO) request.getAttribute("eventsaveVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>收藏狀態新增 - addFriendList.jsp</title>

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
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>活動收藏新增 - addFriendList.jsp</h3>
			</td>
			<td>
				<h4><a href="<%=request.getContextPath() %>/front_end/event/eventsave/selec_eventsave_page.jsp">
				<img src="<%=request.getContextPath() %>/front_end/event/eventsave/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>	
			</td>
		</tr>
	</table>

	<h3>活動收藏新增 :</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eventsave/eventsave.do"
		name="form1">
		<table>
			<tr>
				<td>會員編號:</td>
				<td><input type="TEXT" name="mem_id" size="45"
					value="<%=(eventsaveVO == null) ? "M000001" : eventsaveVO.getMem_id()%>" /></td>
			</tr>

			<tr>
				<td>活動編號</td>
				<td><input type="TEXT" name="eve_id" size="45"
					value="<%=(eventsaveVO == null) ? "E000001" : eventsaveVO.getEve_id()%>" /></td>
			</tr>
			<tr>
				<td>收藏狀態:</td>
				<td>
					<select size="1" name="es_status">
						<option value="ESS0">ESS0 無
						<option value="ESS1">ESS1 新增收藏
						<option value="ESS2">ESS2 取消收藏
					</select>
				</td>
			</tr>
		</table>
		<br> <input type="hidden" name="action" value="insert"> 
			 <input type="submit" value="送出新增">
	</FORM>
</body>
</html>