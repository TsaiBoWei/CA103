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
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>listOneEvent.jsp</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <!--  self-defined css  -->
 
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>


  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
   
<title>�s�W���ʲM�� - addeveList.jsp</title>

<style>
  table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  th, td {
    padding: 1px;
  }
   .eveImg{
  width:60%;
  }
  
  #addElTable th, #addElTable td,#addElTable input {
  	font-size:16px;
  	font-weight:bold;
  }
  
   #addElTable input{
  	border:0px;
  }
</style>

</head>
<body >



<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<h3 class="text-success">���ʳ��W&nbsp-&nbsp ${eveVO.eve_title}</h3>

<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" name="form1">
<table class="table table-striped table-hover" id='addElTable'>

	<tr>
		<td colspan='2' >
			<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
		</td>
	</tr>
	<tr>
		<td >�|���W��:</td>
		<td >${memVO.mem_name}</td>
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
		<td><input type=text name="evepay_amount" size='4' value="${(eventListVO==null)?eveVO.eve_charge:eventListVO.evepay_amount}" readonly> ��</td>
	</tr>
	<tr>
		<td>���ʥI�ںI���:</td>
		<td>
		
			<c:if test="${eventListVO==null}">
				<input type=text name="evepay_deadline" size='10'  readonly
				value="<%=(eveVO.getEve_charge()!=0)?new java.sql.Date(System.currentTimeMillis()+1000*86400*3):"�L" %>">		
			</c:if>
			<c:if test="${eventListVO!=null}">
				${eventListVO.evepay_deadline==null?'�L':eventListVO.evepay_deadline}		
			</c:if>
		
		</td>
	</tr>
</table>
<div class="d-flex justify-content-center">
	<input type="hidden" name="action" value="insert">
	<input type="hidden" name="mem_id" value="${memVO.mem_id}" />
	<input type="hidden" name="eve_id" value="${eveVO.eve_id}" />
	<input type="submit" class='btn btn-primary mx-1' value="�T�{���W">
	<input type="button" class='btn btn-primary mx-1' data-dismiss="modal" value="����">
</div>
</FORM>
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