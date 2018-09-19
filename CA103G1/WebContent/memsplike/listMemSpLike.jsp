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

<b>�o�ӭ����@��MemSpLike���m��, ��EL�s�g</b>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font color='red'>�Эץ��H�U���~:
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li>${message}</li>
		</c:forEach>
	</ul>
	</font>
</c:if>

<table border='1' bordercolor='#CCCCFF' width='800'>
	<tr>
		<th>�|���s��</th>
		<th>�|���ߦn</th>
		<th>�ߦn���A</th>
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