<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.coach.model.*"%>

<%
   
  MemVO memVO= new MemService().getOneMem("M000003");
  session.setAttribute("memVO", memVO);
  

  
  MemVO caochmemVO=(MemVO)session.getAttribute("memVO");
  CoachService coachSvc=new CoachService();
  CoachVO coachVO= coachSvc.getOneCoachByMemId(caochmemVO.getMem_id());
  request.setAttribute("coachVO",coachVO);
 

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
					href="#" >WORK it OUT</a>
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
		style="background-image: url(<%=request.getContextPath() %>/front_end/course/courlist/assets/conference/fitness.jpg);">
	</div>
	<!-- Personal Pic -->
	<div class="row mb-5 personalarea" id="personalnav">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${memVO.mem_id}">
			</div>
		</div>
  <!--coach profile -->
		<div class="col-md-5 align-self-end ml-1 text-left">
	      <div class="pb-2">
	        <span class="badge badge-primary badge-pill mt-1 badge-pill-coachmp mt-1">Coach</span>
	        <h1 class="text-left text-primary" >${memVO.mem_name}</h1>
	      </div>
	      <div class="editcoach p-2">
	        <p><%=coachVO.getCoa_text() %></p>
	        <div class="text-right edithovr"><a href="<%=request.getContextPath()%>/coach/coach.do?action=getOne_For_Update&coa_id=<%=coachVO.getCoa_id()%>"><i class="far fa-edit"></i>&nbsp;&nbsp;Edit Your Coach Profile </a></div>
	     </div>
	    </div>
  <!--coach profile -->
		
	
	</div>
	<!-- NavBar Personal focus §PÂ_¦¡-->
	
<%-- 	<% --%>
<!-- // 	if(sessionPerpageloc!=null){ -->
<!-- // 	String sessionPerpagelocClass="#"+sessionPerpageloc; -->
	
<%-- 	%> --%>
	 
<!-- 	<script> -->
<!-- // 	 $(document).ready(function() { -->
      
<%--         $("<%=sessionPerpagelocClass%>").css({"color": "#12bbad", "border-bottom": " 0.8px solid #12bbad"}); --%>
    
<!-- // 	 }); -->
<!--     </script> -->
<%--     <% }%> --%>
    
<!--     <script> -->
<!-- //     $(document).ready(function() { -->
        
<!-- //         $(".personalnavlink").click(function() { -->
<!-- //         	var href= this.rel; -->
<!-- //         	location.href= href; -->
<!-- //         }); -->
    
<!-- // 	 }); -->
    
    
    
<!--     </script> -->
	
	<!-- NavBar Personal focus §PÂ_¦¡-->
	
	
	<!-- NavBar Personal-->
	
	
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
<!-- 	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing" -->
<!-- 		href="#posteditlight" data-rel="lightcase:myCollection:slideshow"> -->
<!-- 		<i class="fab fa-rocketchat"></i> -->
<!-- 	</a> -->
	<!--fixbutton-->
	



	




