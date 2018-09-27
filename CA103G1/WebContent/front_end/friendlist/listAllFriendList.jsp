<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ page import="java.util.*"%>
<%@ page import="com.friendlist.model.*"%>


<%
	FriendListService friendlistSvc = new FriendListService();
	List<FriendListVO> list = friendlistSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>所有會員的好友清單 - listAllFriendList.jsp</title>

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
				<h3>所有員工資料 - listAllFriendList.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/front_end/friendlist/select_friendlist_page.jsp">
					<img src="<%=request.getContextPath()%>/front_end/friendlist/images/back1.gif" width="100" height="32" border="0">回首頁</a>>
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
			<th>好友編號</th>
			<th>好友姓名</th>
			<th>是否邀請</th>
			<th>是否封鎖</th>
			<th>修改</th>
			<th>刪除</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="firendlistVO" items="${list}"
			begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${firendlistVO.fl_memA_id}</td>
				<td>${firendlistVO.fl_memB_id}</td>
				<td>${firendlistVO.fl_friend_name}</td>
				<td>${firendlistVO.fl_status}</td>
				<td>${firendlistVO.fl_block}</td>

				<td>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/friendlist/friendlist.do" style="margin-bottom: 0px;">
						<input type="submit" value="修改">
						<input type="hidden" name="fl_memA_id" value="${firendlistVO.fl_memA_id}">
						<input type="hidden" name="fl_memB_id" value="${firendlistVO.fl_memB_id}">
						<input type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
				
				
				
				
				<td>
					<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/friendlist/friendlist.do" style="margin-bottom: 0px;">
						<input type="submit" value="刪除">
						<input type="hidden" name="fl_memA_id" value="${firendlistVO.fl_memA_id}">
						<input type="hidden" name="fl_memB_id" value="${firendlistVO.fl_memB_id}">
						<input type="hidden" name="action" value="delete">
					</FORM>
				</td>
				
				
				
				
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>