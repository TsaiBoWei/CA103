<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>

<%
	EveService eveSvc = new EveService();
	List<EventVO> list = eveSvc.getEvesInViewPage();
	pageContext.setAttribute("list",list);
%>



<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listAllEve.jsp</title>
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
 	width: 100%; 
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
  .eveImg{
  width:100%;
  }
  
</style>

</head>
<body bgcolor='white'>


<table id="table-1">
	<tr><td>
		 <h3>�Ҧ����ʸ�� - listAllEve.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/front_end/event/eve/select_event_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
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

<table>
	<tr>   
		<th>���ʼ��D</th>
		<th>���ʹϤ�</th>
<!-- 		<th>�D��H�m�W</th> -->
		<th>���ʮɶ�</th>
		<th>���W����</th>
		<th>���ʪ��A</th>
		<th>�a�Ͽ���</th>
		<th>�B�����O</th>
		<th>�����s������</th>
		<th>���O���B</th>

			
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr ${(eveVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����Ӥw-->
			<td>${eveVO.eve_title}</td>						
			<td>
			<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
			</td>
<%-- 			<td>${memSvc.getOneMem(eveVO.mem_id).mem_name}</td>		 --%>
			<td><fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>~			
				<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/></td>
			<td><fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy/MM/dd "/>~					
				<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy/MM/dd"/></td>					
			
		
			<td>
				<c:if test="${eveVO.ereg_startdate.getTime()<System.currentTimeMillis()}">		
					${eveVO.eve_status=='E4'?'�w�B��':'�u�W���W'}					
				</c:if>
			</td>
			<td>${citySvc.getCityName(eveVO.city_id)}</td>			
			<td>${sportTypeMap.get(eveVO.sptype_id)}</td>			
			<td>${eveVO.eve_view}</td>			
			<td>
				<c:if test="${eveVO.eve_charge==0}">
				    �K�O
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${eveVO.eve_charge}��/�H
				</c:if>		
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