<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.friendlist.model.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*"%>
 <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

 <jsp:useBean id="now" class="java.util.Date" />
<%	
	MemVO memVO=(MemVO)session.getAttribute("memVO");
	String memidtoHg=request.getParameter("mem_id");
	MemVO memVOtoHg=memSvc.getOneMem(memidtoHg);
	pageContext.setAttribute("memVOtoHg", memVOtoHg);

	PlanService planSvc = new PlanService();
	FriendListService flSvc= new FriendListService();
	
	List<PlanVO> list =null;
	FriendListVO flVO=null;
	
	if(memVO!=null){
		String mem_id = memVO.getMem_id();
		flVO= flSvc.getOneFriendList(mem_id, memidtoHg);	
		
	}
	
	//�p�G�O�B��
	if(flVO != null&&flVO.getFl_status().equals("FLS1")) { 
		
		 list =planSvc.getPlanForFriendByMem(memidtoHg);
	//�p�G���O�B��	
	}else {			
		
		 list = planSvc.getPlanForVisitorByMem(memidtoHg);
	}

	System.out.println(list);
	pageContext.setAttribute("list", list);
	
	String perpageloc=request.getParameter("perpageloc");
	session.setAttribute("perpageloc", perpageloc);
	String sessionPerpageloc=(String)session.getAttribute("perpageloc");
	
%>


<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <title>Jennifer Lawernce</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
   <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/post/css/PersonalPage_list.css">
