<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.memsplike.model.*"%>


<%
	MemSpLikeService memSpSvc = new MemSpLikeService();
	List<MemSpLikeVO> list = memSpSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<title>List Mem Sport Like Type</title>
</head>

<body bgcolor='white' >

<b><font color=red>此頁練習採用 EL 的寫法取值:</font></b>
<table border='1' cellpadding='5' cellspacing='0' width='800'>
	<tr bgcolor='#CCCCFF' align='center' valign='middle' height='20'>
		<td>
		<h3>所有員工資料 - ListAllMemSpLike.jsp</h3>
		<a href="select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">回首頁</a>
		</td>
	</tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>請修正以下錯誤:
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li>${message}</li>
		</c:forEach>
	</ul>
	</font>
</c:if>

<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>會員編號</th>
		<th>會員喜好</th>
		<th>喜好狀態</th>
	</tr>
	<%@ include file="page1.file" %>
	<c:forEach var="memSpLikeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
		<tr align='center' valign='middle'>
			<td>${memSpLikeVO.mem_id}</td>
			<td>${memSpLikeVO.sptype_id}</td>
			<td>${memSpLikeVO.like_status}</td>
			<td>
				<%--修改按鈕 --%>
				<form METHOD="post" ACTION="<%=request.getContextPath()%>/memsplike/memsplike.do">
					<input type="submit" value="修改">
					<input type="hidden" name="mem_id" value="${memSpLikeVO.mem_id}">
					<input type="hidden" name="sptype_id" value="${memSpLikeVO.sptype_id}">
					<input type="hidden" name="action" value="getOne_For_Update">
				</form>
			</td>
			
			<td>
				<%--刪除按鈕 --%>
				<form METHOD="post" ACTION="<%=request.getContextPath()%>/memsplike/memsplike.do">
					<input type="submit" value="刪除">
					<input type="hidden" name="mem_id" value="${memSpLikeVO.mem_id}">
					<input type="hidden" name="sptype_id" value="${memSpLikeVO.sptype_id}">
					<input type="hidden" name="action" value="delete">
				</form>
			</td>
		</tr>	
	</c:forEach>
</table>
<%@ include file="page2.file" %>
</body>
</html>