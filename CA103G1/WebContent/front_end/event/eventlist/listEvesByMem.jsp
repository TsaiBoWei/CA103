<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.eventlist.model.*"%>

<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>
<%
	List<EventListVO> list=	evelistSvc.getEveListsByMem(memVO.getMem_id());
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
<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>



<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/event/eventlist/css/listEvesByMem.css">	
<style>
 

/*頁面設定*/
body {
	overflow-x: hidden;
}

</style>


</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
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
 
<!-- code寫在這記得加container -->
 <div class="container py-2" id="eveloc">
    <div class="row">
      <div class="col-md  m-3  " >
      	<div class="d-flex align-items-end" >
      		<div class="col-md-1 " ></div>
	        <h3 class="ml-5 mr-3">${memVO.mem_name}參加的活動</h3>
	        <%@ include file="page1_memEventlist.file" %> 
        </div>
      </div>
    </div>
    <div class="row">
      <div class="list-group col-md-2">
        <a href="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav" class="list-group-item list-group-item-action active"> 參加的活動 </a>
        <a href="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp?perpageloc=event#personalnav" class="list-group-item list-group-item-action ">主辦的活動</a>
        <a href="<%=request.getContextPath()%>/front_end/event/eventsave/eveSave.jsp?perpageloc=event#personalnav" class="list-group-item list-group-item-action ">活動收藏</a>
      </div>
      
     
      
<c:forEach var="eventListVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+3-1%>">
      <div class="col-md-3">
        <div class="card" >         
          <div class="card-body">    
          	<h5 class="card-title">${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</h5>       
            <A href="<%=request.getContextPath() %>/eve/event.do?eve_id=${eventListVO.eve_id}&action=getOne_For_Display&whichPage=<%=request.getParameter("whichPage")%>">               
               <img class="card-img-top"  src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eventListVO.eve_id}" alt="Card image cap">  
            </A>
          </div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item  " >
            	活動日期
            	<div><fmt:formatDate value="${eveSvc.getOneEve(eventListVO.eve_id).eve_startdate}" pattern="yyyy-MM-dd HH:mm "/>~</div>
				<div><fmt:formatDate value="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate}" pattern="yyyy-MM-dd HH:mm "/> </div></li>
            <li class="list-group-item " >
            	${eventListVO.evepay_amount==0?'免費':eventListVO.evepay_amount}
            	<c:if test="${eventListVO.evepay_amount!=0}">元</c:if>
            	<c:if test="${eventListVO.evelist_status=='EL1'}">
            		(付款截止日${eventListVO.evepay_deadline})
            	</c:if>        	
            </li>
            <li class="list-group-item  " >
            <div class='text-center '>
            	<FORM class="form-inline text-center justify-content-center" METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
            		
            		<div class='px-2'>${eveListStatusMap.get(eventListVO.evelist_status)}</div>
              
				<c:if test="${eventListVO.evelist_status=='EL1'}">
									
				     <button type="submit" class="btn btn-sm btn-info">付款</button>
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action"	value="Update_ELStatus"></FORM>	
			     </c:if>
			     
			     <c:if test="${eventListVO.evelist_status=='EL5'}">
					<FORM class="form-inline text-center" METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				      <button type="submit" class="btn btn-sm btn-info">確認</button>
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action"	value="Update_ELStatus">
				    
				     </FORM>	
			     </c:if>
			     </div>		              
            </li>
          </ul>
          <div class="card-body d-flex justify-content-center">
	        <c:if test="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate.getTime()<System.currentTimeMillis()}">
				<c:if test="${eventListVO.eve_rating==0}">
	            	<a href="#register" class="btn btn-sm btn-warning mx-1">評價</a>
	          	</c:if>
					${(eventListVO.eve_rating==0)?"":eventListVO.eve_rating}				
			</c:if>	 
			<c:if test="${eventListVO.eve_share=='ES0'}">
					
						<A class="btn btn-sm btn-warning mx-1" href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_ShareStatus&whichPage=<%=request.getParameter("whichPage")%>&sharestatus=ES1">
						分享
						</A>
									
			</c:if>
			<c:if test="${eventListVO.eve_share=='ES1'}">
					
						<A class="btn btn-sm btn-warning mx-1" href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_ShareStatus&whichPage=<%=request.getParameter("whichPage")%>&sharestatus=ES0">
						取消分享
						</A>
				
			</c:if>
			
			<c:if test="${eventListVO.evelist_status=='EL0'|| eventListVO.evelist_status=='EL1'|| eventListVO.evelist_status=='EL3'}">
				
				  <FORM METHOD="post" class="form-inline" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				     <button type="submit" class="btn btn-sm btn-warning mx-1">退出</button> 
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action" value="delete_By_Participant"></FORM>
			</c:if>
          </div>
        </div>
      </div> 