<!--   <link rel="stylesheet" href="calender.css"> -->
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
   <script src="https://code.jquery.com/jquery-3.2.1.js"></script>

  
  
 
  <script src="<%=request.getContextPath() %>/front_end/post/js/jquery.events.touch.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/course/courboar/js/autotyping.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/post/js/truncateoverride.js"></script>

   <link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

  <!-- fafaicon -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <!-- navbar setting -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
  
  
  
  <style> /*�����]�w*/

    body {
      overflow-x: hidden; 
    }
    .navbar-dark .navbar-nav .nav-link{
	color:rgba(255, 255, 255, 0.8)!important;
	font-weight:bold!important;
	
	}
    
  </style>
  
  <!-- navbar setting -->
  <style type="text/css">

	a,.fontstyle  {
		font-family: Montserrat,Arial,"�L�n������","Microsoft JhengHei"!important;
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
	               <a href="<%=request.getContextPath() %>/front_end/post/listAllPostByMem09.jsp"><i class="fa fa-file "><font class="fontstyle">&nbsp&nbsp�ӤH����</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/plan/My_Plan_myself.jsp"><i class="fa fa-calculator"><font class="fontstyle">&nbsp&nbsp�p�e</font></i></a>
	              <a href="<%=request.getContextPath()%>/front_end/friendlist/listfriendcomfirmed.jsp?perpageloc=friendlist#personalnav"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp�n��</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/course/purchcour/page/purchcour.jsp"><i class="fa fa-film" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp�ҵ{</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp"> <i class="fa fa-hand-spock-o" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp����</font></i></a>
	<!--               <a href=""><i class="fa fa-file">&nbsp&nbsp�K��</i></a> -->
	              <a href="<%=request.getContextPath() %>/front_end/calendar/page/Calendar.jsp"><i class="fa fa-check" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp��ƾ�</font></i></a>
	               
	               <c:if test="${coachSvc.getOneCoachByMemId(memVO.mem_id)!=null}">
	               	<a href="<%=request.getContextPath() %>/front_end/course/coach/page/coach.jsp"><i class="fa fa-sticky-note"><font class="fontstyle">&nbsp&nbsp�нm�޲z</font></i></a>
	               </c:if>
	              <a href="<%=request.getContextPath() %>/front_end/mem/updateMember/updateMember.jsp"><i class="fa fa-address-card" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp�|�����</font></i></a>
	              <a href="<%=request.getContextPath() %>/mem/mem.do?action=loggedout"><font class="fontstyle">�n�X</font></a>
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
	<div class="d-flex align-items-center cover section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/assets/conference/jogback.jpg&quot;);">
	</div>
	<!-- Personal Pic -->
<%-- 	<c:if test="${memVO!=null}"> --%>
	<div class="row mb-5 personalarea" id="personalnav">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${memVOtoHg.mem_id}">
			</div>
		</div>
		
		
		
		<div class="col-md-4 align-self-end ml-1">
		
			<h1 class="text-left text-primary">${memSvc.getOneMem(memVOtoHg.mem_id).mem_name}</h1>
			<p class="text-left">${memSvc.getOneMem(memVOtoHg.mem_id).mem_intro}</p>
		</div>
<!-- 		//toHome page -->
<!-- 		<div class="col-md-4">  -->
			 
<%-- 			 <form METHOD="post" ACTION="<%=request.getContextPath() %>/post/Homepage.do"> --%>
<!-- 			 <p class="h4">  -->
<!-- 			 		<input type="hidden" name="action"     value="toHomePage"> -->
<%-- 			 		<input type="hidden" name="mem_id"      value="${postVO.mem_id}">  --%>
<%-- 			 		<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">            --%>
<!--                		<button type="submit" class="btn  py-1 mb-2 mt-1" style="background-color:black;width:5px"> -->
<!--                     	<i class="fas fa-home text-light"></i>                   -->
<!--                		</button>  -->
<!--               </p> -->
<!--              </form>              -->
           
<!-- 		</div> -->
		<!-- Personal Pic -->
	
	</div>
<%-- 	</c:if> --%>
	<!-- NavBar Personal focus �P�_��-->
	
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
	
	<!-- NavBar Personal focus �P�_��-->


	
<%-- <c:if test="${memVO!=null}"> --%>
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
					<li class="nav-item" ><a class="nav-link personalnavlink" rel="<%=request.getContextPath() %>/post/Homepage.do?action=toHomePage&mem_id=${memVOtoHg.mem_id}&visitor_mem_id=${memVO.mem_id}&perpageloc=mypage#personalnav" id="mypage" style="cursor: pointer;"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; PersonalPage &nbsp; &nbsp;&nbsp;
					</a></li>
				<!-- Workoutplan-->
					<li class="nav-item dropdown" ><a
						class="nav-link dropdown-toggle personalnavlink" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" rel="<%=request.getContextPath()%>/front_end/post/HomePage_plan.jsp?mem_id=${memVOtoHg.mem_id}&perpageloc=workoutplan#personalnav"
						id="workoutplan" style="cursor: pointer;"> <i class="fa fa-calculator"></i>
							&nbsp; WorkOutPlan &nbsp;
					</a>
					</li>
					
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown"
						id="course" style="cursor: pointer;"> <i class="fa fa-film"
							aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
					</a>
					</li>
					<li class="nav-item dropdown"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp" id="event" style="cursor: pointer;">
							<i class="fa fa-hand-spock-o" aria-hidden="true" ></i>&nbsp;Event
							&nbsp;&nbsp;
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container containerHrB  ">
		<hr>
	</div>
	
<%-- </c:if> --%>
	
	
	
	<!--fixbutton-->
	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing"
		href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="fab fa-rocketchat"></i>
	</a>

  <!--Post title-->
  <div class="py-1">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <h2 class="text-left">&nbsp;&nbsp;Plan</h2>
          <hr>
        </div>
      </div>
    </div>
  </div>
  <a class="btn btn-lg btn-primary" id="bli_kontaktad_landing" href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
    <i class="fab fa-rocketchat"></i>
  </a>
  
  
 
  <div class="form-control" style="background-color: #1f1f1f">
		<div class="container">
			<div class="row">
				<c:forEach var="planVO" items="${list}">
					<div class="col-12 col-md-4">
						<div class="card">
							<img class="card-img-top" style="height:250px; overflow:hidden;"
								src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
							<div class="card-body">
								<h5 class="plan_name">${planVO.plan_name}</h5> 
								<p class="sptype_id">�B������:
									<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
										<c:if test="${planVO.sptype_id ==sptypeVO.sptype_id }">${sptypeVO.sport}</c:if>
									</c:forEach>
									
								</p>  
								<p class="plan_start_date">�p�e�ɶ�:<fmt:formatDate value="${planVO.plan_start_date}" pattern="yyyy-MM-dd HH:mm "/></p> 
								<p class="plan_end_date" ><fmt:formatDate value="${planVO.plan_end_date}" pattern="yyyy-MM-dd HH:mm "/></p> 
								<a href="<%=request.getContextPath()%>/front_end/plan/listOnePlan.jsp?plan_id=${planVO.plan_id}" class="btn btn-info" style="font-size:16px">Read More</a>
							</div>
						</div><br>
					</div>
				</c:forEach>
			</div>
		
		</div>
	</div>			


<!-- =========================================�H�U����personlfooter.jsp�����e========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================�H�W����personlfooter.jsp�����e========================================== -->
	

 
