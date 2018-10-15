<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*"%>

<%
	MemVO memVO = (MemVO) session.getAttribute("memVO");

	String perpageloc = request.getParameter("perpageloc");
	session.setAttribute("perpageloc", perpageloc);
	String sessionPerpageloc = (String) session.getAttribute("perpageloc");

	PlanService planSvc = new PlanService();
	List<PlanVO> list = planSvc.getAllforVisitor();
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="sptypeSvc" scope="page" class="com.sptype.model.SptypeService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

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
<link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<!-- fafaicon -->
<link rel="stylesheet" crossorigin="anonymous"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ">


<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/index.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<style>
/*頁面設定*/
body {
	overflow-x: hidden;
}

table {
	width: 1800px;
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

h5 {
	font-size: 30px;
	color: red;
}

/*圖片專區*/
.plan_cover {
	width: 165px;
	depth: 165px;
	border-radius: 100%;
}
</style>

<!-- navbar setting -->
<style type="text/css">
a, .fontstyle {
	font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
}
</style>




</head>

<body class="text-center">

	<!-- Navbar -->
	<nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
		<span class="navbar-text"></span>
		<div class="container">
			<button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" 
				data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" 
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
				<a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" 
					href="<%=request.getContextPath()%>/index.jsp">WORK it OUT</a>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-2 btn-lg">
						<c:if test="${memVO.mem_id ==null }">
							<a class="nav-link"
								href="<%=request.getContextPath()%>/front_end/plan/ListAllPlans_ForVisitor.jsp">WorkOutPlan</a>
						</c:if> 
						<c:if test="${memVO.mem_id !=null }">
							<a class="nav-link"
								href="<%=request.getContextPath()%>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
						</c:if>
					</li>
					<li class="nav-item mx-2 btn-lg">
						<a class="nav-link" 
							href="<%=request.getContextPath()%>/front_end/event/eve/listAllEve.jsp">Event</a>
					</li>
					<li class="nav-item mx-2 btn-lg">
						<a class="nav-link"
							href="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp">Course</a>
					</li>

					<jsp:useBean id="coachSvc" scope="page" class="com.coach.model.CoachService" />
					<c:if test="${memVO!=null}">
						<li class="nav-item mx-2 btn-lg dropdown">
							<a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">${memVO.mem_name} 
								<i class="fa fa-caret-down dropbtn"></i>
							</a>
							<div class="dropdown-content" id="myDropdown">
								<a href="<%=request.getContextPath()%>/front_end/post/listAllPostByMem09.jsp">
									<i class="fa fa-file ">
										<font class="fontstyle">&nbsp&nbsp個人頁面</font>
									</i>
								</a>
								<a href="<%=request.getContextPath()%>/front_end/plan/My_Plan_myself.jsp">
									<i class="fa fa-calculator">
										<font class="fontstyle">&nbsp&nbsp計畫</font>
									</i>
								</a>
								<a href="#">
									<i class="fa fa-users " aria-hidden="true">
										<font class="fontstyle">&nbsp&nbsp好友</font>
									</i>
								</a> 
								<a href="<%=request.getContextPath()%>/front_end/course/purchcour/page/purchcour.jsp">
									<i class="fa fa-film" aria-hidden="true">
										<font class="fontstyle">&nbsp&nbsp課程</font>
									</i>
								</a> 
								<a href="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp">
									<i class="fa fa-hand-spock-o" aria-hidden="true">
										<font class="fontstyle">&nbsp&nbsp活動</font>
									</i>
								</a>
<!--               <a href=""><i class="fa fa-file">&nbsp&nbsp貼文</i></a> -->
								<a href="<%=request.getContextPath()%>/front_end/calendar/page/Calendar.jsp">
									<i class="fa fa-check" aria-hidden="true">
										<font class="fontstyle">&nbsp&nbsp行事曆</font>
									</i>
								</a>

								<c:if test="${coachSvc.getOneCoachByMemId(memVO.mem_id)!=null}">
									<a href="<%=request.getContextPath()%>/front_end/course/coach/page/coach.jsp">
										<i class="fa fa-sticky-note">
											<font class="fontstyle">&nbsp&nbsp教練管理</font>
										</i>
									</a>
								</c:if>
								<a href="<%=request.getContextPath()%>/front_end/mem/updateMember/updateMember.jsp">
									<i class="fa fa-address-card" aria-hidden="true">
										<font class="fontstyle">&nbsp&nbsp會員資料</font>
									</i>
								</a> 
								<a href="<%=request.getContextPath()%>/mem/mem.do?action=loggedout">
									<font class="fontstyle">登出</font>
								</a>
							</div>
						</li>
					</c:if>
				</ul>
				<c:if test="${memVO==null}">
					<a class="btn btn-lg btn-primary" href="<%=request.getContextPath()%>/Mem_Login_Signup.jsp" 
						id="registerBtn">Register now</a>
				</c:if>
			</div>
		</div>
	</nav>
	<!-- Cover -->
	<div class="d-flex align-items-center cover section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/assets/conference/jogback.jpg&quot;);">
	</div>
	
<!-- NavBar Personal focus 判斷式-->

	<%
		if (sessionPerpageloc != null) {String sessionPerpagelocClass = "#" + sessionPerpageloc;
	%>

	<script>
	$(document).ready(function() {
		$("<%=sessionPerpagelocClass%>").css({
			"color" : "#12bbad",
			"border-bottom" : " 0.8px solid #12bbad"
		});
	});
	</script>
	<%
		}
	%>

	<script>
		$(document).ready(function() {
			$(".personalnavlink").click(function() {
				var href = this.rel;
				location.href = href;
			});

		});
	</script>


<!-- NavBar Personal-->
	<div class="container containerHrT ">
		<hr>
	</div>
	
	<nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
		<div class="container">
			<div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
				<ul class="navbar-nav">
					<!-- HomePage-->
					<li class="nav-item">
						<a class="nav-link personalnavlink" rel="<%=request.getContextPath()%>/index.jsp" 
							id="mypage" style="cursor: pointer;"> 
								<i class="fa fa-file"></i>&nbsp; &nbsp; HomePage &nbsp; &nbsp;&nbsp;
						</a>
					</li>
					
					<!-- Workoutplan-->
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle personalnavlink" aria-expanded="false" aria-haspopup="true" 
							data-toggle="dropdown" id="workoutplan" style="cursor: pointer;" rel="<%=request.getContextPath()%>/front_end/plan/ListAllPlans_ForVisitor_test.jsp"> 
							<i class="fa fa-calculator"></i> &nbsp; WorkOutPlan &nbsp;
						</a>
					</li>
					
					<!-- Friend-->
					<li class="nav-item">
						<a class="nav-link personalnavlink" id="friend" style="cursor: pointer;"
							rel="<%=request.getContextPath()%>/front_end/plan/plan_wrong.jsp"> 
								<i class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends &nbsp;&nbsp;
						</a>
					</li>
					<!--Course  -->
					<li class="nav-item">
						<a class="nav-link personalnavlink" id="course" style="cursor: pointer;"
							rel="<%=request.getContextPath()%>/index.jsp">
							<i class="fa fa-film" aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
						</a>
					</li>
					<li class="nav-item dropdown">
						<a class="nav-link personalnavlink" id="event" style="cursor: pointer;" 
							rel="<%=request.getContextPath()%>/index.jsp"> 
							<i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event &nbsp;&nbsp;
						</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container containerHrB ">
		<hr>
	</div>

	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing" href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="fab fa-rocketchat"></i>
	</a>

	<div class="form-control" style="background-color: #1f1f1f">
		<h5>全部計畫清單，可供修改、刪除。10</h5>  
		<%-- 錯誤表列 --%>
		<c:if test="${not empty errorMsgs}">
			<font style="color: red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color: red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>

		<FORM METHOD="post"
			ACTION="<%=request.getContextPath()%>/plan/plan.do"
			style="margin-bottom: 0px;">
			<input type="hidden" name="action" value="VisitorPage">
			<table>
				<tr>
					<th>計畫封面</th>
					<th>計畫名稱</th>
					<th>計畫創建人</th>
					<th>計畫內容</th>
					<th>計畫開始日</th>
					<th>計畫結束日</th>
					<th>運動類別</th>
					<th>瀏覽數</th>
					<th>創建時間</th>
					<th>執行狀態</th>
					<th>隱私權</th>
				</tr>
				<%@ include file="file/page1.file"%>
				<c:forEach var="planVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">
					<%-- 					<c:if test="${!((planVO.plan_privacy == 'PLANPR1') || (planVO.plan_privacy == 'PLANPR2'))}"> --%>
					<c:if test="${(planVO.plan_privacy == 'PLANPR0')}">

						<tr>
							<td><img class="plan_cover"
								src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
							</td>
							<td>${planVO.plan_name}</td>
							<td><c:forEach var="memVO" items="${memSvc.all }">
									<c:if test="${planVO.mem_id == memVO.mem_id }">${memVO.mem_name}</c:if>
								</c:forEach></td>
							<td>${planVO.plan_vo}</td>
							<td>${planVO.plan_start_date}</td>
							<td>${planVO.plan_end_date}</td>
							<td><c:forEach var="sptypeVO" items="${sptypeSvc.all}">
									<c:if test="${planVO.sptype_id ==sptypeVO.sptype_id }">${sptypeVO.sport}</c:if>
								</c:forEach></td>
							<td>${planVO.plan_view}</td>
							<td>${planVO.plan_create_time}</td>
							<td><c:if test="${planVO.plan_status =='PLANST0'}">進行中</c:if>
								<c:if test="${planVO.plan_status =='PLANST1'}">已完成</c:if></td>
							<td><c:if test="${planVO.plan_privacy =='PLANPR0'}">公開</c:if>
								<c:if test="${planVO.plan_privacy =='PLANPR1'}">不公開</c:if> <c:if
									test="${planVO.plan_privacy =='PLANPR2'}"> 只對朋友公開</c:if></td>
						</tr>
					</c:if>
				</c:forEach>
			</table>
			<%@ include file="file/page2.file"%>
		</FORM>
	</div>

	<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
	<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

</body>


</html>