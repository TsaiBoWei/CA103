<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>listOneEvent.jsp</title>
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
		 <h3>��@���ʸ�� - listOneEvent.jsp</h3>
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

		<th>�D��H�m�W</th>
		<th>���ʼ��D</th>	
		<th>���ʹϤ�</th>
		<th>���ʱԭz</th>
		<th>���ʮɶ�</th>
		<th>���W����</th>
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

	<tr>
		<td>${memSvc.getOneMem(eveVO.mem_id).mem_name}</td>
		<td>${eveVO.eve_title}</td>
		<td>
		<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
		</td>
		<td>${eveVO.eve_content}</td>			
		<td><fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy-MM-dd HH:mm "/>~			
			<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy-MM-dd HH:mm"/></td>
		<td><fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy-MM-dd "/>~					
			<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy-MM-dd"/></td>		
		<td>${eveVO.estart_limit}</td>			
		<td>${eveStatusMap.get(eveVO.eve_status)}</td>			
		<td>${eveVO.eve_location}</td>			
		<td>${eveVO.eve_long}</td>			
		<td>${eveVO.eve_lat}</td>			
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
		<td>${eveVO.econtact_info}</td>			
		<td>
		<fmt:formatDate value="${eveVO.eestablish_date}" pattern="yyyy/MM/dd HH:mm:ss"/>
		</td>
		<td>			
		  	<jsp:useBean id="eveListSvc" scope="page" class="com.eventlist.model.EventlistService" />
		  	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)==null||eveVO.eve_status=='E4'}"> 
		  		<c:if test="${memVO.mem_id!=eveVO.mem_id}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front_end/event/eventlist/addeveList.jsp" style="margin-bottom: 0px;">
				    <input type="submit" value="�[�J����"> 
				    <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
				    <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			  		</FORM>
			  	</c:if>					
			</c:if>				  	
		</td>				
	</tr>

</table>


<br>�����������|:<br><b>
   <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br>
   <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b>

</body>
</html>