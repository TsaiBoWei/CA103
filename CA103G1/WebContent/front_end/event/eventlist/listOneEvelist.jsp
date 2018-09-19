<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.eventlist.model.*"%>
<%@ page import="com.eve.model.*"%>
<%
	EventListVO eventListVO = (EventListVO) request.getAttribute("eventListVO"); 
%>    
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<!DOCTYPE html>
<html>
<head>
<title>��@���ʲM�� - listOneEvelist.jsp</title>

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
  
  .evelistImg{
  	height: 30%;
  	width:30%;
  }
</style>

</head>
<body bgcolor='white'>


<table id="table-1" class="myTable">
	<tr><td>
		 <h3>��@���ʲM�� - listOneEvelist.jsp</h3>
<%-- 		 <h4><a href="<%=request.getContextPath() %>/front_end/event/eventlist/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4> --%>
	</td></tr>
</table>

<table class="myTable">
	<tr>
		<th>�|���W��</th>
		<th>���ʦW��</th>
		<th>���ʵ���</th>
		<th>���ʲM�檬�A</th>
		<th>���ʥI�ڪ��B</th>
		<th>���ʤ���</th>
		<th>���ʥI�ںI���</th>
<!-- 		<th>���ʹϤ�</th> -->
<!-- 		<th>�ק�</th> -->
<!-- 		<th>�R��</th> -->
	</tr>
	<tr>
		<td>${memSvc.getOneMem(eventListVO.mem_id).mem_name}</td>
		<td>${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</td>
		<td>${eventListVO.eve_rating}</td>
		<td>${eventListVO.evelist_status}</td>
		<td>${eventListVO.evepay_amount}</td>
		<td>${eventListVO.eve_share}</td> 
		<td>${eventListVO.evepay_deadline}</td>
		
<!-- 		<td> -->
<%-- 		  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;"> --%>
<!-- 		     <input type="submit" value="�ק�"> -->
<%-- 		     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}"> --%>
<%-- 		     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}"> --%>
<!-- 		     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 		</td> -->
<!-- 		<td> -->
<%-- 		  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;"> --%>
<!-- 		     <input type="submit" value="�R��"> -->
<%-- 		     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}"> --%>
<%-- 		     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}"> --%>
<!-- 		     <input type="hidden" name="action" value="delete"></FORM> -->
<!-- 		</td> -->
	</tr>	
</table>
<img class="evelistImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eventListVO.eve_id}">

</body>
</html>