</c:forEach>
	</div>
</div>	

  
  <div class="container py-2">
    <div class="row">
      <div class="list-group col-md-2"> </div>
      
<c:forEach var="eventListVO" items="${list}" begin="<%=pageIndex+3%>" end="<%=pageIndex+rowsPerPage-1%>">
        <div class="col-md-3">
        <div class="card" >         
          <div class="card-body" ${(eventListVO.mem_id==param.mem_id && eventListVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}>
            <h5 class="card-title">${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</h5>
              <img class="card-img-top"  src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eventListVO.eve_id}" alt="Card image cap">  
          </div>
          <ul class="list-group list-group-flush">
            <li class="list-group-item  " >
            	活動日期
            	<div><fmt:formatDate value="${eveSvc.getOneEve(eventListVO.eve_id).eve_startdate}" pattern="yyyy-MM-dd HH:mm "/>~</div>
				<div><fmt:formatDate value="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate}" pattern="yyyy-MM-dd HH:mm "/> </div></li>
            <li class="list-group-item " >
            	${eventListVO.evepay_amount==0?'免費':eventListVO.evepay_amount}
            	<c:if test="${eventListVO.evepay_amount!=0}">元</c:if>
            	<c:if test="${eventListVO.evelist_status=='EL1'}">
            		(付款截止日${eventListVO.evepay_deadline})
            	</c:if>        	
            </li>
            <li class="list-group-item  " >
            <div class='text-center '>
            	<FORM class="form-inline text-center justify-content-center" METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
            		
            		<div class='px-2'>${eveListStatusMap.get(eventListVO.evelist_status)}</div>
              
				<c:if test="${eventListVO.evelist_status=='EL1'}">
									
				     <button type="submit" class="btn btn-sm btn-info">付款</button>
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action"	value="Update_ELStatus"></FORM>	
			     </c:if>
			     
			     <c:if test="${eventListVO.evelist_status=='EL5'}">
					<FORM class="form-inline text-center" METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				      <button type="submit" class="btn btn-sm btn-info">確認</button>
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action"	value="Update_ELStatus">
				    
				     </FORM>	
			     </c:if>
			     </div>		              
            </li>
          </ul>
          <div class="card-body d-flex justify-content-center">
	        <c:if test="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate.getTime()<System.currentTimeMillis()}">
				<c:if test="${eventListVO.eve_rating==0}">
	            	<a href="#register" class="btn btn-sm btn-warning mx-1">評價</a>
	          	</c:if>
					${(eventListVO.eve_rating==0)?"":eventListVO.eve_rating}				
			</c:if>	 
			<c:if test="${eventListVO.eve_share=='ES0'}">
					
						<A class="btn btn-sm btn-warning mx-1" href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_ShareStatus&whichPage=<%=request.getParameter("whichPage")%>&sharestatus=ES1">
						分享
						</A>
									
			</c:if>
			<c:if test="${eventListVO.eve_share=='ES1'}">
					
						<A class="btn btn-sm btn-warning mx-1" href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_ShareStatus&whichPage=<%=request.getParameter("whichPage")%>&sharestatus=ES0">
						取消分享
						</A>
				
			</c:if>
			
			<c:if test="${eventListVO.evelist_status=='EL0'|| eventListVO.evelist_status=='EL1'|| eventListVO.evelist_status=='EL3'}">
				
				  <FORM METHOD="post" class="form-inline" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				     <button type="submit" class="btn btn-sm btn-warning mx-1">退出</button> 
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--送出本網頁的路徑給Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action" value="delete_By_Participant"></FORM>
			</c:if>
          </div>
        </div>
      </div> 
</c:forEach>
    </div>
 
    <div class="row">
    	<div class="col-md-3 offset-md-5 d-flex ">
			<%@ include file="page2_memEventlist.file" %>
		</div>
   </div>
</div>
  <script>
    window.onload=function(){
    	location.hash="#eveloc";
    	console.log(location.href);
    };
           
   </script>

<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	




