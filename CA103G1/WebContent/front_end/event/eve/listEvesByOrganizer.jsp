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
 /*頁面設定*/
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
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>


</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

<!-- code寫在這記得加container -->
 <div class="container" >
 		<div class="row">
	      <div class="col-md  m-3  " >
	      	<div class="d-flex align-items-end" >
	      		<div class="col-md-1 " ></div>
		        <h3 class="ml-5 mr-3">${memVO.mem_name}主辦的活動 </h3>
		        <%@ include file="page1.file" %> 
	        </div>
	      </div>
	    </div>
		<div class="row">
			<div class="list-group col-md-2">				
				<a href="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action "> 參加的活動 </a> 					
				<a href="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action active">主辦的活動</a> 
				<a href="<%=request.getContextPath()%>/front_end/event/eventsave/eveSave.jsp?perpageloc=event#personalnav"
					class="list-group-item list-group-item-action ">活動收藏</a>	
			</div>
			<div class="col-md-9">	
				<%-- 錯誤表列 --%>
				<c:if test="${not empty errorMsgs}">
					<font style="color:red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
							<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
				<% session.removeAttribute("errorMsgs"); %>
<table id='eveTable'>
	<tr>   
		<th class="w-25">活動名稱</th>	
		<th>活動時間</th>
		<th>報名&nbsp/<br>成行人數</th>
		<th>狀態</th>
		<th>總收費</th>
		<th>報名檢視</th>		
		<th>修改資訊</th>
		<th>取消活動</th>
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
				    免費
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${evelistSvc.getEveIncome(eveVO.eve_id)}元
				</c:if>		
			</td>										
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eventlist/eventlist.do" style="margin-bottom: 0px;">
			     <input type="submit" class="btn btn-sm btn-danger " value="報名清單"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getEvelists_By_EVE"></FORM>
			</td>
	
				
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" class="btn btn-sm btn-warning " value="修改資訊"> 
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     <input type="hidden" name="action"	    value="getOne_For_Update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" style="margin-bottom: 0px;">
			     <input type="submit" value="取消活動" class="btn btn-sm ml-1" >
			     <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
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

 <!-- =========================================以下為聊天視窗========================================== -->
  
   <jsp:include page="/front_end/event/evechat/eveChat.jsp"/> 
  
<!-- =========================================以上為聊天視窗========================================== --> 	


<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	
  <script>
    window.onload=function(){
    	location.hash="#event";
    	console.log(location.href);
    };
           
   </script>


