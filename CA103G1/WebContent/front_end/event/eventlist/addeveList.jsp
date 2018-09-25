<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.eventlist.model.*"%> 
<%@ page import="com.mem.model.*"%> 
<%@ page import="com.eve.model.*"%> 


<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />   
<%
	EventListVO eventListVO = (EventListVO) request.getAttribute("eventListVO"); 
%>

<%	//���X�|����SESSION
	 MemVO memVO = (MemVO) session.getAttribute("memVO"); 
	 EventVO eveVO=eveSvc.getOneEve(request.getParameter("eve_id"));
	 pageContext.setAttribute("eveVO", eveVO);
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
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
   .eveImg{
  width:100%;
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

<h3>��Ʒs�W</h3>

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
		<td>���ʹϤ�:</td>
		<td>
			<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
		</td>
	</tr>
	<tr>
		<td>�|���W��:</td>
		<td>${memVO.mem_name}</td>
	</tr>
		<jsp:useBean id="eveListSvc" scope="page" class="com.eventlist.model.EventlistService" />
	<tr>
		<td>���ʦW��:<font color=red><b>*</b></font></td>
		<td>${eveVO.eve_title}</td>
<!-- 		<td><select size="1" name="eve_id"> -->
<%-- 			<c:forEach var="evelsVO" items="${eveSvc.all}"> --%>
<%-- 				<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,evelsVO.eve_id)==null}">  --%>
<%-- 					<option value="${evelsVO.eve_id}" ${(eventListVO.eve_id==evelsVO.eve_id)? 'selected':'' } >${evelsVO.eve_title} --%>
<%-- 				</c:if>				 --%>
<%-- 			</c:forEach> --%>
<!-- 		</select></td> -->
	</tr>
	
	<tr>
		<td>���ʮɶ�:</td>			
		<td><fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>~			
			<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/></td>	
	</tr>
	<tr>		
		<td>���ʦa�I</td>
		<td>${eveVO.eve_location}</td>	
	</tr>	
	<tr>
		<td>���ʥI�ڪ��B:</td>
		<td><input name="evepay_amount"  type="text" size="5" readonly
			  value="${(eventListVO==null)?eveVO.eve_charge:eventListVO.evepay_amount}"  />��</td>
	</tr>
	<tr>
		<td>���ʥI�ںI���:</td>
		<td><input type="TEXT" name="evepay_deadline" size="45" readonly
			  value="<%= (eventListVO==null)? new java.sql.Date(System.currentTimeMillis()+1000*86400*3) : eventListVO.getEvepay_deadline()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="insert">
<input type="hidden" name="mem_id" value="${memVO.mem_id}" />
<input type="hidden" name="eve_id" value="${eveVO.eve_id}" />
<input type="submit" value="�T�{���W"></FORM>

  <!-- The Modal -->
<c:if test="${openModal!=null}">

<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog ">
		<div class="modal-content">
		
			<div class="modal-header">
				<h3 class="modal-title" id="myModalLabel">�I�ڸ�T</h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>                
            </div>
							
			<div class="modal-body">
				 <div>���ʦW�� :  ${eveVO.eve_title}</div>
          		 <div>�I�ڪ��B : ${eventListVO.evepay_amount}</div>
          		 <div>�I�ڱb�� : </div>
          		 <div>�I�ںI��� : ${eventListVO.evepay_deadline}</div>
        	</div>
        	
			<div class="modal-footer">
                <button type="button" class="btn btn-default" >
                	<A href="<%=request.getContextPath() %>/eventlist/eventlist.do?action=pay_Update_Status&mem_id=${memVO.mem_id}&eve_id=${eveVO.eve_id}">�T�{�I��</A>
                </button>
                <button type="button" class="btn btn-default">
                	<A href="<%=request.getContextPath() %>/front_end/event/eventlist/addeveList.jsp">�y��I��</A>
                </button>
            </div>
		
		</div>
	</div>
</div>
        <script>
    		 $("#basicModal").modal({show: true});
        </script>
 </c:if>


</body>

</html>