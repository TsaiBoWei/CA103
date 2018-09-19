<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>

<%
	EveService eveSvc = new EveService();
	List<EventVO> list = eveSvc.getAll();
	pageContext.setAttribute("list",list);
%>


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
		<th>���ʽs��</th>
		<th>�D��HID</th>
		<th>���ʼ��D</th>	
		<th>���ʭ����Ϥ�</th>
		<th>���ʹϤ�</th>
		<th>���ʹϤ��ɮ׮榡</th>
		<th>���ʱԭz</th>
		<th>���ʶ}�l�ɶ�</th>
		<th>���ʵ����ɶ�</th>
		<th>���ʶ}�l���W��</th>
		<th>���ʵ������W��</th>
		<th>���ʦ��橳�u�H��</th>
		<th>���ʪ��A</th>
		<th>���ʦa�I</th>
		<th>���ʦa�g��</th>
		<th>���ʦa�n��</th>
		<th>�a�Ͽ����s��</th>
		<th>�B�����O�s��</th>
		<th>�����s������</th>
		<th>���O���B</th>
		<th>�D��H�p���q��</th>
		<th>���ʫإ߮ɶ�</th>
			
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr ${(eveVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}><!--�N�ק諸���@���[�J����Ӥw-->
			<td>${eveVO.eve_id}</td>
			<td>${eveVO.mem_id}</td>
			<td>${eveVO.eve_title}</td>
			<td>${eveVO.eve_photo}</td>
			<td>
			<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
			</td>
			<td>${eveVO.eve_ptype}</td>
			<td>${eveVO.eve_content}</td>			
			<td>${eveVO.eve_startdate}</td>			
			<td>${eveVO.eve_enddate}</td>			
			<td>${eveVO.ereg_startdate}</td>			
			<td>${eveVO.ereg_enddate}</td>			
			<td>${eveVO.estart_limit}</td>			
			<td>${eveVO.eve_status}</td>			
			<td>${eveVO.eve_location}</td>			
			<td>${eveVO.eve_long}</td>			
			<td>${eveVO.eve_lat}</td>			
			<td>${eveVO.city_id}</td>			
			<td>${eveVO.sptype_id}</td>			
			<td>${eveVO.eve_view}</td>			
			<td>${eveVO.eve_charge}</td>			
			<td>${eveVO.econtact_info}</td>			
			<td>${eveVO.eestablish_date}</td>			
			
		
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

<br>�����������|:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>