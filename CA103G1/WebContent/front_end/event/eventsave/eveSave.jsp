<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.eventsave.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="eventsaveSvc" scope="page" class="com.eventsave.model.EventSaveService" />

<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
	
	List<EventSaveVO> list=	eventsaveSvc.getEventSavesByMem(memVO.getMem_id());
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
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
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
    font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
	display: inline;
}
</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>

<style>
table {
	width: 100%;
	background-color: #1f1f1f;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #12bbad;
}

th, td {
	padding: 5px;
	text-align: center;
}

.eveImg{
	width: 100%;
	height: 180px;
}
</style>


</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
<jsp:include page="/front_end/course/purchcour/page/personlhead.jsp" />

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
	<div class="container">
		<div class="row">
			<div class="list-group col-md-2">				
				<a href="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav" class="list-group-item list-group-item-action "> 參加的活動 </a>
		        <a href="<%=request.getContextPath()%>/front_end/event/eve/listEvesByOrganizer.jsp?perpageloc=event#personalnav" class="list-group-item list-group-item-action ">主辦的活動</a>
		        <a href="<%=request.getContextPath()%>/front_end/event/eventsave/eveSave.jsp?perpageloc=event#personalnav" class="list-group-item list-group-item-action active">活動收藏</a>					
			</div>
			
			<div class="col-md-10">			
				
				
				
				<table align="center">
					<tr>
						<th width="300px">活動圖片</th>
						<th width="350px"></th>
						<th width="10px"></th>
					</tr>
					
					<%@ include file="page1.file"%>
					<c:forEach var="eventsaveVO" items="${list}"
						begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
					
						
		
						<tr>
							<td>
								<A href="<%=request.getContextPath() %>/eve/event.do?eve_id=${eventsaveVO.eve_id}&action=getOne_For_Display">
									<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eventsaveVO.eve_id}">
								</A>
							</td>
							<td style="text-align:left">
							
								<h1>活動名稱：${eveSvc.getOneEve(eventsaveVO.eve_id).eve_title}<h1>
									<p><h4>主辦人：${memSvc.getOneMem(eveSvc.getOneEve(eventsaveVO.eve_id).mem_id).mem_name}</h4></p> 
								<div style="font-style: 14px;">報名截止日期：${eveSvc.getOneEve(eventsaveVO.eve_id).ereg_enddate}</div>
							</td>

							<td>
								<a href="<%=request.getContextPath() %>/eve/event.do?eve_id=${eventsaveVO.eve_id}&action=getOne_For_Display" class="btn btn-info" style = "margin-bottom: 30px">活動資訊</a>
								<br>
								<FORM METHOD="post"	ACTION="<%=request.getContextPath()%>/eventsave/eventsave.do">
									<input type="submit" class="btn btn-danger" value="取消收藏">
									<input type="hidden" name="mem_id" value="${eventsaveVO.mem_id}">
									<input type="hidden" name="eve_id" value="${eventsaveVO.eve_id}">
									<input type="hidden" name="action" value="delete">
								</FORM>
							</td>
							

									
						</tr>
					
				</c:forEach>
				</table>
				<%@ include file="page2.file"%>				
				
				
			</div>								
		</div>
	</div>




<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->