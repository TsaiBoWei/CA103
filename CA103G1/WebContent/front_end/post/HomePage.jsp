<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.Post.model.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*"%>
 <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

 <jsp:useBean id="now" class="java.util.Date" />
<%	
// 	 首頁測試
	


	MemVO memVO=(MemVO)session.getAttribute("memVO");

// 	String mem_id = memVO.getMem_id();
	
// 	PostService postSvc = new PostService();
// 	List<PostVO> list = postSvc.getByMemIDToDisplay(mem_id);
// 	pageContext.setAttribute("list",list);

// 	PlanService planSvc =new PlanService();
// 	List<PlanVO> planlist = planSvc.getPlansByMem(mem_id);
// 	pageContext.setAttribute("planlist",planlist);

/******************************************************************/

// 	PostService postSvc = new PostService();
// 	List<PostVO> list = postSvc.getByMemIDToDisplay("M000001");
// 	pageContext.setAttribute("list",list);

// 	PlanService planSvc =new PlanService();
// 	List<PlanVO> planlist = planSvc.getPlansByMem("M000001");
// 	pageContext.setAttribute("planlist",planlist);


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
  
  
  
  <style> /*頁面設定*/

    body {
      overflow-x: hidden; 
    }
    
  </style>
  
  <!-- navbar setting -->
  <style type="text/css">

	a,.fontstyle  {
		font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
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
















<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
<%-- 	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/> --%>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

<!-- Plan List-->
<!--   <div class=" m-4"> -->
<!--     <div class="row"> -->
<!--       <div class="container"> -->
<!--         <div class="row"> -->
<!--           <div class="col-md-6 my-3"> -->
<!--             <div class="card col-12 card-custom"> -->
<%--             <% --%>
<!-- //             Date date=new Date(); -->
<!-- //             SimpleDateFormat formatter = new SimpleDateFormat("EEE, d MMM yyyy", Locale.US); -->
<%--             %> --%>
<%--               <div class="card-header card-header-custom text-left text-light"><%=formatter.format(date) %></div> --%>
<!--               <div class="card-body card-body-custom"> -->
<!--                 <h4 class="text-primary text-left">Plan Today</h4> -->
<%--                 <c:forEach var="planVO" items="${planlist}" > --%>

<!--                 <h6 class="text-muted  text-left"></h6> -->
               
<%-- 			<c:if test="${((now.time ge (planVO.plan_start_date).time)) && ((now.time le (planVO.plan_end_date).time)) }">			 --%>
<%--                 <p class="text-left text-white plan_vo">${planVO.plan_name }</p> --%>
<%-- 			</c:if> --%>


<%--                 </c:forEach> --%>
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--           <div class=" col-md-6 p-3"> -->
<!--             <div class="row justify-content-end"> -->
<!--               <div class="col-sm-12 my-3"> -->
<!--                 <div class="card workoutnotecard"> -->
<!--                   <div class="card-body workoutnotecardbody "> -->
<!--                     <div class="my-2 "> -->
<%--                       <h4 class="text-left">Hi,&nbsp;${memSvc.getOneMem(memVO.mem_id).mem_name}</h4> --%>
<!--                       <h4> Do You <span class="txt-rotate" data-period="1800" data-rotate="[ &quot;Work Out Today ?&quot; ]"></span> -->
<!--                       </h4> -->
<!--                     </div> -->
<!--                     <div class="mt-3 text-right"> -->
<%--                       <a href="<%=request.getContextPath()%>/front_end/post/Create_Post.jsp" class="btn btn-primary btnworkoutnote "> --%>
<!--                         <i class="fa fa-edit"></i>Make Post</a> -->
<!--                     </div> -->
<!--                   </div> -->
<!--                 </div> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
  <!--list-->
  <!--Post title-->
  <div class="py-1">
    <div class="container">
      <div class="row">
        <div class="col-12">
          <h2 class="text-left">&nbsp;&nbsp;Posts</h2>
          <hr>
        </div>
      </div>
    </div>
  </div>
  <a class="btn btn-lg btn-primary" id="bli_kontaktad_landing" href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
    <i class="fab fa-rocketchat"></i>
  </a>
  <!--fixbutton-->
  <!--lightbox script-->

  <!--lightbox script-->
  <!--blog1-->
  <c:forEach var="postVOtoHg" items="${postVOtoHg}">
  
  <div class="p-2 m-5">
    <div class="container">
      <div class="row">
        <div class="col-md-7 order-2 order-md-1 postsection ">
          <div class="col-12 mb-2 mt-1 postimgframe">
            <img class="img-fluid d-block post-img-custom" src="${postVOtoHg.post_img}"> </div>
          <div class="row ">
            <div class="col-5 m-2">
              <h5 class="text-left postdate"><fmt:formatDate value="${postVOtoHg.post_time}" pattern="dd"/></h5>
              <fmt:setLocale value="en_US" />
              <h6 class="text-left postmonth"><fmt:formatDate value="${postVOtoHg.post_time}" pattern="MMM"/>,&nbsp; &nbsp;<fmt:formatDate value="${postVOtoHg.post_time}" pattern="yyyy"/></h6>
            </div>
            <div class="col-6  align-self-end text-right">
              <ul class="list-inline postrectbar">
                <li class="list-inline-item">
                  <p class="h6">
                   &nbsp;
                    <i class="fa fa-eye" style="font-size:17px"> &nbsp;</i>
                    ${postVOtoHg.post_view}
                   </p>
                </li>
<!--                 <li class="list-inline-item"> -->
<!--                   <p class="h4"> -->
<!--                     <i class="far fa-heart"></i>&nbsp; &nbsp; </p> -->
<!--                 </li> -->
<!--                 <li class="list-inline-item">                   -->
<!-- <!--                     <i class="far fa-trash-alt"></i>&nbsp; &nbsp; </p> -->                    
<%--                  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;"> --%>
<!-- <!-- 			     <input type="submit" class="far fa-trash-alt" value=null> -->				  
<!-- 					<p class="h4">					 -->
<!-- 					<button type="submit" class="btn  py-1 mb-2 mt-1" style="background:none;width:5px"> -->
<!-- 					<i class="far fa-trash-alt text-light"></i>					 -->
<!-- 					</button> -->
<!-- 					</p>								 -->
<%-- 			     <input type="hidden" name="post_id"      value="${postVO.post_id}">			   --%>
<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<!-- 			     <input type="hidden" name="action"     value="delete_post">			      -->
<!-- 			     </FORM> -->
<!--                 </li> -->
                
<!--                 修改貼文 -->
<!--                 <li class="list-inline-item"> -->
<%--                 <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;"> --%>
<!--                   <p class="h4">               -->
<!--                   <button type="submit" class="btn  py-1 mb-2 mt-1" style="background:none;width:5px"> -->
<!--                     <i class="far fa-edit text-light"></i>                   -->
<!--                   </button>             -->
<!--                   </p> -->
                  
<%--                  <input type="hidden" name="post_id"      value="${postVO.post_id}">			      --%>
<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--> --%>
<!-- 			     <input type="hidden" name="action"     value="getOnePostToUpdate"> -->
<!-- 			     </FORM>                 -->
<!--                 </li> -->
              </ul>
            </div>
          </div>
        </div>
        <div class="col-md-5 order-1 order-md-2 text-left postsectiontext">
       
          <div class="col-md-2 mt-2 p-0 text-center text-light postclass" style="background-color:${sportTypeColor.get(postVOtoHg.sptype_id)}!important; opacity:0.8">${sportTypeMap.get(postVOtoHg.sptype_id)} </div>
          <div class="col-md-12 mt-3 p-0 posttitle ">
            <h2 class="text-left">${postVOtoHg.post_title}</h2>
          </div>
          <hr>
          
 
      
          
          <div class=" postbriefcontent ">
      
          
            <p class="postbrieftruncate">${postVOtoHg.getPost_con().replaceAll("</?[^>]+>", "") }&nbsp; &nbsp; </p>
          </div>
          <div class="col-md-12 mt-5 align-self-end text-right p-0">
          <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/post/post.do" style="margin-bottom: 0px;">
			     <input type="submit" class="btn btn-outline-primary m-2" value="Read More"> 
			     <input type="hidden" name="post_id"      value="${postVOtoHg.post_id}">
			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller--><!-- 目前尚未用到  -->
			     <input type="hidden" name="action"	    value="find_by_post_id">
			</FORM>
<!--             <a class="btn btn-outline-primary m-2" href="#">Read More</a> -->
          </div>
        </div>
      </div>
    </div>
  </div>
  </c:forEach>
  <!--blog1-->
  <!--blog2-->
 
  <!--blog2-->
  <!--blog3-->
  
  <!--blog3-->
  <!-- Sponsor logos -->

<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	

  
  <!-- Script: Smooth scrolling between anchors in a same page -->
 
  <!--
 
</body>

</html>-->
 
