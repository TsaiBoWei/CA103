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
<title>sss456 it OUT</title>

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

/* 
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


<!-- start -->

<script src='//static.codepen.io/assets/editor/live/console_runner-ce3034e6bde3912cc25f83cccb7caa2b0f976196f2f2d52303a462c826d54a73.js'></script><script src='//static.codepen.io/assets/editor/live/css_live_reload_init-e9c0cc5bb634d3d14b840de051920ac153d7d3d36fb050abad285779d7e5e8bd.js'></script><meta charset='UTF-8'><meta name="robots" content="noindex"><link rel="shortcut icon" type="image/x-icon" href="//static.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" /><link rel="mask-icon" type="" href="//static.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" /><link rel="canonical" href="https://codepen.io/DerkJanS/pen/amRpGb" />


<style class="cp-pen-styles">@import url('https://fonts.googleapis.com/css?family=Poppins:400,700');

* {
  margin: 0;
  padding: 0;
}
body {
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='#c1c4cb',GradientType=1 );
  padding: 100px;
  font-family: 'Poppins', sans-serif;
}

.container {
  position: relative;
  margin: auto;
  width: 100%;
  max-width: 1200px;
}

/* option */
.option {
  -webkit-display: flex;
  display: flex;
  color: #FFF;
}
.option .side, .option .divider, .option .right-finish {
  -webkit-flex: none;
  flex: none;
}
/* side */
.option .side {
  position: relative;
  width: 160px;
  -webkit-transform: translateY(24px);
  transform: translateY(24px);
}
.side-top {
  position: absolute;
  height: 50px;
  width: 100%;
  -webkit-transform: translateY(-98%);
  transform: translateY(-98%);
}
.option-info {
  position: absolute; 
  left: 0;
  bottom: 0;
  width: 100%;
}
.side span {
  display: block;
  padding: 0 20px;
  line-height: 1.15em;
  text-align: center;
  font-size: 30px;
  font-weight: 700;
}
.side .number {
  font-size: 80px;
}
/* divider */
.option .divider {
  position: relative;
  width: 50px;
}
.option .divider-overlay {
  background-color: #000;
  height: 100%;
  width: 100%;
  opacity: .3;
}
.divider-skew, .divider-skew-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 25px 50px 0 0;
}
.divider-skew-overlay {
  opacity: .3;
  border-color: #000 transparent transparent transparent;
}
.divider-skew.divider-skew-top, .divider-skew-overlay.divider-skew-top {
  top: -25px;
  border-width: 25px 0 0 50px;
}
.divider-skew-overlay.divider-skew-top {
  border-color: transparent transparent transparent #000;
}
.divider-skew-bot {
  top: auto;
  bottom: -24px;
}
/* main */
.main {
  position: relative;
  text-align: center;
}
/* shadow */
.main .box-shadow {
  position: absolute;
  top: 0;
  left: 0;
  height: 100px;
  width: 100%;
  overflow: hidden;
  -webkit-transform-origin: left;
  transform-origin: left;
}
.main .box-shadow .blur.rotate {
  height: 100%;
  width: 100%;
  filter: blur(5px);
  -webkit-transform: translate(0, -77%) rotate(4deg);
  transform: translate(0, -77%) rotate(4deg);
}
.main .box-shadow.box-shadow-bot {
  top: auto;
  bottom: 0;
  -webkit-transform: translate(0, 100%);
  transform: translate(0, 100%);
}
.main .box-shadow .gradient {
  background: -moz-linear-gradient(left,  rgba(0,0,0,0.7) 0%, rgba(0,0,0,0) 100%);
  background: -webkit-linear-gradient(left,  rgba(0,0,0,0.7) 0%,rgba(0,0,0,0) 100%);
  background: linear-gradient(to right,  rgba(0,0,0,0.7) 0%,rgba(0,0,0,0) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#b3000000', endColorstr='#00000000',GradientType=1 );
  height: 100%;
  width: 100%;
}
/* content */
.main .content {
  display: -webkit-flex;
  display: flex;
}
.main .content .text {
  -webkit-flex: 1;
  flex: 1;
  padding: 30px 20px 20px 20px;
}
.main .content .text h2, .main .content .text .subtitle {
  display: inline-block;
  line-height: 1em;
  letter-spacing: 10px;
  text-transform: uppercase;
  font-weight: 700;
}
.main .content .text h2 {
  position: relative;
  padding: 0 .5em;
  font-size: 50px;
}
.main .content .text h2:after, .main .content .text h2:before {
  position: absolute;
  content: '';
  left: 0;
  top: 50%;
  height: 8px;
  width: 8px;
}
.main .content .text h2:after {
  background-color: #FFF;
  -webkit-transform: translate(25%, -75%);
  transform: translate(25%, -75%);
}
.main .content .text h2:before {
  background-color: #000;
  opacity: .6;
  -webkit-transform: translate(-25%, -125%);
  transform: translate(-25%, -125%);
}
.main .content .text .subtitle {
  background-color: #FFF;
  color: #3B454F;
  padding: .25em .5em .25em 1em;
  margin-bottom: 10px;
}
.main .content .icon {
  position: relative;
  -webkit-flex: none;
  flex: none;
  margin-right: 20px;
}
.main .content .icon svg {
  fill: currentColor;
  height: 100%;
  width: 100px;
}
.main .content .icon .icon-shadow {
  position: absolute;
  background: #000;
  top: 75%;
  left: 50%;
  height: 10px;
  width: 80%;
  opacity: .5;
  border-radius: 100%;
  filter: blur(4px);
  -webkit-transform: translate(-50%);
  transform: translate(-50%);
}

/* right finish */
.right-finish {
  width: 150px;
}
.right-fill {
  width: 0;
  height: 0;
  border-style: solid;
}

/* overlay */
.side-overlay, .side-overlay-shadow {
  position: absolute;
  top: -.5px;
  left: -1px;
  width: 0;
  height: 0;
  border-style: solid;
  border-width: 80px 81px 0 81px;
}
.side-overlay-shadow {
  filter: blur(2px);
  opacity: .6;
  left: 50%;
  border-width: 80px 75px 0 75px;
  border-color: #000 transparent transparent transparent;
  -webkit-transform: translate(-50%, 8px);
  transform: translate(-50%, 8px);
}
.side-overlay-bot {
  top: auto;
  bottom: 0;
}
.side-overlay.side-overlay-bot {
  -webkit-transform: translate(0%, 98%);
  transform: translate(0%, 98%);
}
.side-overlay-shadow.side-overlay-bot {
  -webkit-transform: translate(-50%, 107%);
  -webkit-transform: translate(-50%, calc(98% + 8px));
  transform: translate(-50%, 107%);
  transform: translate(-50%, calc(98% + 8px));
}

/* option1 */
.option1 .side, .option1 .side-top, .option1 .divider {
  background: #62D8E2;
}
.option1 .main {
  background: rgb(78,186,198);
  background: -moz-linear-gradient(left,  rgba(78,186,198,1) 0%, rgba(100,213,227,1) 100%);
  background: -webkit-linear-gradient(left,  rgba(78,186,198,1) 0%,rgba(100,213,227,1) 100%);
  background: linear-gradient(to right,  rgba(78,186,198,1) 0%,rgba(100,213,227,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#4ebac6', endColorstr='#64d5e3',GradientType=1 );
}
.option1-side-overlay, .option1-divider-skew, .option1 .right-fill {
  border-color: #64D5E3 transparent transparent transparent;
}
.option1 .divider-skew.divider-skew-top {
  border-color: transparent transparent transparent #64D5E3;
}

/* option2 */
.option2 .side, .option2 .divider {
  background: #FF4C1A;
}
.option2 .main {
  background: rgb(207,65,15);
  background: -moz-linear-gradient(left,  rgba(207,65,15,1) 0%, rgba(255,77,29,1) 100%);
  background: -webkit-linear-gradient(left,  rgba(207,65,15,1) 0%,rgba(255,77,29,1) 100%);
  background: linear-gradient(to right,  rgba(207,65,15,1) 0%,rgba(255,77,29,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#cf410f', endColorstr='#ff4d1d',GradientType=1 );
}
.option2-side-overlay, .option2-divider-skew {
  border-color: #FF4C1A transparent transparent transparent;
}
.option2 .right-fill {
  border-color: #FD5014 transparent transparent transparent;
}

/* option3 */
.option3 {
  color: #3B454F;
}
.option3 .side, .option3 .divider {
  background: #FCFCFC;
}
.option3 .main {
  background: rgb(223,224,226);
  background: -moz-linear-gradient(left,  rgba(223,224,226,1) 0%, rgba(255,255,255,1) 100%);
  background: -webkit-linear-gradient(left,  rgba(223,224,226,1) 0%,rgba(255,255,255,1) 100%);
  background: linear-gradient(to right,  rgba(223,224,226,1) 0%,rgba(255,255,255,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#dfe0e2', endColorstr='#ffffff',GradientType=1 );
}
.option3 .main .content .text .subtitle {
  background-color: #3B454F;
  color: #FFF;
}
.option3-side-overlay, .option3-divider-skew {
  border-color: #FCFCFC transparent transparent transparent;
}
.option3 .right-fill {
  border-color: #FFFFFF transparent transparent transparent;
}

/* option4 */
.option4 .side, .option4 .divider {
  background: #F6AA18;
}
.option4 .main {
  background: rgb(219,150,13);
  background: -moz-linear-gradient(left,  rgba(219,150,13,1) 0%, rgba(248,167,26,1) 100%);
  background: -webkit-linear-gradient(left,  rgba(219,150,13,1) 0%,rgba(248,167,26,1) 100%);
  background: linear-gradient(to right,  rgba(219,150,13,1) 0%,rgba(248,167,26,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#db960d', endColorstr='#f8a71a',GradientType=1 );
}
.option4-side-overlay, .option4-divider-skew, .option4 .right-fill {
  border-color: #F6AA18 transparent transparent transparent;
}

/* option5 */
.option5 .side, .option5 .divider {
  background: #3B454F;
}
.option5 .main {
  background: rgb(61,68,78);
  background: -moz-linear-gradient(left,  rgba(61,68,78,1) 0%, rgba(81,84,89,1) 100%);
  background: -webkit-linear-gradient(left,  rgba(61,68,78,1) 0%,rgba(81,84,89,1) 100%);
  background: linear-gradient(to right,  rgba(61,68,78,1) 0%,rgba(81,84,89,1) 100%);
  filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#3d444e', endColorstr='#515459',GradientType=1 );, .option5 .right-fill
}
.option5 .right-fill {
  border-color: #515459 transparent transparent transparent;
}
.option5-side-overlay, .option5-divider-skew, .option5 .divider-skew.divider-skew-bot {
  border-color: #3B454F transparent transparent transparent;
}</style>


<!-- end -->


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


<!-- NavBar Personal-->
	<div class="container containerHrT ">
		<hr>
	</div>
	
	<nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
		<div class="container">
			<div class="collapse navbar-collapse text-right justify-content-center marignBun"
				id="navbar3SupportedContent">
				<ul class="navbar-nav">

					<!-- HomePage-->
					<li class="nav-item">
						<a class="nav-link personalnavlink" id="mypage" style="cursor: pointer;"
							rel="<%=request.getContextPath()%>/index.jsp"> 
							<i class="fa fa-file"></i>&nbsp;&nbsp; PersonalPage &nbsp; &nbsp;&nbsp;
						</a>
					</li>

					<!-- Workoutplan-->
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle personalnavlink"  style="cursor: pointer;"
						aria-haspopup="true" id="workoutplan" aria-expanded="false" data-toggle="dropdown"		
						rel="<%=request.getContextPath()%>/front_end/plan/ListAllPlans_ForVisitor.jsp">
							<i class="fa fa-calculator"></i> &nbsp; WorkOutPlan &nbsp;
						</a>
					</li>


					<!--Course  -->
					<li class="nav-item">
						<a class="nav-link personalnavlink" id="course" style="cursor: pointer;"
							rel="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp"> 
							<i class="fa fa-film" aria-hidden="true"></i>&nbsp; &nbsp;Course&nbsp; &nbsp;
						</a>
					</li>
				
					<li class="nav-item dropdown">
						<a class="nav-link personalnavlink" id="event" style="cursor: pointer;"
							rel="<%=request.getContextPath()%>/front_end/event/eve/listAllEve.jsp"> 
							<i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event&nbsp;&nbsp;
						</a>
					</li>
					
				</ul>
			</div>
		</div>
	</nav>

	<div class="container containerHrB ">
		<hr>
	</div><br>

<!-- start -->

<div class="container">
  <div class="option option1">
    <div class="side">
      <div class="side-top"></div>
      <div class="option-info">
        <span>option</span>
        <span class="number">01</span>
      </div>
    </div>
    
    <div class="divider">
      <div class="divider-overlay"></div>
      <div class="divider-skew divider-skew-top"></div>
      <div class="divider-skew-overlay divider-skew-top"></div>
    </div>
    
    <div class="main">
      <div class="content">
      	<div class="text">
	        <h2>Title</h2>
	        <br/>
	        <span class="subtitle">your subtitle</span>
	        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
        <div class="icon">
        	<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"  viewBox="0 0 1024 1024" enable-background="new 0 0 1024 1024" xml:space="preserve">
        		<path d="M819.52 819.2h-179.52c-14.139 0-25.6-11.461-25.6-25.6s11.461-25.6 25.6-25.6h179.52c84.518 0 153.28-68.762 153.28-153.28s-68.762-153.28-153.28-153.28c-18.005 0-35.626 3.086-52.368 9.173-11.168 4.056-23.654-0.099-30.163-10.035-6.507-9.938-5.323-23.048 2.859-31.659 18.154-19.106 28.152-44.15 28.152-70.518 0-56.464-45.936-102.4-102.4-102.4-32.858 0-62.912 15.187-82.456 41.667-11.704 15.859-18.533 34.638-19.746 54.307-0.67 10.867-8.141 20.122-18.622 23.069s-21.682-1.059-27.915-9.984l-0.238-0.342c-5.49-7.795-11.549-15.443-17.952-22.653-48.587-54.694-118.374-86.064-191.47-86.064-141.158 0-256 114.842-256 256 0 141.16 114.842 256 256 256h128c14.138 0 25.6 11.461 25.6 25.6s-11.462 25.6-25.6 25.6h-128c-169.39 0-307.2-137.81-307.2-307.2s137.81-307.2 307.2-307.2c82.050 0 160.621 32.933 218.142 90.901 4.47-9.989 10.026-19.52 16.608-28.438 28.867-39.112 75.090-62.462 123.65-62.462 84.696 0 153.6 68.904 153.6 153.6 0 17.976-3.099 35.542-9.035 52.050 3.11-0.139 6.23-0.21 9.357-0.21 112.75 0 204.48 91.73 204.48 204.48-0.002 112.75-91.731 204.48-204.482 204.48z"/>
        		<path d="M658.101 621.899l-102.4-102.4c-9.997-9.997-26.206-9.997-36.203 0l-102.4 102.4c-9.997 9.997-9.997 26.206 0 36.203s26.206 9.997 36.205 0l58.698-58.698v194.195c0 14.139 11.461 25.6 25.6 25.6s25.6-11.461 25.6-25.6v-194.195l58.699 58.698c4.998 4.998 11.549 7.498 18.101 7.498s13.102-2.499 18.101-7.499c9.998-9.997 9.998-26.205 0-36.202z" />
        	</svg>
        	<div class="icon-shadow"></div>
        </div>
      </div>
    </div>
    <div class="right-finish">
      <div class="right-fill"></div>
    </div>
  </div>
  <div class="option option2">
    <div class="side">
      <div class="side-overlay-shadow"></div>
      <div class="side-overlay option1-side-overlay"></div>
      <div class="option-info">
        <span>option</span>
        <span class="number">02</span>
      </div>
    </div>
    <div class="divider">
      <div class="divider-overlay"></div>
      <div class="divider-skew option1-divider-skew"></div>
      <div class="divider-skew-overlay"></div>
    </div>
    <div class="main">
      <div class="box-shadow">
      	<div class="blur rotate">
	      	<div class="gradient"></div>
      	</div>
      </div>
      <div class="content">
      	<div class="text">
	        <h2>Title</h2>
	        <br/>
	        <span class="subtitle">your subtitle</span>
	        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
        <div class="icon">
        	<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"  viewBox="0 0 1024 1024" enable-background="new 0 0 1024 1024" xml:space="preserve">
        		<path d="M947.2 921.6h-563.2c-42.347 0-76.8-34.453-76.8-76.8 0-2.461 0.538-60.952 47.331-118.544 26.883-33.088 63.541-59.31 108.952-77.941 54.856-22.504 122.858-33.915 202.117-33.915s147.261 11.411 202.117 33.915c45.411 18.63 82.067 44.853 108.952 77.941 46.794 57.592 47.331 116.083 47.331 118.544 0 42.347-34.453 76.8-76.8 76.8zM358.4 844.931c0.072 14.056 11.528 25.469 25.6 25.469h563.2c14.072 0 25.528-11.413 25.6-25.469-0.048-1.786-1.656-45.802-37.851-88.786-49.88-59.235-143.019-90.546-269.349-90.546s-219.469 31.31-269.349 90.546c-36.194 42.984-37.803 87-37.851 88.786z" />
        		<path d="M665.6 563.2c-112.926 0-204.8-91.874-204.8-204.8 0-112.928 91.874-204.8 204.8-204.8s204.8 91.872 204.8 204.8c0 112.926-91.874 204.8-204.8 204.8zM665.6 204.8c-84.696 0-153.6 68.904-153.6 153.6s68.904 153.6 153.6 153.6 153.6-68.904 153.6-153.6-68.904-153.6-153.6-153.6z" />
        		<path d="M230.4 921.6h-153.6c-42.347 0-76.8-34.451-76.8-76.8 0-1.915 0.386-47.446 33.92-92.16 19.373-25.832 45.778-46.299 78.483-60.834 39.126-17.389 87.438-26.206 143.597-26.206 9.16 0 18.232 0.235 26.962 0.701 14.118 0.754 24.954 12.81 24.2 26.928-0.752 14.117-12.781 24.96-26.928 24.2-7.826-0.418-15.979-0.629-24.234-0.629-199.366 0-204.666 121.826-204.8 128.131 0.072 14.054 11.528 25.469 25.6 25.469h153.6c14.138 0 25.6 11.461 25.6 25.6s-11.462 25.6-25.6 25.6z" />
        		<path d="M256 614.4c-84.696 0-153.6-68.904-153.6-153.6s68.904-153.6 153.6-153.6 153.6 68.904 153.6 153.6-68.904 153.6-153.6 153.6zM256 358.4c-56.464 0-102.4 45.936-102.4 102.4s45.936 102.4 102.4 102.4 102.4-45.936 102.4-102.4c0-56.464-45.936-102.4-102.4-102.4z" />
        	</svg>
        	<div class="icon-shadow"></div>
        </div>
      </div>
    </div>
    <div class="right-finish">
      <div class="right-fill"></div>
    </div>
  </div>
  <div class="option option3">
    <div class="side">
      <div class="side-overlay-shadow"></div>
      <div class="side-overlay option2-side-overlay"></div>
      <div class="option-info">
        <span>option</span>
        <span class="number">03</span>
      </div>
    </div>
    <div class="divider">
      <div class="divider-overlay"></div>
      <div class="divider-skew option2-divider-skew"></div>
      <div class="divider-skew-overlay"></div>
    </div>
    <div class="main">
      <div class="box-shadow">
      	<div class="blur rotate">
	      	<div class="gradient"></div>
      	</div>
      </div>
      <div class="content">
      	<div class="text">
	        <h2>Title</h2>
	        <br/>
	        <span class="subtitle">your subtitle</span>
	        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
        <div class="icon">
        	<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"  viewBox="0 0 1024 1024" enable-background="new 0 0 1024 1024" xml:space="preserve">
        		<path d="M896 1024h-819.2c-42.347 0-76.8-34.451-76.8-76.8v-819.2c0-42.347 34.453-76.8 76.8-76.8h819.2c42.349 0 76.8 34.453 76.8 76.8v819.2c0 42.349-34.451 76.8-76.8 76.8zM76.8 102.4c-14.115 0-25.6 11.485-25.6 25.6v819.2c0 14.115 11.485 25.6 25.6 25.6h819.2c14.115 0 25.6-11.485 25.6-25.6v-819.2c0-14.115-11.485-25.6-25.6-25.6h-819.2z" />
        		<path d="M332.8 870.4h-102.4c-14.138 0-25.6-11.461-25.6-25.6v-460.8c0-14.138 11.462-25.6 25.6-25.6h102.4c14.138 0 25.6 11.462 25.6 25.6v460.8c0 14.139-11.462 25.6-25.6 25.6zM256 819.2h51.2v-409.6h-51.2v409.6z" />
        		<path d="M537.6 870.4h-102.4c-14.138 0-25.6-11.461-25.6-25.6v-614.4c0-14.138 11.462-25.6 25.6-25.6h102.4c14.139 0 25.6 11.462 25.6 25.6v614.4c0 14.139-11.461 25.6-25.6 25.6zM460.8 819.2h51.2v-563.2h-51.2v563.2z" />
        		<path d="M742.4 870.4h-102.4c-14.139 0-25.6-11.461-25.6-25.6v-256c0-14.139 11.461-25.6 25.6-25.6h102.4c14.139 0 25.6 11.461 25.6 25.6v256c0 14.139-11.461 25.6-25.6 25.6zM665.6 819.2h51.2v-204.8h-51.2v204.8z" />
        	</svg>
        	<div class="icon-shadow"></div>
        </div>
      </div>
    </div>
    <div class="right-finish">
      <div class="right-fill"></div>
    </div>
  </div>
  <div class="option option4">
    <div class="side">
      <div class="side-overlay-shadow"></div>
      <div class="side-overlay option3-side-overlay"></div>
      <div class="option-info">
        <span>option</span>
        <span class="number">04</span>
      </div>
    </div>
    <div class="divider">
      <div class="divider-overlay"></div>
      <div class="divider-skew option3-divider-skew"></div>
      <div class="divider-skew-overlay"></div>
    </div>
    <div class="main">
      <div class="box-shadow">
      	<div class="blur rotate">
	      	<div class="gradient"></div>
      	</div>
      </div>
      <div class="content">
      	<div class="text">
	        <h2>Title</h2>
	        <br/>
	        <span class="subtitle">your subtitle</span>
	        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
        <div class="icon">
        	<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"  viewBox="0 0 1024 1024" enable-background="new 0 0 1024 1024" xml:space="preserve">
        		<path d="M256 768c-6.552 0-13.102-2.499-18.101-7.499l-204.8-204.8c-9.998-9.997-9.998-26.206 0-36.203l204.8-204.8c9.997-9.997 26.206-9.997 36.203 0 9.998 9.997 9.998 26.206 0 36.203l-186.699 186.699 186.698 186.699c9.998 9.997 9.998 26.206 0 36.203-4.998 4.998-11.549 7.498-18.101 7.498z" />
        		<path d="M768 768c-6.552 0-13.102-2.499-18.101-7.499-9.998-9.997-9.998-26.206 0-36.203l186.698-186.698-186.698-186.699c-9.998-9.997-9.998-26.206 0-36.203 9.997-9.997 26.206-9.997 36.203 0l204.8 204.8c9.998 9.997 9.998 26.206 0 36.203l-204.8 204.8c-5 5-11.55 7.499-18.102 7.499z" />
        		<path d="M383.976 768.003c-4.634 0-9.325-1.258-13.544-3.894-11.989-7.494-15.634-23.288-8.141-35.278l256-409.6c7.493-11.984 23.283-15.634 35.278-8.141 11.989 7.494 15.634 23.288 8.141 35.278l-256 409.6c-4.858 7.77-13.202 12.035-21.734 12.035z" />
        	</svg>
        	<div class="icon-shadow"></div>
        </div>
      </div>
    </div>
    <div class="right-finish">
      <div class="right-fill"></div>
    </div>
  </div>
  <div class="option option5">
    <div class="side">
      <div class="side-overlay-shadow"></div>
      <div class="side-overlay option4-side-overlay"></div>
      <div class="side-overlay-shadow side-overlay-bot"></div>
      <div class="side-overlay option5-side-overlay side-overlay-bot"></div>
      <div class="option-info">
        <span>option</span>
        <span class="number">05</span>
      </div>
    </div>
    <div class="divider">
      <div class="divider-overlay"></div>
      <div class="divider-skew option4-divider-skew"></div>
      <div class="divider-skew-overlay"></div>
      <div class="divider-skew divider-skew-bot"></div>
      <div class="divider-skew-overlay divider-skew-bot"></div>
    </div>
    <div class="main">
      <div class="box-shadow">
      	<div class="blur rotate">
	      	<div class="gradient"></div>
      	</div>
      </div>
      <div class="box-shadow box-shadow-bot">
      	<div class="blur rotate">
	      	<div class="gradient"></div>
      	</div>
      </div>
      <div class="content">
      	<div class="text">
	        <h2>Title</h2>
	        <br/>
	        <span class="subtitle">your subtitle</span>
	        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
        </div>
        <div class="icon">
        	<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1"  viewBox="0 0 1024 1024" enable-background="new 0 0 1024 1024" xml:space="preserve">
        		<path d="M1001.331 531.632l-138.157-315.786c-15.272-34.906-57.075-62.246-95.174-62.246h-512c-38.099 0-79.904 27.341-95.176 62.246l-138.157 315.786c-12.71 29.056-22.667 76.658-22.667 108.368v204.8c0 42.349 34.453 76.8 76.8 76.8h870.4c42.349 0 76.8-34.451 76.8-76.8v-204.8c0-31.714-9.958-79.314-22.669-108.368zM207.733 236.368c7.227-16.522 30.234-31.568 48.267-31.568h512c18.034 0 41.038 15.046 48.269 31.568l138.157 315.786c1.557 3.558 3.082 7.59 4.547 11.95-3.84-0.595-7.77-0.904-11.773-0.904h-307.2c-14.139 0-25.6 11.461-25.6 25.6v25.6c0 56.464-45.936 102.4-102.4 102.4s-102.4-45.936-102.4-102.4v-25.6c0-14.139-11.462-25.6-25.6-25.6h-307.2c-4.002 0-7.933 0.309-11.771 0.902 1.466-4.36 2.992-8.392 4.547-11.95l138.157-315.784zM972.8 844.8c0 14.115-11.485 25.6-25.6 25.6h-870.4c-14.115 0-25.6-11.485-25.6-25.6v-204.8c0-14.115 11.485-25.6 25.6-25.6h281.6c0 84.696 68.904 153.6 153.6 153.6s153.6-68.904 153.6-153.6h281.6c14.115 0 25.6 11.485 25.6 25.6v204.8z" />
        	</svg>
        	<div class="icon-shadow"></div>
        </div>
      </div>
    </div>
    <div class="right-finish">
      <div class="right-fill"></div>
    </div>
  </div>
</div>
<script src='//static.codepen.io/assets/common/stopExecutionOnTimeout-41c52890748cd7143004e05d3c5f786c66b19939c4500ce446314d1748483e13.js'></script><script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
<script >$(".option").each(function (index, el) {
	var height = $(".text").outerHeight();
	$(".right-fill").css('border-width', height + 'px 150px 0 0');
});

$(window).on('resize', function (event) {
	var height = $(".text").outerHeight();
	$(".right-fill").css('border-width', height + 'px 150px 0 0');
});
//# sourceURL=pen.js
</script>




<!-- end -->



	
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->


</body>


</html>
