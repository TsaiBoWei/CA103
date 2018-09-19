<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ page import="com.eventlist.model.*"%> 
<%@ page import="com.mem.model.*"%> 

<%
	EventListVO eventListVO = (EventListVO) request.getAttribute("eventListVO"); 
%>

<%	//���X�|����SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>�s�W���ʲM�� - addeveList.jsp</title>

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
	<tr><td>
		 <h3>�s�W���ʲM�� - addeveList.jsp</h3></td><td>
		 <h4><a href="<%=request.getContextPath() %>/front_end/event/eventlist/select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">�^����</a></h4>
	</td></tr>
</table>

<h3>��Ʒs�W(�|���qsession ��):</h3>

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
<table>
	<tr>
		<td>�|���W��:</td>
		<td>${memVO.mem_name}</td>
	</tr>
		<jsp:useBean id="eveListSvc" scope="page" class="com.eventlist.model.EventlistService" />
	<tr>
		<td>���ʦW��:<font color=red><b>*</b></font></td>
		<td><select size="1" name="eve_id">
			<c:forEach var="evelsVO" items="${eveSvc.all}">
				<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,evelsVO.eve_id)==null}"> 
					<option value="${evelsVO.eve_id}" ${(eventListVO.eve_id==evelsVO.eve_id)? 'selected':'' } >${evelsVO.eve_title}
				</c:if>				
			</c:forEach>
		</select></td>
	</tr>
	
	<tr>
		<td>���ʥI�ڪ��B:</td>
		<td><input name="evepay_amount"  type="text" size="45"
			  value="<%= (eventListVO==null)? "0": eventListVO.getEvepay_amount()%>" /></td>
	</tr>
	<tr>
		<td>���ʥI�ںI���:</td>
		<td><input type="TEXT" name="evepay_deadline" size="45"
			  value="<%= (eventListVO==null)? new java.sql.Date(System.currentTimeMillis()+1000*86400*3) : eventListVO.getEvepay_deadline()%>" /></td>
	</tr>
	
<!-- 	�qEVE_CONTROLLER�L�ӫݧ�g -->
	<tr>
		<td>���ʲM�檬�A:</td>
		<td><input type="TEXT" name="evelist_status" size="45"
			 value="${(eventListVO==null)?'�L���A' : eveListStatusMap.get(eventListVO.evelist_status)}" /></td>
	</tr>
	<tr>
		<td>���ʤ���:</td>
		<td>
			<BUTTON name="eve_share" value=""<%= (eventListVO==null)? "ES0" : eventListVO.getEve_share()%>">
				����
			</BUTTON>		 
		</td>
	</tr>



</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="hidden" name="mem_id" value="${memVO.mem_id}" />
<input type="submit" value="�e�X�s�W"></FORM>
</body>

</html>