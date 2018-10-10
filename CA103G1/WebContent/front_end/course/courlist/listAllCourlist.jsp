<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
CourlistService courlistSvc = new CourlistService();
    List<CourlistVO> list = courlistSvc.getAll();
    pageContext.setAttribute("list",list);
%>


<html>
<head>
<title>所有員工資料 - listAllCourlist.jsp</title>

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
	<tr><td>
		 <h3>所有員工資料 - listAllCourlist.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">
		 <img src="<%=request.getContextPath()%>/front_end/course/courlist/images/back1.gif" width="100" height="32" border="0">回首頁</a></h4>
	</td></tr>
</table>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<table>
	<tr>
		<th>課程編號</th>
		<th>運動類別編號</th>
		<th>教練編號</th>
		<th>課程姓名</th>
		<th>課程介紹</th>
		<th>課程費用</th>
		<th>課程主頁圖片</th>
		<th>課程狀態</th>
		<th>課程公告</th>
		<th>課程瀏覽次數</th>
		<th>修改</th>
		<th>刪除</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="courlistVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
		
			<td>${courlistVO.cour_id}</td>
			<td>${courlistVO.sptype_id}</td>
			<td>${courlistVO.coa_id}</td>
			<td>${courlistVO.cname}</td>
			<td>${courlistVO.cour_text}</td>
			<td>${courlistVO.cour_cost}</td> 
			<td>
<%-- 			${courlistVO.cour_pho} --%>
<!-- 			<img class="img-fluid rounded-circle" alt="Card image" -->
<%--           src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=${courlistVO.cour_id}"> --%>
          <img class="img-fluid d-block w-50 mb-3 rounded" width="200" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=${courlistVO.cour_id}">
			</td>
			<td>${courlistVO.cour_lau}</td>
			<td>${courlistVO.cour_ann}</td> 
			<td>${courlistVO.cour_view}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="修改">
			     <input type="hidden" name="cour_id"  value="${courlistVO.cour_id}">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/courlist/courlist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="刪除">
			     <input type="hidden" name="cour_id"  value="${courlistVO.cour_id}">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>