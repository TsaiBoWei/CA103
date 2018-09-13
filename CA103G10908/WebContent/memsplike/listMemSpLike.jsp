<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.memsplike.model.*"%>
<%@ page import="com.mem.model.*" %>
<%@ page import="java.util.*" %>

<%
	MemSpLikeService memSpSvc = new MemSpLikeService();
	List<MemSpLikeVO> list = memSpSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>List Mem Sport Like Type</title>
</head>

<body bgcolor='white' >

<b>這個頁面作為MemSpLike的練習, 用EL編寫</b>

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
	<c:forEach var="MemSpLikeVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" >
		<tr align='center' valign='middle'>
			<td>${MemSpLikeVO.mem_id}</td>
			<td>${MemSpLikeVO.sptype_id}</td>
			<td>${MemSpLikeVO.like_status}</td>
		</tr>	
	</c:forEach>
</table>

</body>
</html>