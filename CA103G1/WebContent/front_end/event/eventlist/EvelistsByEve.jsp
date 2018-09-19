<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.eventlist.model.*"%>
<!DOCTYPE html>
<%
	List<EventListVO> list=(ArrayList) session.getAttribute("eveListsByEve");
	pageContext.setAttribute("list",list);
%>
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<html>
<head>
<title>���ʥD�쪺���ʲM�� - EvelistsByEve.jsp</title>

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

<table id="table-1">
	<tr><td>
		 <h3>���ʥD�쪺���ʲM��  - EvelistsByEve.jsp</h3>
		 <h4><a href="<%=request.getContextPath() %>/front_end/event/eventlist/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<% session.removeAttribute("errorMsgs"); %>
<table>
	<tr>
		<th>�|���W��</th>
		<th>���ʦW��</th>
		<th>���ʵ���</th>
		<th>���ʲM�檬�A</th>
		<th>���ʥI�ڪ��B</th>
		<th>���ʤ���</th>
		<th>���ʥI�ںI���</th>
		<th>�ק�</th>
		<th>�R��</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eventListVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr ${(eventListVO.mem_id==param.mem_id && eventListVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}>
			<td>${memSvc.getOneMem(eventListVO.mem_id).mem_name}</td>
			<td>${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</td>
			<td>
				<c:if test="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate.getTime()<System.currentTimeMillis()}">
					${(eventListVO.eve_rating==0)?"":eventListVO.eve_rating}				
				</c:if>	
			</td>
			<td>${eventListVO.evelist_status}</td>
			<td>${eventListVO.evepay_amount}</td>
			<td>${eventListVO.eve_share}</td> 
			<td>${eventListVO.evepay_deadline}</td>
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�ק�">
			     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
			     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
			     <input type="submit" value="�R��">
			     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
			     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
			     <input type="hidden" name="action" value="delete"></FORM>
			</td>
		</tr>
	</c:forEach>
</table>

<%@ include file="page2.file" %>
<br>�����������|:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>
</body>
</html>