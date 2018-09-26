<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="js/animate-in.js"></script>
</head>
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
					class="btn navbar-btn mx-2 justify-content-start btn-outline-info btn-lg"
					href="#">WORK it OUT</a>
				<form class="form-inline my-2 my-lg-0">
	      			<input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
	      			<button class="btn btn-outline-primary my-2 my-sm-0" type="submit">Search</button>
	    		</form>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-25 btn-lg"><a class="nav-link" href="#">activity</a>
					</li>
					<li class="nav-item mx-25 btn-lg"><a class="nav-link"
						href="#speakers">Course</a></li>
					<li class="nav-item mx-25 btn-lg"><a class="nav-link"
						href="personalPage.jsp">User</a></li>
				</ul>									
				<a class="btn btn-lg btn-primary" href="<%=request.getContextPath() %>/front_end/mem/login/Mem_Login_Signup.jsp">Register now</a>
			</div>
		</div>
	</nav>
	<!-- Cover -->
	<div class="d-flex align-items-center py-5 cover section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/images/assets/conference/Top-5-Best-Running-Shoes-for-Women-in-2015.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="mt-5 text-right col-12">
					<h1 class="display-6">WORK it OUT</h1>
					<p class="lead">TURN Your Goals INTO ACTION</p>
				</div>
			</div>
		</div>
	</div>
	<!-- Intro section -->
	<div class="py-5 section-fade-in"
		style="background-image: url('<%=request.getContextPath()%>/front_end/plan/images/assets/conference/56930f225e8db.jpg');">
		<div class="container p-4 my-5">
			<div class="row">
				<div class="col-12">
					<h1 class="mb-3">About the event</h1>
					<p>Three days immersion in the world of UX/UI prototyping. Meet
						the most important design influencer of the moment, assist to
						speeches given by worldwide known designers and much, much more.
						The unique possibility to enhance your professionality with the
						smallest effort.</p>
				</div>
			</div>
		</div>
	</div>
	<!-- Speakers -->
	<div class="py-5 " id="speakers">
		<div class="container ">
			<div class="row ">
				<div class="col-12 col-md-12">
					<h1 class="px-2 text-justify">Popular</h1>
					<ul class="nav nav-tabs">
						<li class="nav-item"><a href="#home" class="nav-link active"
							data-toggle="tab" aria-controls="home" aria-selected="true"
							id="home-tab" role="tab">貼文</a></li>
						<li class="nav-item"><a href="#profile" class="nav-link"
							data-toggle="tab" aria-controls="profile" aria-selected="false"
							id="profile-tab" role="tab">計畫</a></li>
						<li class="nav-item"><a href="#contact" class="nav-link"
							data-toggle="tab" aria-controls="contact" aria-selected="false"
							id="contact-tab" role="tab">活動</a></li>
						<li class="nav-item"><a class="nav-link" href="#contact"
							data-toggle="tab" aria-controls="contact" aria-selected="false"
							id="contact-tab" role="tab">課程</a></li>
					</ul>
					<div class="tab-content mt-2">
						<div class="tab-pane fade" id="tabthree" role="tabpanel">
							<p class="text-primary">Tab pane three. Lorem ipsum dolor sit
								amet, consectetur adipiscing elit.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/02.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/01.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/03.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="py-5 " id="speakers">
		<div class="container ">
			<div class="row ">
				<div class="col-12 col-md-12">
					<h1 class="px-2 text-justify">NEW</h1>
					<ul class="nav nav-tabs">
						<li class="nav-item"><a href="#home" class="nav-link active"
							data-toggle="tab" aria-controls="home" aria-selected="true"
							id="home-tab" role="tab">貼文</a></li>
						<li class="nav-item"><a href="#profile" class="nav-link"
							data-toggle="tab" aria-controls="profile" aria-selected="false"
							id="profile-tab" role="tab">計畫</a></li>
						<li class="nav-item"><a href="#contact" class="nav-link"
							data-toggle="tab" aria-controls="contact" aria-selected="false"
							id="contact-tab" role="tab">活動</a></li>
						<li class="nav-item"><a class="nav-link" href="#contact"
							data-toggle="tab" aria-controls="contact" aria-selected="false"
							id="contact-tab" role="tab">課程</a></li>
					</ul>
					<div class="tab-content mt-2">
						<div class="tab-pane fade" id="tabthree" role="tabpanel">
							<p class="text-primary">Tab pane three. Lorem ipsum dolor sit
								amet, consectetur adipiscing elit.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/04.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/ANQ_2018_2.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/07.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
			</div>
		</div>
	</div>
	<div class="py-5 " id="speakers">
		<div class="container ">
			<div class="row ">
				<div class="col-12 col-md-12">
					<h1 class="px-2 text-justify">FRIEND</h1>
					<ul class="nav nav-tabs">
						<li class="nav-item"><a href="#home" class="nav-link active"
							data-toggle="tab" aria-controls="home" aria-selected="true"
							id="home-tab" role="tab">貼文</a></li>
						<li class="nav-item"><a href="#profile" class="nav-link"
							data-toggle="tab" aria-controls="profile" aria-selected="false"
							id="profile-tab" role="tab">計畫</a></li>
						<li class="nav-item"><a href="#contact" class="nav-link"
							data-toggle="tab" aria-controls="contact" aria-selected="false"
							id="contact-tab" role="tab">活動</a></li>
						<li class="nav-item"><a class="nav-link" href="#contact"
							data-toggle="tab" aria-controls="contact" aria-selected="false"
							id="contact-tab" role="tab">課程</a></li>
					</ul>
					<div class="tab-content mt-2">
						<div class="tab-pane fade" id="tabthree" role="tabpanel">
							<p class="text-primary">Tab pane three. Lorem ipsum dolor sit
								amet, consectetur adipiscing elit.</p>
						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/06.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/05.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
				<div class="col-lg-4 col-md-4">
					<a href="#"> <img src="<%=request.getContextPath()%>/front_end/plan/images/assets/conference/08.png"
						class="center-block img-fluid my-3 shadowed" width="300">
						<h3 class="mb-0 text-left text-primary">
							<b>Post title</b>
						</h3>
						<p class="text-muted text-right">author name</p>
						<p class="text-light text-left">
							about the post <br>about the post <br>about the post
						</p>
					</a>
				</div>
			</div>
		</div>
	</div>
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

</body>
</html>