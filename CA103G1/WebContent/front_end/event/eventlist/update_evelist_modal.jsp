<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.eventlist.model.*"%>

<% 
	EventListVO eventListVO=(EventListVO)request.getAttribute("eventListVO");
%>
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

    
<!DOCTYPE html>
<html>
<head>

<meta charset="utf-8">
<title>活動清單修改update_evelist_input.jsp</title>
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
/* 	width: 450px; */
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  .myTable, .myTable th,.myTable td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1" class="myTable" >
	<tr><td>
		 <h3>活動清單修改update_evelist_modal.jsp</h3>
	</td></tr>
</table>

<h3>資料修改:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" name="form1">
<table class="myTable" >
	<tr>
		<td>會員名稱:</td>
		<td>${memSvc.getOneMem(eventListVO.mem_id).mem_name}</td>
	</tr>
	<tr>
		<td>活動名稱:</td>
		<td>${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</td>
	</tr>
	<tr>
		<td>活動付款金額:</td>
		<td><input name="evepay_amount"  type="text" size="45"
			  value="<%=eventListVO.getEvepay_amount()%>" /></td>
	</tr>
	
	<c:if test="${eventListVO.evepay_amount!=0}">
		<tr>
			<td>活動付款截止日:</td>
			<td><input name="evepay_deadline"  type="text" size="45"
			  value="<%=eventListVO.getEvepay_deadline()%>" /></td>
		</tr>
	</c:if>
	
	<tr>
		<td>活動清單狀態:</td>
		<td><input type="TEXT" name="evelist_status" size="45"
			 value="<%=eventListVO.getEvelist_status()%>" /></td>
	</tr>
	<tr>
		<td>活動評價:</td>
		<td><input type="TEXT" name="eve_rating" size="45"
			 value="<%=eventListVO.getEve_rating()%>" /></td>
	</tr>
	<tr>
		<td>活動分享:</td>
		<td><input type="TEXT" name="eve_share" size="45"
			 value="<%=eventListVO.getEve_share()%>" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="mem_id" value="<%=eventListVO.getMem_id()%>">
<input type="hidden" name="eve_id" value="<%=eventListVO.getEve_id()%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
<div class="text-right" >
<input type="submit" value="送出修改" class="btn btn-primary ">
<button type="button" class="btn btn-default " data-dismiss="modal">返回</button>
</div>
</FORM>


</body>


</html>