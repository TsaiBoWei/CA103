<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.Map" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<link rel="icon"
	href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
<title>Conference Neon - Pingendo template</title>
<meta name="description"
	content="Free Bootstrap 4 Pingendo Neon template for unique events.">
<meta name="keywords"
	content="Pingendo conference event neon free template bootstrap 4">
<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js "></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">

<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
 
 <!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}

.navbar-dark .navbar-nav .nav-link{
color:rgba(255, 255, 255, 0.8)!important;
font-weight:bold!important;

}
input {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
	color:rgba(0, 0, 0, 0.8)!important;
	font-weight:bold!important;
	font-size:150% !important;
}

</style>
 
</head>

<body class="text-center">
	<!-- Navbar -->
<nav   class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="<%=request.getContextPath()%>/index.jsp">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp">Course</a>
          </li>
         
          <jsp:useBean id="coachSvc" scope="page" class="com.coach.model.CoachService" /><jsp >
          <c:if test="${memVO!=null}">
	          <li class="nav-item mx-2 btn-lg dropdown" >
	            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">${memVO.mem_name}
	              <i class="fa fa-caret-down dropbtn"></i>
	            </a>
	            <div class="dropdown-content" id="myDropdown">
	               <a href="<%=request.getContextPath() %>/front_end/post/listAllPostByMem09.jsp"><i class="fa fa-file "><font class="fontstyle">&nbsp&nbsp個人頁面</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/plan/My_Plan_myself.jsp"><i class="fa fa-calculator"><font class="fontstyle">&nbsp&nbsp計畫</font></i></a>


	              <a href="#"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>

	              <a href="<%=request.getContextPath() %>/front_end/friendlist/listfriendcomfirmed.jsp"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>


	              <a href="<%=request.getContextPath() %>/front_end/friendlist/listfriendcomfirmed.jsp"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>

	              <a href="<%=request.getContextPath() %>/front_end/course/purchcour/page/purchcour.jsp"><i class="fa fa-film" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp課程</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp"> <i class="fa fa-hand-spock-o" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp活動</font></i></a>
	<!--               <a href=""><i class="fa fa-file">&nbsp&nbsp貼文</i></a> -->
	              <a href="<%=request.getContextPath() %>/front_end/calendar/page/Calendar.jsp"><i class="fa fa-check" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp行事曆</font></i></a>
	               
	               <c:if test="${coachSvc.getOneCoachByMemId(memVO.mem_id)!=null}">
	               	<a href="<%=request.getContextPath() %>/front_end/course/coach/page/coach.jsp"><i class="fa fa-sticky-note"><font class="fontstyle">&nbsp&nbsp教練管理</font></i></a>
	               </c:if>
	              <a href="<%=request.getContextPath() %>/front_end/mem/updateMember/updateMember.jsp"><i class="fa fa-address-card" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp會員資料</font></i></a>
	              <a href="<%=request.getContextPath() %>/mem/mem.do?action=loggedout"><font class="fontstyle">登出</font></a>
	            </div>
	          </li>
          </c:if>
        </ul>
        
         <c:if test="${memVO==null}">
        	<a class="btn btn-lg btn-primary" href="<%=request.getContextPath() %>/Mem_Login_Signup.jsp" id="registerBtn">Register now</a>
		 </c:if>      	
      </div>
    </div>	
  </nav>


	<!-- Cover -->
	<div class="d-flex py-5 cover section-fade-in-out align-items-center"
		style="background-image: url(&quot;<%=request.getContextPath()%>/img/index/cover_run.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h1 class="display-1">
						Log Into <br>Work It Out
					</h1>
				</div>
			</div>
			<div class="row">
				<div class="form-group mx-auto">
					<c:if test="${not empty loginErrorMsgs }">
						<ul id="errorUL" style="color: white">
							<c:forEach var="message" items="${loginErrorMsgs}">
								<li>${message }</li>
							</c:forEach>
						</ul>
					</c:if>
				</div>
			</div>
			<div class="row">
				<div class="col-6 offset-3 col-md-6 offset-md-3">
					<form method="post"
						action="<%=request.getContextPath()%>/mem/mem.do">
						<div class="form-group">
							<input style="color:#ff0000" type="email" name="email"
								class="form-control" placeholder="電子郵件">
						</div><br>

						<div class="form-group">
							<input  type="password" name="password"
								class="form-control" placeholder="密碼">
						</div>
						
						<br> <input type="hidden" name="action" value="login">
						<button type="submit" style="font-size:150%"
							class="btn btn-primary flex-row-reverse form-control fontstyle text-dark"
							id="btnLogIn" >登&nbsp;入</button>
					</form>
				</div>
				<div class="col-md-12" style="margin-bottom: 14px;">
					<a href="#" data-toggle="modal" data-target="#idModal" style="font-size:150%">快 速 註 冊</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="idModal" tabindex="-1" role="dialog"
		aria-labelledby="idModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="center modal-title" id="exampleModalLongTitle">會員註冊</h4>
					<button type="button" class="close cancel" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="false">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="from-group mx-auto">
							<c:if test="${not empty errorMsgs}">

								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color: red">${message}</li>
									</c:forEach>
								</ul>
							</c:if>
						</div>
					</div>
					<form METHOD="post"
						action="<%=request.getContextPath()%>/mem/mem.do">
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text">信箱*</span>
							</div>
							<input value="${param.regEmail }" type="email" name="regEmail" class="form-control"
								aria-label="Large" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>

						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text">暱稱 </span>
							</div>
							<input value="${param.regName }" type="text" name="regName" class="form-control"
								aria-label="Large" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>

						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text">密碼*</span>
							</div>
							<input type="password" name="regPassword" class="form-control"
								aria-label="Large" aria-describedby="inputGroup-sizing-sm ">
						</div>
						<br>

						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text">確認密碼*</span>
							</div>
							<input type="password" name="confirmedPsw" class="form-control"
								aria-label="Large" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>
						<div class="modal-footer">
							<input type="hidden" name="action" value="mem_signUp">
							<button type="submit" class="btn btn-primary" id="regSend">送出</button>
							<button type="button" class="btn btn-secondary cancel"
								data-dismiss="modal">取消</button>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Intro section -->
	<!-- Speakers -->
	<!-- Schedule -->
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
						src="<%=request.getContextPath()%>/img/index/logo_1.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="<%=request.getContextPath()%>/img/index/logo_2.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="<%=request.getContextPath()%>/img/index/logo_3.png">
				</div>
				<div class="col-md-2 col-6">
					<img class="center-block img-fluid d-block"
						src="<%=request.getContextPath()%>/img/index/logo_4.png">
				</div>
			</div>
		</div>
	</div>
	<!-- Call to action -->
	<div class="py-5 section section-fade-in-out" id="register"
		style="background-image: url(&quot;<%=request.getContextPath()%>/img/index/cover_buttom.jpg&quot;);">
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
						<br> <br> Copyright 2018 Pingendo - All rights reserved.
						<br> <br>
					</p>
				</div>
			</div>
		</div>
	</footer>
	<!-- JavaScript dependencies -->
	<script src="https://code.jquery.com/jquery-3.2.1.min.js "></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<!-- Script: Smooth scrolling between anchors in a same page -->
	<script src="<%=request.getContextPath()%>/js/smooth-scroll.js"></script>

<!-- 註冊失敗,打開燈箱 -->

	<c:if test="${openModal!=null}">
		<script>
    		 $("#idModal").modal({show: true});
        </script>
	</c:if>

	<script>
   $(function() {
       $(".cancel").click(function() {
            $(location).attr('href', '<%= request.getContextPath()%>/Mem_Login_Signup.jsp');
							});
		});
		var width = document.body.offsetWidth;
		$(function() {
			$(window).resize(function() {
				$("#errorUL").css("padding-left", "2000 px")
			})
		});
	</script>

</body>

</html>