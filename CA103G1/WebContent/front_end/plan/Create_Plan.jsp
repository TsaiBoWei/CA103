<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.plan.model.*"%>

<%
	PlanVO planVO = (PlanVO) request.getAttribute("planVO");
%>

<%/*1.下拉式選單做<請選擇>選項，並作錯誤驗證及導向。 
	2.計畫封面圖片沒上傳錯誤處理不做，不放圖的預設圖未做。
	3.計畫內容拖拉圖片未做。
	4.set/cancel 按鈕未做完全。
	5.開始結束時間送進資料庫不同。
	6.觀看次數
	7.輸入計畫開始時間但不輸入結束時間，送出後開始時間會變更，不會是送出前設定好的時間。






*/%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/images/weight-lifting.png">
<title>WORK it OUT</title>
<meta name="description"
	content="Free Bootstrap 4 Pingendo Neon template for unique events.">
<meta name="keywords"
	content="Pingendo conference event neon free template bootstrap 4">

<!-- CSS dependencies -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/PersonalPageBase.css">
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
	
	.date{
		width: 170px;
		height: 33px;
		font-size: 18px;
	}
	
</style>

<%--上傳圖片 --%>
<script
	src="<%=request.getContextPath()%>/front_end/plan/js/UploadPlan_Cover.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/plan/css/img.css">

<%-- 計畫內容 --%>
<script src="https://cdn.ckeditor.com/4.7.3/standard-all/ckeditor.js"></script>
<script>
CKEDITOR.plugins.addExternal("codesnippet", "https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.7.3/plugins/codesnippet/plugin.js", "");
CKEDITOR.replace("editor1", {
extraPlugins: "codesnippet",
codeSnippet_theme: "solarized_dark"
});
</script>

</head>


<body class="text-center">
	<% session.setAttribute("mem_id" , "M000001");%>
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
					class="btn navbar-btn mx-2 justify-content-start btn-outline-info btn-lg"
					href="<%=request.getContextPath() %>/front_end/plan/HomePage.jsp">WORK it OUT</a>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-2 btn-lg"><a class="nav-link" href="#">WorkOutPlan</a>
					</li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link" href="#">Event</a>
					</li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link"
						href="#speakers">Course</a></li>
					<li class="nav-item mx-2 btn-lg"><a class="nav-link"
						href="personalPage.jsp">User</a></li>
				</ul>									
				<a class="btn btn-lg btn-primary" href="/CA103G10908/front_end/mem/login/Mem_Login_Signup.jsp">Register now</a>
			</div>
		</div>
	</nav>
	<!-- Cover -->
	<div class="d-flex align-items-center cover section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/images/assets/conference/jogback.jpg&quot;);">
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
					src="<%=request.getContextPath()%>/front_end/plan/images/assets/styleguide/people_2.jpg">
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
								href="<%= request.getContextPath()%>/front_end/plan/Create_Plan.jsp">Create Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="<%= request.getContextPath()%>/front_end/plan/My_plan_blank.jsp">My Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="<%= request.getContextPath()%>/front_end/plan/Interesting_Plan.jsp">Interesting Plan</a>
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


	<div class="py-5 text-light opaque-overlay section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/images/CreatPlan_picture.jpeg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 mx-auto">
					<form method="post"
						action="<%=request.getContextPath()%>/plan/plan.do"
						enctype="multipart/form-data">


						<div class="form-group text-primary" style="font-size: 48px">
							Create A New Plan
						</div>
						<br>
						
						<%-- 錯誤表列 --%>
							<c:if test="${not empty errorMsgs}">
								<font style="color:red" size="5">Amend　The　Following　Errors</font><br>
								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color:red ; font-size:20px ">${message}</li>
									</c:forEach>
								</ul>
							</c:if>
						

						<div class="form-group">
							<h3>Plan Name:</h3>
							<input type="text" name="plan_name"
								value="<%= (planVO==null) ? "MyFirstDay" : planVO.getPlan_name()%>"
								class="form-control"/>
						</div>
						<br>


						<div class="form-group">
							<label><h3>Plan Cover:　</h3></label> 
							<label class="btn btn-info btn-lg"> 
								<input type="file" id="upload_img" name="plan_cover" accept="image/*" 
									 onchange="openFile(event)" style="display: none;" 
									 <%--  value="= (planVO==null) ?"= request.getContextPath()>/front_end/plan/images/photo.png":planVO.getPlan_cover%>"--%>/>
									<i class="fa fa-photo">　Upload</i>
							</label>
						</div>
						
						
						<div class="form-group">
							　　　　　　　　　<img class="img" id="output"  style="display: none;">
						</div>
						
						
						<div class="form-group">
							<label><h3>PlanStartDate:　</h3></label> 
							<input type="text" name="plan_start_date" id="f_date1" class="date"/>
						</div>


						<div class="form-group">
							<label><h3>Plan EndDate:　</h3></label> 
							<input type="text" name="plan_end_date" id="f_date2" class="date"/>
						</div>
 						<jsp:useBean id="sptypeSvc"  scope="page" class="com.sptype.model.SptypeService"/>
						
 						<div class="form-group"> 
							<label><h3>Sport Type:　　</h3></label> <select size="1"
								name="sptype_id" style="width: 150px; font-size: 18px;">
								<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
									<option value="${sptypeVO.sptype_id}" ${(planVO.sptype_id==sptypeVO.sptype_id)? 'selected':''}>${sptypeVO.sport}
								</c:forEach>
							</select>
						</div>


						<div class="form-group">
							<label><h3>Privacy Setting:</h3></label> <select size="1"
								name="plan_privacy" style="width: 150px; font-size: 18px;">
								<option value="PLANPR0">公開</option>
								<option value="PLANPR1">不公開</option>
								<option value="PLANPR2">只對朋友公開</option>
							</select>
						</div>


						<div class="form-group">
							<label><h3>Plan Content:</h3></label><br>
							<textarea name="plan_vo" rows="10" class="form-control" style="font-size: 22px"><%=(planVO == null) ? "Enter Your Plan Content" : planVO.getPlan_vo()%></textarea>
							<br>
						</div>
						
						
						<div class="from-group">
							<script src="https://cdn.ckeditor.com/4.7.3/standard-all/ckeditor.js"></script>
