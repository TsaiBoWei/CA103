<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*"%>

<%

	PlanVO planVO = (PlanVO) request.getAttribute("planVO");
	pageContext.setAttribute("planVO", planVO);

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
<link rel="stylesheet" crossorigin="anonymous" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ">


<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<style>


	/*頁面設定*/
	body {
		overflow-x: hidden;
	}
	
	h5 {
		font-size: 23px;
		color: #00FFFF;
	}
	
	p {
		font-size: 18px;
	}


	#img123{
		
		background-image: 150px;
		
	}
	
	.img-fluid{
	
		width: 450px;
		border-radius: 100%;
	}

</style>

<!-- navbar setting -->

<style type="text/css">
	a, .fontstyle {
		font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
	}
	
	.navbar-dark .navbar-nav .nav-link{
		color:rgba(255, 255, 255, 0.8)!important;
		font-weight:bold!important;
	
	}

</style>

</head>

<body class="text-center">

	<!-- Navbar -->
	<nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
		<span class="navbar-text"></span>
		<div class="container">
			<button class="navbar-toggler navbar-toggler-right" type="button"
				aria-expanded="false" data-toggle="collapse" data-target="#navbar2SupportedContent"
				aria-controls="navbar2SupportedContent" aria-label="Toggle navigation">
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
							<a class="nav-link" href="<%=request.getContextPath()%>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
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
							<a class="nav-link dropbtn"  href="javascript:void(0)" 
								id="navUserName">${memVO.mem_name} 
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
		if (sessionPerpageloc != null) {
			String sessionPerpagelocClass = "#" + sessionPerpageloc;
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


 	<P>3789</P>


<!-- 		<div class="py-5"> -->
	<div class="py-5 text-light opaque-overlay section-fade-in-out" id="img123"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/img/rsz_test2.jpg&quot;);">
			<div class="container">
				<div class="row">
					<div class="p-0 col-lg-5 order-2 order-lg-1">
						<img class="img-fluid d-block"
							src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
					</div>
					<div
						class="d-flex flex-column justify-content-center p-3 col-lg-7 order-1 order-lg-2">
						<a class="btn btn-outline-secondary mb-3"
							href="https://tw.yahoo.com/">Read more</a> <a
							class="btn btn-primary mb-3"
							href="https://shopping.pchome.com.tw/">Main action</a> <a
							class="btn btn-link" href="https://shopee.tw/">Link</a>
						<p class="lead mb-0">
							123456789來到減脂期的運動課表安排的時間啦，接下來我們就要來看一下中體脂的朋友，也就是體脂約在20%～30%的朋友如何安排運動課表。
							我一直強調無氧運動跟鍛練肌肉的重要性，「為什麼無氧運動跟肌力訓練會那麼重要呢？」
							簡單來說因為有氧運動對於增肌是沒什麼效果的，即使是有氧運動類別是世界級或專業級的選手，例如長跑，馬拉松，腳踏車等，也都不會只做長時間有氧的訓練，除了心肺跟肌耐力的訓練外，也會安排很多的肌力阻力以及爆發力的訓練以增進運動表現。

						</p>
					</div>
				</div>
			</div>
		</div>
<!-- 	</div> -->





	<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->


</body>


</html>