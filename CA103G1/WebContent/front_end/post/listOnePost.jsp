<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ page import="com.mem.model.*"%>
 <%@ page import="com.Post.model.*"%>
 <%@ page import="java.util.*"%>
  <%@ page import="java.text.*"%>
   <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
 <%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO");  
 %>
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
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <title>Jennifer Lawernce</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- summernote css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
  <!-- summernote -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  <!-- summernote -->
  <script src="<%=request.getContextPath() %>/front_end/post/js/jquery.events.touch.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/purchcour/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/post/css/editpostform.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/post/css/blogdetail.css">
  <!-- fafaicon -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <!-- navbar setting -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
  
  
  <style>
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }

    .commenttextarea {
      height: 120px;
    }
    
    #post_con p,#post_con span,#post_con h1,#post_con h2,#post_con h3,#post_con h4,#post_con h5,#post_con h6{
    	color:#fff !important;
    	font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }
    
    h1,h2,h3,h4 {
      font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
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
					src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${postVO.mem_id}">
			</div>
		</div>
		
		
		
		<div class="col-md-4 align-self-end ml-1">
		
			<h1 class="text-left text-primary">${memSvc.getOneMem(postVO.mem_id).mem_name}</h1>
			<p class="text-left">${memSvc.getOneMem(postVO.mem_id).mem_intro}</p>
		</div>
		//toHome page
		<div class="col-md-4"> 
			 
			 <form METHOD="post" ACTION="<%=request.getContextPath() %>/post/Homepage.do">
			 <p class="h4"> 
			 		<input type="hidden" name="action"     value="toHomePage">
			 		<c:if test="${memVO!=null}">
			 			<input type="hidden" name="visitor_mem_id"      value="${memVO.mem_id}"> 
			 		</c:if>
			 		<input type="hidden" name="mem_id"      value="${postVO.mem_id}"> 
			 		<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>">           
               		<button type="submit" class="btn  py-1 mb-2 mt-1" style="background-color:black;width:5px">
                    	<i class="fas fa-home text-light"></i>                  
               		</button> 
              </p>
             </form>             
           
		</div>
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


	
<c:if test="${memVO!=null}">
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
					<li class="nav-item" ><a class="nav-link personalnavlink" rel="<%=request.getContextPath()%>/front_end/post/listAllPostByMem09.jsp?perpageloc=mypage#personalnav" id="mypage" style="cursor: pointer;"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;
					</a></li>
				<!-- Workoutplan-->
					<li class="nav-item dropdown" ><a
						class="nav-link dropdown-toggle personalnavlink" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=workoutplan#personalnav"
						id="workoutplan" style="cursor: pointer;"> <i class="fa fa-calculator"></i>
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
					<li class="nav-item"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=friend#personalnav" id="friend" style="cursor: pointer;"> <i
							class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends
							&nbsp;&nbsp;
					</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle personalnavlink"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/purchcour.jsp?perpageloc=course#personalnav" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown"
						id="course" style="cursor: pointer;"> <i class="fa fa-film"
							aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom ">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#" >MyCourse</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="#">Interetsting Course</a>
						</div></li>
					<li class="nav-item dropdown"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/event/eventlist/listEvesByMem.jsp?perpageloc=event#personalnav" id="event" style="cursor: pointer;">
							<i class="fa fa-hand-spock-o" aria-hidden="true" ></i>&nbsp;Event
							&nbsp;&nbsp;
					</a></li>
<%-- 					<li class="nav-item"><a class="nav-link personalnavlink" id="post"  rel="<%=request.getContextPath()%>/front_end/course/purchcour/page/personltemplete.jsp?perpageloc=post#personalnav" style="cursor: pointer;"> <i --%>
<!-- 							class="fa fa-sticky-note" aria-hidden="true" ></i>&nbsp;&nbsp;Post&nbsp;&nbsp; -->
<!-- 					</a></li> -->
					<li class="nav-item"><a class="nav-link personalnavlink "  rel="<%=request.getContextPath() %>/front_end/calendar/page/Calendar.jsp?perpageloc=mycalender#personalnav" id="mycalender" style="cursor: pointer;"> <i
							class="fa fa-sticky-note" aria-hidden="true" ></i>
							&nbsp;MyCalender&nbsp;
					</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container containerHrB  ">
		<hr>
	</div>
	
</c:if>
	
	
	
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
	
	
	
	
	
	
	
	
	
	
	
	<div class="py-4" id="jys">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h2 class="text-left">Post</h2>
					<hr>
				</div>
			</div>
		</div>
	</div>
	<!--fixbutton -->
	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing"
		href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="fab fa-rocketchat"></i>
	</a>
  <!--fixbutton-->
  <!--blogcontent-->
  <div class="container mb-3">
    <div class="row align-items-start ">
      <!--blogtitle-->
      <div class="col-md-2 offset-md-5  text-center  text-light mb-2 ">
        <div class="col-md-6 offset-md-3 postclassontop text-center bg-secondary mb-1"> ${sportTypeMap.get(postVO.sptype_id)} </div>
      </div>
      <div class=" col-md-12 mb-0">
        <div class=" blogcontent text-left px-2 text-center">
          <h1 class="mb-3 ">${postVO.post_title}</h1>
        </div>
        <!--bloglist-->
        <div class="text-center pr-4 ">
          <ul class="list-inline postsubtitle ">
            <li class="list-inline-item px-2 border-right ">            
            <fmt:formatDate value="${postVO.post_time}" pattern="yyyy-MM-dd HH:mm"/>
           </li>
<%--            <% --%>
<!-- //            		PostVO postVO=(PostVO)request.getAttribute("postVO"); -->
<!-- //            		String post_id=postVO.getPost_id(); -->
<!-- //            		int post_view=0; -->
<!-- //            		if((application.getAttribute(post_id+"view"))==null){ -->
           			
<!-- //            			post_view=0; -->
<!-- //            		}else{ -->
<!-- //            			post_view=(int)application.getAttribute(post_id+"view"); -->
           			
<!-- //            		} -->
<!-- //            		application.setAttribute(post_id+"view",++post_view); -->
           
           
<%--            %> --%>
            <li class="list-inline-item px-2 border-right ">瀏覽數:&nbsp;&nbsp;${postVO.post_view}</li>
            <li class="list-inline-item  px-2  "> 10k likes </li>
          </ul>
        </div>
        <!--bloglist-->
      </div>
      <!--blogblock-->
      <div class=" col-md-2 offset-md-5 mb-3 p-0">
        <hr> </div>
      <!--blogblock-->
      <!--blogtitle-->
      <div class=" col-md-12 ">
        <div id="post_con" class=" blogcontent text-left px-2 ">
           ${postVO.post_con}
        </div>
      </div>
      <div class=" col-md-12  mt-4 p-0">
        <hr> </div>
    </div>
  </div>
  <!--blogcontent-->
  <!--Post -->
  <!-- Sponsor logos -->
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	
  <!--summernote-->
  <script src="<%=request.getContextPath() %>/front_end/post/js/summernotecutom.js"></script>
 <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
  
