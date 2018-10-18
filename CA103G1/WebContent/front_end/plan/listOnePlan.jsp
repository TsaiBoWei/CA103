<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.friendlist.model.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*"%>
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<jsp:useBean id="now" class="java.util.Date" />
<%
	MemVO memVO = (MemVO) session.getAttribute("memVO");

	String plan_id = request.getParameter("plan_id");
	PlanService planSvc = new PlanService();
	PlanVO planVO = planSvc.getOnePlan(plan_id);
	pageContext.setAttribute("planVO", planVO);

	String memidtoHg = planVO.getMem_id();
	MemVO memVOtoHg = memSvc.getOneMem(memidtoHg);
	pageContext.setAttribute("memVOtoHg", memVOtoHg);

	String perpageloc = request.getParameter("perpageloc");
	session.setAttribute("perpageloc", perpageloc);
	String sessionPerpageloc = (String) session.getAttribute("perpageloc");
%>


<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon"
	href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>WORK it OUT</title>


<!-- CSS dependencies -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/post/css/PersonalPage_list.css">

<!-- <script -->
<%-- 	src="<%=request.getContextPath()%>/front_end/post/js/jquery.events.touch.js"></script> --%>
<!-- <script -->
<%-- 	src="<%=request.getContextPath()%>/front_end/course/courboar/js/autotyping.js"></script> --%>
<!-- <script -->
<%-- 	src="<%=request.getContextPath()%>/front_end/post/js/truncateoverride.js"></script> --%>

<!-- <link rel="stylesheet" type="text/css" -->
<%-- 	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css"> --%>

<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">

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

/*圖片專區*/
#plan_cover {
	width: 250px;
	height: 250px;
	border-radius: 180px;
}
</style>

<!-- navbar setting -->

<style type="text/css">
	a, .fontstyle {
		font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
	}
	
	#update {
		font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
		font-size: 24px;
		font-weight:bold;
	}

	#delete {
		font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
		font-size: 24px;
		font-weight:bold;
	}
	
	
	.navbar-dark .navbar-nav .nav-link{
		color:rgba(255, 255, 255, 0.8)!important;
		font-weight:bold!important;
	
	}
	
	.together{
		display: inline;		
	
	}
	
	
</style>

<!-- 	<script> -->
<!-- // 		//使顯現出來的回應換行 -->
<!-- // 		$(function(){ -->
<!-- // 			$('#inputText').click(function(){ -->
<!-- // 				var temp = $('#message').val().replace(/\n/g,'<br/>'); -->
<!-- // 				$('#message').val(temp); -->
<!-- // 				$('#comPostForm').submit(); -->
<!-- // 			}); -->
<!-- // 		}); -->

<!-- 	</script> -->




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
          	<c:if test="${memVO.mem_id ==null }">
            	<a class="nav-link" href="<%=request.getContextPath() %>/front_end/plan/ListAllPlans_ForVisitor.jsp">WorkOutPlan</a>
			</c:if>
			<c:if test="${memVO.mem_id !=null }">
            	<a class="nav-link" href="<%=request.getContextPath() %>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
			</c:if>
		  </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp">Course</a>
          </li>
         
          <jsp:useBean id="coachSvc" scope="page" class="com.coach.model.CoachService" />
          <c:if test="${memVO!=null}">
	          <li class="nav-item mx-2 btn-lg dropdown" >
	            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">${memVO.mem_name}
	              <i class="fa fa-caret-down dropbtn"></i>
	            </a>
	            <div class="dropdown-content" id="myDropdown">
	               <a href="<%=request.getContextPath() %>/front_end/post/listAllPostByMem09.jsp"><i class="fa fa-file "><font class="fontstyle">&nbsp&nbsp個人頁面</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/plan/My_Plan_myself.jsp"><i class="fa fa-calculator"><font class="fontstyle">&nbsp&nbsp計畫</font></i></a>
	              <a href="<%=request.getContextPath()%>/front_end/friendlist/listfriendcomfirmed.jsp?perpageloc=friendlist#personalnav"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>
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
	<div class="row mb-5 personalarea" id="personalnav">
		<div class="col-md-3 offset-md-1">
			<div class="colProfile">
				<img class="img-fluid rounded-circle" alt="Card image"
					src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${memVO.mem_id}">
			</div>
		</div>
		<div class="col-md-4 align-self-end ml-1">
			<h1 class="text-left text-primary">${memVO.mem_name}</h1>
			<p class="text-left">${memVO.mem_intro}</p>
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
					<li class="nav-item" ><a class="nav-link personalnavlink" rel="<%=request.getContextPath()%>/front_end/post/listAllPostByMem09.jsp?perpageloc=mypage#personalnav" id="mypage" style="cursor: pointer;"> <i
							class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;
					</a></li>
				<!-- Workoutplan-->
					<li class="nav-item dropdown" ><a
						class="nav-link dropdown-toggle personalnavlink" aria-expanded="false"
						aria-haspopup="true" data-toggle="dropdown" rel="<%=request.getContextPath() %>/front_end/plan/My_Plan_myself.jsp?perpageloc=workoutplan#personalnav"
						id="workoutplan" style="cursor: pointer;"> <i class="fa fa-calculator"></i>
							&nbsp; WorkOutPlan &nbsp;
					</a>
						<div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom">
							<a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="<%= request.getContextPath() %>/front_end/plan/Create_Plan.jsp">Create Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light dropdown-item-custom"
								href="<%=request.getContextPath()%>/front_end/plan/My_Plan_myself.jsp">My Plan</a> <a
								class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light"
								href="<%=request.getContextPath()%>/front_end/plan/compositeQuery.jsp">Interesting Plan</a>
						</div></li>
					<!-- Friend-->
                  <li class="nav-item"><a class="nav-link personalnavlink"  rel="<%=request.getContextPath()%>/front_end/friendlist/listfriendcomfirmed.jsp?perpageloc=friendlist#personalnav" id="friend"> <i
                         class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends &nbsp;&nbsp;
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
  
	<P align="center"><font size="6">The Plan</font></P>

	<div class="container containerHrB  ">
		<hr>
	</div><br> 
	<!--plan title-->
	<div class="py-1">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h2 class="text-center" style="font-size: 36px; color: #00FFFF">Plan Name:&nbsp;${planVO.plan_name}</h2>
