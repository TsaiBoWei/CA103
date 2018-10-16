<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.eventlist.model.*"%>

<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />

<%	
	String eve_id=(String)session.getAttribute("eve_id");
	List<EventListVO> list= (List<EventListVO> )evelistSvc.getEveListsByEve(eve_id);
	pageContext.setAttribute("list",list);
%>



<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>Jennifer Lawernce</title>

<!-- CSS dependencies -->
 <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">


<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/event/eventlist/css/eveEventlist.css">	
<link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/evechat/css/eveChat.css">

<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
	
<style>
 

/*�����]�w*/
body {
	overflow-x: hidden;
}

.evetab{
  font-size:15px;
  font-weight:bold!important;
}


</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"�L�n������","Microsoft JhengHei"!important;
}

   .navbar-dark .navbar-nav .nav-link{
	color:rgba(255, 255, 255, 0.8)!important;
	font-weight:bold!important;	
}

th,td{
   font-weight:bold!important;
   font-size:18px;

}
</style>


</head>

<!-- =========================================�H�U����personlhead.jsp�����e========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================�H�W����personlhead.jsp�����e========================================== -->

<!-- code�g�b�o�O�o�[container -->
 <div class="container" >
 		<div class="row">
	      <div class="col-md  m-3  " >
	      	<div class="d-flex align-items-end" >
	      		<div class="col-md-1 " ></div>
		        <h3 class="ml-5 mr-3">${memVO.mem_name}�D�쪺���� :  ${eveSvc.getOneEve(eve_id).eve_title} </h3>
		        <%@ include file="page1.file" %> 
	        </div>
	      </div>
	    </div>
		<div class="row">
			<div class="list-group col-md-2">				
				<a href="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action evetab"> �ѥ[������ </a> 					
				<a href="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action active evetab">�D�쪺����</a> 
				<a href="<%=request.getContextPath()%>/front_end/event/eventsave/eveSave.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action evetab">���ʦ���</a>	
			</div>
			<div class="col-md-9">	
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
				<table id="evelistTable" class="table table-striped table-hover">
					<thead class="thead-light">
					<tr >
					
						<th class="w-25">�|���W��</th>
						<th>�I�ڪ��B</th>		
						<th class="w-20">�I�ںI���</th>
						<th class="w-25">���ʲM�檬�A</th>
						<th>���ʵ���</th>
						<th class="w-20">�h�X</th>
					</tr>
					</thead>
					
					<c:forEach var="eventListVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						
						<tr class="table-warning">
							<td>${memSvc.getOneMem(eventListVO.mem_id).mem_name}</td>
							
							<td>
								<c:if test="${eventListVO.evepay_amount!=0}">
									${eventListVO.evepay_amount}��
								</c:if>	
								<c:if test="${eventListVO.evepay_amount==0}">
									�K�O
								</c:if>	
							</td>
							<td>${eventListVO.evepay_deadline==null?'�L':eventListVO.evepay_deadline}</td>
							<td><div class='d-flex justify-content-center'>
								${eveListStatusMap.get(eventListVO.evelist_status)}
								<c:if test="${eventListVO.evelist_status=='EL2'||eventListVO.evelist_status=='EL4'}">
									<FORM METHOD="post"  ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
								     <input type="submit" class="btn btn-sm btn-info ml-2" value="�T�{">
								     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
								     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
								     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
								     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--�e�X�����������|��Controller-->
								     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
								     <input type="hidden" name="action"	value="Update_ELStatus"></FORM>	
							     </c:if>
							     </div>		
							</td>		
							<td>
								<c:if test="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate.getTime()<System.currentTimeMillis()}">
									${(eventListVO.eve_rating==0)?"":eventListVO.eve_rating}				
								</c:if>	
							</td>
							<td>
							  <c:if test="${eventListVO.evepay_amount==0}">				  
								  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
								     <input type="submit" value="�R��">
								     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
								     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
								     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--�e�X�����������|��Controller-->
								     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
								     <input type="hidden" name="action" value="delete_By_Organizer"></FORM>
							  </c:if>			
							</td>
						</tr>
					</c:forEach>
				</table>
			
			</div>	
		</div>
		<div class="row">
    	<div class="col-md-12 offset-md-5 d-flex ">
			<%@ include file="page2.file" %>	
		</div>
   </div>
		
	</div>
	
 <!-- =========================================�H�U����ѵ���========================================== -->
  
   <jsp:include page="/front_end/event/evechat/eveChat.jsp"/> 
   
<!-- =========================================�H�W����ѵ���========================================== --> 	




<!-- =========================================�H�U����personlfooter.jsp�����e========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================�H�W����personlfooter.jsp�����e========================================== -->
	
  <script>
    window.onload=function(){
    	location.hash="#event";
    	console.log(location.href);
    };
           
   </script>


