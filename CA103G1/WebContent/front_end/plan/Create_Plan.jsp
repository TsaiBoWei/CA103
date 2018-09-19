<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.plan.model.*"%>

<%
	PlanVO planVO = (PlanVO) request.getAttribute("PlanVO");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon"
	href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
<title>TRY</title>
<meta name="description"
	content="Free Bootstrap 4 Pingendo Neon template for unique events.">
<meta name="keywords"
	content="Pingendo conference event neon free template bootstrap 4">

<!-- CSS dependencies -->
<link rel="stylesheet" href="css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet" href="css/PersonalPageBase.css">
<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="js/animate-in.js"></script>
<!-- lightcase settings -->
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<style>
/*頁面設定*/
body {
	overflow-x: hidden;
}
</style>


</head>
<body>
<body class="text-center">
	<!-- Navbar -->
	<nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
		<span class="navbar-text"></span>
		<div class="container">
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbar2SupportedContent"
				aria-controls="navbar2SupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-center"
				id="navbar2SupportedContent">
				<a
					class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg"
					href="#">WORK it OUT</a>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-2 btn-lg"><a class="nav-link" href="#">WorkOutPlan</a>
					</li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link" href="#">Event</a>
					</li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link"
						href="#speakers">Course</a></li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link"
						href="#schedule">User</a></li>
				</ul>
				<a class="btn btn-lg btn-primary" href="#register">Register now</a>
			</div>
		</div>
	</nav>
	<!-- Cover -->
	<div class="d-flex align-items-center cover section-fade-in-out"
		style="background-image: url(&quot;assets/conference/jogback.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="mt-5 text-right col-12">
					<h1 class="display-6 text-light">WORK it OUT</h1>
					<p class="lead">TURN Your Goals INTO ACTION</p>
					<!-- List -->
				</div>
			</div>
			<!-- 卡片row 移出-->
			<div class="row justify-content-end">
				<div class="card col-6 card-custom">
					<div class="card-header card-header-custom text-right">Aug 11
						, 2018</div>
					<div class="card-body card-body-custom">
						<h4 class="text-primary text-right">Plan Today</h4>
						<h6 class="text-muted  text-right">Subtitle</h6>
						<p class=" text-right">Some quick example text to build on the
							card title.</p>
					</div>
				</div>
			</div>
			<!--  // 卡片row 移出-->
		</div>
	</div>
	<!-- Personal Pic -->
	<div class="row mb-5">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="images/assets/styleguide/people_2.jpg">
			</div>
		</div>
		<div class="col-md-4 align-self-end ml-3">
			<h1 class="text-left text-primary">Jennifer Lawrence</h1>
			<p class="text-left">Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.</p>
		</div>
		<!--<div class="col-md-4  py-10"></div>-->
	</div>
	<!-- NavBar Personal-->
	<div class="container containerHrT ">
		<hr>
	</div>
	<nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0"
		id="profile-navbar">
		<div class="container">
			<div
				class="collapse navbar-collapse text-right justify-content-center marignBun"
				id="navbar3SupportedContent">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;
					</a></li>
					<!-- Workoutplan-->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" href="#"
						id="navbarDropdownMenuLink"> <i class="fa fa-calculator"></i>
							&nbsp; WorkOutPlan &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Add Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">My Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Plan</a>
						</div></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown"
						id="navbarDropdownMenuLink"> <i class="fa fa-film"
							aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom ">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">MyCourse</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Course</a>
						</div></li>
					<li class="nav-item dropdown"><a class="nav-link" href="#">
							<i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>&nbsp;&nbsp;Post&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>
							&nbsp;MyCalender&nbsp;
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="py-5 text-secondary opaque-overlay"
		style="background-image: url(&quot;https://pingendo.github.io/templates/sections/assets/cover_restaurant.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-md-3"></div>
				<div class="col-md-6">
					<h1 class="text-gray-dark">Create A New Plan</h1>
					<form method="post" action="plan.do">
						<div class="form-group">
							<label><h5>Plan Name ：</h5></label> <input type="TEXT"
								name="plan_name" size="45"
								value="<%=(planVO == null) ? "JoggingDay" : planVO.getPlan_name()%>" />
						</div>
					</form>

					<form method="post" action="plan.do">
						<div class="form-group">
							<label><h5>Plan Cover ：</h5></label> <input type="submit"
								name="plan_name"
								value="<%=(planVO == null) ? "選擇檔案" : planVO.getPlan_name()%>" />
						</div>
					</form>

					<form>
						<label class="btn btn-info"> <input id="upload_img"
							style="display: none;" type="file"> <i
							class="fa fa-photo"></i> 上傳圖片
						</label>

					</form>

					<jsp:useBean id="PlanSvc" scope="page"
						class="com.plan.model.PlanService" />

					<form method="post" action="plan.do">
						<div class="form-group">
							<label><h5>plan_start_time_undone :</h5></label> <input
								type="text" name="plan_create_time" id="f_date1">
						</div>
					</form>

					<form method="post" action="plan.do">
						<div class="form-group">
							<label><h5>plan_end_time_undone :</h5></label> <input type="text"
								name="plan_create_time" id="f_date1">
						</div>
					</form>


					<form class="" method="post" action="plan.do">
						<div class="form-group">
							<label>Plan SportType</label> <select size="1" name="sptype_id">
								<c:forEach var="planVO" items="${planSvc.all}">
									<option value="${planVO.sptype_id}"
										${(PlanVO.sptype_id==SptypeVO.sptype_id)? 'selected':'' }>${planVO.sptype_id}
								</c:forEach>
							</select>
						</div>
					</form>

					<form class="" method="post" action="plan.do">
						<div class="form-group">
							<label><h5>Privacy Setting :</h5></label> <select size="1"
								name="privacy">
								<option value="PLANPR0">公開</option>
								<option value="PLANPR1">不公開</option>
								<option value="PLANPR2">只對朋友公開</option>
							</select>
						</div>
					</form>

					<form class="" method="post" action="plan.do">
						<div class="form-group">
							<label><h5>Sport Type :</h5></label> <select size="1"
								name="privacy">
								<option value="SP000001">田徑</option>
								<option value="SP000002">單車</option>
								<option value="SP000003">球類</option>
								<option value="SP000004">重訓</option>
								<option value="SP000005">有氧</option>
								<option value="SP000006">武術</option>
								<option value="SP000007">水上</option>
								<option value="SP000008">其他</option>
							</select>
						</div>
					</form>

					<form class="" method="post" action="plan.do">
						<div class="form-group">
							<label>Plan Content(plan vo) </label>
							<textarea name="Planning_Content" rows="10" cols="30" wrap="off"
								style="margin-top: 0px; margin-bottom: 0px; height: 100px;"
								value="<%=(planVO == null) ? "JoggingDay" : planVO.getPlan_name()%>"> </textarea>
							<br>
						</div>
					</form>
					<form class="" method="post" action="plan.do">
						<button type="submit" class="btn btn-primary">
							<a herf=''>Add 
						</button>
						<button type="submit" class="btn btn-primary">Reset</button>
						<button type="submit" class="btn btn-primary">cancel</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="container containerHrB ">
		<hr>
	</div>
	<!-- Here you go -->
	<!-- Sponsor logos -->
	<div class="py-5 section">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h1 class="mb-4">Sponsors</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-md-2 col-6"></div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="images/assets/conference/logo_1.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="images/assets/conference/logo_4.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="images/assets/conference/logo_3.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="images/assets/conference/logo_2.png">
				</div>
			</div>
		</div>
	</div>
	<!-- Call to action -->
	<div class="py-5 section section-fade-in-out" id="register"
		style="background-image: url('images/assets/conference/cover_2.jpg');">
		<div class="container">
			<div class="row">
				<div class="col-md-12 text-left">
					<h1 class="mb-3">Something Here</h1>
					<p>
						Pre-register to get a priority access to the event. Fares will be
						published later on.&nbsp; <br>Get the maximum from the
						lectures together with the possibility of joining exclusive
						side-events.
					</p>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<footer class="text-md-left text-center p-4">
		<div class="container">
			<div class="row">
				<div class="col-lg-12"></div>
			</div>
			<div class="row">
				<div class="col-md-12">
					<p class="text-muted">
						<br> <br>© Copyright 2018 Pingendo - All rights
						reserved. <br> <br>
					</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- JavaScript dependencies -->
	<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
	<!-- Script: Smooth scrolling between anchors in a same page -->
	<script src="js/smooth-scroll.js"></script>
	<pingendo onclick="window.open('https://pingendo.com/', '_blank')"
		style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:250px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made
	with Pingendo Free&nbsp;&nbsp; <img
		src="https://pingendo.com/site-assets/Pingendo_logo_big.png"
		class="d-block" alt="Pingendo logo" height="16"> </pingendo>

</body>

<%
	java.sql.Date plan_create_time = null;
	try {
		plan_create_time = planVO.getPlan_create_time();
	} catch (Exception e) {
		plan_create_time = new java.sql.Date(System.currentTimeMillis());
	}
%>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script
	src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
}
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=plan_create_time%>
	', // value:   new Date(),
	//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      2.以下為某一天之後的日期無法選擇
	//      var somedate2 = new Date('2017-06-15');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});

	//      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
	//      var somedate1 = new Date('2017-06-15');
	//      var somedate2 = new Date('2017-06-25');
	//      $('#f_date1').datetimepicker({
	//          beforeShowDay: function(date) {
	//        	  if (  date.getYear() <  somedate1.getYear() || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
	//		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
	//		             ||
	//		            date.getYear() >  somedate2.getYear() || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
	//		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
	//              ) {
	//                   return [false, ""]
	//              }
	//              return [true, ""];
	//      }});
</script>



</html>