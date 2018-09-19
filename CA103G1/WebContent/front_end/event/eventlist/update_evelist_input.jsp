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
<title>���ʲM��ק�update_evelist_input.jsp</title>
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

<table id="table-1" class="myTable" >
	<tr><td>
		 <h3>���ʲM��ק�update_evelist_input.jsp</h3>
		 <h4><a href="<%=request.getContextPath() %>/front_end/event/eventlist/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" name="form1">
<table class="myTable" >
	<tr>
		<td>�|���W��:</td>
		<td>${memSvc.getOneMem(eventListVO.mem_id).mem_name}</td>
	</tr>
	<tr>
		<td>���ʦW��:</td>
		<td>${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</td>
	</tr>
	<tr>
		<td>���ʥI�ڪ��B:</td>
		<td><input name="evepay_amount"  type="text" size="45"
			  value="<%=eventListVO.getEvepay_amount()%>" /></td>
	</tr>
	
	<c:if test="${eventListVO.evepay_amount!=0}">
		<tr>
			<td>���ʥI�ںI���:</td>
			<td><input name="evepay_deadline"  type="text" size="45"
			  value="<%=eventListVO.getEvepay_deadline()%>" /></td>
		</tr>
	</c:if>
	
	<tr>
		<td>���ʲM�檬�A:</td>
		<td><input type="TEXT" name="evelist_status" size="45"
			 value="<%=eventListVO.getEvelist_status()%>" /></td>
	</tr>
	<tr>
		<td>���ʵ���:</td>
		<td><input type="TEXT" name="eve_rating" size="45"
			 value="<%=eventListVO.getEve_rating()%>" /></td>
	</tr>
	<tr>
		<td>���ʤ���:</td>
		<td><input type="TEXT" name="eve_share" size="45"
			 value="<%=eventListVO.getEve_share()%>" /></td>
	</tr>
	
</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="mem_id" value="<%=eventListVO.getMem_id()%>">
<input type="hidden" name="eve_id" value="<%=eventListVO.getEve_id()%>">
<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--������e�X�ק諸�ӷ��������|��,�A�e��Controller�ǳ���椧��-->
<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--�u�Ω�:istAllEmp.jsp-->
<input type="submit" value="�e�X�ק�"></FORM>

<!-- <br>�e�X�ק諸�ӷ��������|:<br><b> -->
   <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
   <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%> (���d�ҥثe�u�Ω�:istAllEmp.jsp))</b>
</body>


</html>