<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>

<%
   
//   MemVO memVO= new MemService().getOneMem("M000001");
//   session.setAttribute("memVO", memVO);
  
  String perpageloc=request.getParameter("perpageloc");
//  設在URL參數裡 ?perpageloc=course#personalnav
//  #personalnav讓頁面停留在personal nav bar位置
//  然後getParameter("perpageloc") 作為personal NavBar focus之判斷
	//id="event"
	//id="post"
	//id="mycalender"
	//id="friend"
	//id="workoutplan"
	//id="mypage"
  
  session.setAttribute("perpageloc", perpageloc);
  String sessionPerpageloc=(String)session.getAttribute("perpageloc");
 

%>



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
					href="<%= request.getContextPath() %>/index.jsp" >WORK it OUT</a>
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-2 btn-lg" ><a class="nav-link" href="#">WorkOutPlan</a>
					</li>
					<li class="nav-item mx-2 btn-lg" ><a class="nav-link" href="#">Event</a>
					</li>
					<li class="nav-item mx-2 btn-lg" ><a class="nav-link"
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
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/assets/conference/jogback.jpg&quot;);">
	</div>
	<!-- Personal Pic -->
	<div class="row mb-5 personalarea" id="personalnav">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${memVO.mem_id}">
			</div>
		</div>
		<div class="col-md-4 align-self-end ml-1">
			<h1 class="text-left text-primary">Jennifer Lawrence</h1>
			<p class="text-left">Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet,
				consectetur adipiscing elit.</p>
		</div>
		<!-- Personal Pic -->
	
	</div>
	<!-- NavBar Personal focus 判斷式-->
	
	<%
	if(sessionPerpageloc!=null){
	String sessionPerpagelocClass="#"+sessionPerpageloc;
	
	%>
	 
	<script>
	 $(document).ready(function() {
      
        $("<%=sessionPerpagelocClass%>").css({"color": "#12bbad", "border-bottom": " 0.8px solid #12bbad"});
    
	 });
    </script>
    <% }%>
    
    <script>
    $(document).ready(function() {
        
        $(".personalnavlink").click(function() {
        	var href= this.rel;
        	location.href= href;
        });
    
	 });
    
    
    
    </script>
	
	<!-- NavBar Personal focus 判斷式-->
	
	
	<!-- NavBar Personal-->
	<div class="container containerHrT " >
		<hr>
	</div>
	<nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0"
		id="profile-navbar">
		<div class="container">
			<div
				class="collapse navbar-collapse text-right justify-content-center marignBun"
				id="navbar3SupportedContent">
				<ul class="navbar-nav">
				<!-- mypage-->
					<li class="nav-item"><a class="nav-link personalnavlink" rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=mypage#personalnav" id="mypage"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;
					</a></li>
				<!-- Workoutplan-->
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle personalnavlink" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=workoutplan#personalnav"
						id="workoutplan"> <i class="fa fa-calculator"></i>
							&nbsp; WorkOutPlan &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="<%= request.getContextPath() %>/front_end/plan/plan_wrong.jsp">Create Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light dropdown-item-custom"
								href="<%=request.getContextPath()%>/front_end/plan/My_Plan.jsp">My Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="<%=request.getContextPath()%>/front_end/plan/Interesting_Plan.jsp">Interetsting Plan</a>
						</div></li>
					<!-- Friend-->
					<li class="nav-item"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=friend#personalnav" id="friend"> <i
							class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=course#personalnav" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown"
						id="course"> <i class="fa fa-film"
							aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom ">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#" >MyCourse</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Course</a>
						</div></li>
					<li class="nav-item dropdown"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav" id="event">
							<i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link personalnavlink" id="post"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=post#personalnav"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>&nbsp;&nbsp;Post&nbsp;&nbsp;
					</a></li>
					<li class="nav-item"><a class="nav-link personalnavlink "  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=mycalender#personalnav" id="mycalender"> <i
							class="fa fa-sticky-note" aria-hidden="true"></i>
							&nbsp;MyCalender&nbsp;
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container containerHrB  ">
		<hr>
	</div>
	
	<!--header  -->
	
<!-- 	<div class="py-4" id="jys"> -->
<!-- 		<div class="container"> -->
<!-- 			<div class="row"> -->
<!-- 				<div class="col-12"> -->
<!-- 					<h2 class="text-left">Course Board</h2> -->
<!-- 					<hr> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
	<!--fixbutton-->
	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing"
		href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="fab fa-rocketchat"></i>
	</a>
	<!--fixbutton-->
	

	

	




