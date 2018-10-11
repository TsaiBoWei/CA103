<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.eve.model.*" %>
<%@ page import="com.eventlist.model.*" %>

<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />

<%  
	MemVO memVO=(MemVO)session.getAttribute("memVO");
	List<EventVO> list = eveSvc.getEvesByMem(memVO.getMem_id());
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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/event/eve/css/listEvesByOrganizer.css">	
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

.eveImg{
 width:100%;
 }
 

 
 

</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"�L�n������","Microsoft JhengHei"!important;
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
		        <h3 class="ml-5 mr-3">${memVO.mem_name}�D�쪺���� </h3>
		        <%@ include file="page1.file" %> 
	        </div>
	      </div>
	    </div>
		<div class="row">
			<div class="list-group col-md-2">				
				<a href="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action "> �ѥ[������ </a> 					
				<a href="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action active">�D�쪺����</a> 
				<a href="<%=request.getContextPath()%>/front_end/event/eventsave/eveSave.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action ">���ʦ���</a>	
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
<table id='eveTable'>
	<tr>   
		<th class="w-25">���ʦW��</th>	
		<th>���ʮɶ�</th>
		<th>���W&nbsp/<br>����H��</th>
		<th>���A</th>
		<th>�`���O</th>
		<th>���W�˵�</th>		
		<th>�ק��T</th>
		<th>��������</th>
	</tr>
	<c:forEach var="eveVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		<tr >	
			<td>${eveVO.eve_title}
				 <A href="<%=request.getContextPath() %>/eve/event.do?eve_id=${eveVO.eve_id}&action=getOne_For_Display&whichPage=<%=request.getParameter("whichPage")%>">               
					<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
				 </A>	
			</td>		
			<td><fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>~<br>		
				<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/></td>		
			<td>${evelistSvc.getNumOfMemByEve(eveVO.eve_id)}/${eveVO.estart_limit}</td>			
			<td>${eveStatusMap.get(eveVO.eve_status)}</td>					
			<td>
				<c:if test="${eveVO.eve_charge==0}">
				    �K�O
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${evelistSvc.getEveIncome(eveVO.eve_id)}��
				</c:if>		
			</td>										
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eventlist/eventlist.do" style="margin-bottom: 0px;">
			     <input type="submit" class="btn btn-sm btn-danger " value="���W�M��"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
			     <input type="hidden" name="action"	    value="getEvelists_By_EVE"></FORM>
			</td>
	
				
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" class="btn btn-sm btn-warning " value="�ק��T"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" value="��������" class="btn btn-sm ml-1" >
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller-->
			     <input type="hidden" name="action"     value="delete"></FORM>
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