<textarea name="editor1"></textarea>
<script>
CKEDITOR.plugins.addExternal("codesnippet", "https://cdnjs.cloudflare.com/ajax/libs/ckeditor/4.7.3/plugins/codesnippet/plugin.js", "");
CKEDITOR.replace("editor1", {
extraPlugins: "codesnippet",
codeSnippet_theme: "solarized_dark"
});
</script>
						</div>
		
		
						<div class="from-group">
							<input type="hidden" name="plan_view">
							<h5>
							<%Integer plan_view = (Integer)(application.getAttribute("plan_view"));
							  if( plan_view ==null || plan_view == 0 ){
      						  	out.println("Welcome to my website!");
      							plan_view = 0;
    						  }else{
							  	out.println("Welcome back to my website!");
								plan_view ++;
							  }
    							application.setAttribute("plan_view", plan_view);%>
    							瀏覽數：<%=plan_view %>
							</h5>
						</div>
						<div class="form-group">
							<input type="hidden" name="action" value="insert">
							<button type="submit" class="btn btn-primary">Add</button>
						 	<button type="submit" class="btn btn-primary"
						 		formaction="<%= request.getContextPath()%>/front_end/plan/Interesting_Plan.jsp">Reset</button>
							<button type="submit" class="btn btn-primary" 
								formaction="<%= request.getContextPath()%>/front_end/plan/HomePage.jsp">cancel</button>
						</div>
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
						src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/logo_1.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/logo_4.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/logo_3.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/logo_2.png">
				</div>
			</div>
		</div>
	</div>
	<!-- Call to action -->
	<div class="py-5 section section-fade-in-out" id="register"
		style="background-image: url('<%=request.getContextPath()%>/front_end/plan/images/assets/conference/cover_2.jpg');">
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
	<h1>123</h1> 
</body> 

<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<%
	java.sql.Timestamp plan_start_date = null;
	try {
		plan_start_date = planVO.getPlan_start_date();
	} catch (Exception e) {
		plan_start_date = new java.sql.Timestamp(System.currentTimeMillis());
	}
%>

<%
	java.sql.Timestamp plan_end_date = null;
	try {
		plan_end_date = planVO.getPlan_end_date();
	} catch (Exception e) {
		plan_end_date = new java.sql.Timestamp(System.currentTimeMillis());
	}
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.full.js"></script>



<script>
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              			//theme: 'dark',
	       timepicker:true,        			//timepicker:true,
	       step: 5,                			//step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d  H:i',   			//format:'Y-m-d H:i:s', 
	       value: '<%=plan_start_date%>',   // value:   new Date(),
	       //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
	//startDate:	            '2017/07/10',  // 起始日
	//minDate:               '-1970-01-01', // 去除今日(不含)之前
	//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
	});

	// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

	//      1.以下為某一天之前的日期無法選擇
	//      var somedate1 = new Date('2017-06-15');
	//      $('.f_date1').datetimepicker({
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

<script> 
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              			//theme: 'dark',
	       timepicker:true,        			//timepicker:true,
	       step: 5,                			//step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d  H:i',   			//format:'Y-m-d H:i:s', 
	       value: '<%=plan_end_date%>', 
	    });
</script>



</html>