<%-- 					<input type="hidden" name="plan_name" value="${planVO.plan_name }"> --%>
					<br>
					<br>
				</div>
			</div>
		</div>


		<!-- start -->
		<div>
			<div class="container">
				<div class="row">
					<div class="p-0 col-lg-5 order-2 order-lg-1">
					<form method="post"  action="<%= request.getContextPath()%>/plan/plan.do">
					<a href="<%= request.getContextPath()%>/plan/plan.do?action=getOne_For_Display1&plan_id=${planVO.plan_id}">	
										<img class="card-img-top" style="height:250px; overflow:hidden;"
											src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
									</a>
<!-- 									<input type="hidden" name="action" value="getOne_For_Display"> -->
<%-- 									<input type="hidden" name="plan_id" value="${planVO.plan_id}"> --%>
								</form>
					
					
					
<!-- 						<img class="img-fluid" id="plan_cover" -->
<%-- 							src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}"> --%>
							
					</div>

					<div
						class="flex-column justify-content-center p-3 col-lg-7 order-1 order-lg-2">
						<button class="btn btn-lg btn-info text-light">
							<jsp:useBean id="sptypeSvc" scope="page"
								class="com.sptype.model.SptypeService" />
							<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
								<c:if test="${planVO.sptype_id ==sptypeVO.sptype_id }">${sptypeVO.sport}</c:if>
							</c:forEach>
						</button>
						<p>
							<font size="5">計畫開始: <fmt:formatDate
									value="${planVO.plan_start_date}" pattern="yyyy-MM-dd HH:mm " />
							</font>
						</p>

						<p>
							<font size="5">計畫結束: <fmt:formatDate
									value="${planVO.plan_end_date}" pattern="yyyy-MM-dd HH:mm " />
							</font>
						</p>
						
						<p>
							<font size="5">
							計畫狀態：
								<c:if test="${planVO.plan_status=='PLANST0'}">進行中</c:if>
								<c:if test="${planVO.plan_status=='PLANST1'}"><font size="5" color="red">已完成</font></c:if>
							</font>
							
						
						</p>
						
						
						<p>
<!-- 						<FORM METHOD="post" class="together" -->
<%-- 								ACTION="<%=request.getContextPath()%>/plan/plan.do" --%>
<!-- 								style="margin-bottom: 0px;" enctype="multipart/form-data"> -->
<!-- 									<input type="submit" class="btn btn-outline-primary mb-3" id="update"  value="update"> -->
<%-- 									<input type="hidden" name="plan_id" value="${planVO.plan_id}"> --%>
<%-- 									<input type="hidden" name="plan_name" value="${planVO.plan_name }"> --%>
<%-- 									<input type="hidden" name="plan_cover" value="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}"> --%>
<%-- 									<input type="hidden" name="plan_vo" value="${planVO.plan_vo }"> --%>
<%-- 									<input type="hidden" name="plan_start_date" value="${planVO.plan_start_date }"> --%>
<%-- 									<input type="hidden" name="plan_end_date" value="${planVO.plan_end_date }"> --%>
<%-- 									<input type="hidden" name="sptype_id" value="${planVO.sptype_id }"> --%>
<%-- 									<input type="hidden" name="plan_privacy" value="${planVO.plan_privacy }"> --%>
<%-- 									<input type="hidden" name="plan_status" value="${planVO.plan_status }"> --%>
<%-- 									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">   <!--送出本網頁的路徑給Controller--> --%>
<!-- 									<input type="hidden" name="action" value="getOne_For_Update"> -->
<!-- 							</FORM> -->
<!-- 							<FORM METHOD="post" class="together" -->
<%-- 								ACTION="<%=request.getContextPath()%>/plan/plan.do" --%>
<!-- 								style="margin-bottom: 0px;" enctype="multipart/form-data"> -->
<!-- 									<input type="submit" class="btn btn-outline-primary mb-3" id="delete" value="delete"> -->
<%-- 									<input type="hidden" name="plan_id" value="${planVO.plan_id}"> --%>
<%-- 									<input type="hidden" name="requestURL" value="<%=request.getServletPath()%>">   <!--送出本網頁的路徑給Controller--> --%>
<!-- 									<input type="hidden" name="action" value="delete"> -->
<!-- 									<input type="hidden" name="action" value="delete"> -->
									
<!-- 							</FORM> -->
						
						
						
						</p>
						
					</div>
					<div
						class="flex-column justify-content-center p-3 order-1 order-lg-2">
						<br>
						<p class="lead mb-0" style="color: white">
							<font color="white">${planVO.plan_vo}</font>
						</p>
					</div>
				</div>
			</div>
		</div>
</div>
		<!-- end -->

		<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
		<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
		<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
</body>
</html>

