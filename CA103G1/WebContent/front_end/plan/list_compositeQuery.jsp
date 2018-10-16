<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%
	PlanService planSvc = new PlanService();
	List<PlanVO> list = (List<PlanVO>)(request.getAttribute("listPlans_ByCompositeQuery"));
	request.setAttribute("list", list);
%>

<jsp:useBean id="listPlans_ByCompositeQuery" scope="session" type="java.util.List<PlanVO>" /> <!-- 於EL此行可省略 -->

<jsp:useBean id="sptypeSvc" scope="page"
	class="com.sptype.model.SptypeService" />


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>WORK it OUT</title>

<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">

<style>
/*頁面設定*/
body {
	overflow-x: hidden;
}


table {
 	width: 1850px; 
/* 	background-color: #E0FFFF; */
 	color: #FFFFFF; 
	font-size: 18px;
	margin-top: 10px;
	margin-bottom: 10px;
}

table, th, td {
	border: 1px solid #00FFFF;
}

th, td {
	padding: 8px;
	text-align: center;
}

.plan_cover {
	width: 165px;
	depth: 165px;
	border-radius: 100%;
}

h5	{
	 font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
	 font-size: 18px;
	 color: #FFFF00;

}

b {
	font-size: 16px;
	color: white;
}
</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>




</head>
<body>
<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlhead.jsp" />
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
	
	<div class="form-control" style="background-color: #1f1f1f">
		<h5>我的計畫清單，可供修改、刪除。5</h5>
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

		<table>
			<tr>
				<th>計畫封面</th>
				<th>計畫名稱</th>
				<th>計畫編號</th>
				<th>計畫創建人</th>
				<th>計畫內容</th>
				<th>計畫開始日</th>
				<th>計畫結束日</th>
				<th>運動類別</th>
				<th>瀏覽數</th>
				<th>創建時間</th>
				<th>執行狀態</th>
				<th>隱私權</th>
				<th>修改</th>
				<th>刪除</th>
			</tr>
			<%@ include file="file/page1_ByCompositeQuery.file" %>    
			<c:forEach var="planVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
				<tr ${(planVO.plan_id==param.plan_id) ? 'bgcolor=#0066FF':''}>
					<td>
						<img class="plan_cover" 
							 src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
					</td>
					<td>${planVO.plan_name}</td>
					<td>${planVO.plan_id}</td>
					<td>${planVO.mem_id}</td>
					<td>${planVO.plan_vo}</td>
					<td>${planVO.plan_start_date}</td>
					<td>${planVO.plan_end_date}</td>
					<td><c:forEach var="sptypeVO" items="${sptypeSvc.all}">
							<c:if test="${planVO.sptype_id ==sptypeVO.sptype_id }">
								${sptypeVO.sport}
								</c:if>
						</c:forEach></td>
					<td>${planVO.plan_view}</td>
					<td>${planVO.plan_create_time}</td>
					<td>
						<c:if test="${planVO.plan_status =='PLANST0'}">進行中</c:if> 
						<input type="hidden" value="PLANST0">
						<c:if test="${planVO.plan_status =='PLANST1'}">已完成</c:if>
						<input type="hidden" value="PLANST1">
					</td>
					<td>
						<c:if test="${planVO.plan_privacy =='PLANPR0'}">公開</c:if>
						<c:if test="${planVO.plan_privacy =='PLANPR1'}">不公開</c:if>
						<c:if test="${planVO.plan_privacy =='PLANPR2'}"> 只對朋友公開</c:if>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/plan/plan.do"
							style="margin-bottom: 0px;">
							<input type="submit" value="修改"> 
							<input type="hidden" name="plan_id" value="${planVO.plan_id}"> 
							<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>"> 
							<input type="hidden" name="action" value="getOne_For_Update">
						</FORM>
					</td>
					<td>
						<FORM METHOD="post"
							ACTION="<%=request.getContextPath()%>/plan/plan.do"
							style="margin-bottom: 0px;">
							<input type="submit" value="刪除"> 
							<input type="hidden" name="plan_id" value="${planVO.plan_id}"> 
							<input type="hidden" name="action" value="delete">
						</FORM>
					</td>
				</tr>
			</c:forEach>
		</table>
		<%@ include file="file/page2_ByCompositeQuery.file"%>
	</div>
		<br>本網頁的路徑:<br><b>
   <font color=white>request.getServletPath(): <%=request.getServletPath()%><br></font>
   <font color=white>request.getRequestURI():  <%=request.getRequestURI()%></font> </b>
		
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->

</body>

</html>