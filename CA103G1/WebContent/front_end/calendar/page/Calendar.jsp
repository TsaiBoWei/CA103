<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.*"%>
    <%@ page import="com.mem.model.*"%>
    <%@ page import="com.eve.model.*" %>
	<%@ page import="com.eventlist.model.*"%>
	<%@ page import="java.text.*"%>
	<%@ page import="com.plan.model.*" %>
	<%@ page import="com.purchcour.model.*" %>
	<%@ page import="com.courlist.model.*" %>
	<%@ page import="java.util.regex.*"%>
	<%@ page import="java.util.*"%>
<!DOCTYPE html>

<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<jsp:useBean id="planSvc" scope="page" class="com.plan.model.PlanService" />
<%-- <jsp:useBean id="purSvc" scope="page" class="com.purchcour.model.PurchcourService" /> --%>
<jsp:useBean id="courlistSvc" scope="page" class="com.courlist.model.CourlistService" />
<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO");  
 %>
<% /*以會員id取出對應的evelist*/
  	List<EventListVO> list =evelistSvc.getEveListsByMemToCal(memVO.getMem_id());
 %> 

<%-- <% /*以會員id(先用假資料)取出對應的evelist*/ --%>
<!-- 	List<EventListVO> list =evelistSvc.getEveListsByMemToCal("M000001");   -->
	
<!-- %> -->

<%
	List<EventVO> listEve = new ArrayList<EventVO>();
	for(EventListVO eve:list){
		EventVO vo = eveSvc.getOneEve(eve.getEve_id());
		listEve.add(vo);
	}//取出evelist裡的eve_id再查出eve_id所對應的event 並存進listEve
	
%>


<!--  /***假資料會員*****/ -->
<%-- <%	List<PlanVO> listPlan = planSvc.getPlansByMem("M000001");  --%>

<%--  %>  --%>

<%
  List<PlanVO> listPlan = planSvc.getPlansByMem(memVO.getMem_id()); 

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
 
<!-- //課程 暫不做 -->
<%-- <% --%>
<!-- // 	List<PurchCourVO> listPurchCour = purSvc.findByMemToCal("M000001"); -->
<!-- // 	System.out.println(listPurchCour); -->
<%-- %> --%>
<%-- <% --%>
<!-- // 	List<CourlistVO> listCour = new ArrayList<CourlistVO>(); -->
<!-- // 	for(PurchCourVO pur:listPurchCour){ -->
<!-- // 		CourlistVO vo  = courlistSvc.getOneToCal(pur.getCour_id()); -->
<!-- // 		System.out.println(vo); -->
<!-- // 		listCour.add(vo); -->
<!-- // 		System.out.println(listCour); -->
<!-- // 	} -->
<%-- %> --%>

<html>
<head>
<meta charset="BIG5">
<title>行事曆</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- PAGE settings -->
    <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">

    <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
    <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
    <!-- CSS dependencies -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/calendar/css/neon_cal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/PersonalPageBase.css">
<!--     <link rel="stylesheet" -->
<%-- 	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css"> --%>
    <link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">
	<!-- fafaicon -->
	<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
<!--    <link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.theme.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.structure.css">

    <!-- lightcase settings -->
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <!--  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/css/fullcalendar.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/calendar/css/jquery.datetimepicker.css" />
	
<script src="<%=request.getContextPath()%>/front_end/calendar/js/jquery.datetimepicker.full.js"></script>
    
    
    <script src="<%=request.getContextPath() %>/front_end/calendar/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath() %>/front_end/calendar/js/moment.min.js"></script>
    <script src="<%=request.getContextPath() %>/front_end/calendar/js/fullcalendar.js">
    </script>
    <script src="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    
    <!-- navbar setting -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
	<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
	<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
    <style>
        /*頁面設定*/

    body {
      overflow-x: hidden;
      height: 0%;
    }

    .eventCard {
      color: #fff;
    }
    
    .dialog_inpu input{width: 100%;} 
        .dialog_inpu textarea{width: 100%;} 
      
     .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }  
  
  #calendar1{
  background-color: rgba(204, 204, 204,0.2);
  }
   .fc th, .fc td{ 
   border:0.8px solid rgba(221, 221, 221,0.8); 
  	
   } 
   .fc .fc-row .fc-content-skeleton table, .fc .fc-row .fc-content-skeleton td, .fc .fc-row .fc-helper-skeleton td {
    background: none;
    border-color: transparent;
}
  .fc-state-hover, .fc-state-down, .fc-state-active, .fc-state-disabled, .fc-state-default {
    color: rgba(255,255,255,1);
    background-color: rgba(68,68,68,0);
    background-image: linear-gradient(to bottom, rgba(68, 68, 68, 0.8), rgba(68, 68, 68, 0.8));
}
 .note-editable { padding-top: 50px !important;}
/* background-image: linear-gradient(to bottom, rgba(31, 31, 31, 0.8), #e6e6e6); */
.fc-event{font-size: .92em;}

.navbar-dark .navbar-nav .nav-link{
color:rgba(255, 255, 255, 0.8)!important;
font-weight:bold!important;

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
	<div class="container" style="height:100px"></div>
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
								href="<%=request.getContextPath()%>/front_end/plan/My_Plan.jsp">My Plan</a> <a
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
	


























<!-- <!-- =========================================以下為原personlhead.jsp的內容========================================== --> 
<%-- 	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/> --%>
<!-- <!-- =========================================以上為原personlhead.jsp的內容========================================== --> 

   
   
   
   
    
      <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
    <div class="py-5">
        <div class="container">
            <div class="row">
                <!--行事曆-->
                <div class="col-md-12 cal1 py-4 px-3" id="calendar1"></div>
                <!-- 計畫列表-->
                  
              <div class="dialog_inpu" id="evedialog" title="My dialog" style="display:none">
    <div class="container">
    




      <div id="eve_id" style="display:none"></div>
      <div class="row">
        <div class="" >活動標題:</div>
        <div id="eve_title"></div>
      </div>
      <div class="row">
        <div>活動內容:</div>
        <div id="eve_content"></div>
        
<!--             <input type="hidden" name="eve_content" id="eve_content"> -->
<!--          <textarea class="form-control" id="eve_content" name="plan_vo" rows="5"></textarea> -->
        
      </div>
      <div class="row">
        <div>活動地點:</div>
        <div id="eve_location"></div>
      </div>
      <div class="row">
        <div>活動開始時間:</div>
        <div id="eve_startdate"></div>
      </div>
      <div class="row">
        <div>活動結束時間:</div>
        <div id="eve_enddate"></div>
      </div>
      <div class="row">
        <div>收費金額:</div>
        <div id="eve_charge"></div>
      </div>
      <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div>
          <input type="hidden" name="eve_idTochange" id="eve_idTochange">
          <input type="hidden" name="eve_chargeToback" id="eve_chargeToback">
          <input type="hidden" name="CaloutEvent" value="Cal_out_event" >
          <input type="submit" name="deleteEve" value="退出活動" class="m-1 btn btn-info"> </div>
      </form>
    </div>
  </div>
  
  
    <!-- 計畫列表-->
     <div class="col p-3" id="plandialog" style="display:none">
     
        <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
     
       <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div class="form-group">
          <input type="text" class="form-control" id="plan_id" name="plan_id" style="display:none"> </div>
        <div class="form-group">
          <label for="plan_name">計畫名稱</label>
          <input type="text" placeholder="計畫名稱" id="plan_name" name="plan_name" class="form-control" id="plan_name"> </div>
        <div class="form-row">
          <div class="form-group col m-1">
            <label for="plan_start_date">計畫開始日</label>
            <input type="text" class="form-control date1" placeholder="" id="plan_start_date" name="plan_start_date"> </div>
          <div class="form-group col m-1">
            <label for="plan_end_date">計畫結束日</label>
            <input type="text" class="form-control date1" placeholder="" id="plan_end_date" name="plan_end_date"> </div>
        </div>
        <div class="form-group">
          <label for="plan_vo">計畫內容</label>
           <div id="summernote"></div>
        
            <input type="hidden" name="plan_vo" id="plan_vo">
<!--           <textarea class="form-control" id="plan_vo" name="plan_vo" rows="5"></textarea> -->
        </div>
        
       
        <input type="submit" id="updatePlan" name="changePlan" value="修改計畫" class="m-1 btn btn-info">
        <input type="hidden" name="CalChangePlan" value="Cal_Change_Plan" >
      </form>
      <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div>
          <input type="hidden" name="plan_idToDelete" id="plan_idToDelete">
          <input type="hidden" name="outPlan" value="out_Plan" >
          <input type="submit" name="deletePlan" value="刪除計畫" class="btn btn-primary my-2"> 
       </div>
      </form>
    </div>
    <!-- 計畫列表結束-->            
    
     <!-- 課程列表開始-->
     
<!--      <div class="dialog_inpu" id="courdialog" title="My dialog" style="display:none"> -->
<!--      <div class="container"> -->
<!--       <div class="row"> -->
<!--         <div>課程名稱:</div> -->
<!--         <div id="cname"></div> -->
<!--       </div> -->
<!--       <div class="row"> -->
<!--         <div>課程介紹:</div> -->
<!--         <div id="cour_text" ></div> -->
<!--       </div> -->
<!--       <div class="row"> -->
<!--         <div>課程公告:</div> -->
<!--         <div id="cour_ann"></div> -->
<!--       </div> -->
      
<!--       c:for -->
<!--       <div class="row"> -->
<!--         <div>課程單元:</div> -->
<!--         <div id="cu_name"></div> -->
<!--         <a class="btn btn-link m-2" href="#" >前往觀看</a> -->
<!--       </div> -->
      
<%--       <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do"> --%>
<!--         <div> -->
<!--           <input type="hidden" name="eve_idTochange" id="eve_idTochange"> -->
<!--           <input type="hidden" name="eve_chargeToback" id="eve_chargeToback"> -->
<!--           <input type="hidden" name="CaloutEvent" value="Cal_out_event"> -->
<!--           <input type="submit" name="deleteEve" value="退訂" class="m-1 btn btn-info"> </div> -->
<!--       </form> -->
<!--     </div> -->
<!--   </div> -->
     
     
     
     
     
     
     
     
     
     
          
            </div>
        </div>
    </div>
    <div class="container containerHrB ">
        <hr>
    </div>
    <!-- Here you go -->
    <!-- Here you go -->
    <!-- Sponsor logos -->
    <!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
	<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	
    <!-- JavaScript dependencies -->
    <script>
    $(document).ready(function() {
        $(".cancel").click(function() {
           
             $(location).attr('href', 'https://fontawesome.com/icons/play-circle?style=regular');

                
                 });
    });
    
    $.datetimepicker.setLocale('zh');
    
    <!-- 活動的值帶入 -->
    var events = [
    	<% 	
    		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    	for(EventVO ii: listEve){
    		
    	%>
    	
    		{
        	id: '<%=ii.getEve_id()%>',
        	title: '<%=ii.getEve_title()%>',
        	start: '<%=sdFormat.format(ii.getEve_startdate())%>',
        	end: '<%=sdFormat.format(ii.getEve_enddate())%>',
        	description:'<%=ii.getEve_content()%>',
        	money:'<%=ii.getEve_charge()%>',
        	location:'<%=ii.getEve_location()%>',
        	moneytobackend:'<%=ii.getEve_charge()%>',
        	eveidtochange:'<%=ii.getEve_id()%>',
        	
        	
    		},
      
    	<%
    	
    	
          }
        %>  
       
    	]
    <!-- 計畫的值帶入 -->
    	var plan = [
    		<% 	
    		SimpleDateFormat sdFormat1 = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    	for(PlanVO planCal: listPlan){
    		
     		
    			String str = planCal.getPlan_vo();
     
  		  	%>
    	
    		{
    	        id: '<%=planCal.getPlan_id()%>',
    	        title: '<%=planCal.getPlan_name()%>',
    	        start: moment('<%=sdFormat1.format(planCal.getPlan_start_date())%>'),
    	        end: moment('<%=sdFormat1.format(planCal.getPlan_end_date()) %>'),
    	        <%    	       
   		 			 String dest = "";
  					 if (str!=null) {
  						Pattern p = Pattern.compile("\\s*|\r|\n");
  						Matcher m = p.matcher(str);
  						dest = m.replaceAll("");
  					}
  					            	        
    	        %>
    	        description: '<%=dest%>',
    	        planidToDelete:'<%=planCal.getPlan_id()%>',
    	        
    	      
    	    	},
    	    	
    		
    	<%
    	}
        %>  
    		
    	]
    	
    	<!-- 課程的值帶入 -->
    	var cour=[
    		
//     		{id:'cour0001',
//     		title:'測試',
//     		start:'2018-10-07',
    		
//     		},
    			
    			
<%--     		<% --%>
//     		SimpleDateFormat sdFormat2 = new SimpleDateFormat("yyyy-MM-dd hh:mm");
//     		for(CourlistVO courCal: listCour){    		
<%--     		%> --%>
//     		{
<%--     		id:'<%=courCal.getCour_id()%>', --%>
<%--     		title:'<%=courCal.getCname()%>', --%>
    		
    		
<%--     		description:'<%=courCal.getCour_text()%>', --%>
//     		}, 
    		
    		
<%--     		<% --%>
//     		}
<%--     		%> --%>
    		
    		]
    	
    	
    	
    	
        $(document).ready(function() {
//             (function() {
                var date = new Date();
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();

                <!-- 設定fullcalendar--> 
                $('#calendar1').fullCalendar({
                    editable: true,
                    height: 650,
                    width: 500,
                    
                    eventLimit: true,
                    nextDayThreshold: "00:00:00",
                    header: {
                    	 left: 'today prev,next',
                         center: 'title',
                         right: 'agendaDay,agendaWeek,month'
                    },

                    <!-- eventSources帶入活動和計畫到fullcalendar --> 
                    eventSources: [
                    	{
                    		events: events,
                    		 color: 'rgba(130, 179, 183,0.5)',
                    		 
                    		 editable: false
                    	},
                    	{
                    		
                    		events:plan,
                    		 color: 'rgba(200, 175, 217,0.5)',
                    		 
                    		 
                    	},
                    	
                    	{
                    		events:cour,
                    		color:'blue',
                    		allDayDefault:true,
                    		editable: false
                    		
                    		
                    	},
                    	
                    ],
                    eventClick: function(calEvent, jsEvent, view) { //計畫條點選事件，表示點擊計畫條之後要幹嘛
                    	 
                    	var eventcheck = calEvent.id;
                    
                    if(eventcheck.indexOf('E00')>-1){

                        $("#evedialog").dialog({ //對話框的設定
                            autoOpen: false,
                            draggable: true,
                             height: 520,
                            width:620,
                            title: "work it out!",
                        });
                       
             
                        $("#eve_id").html(calEvent.id); //關於對話框(活動)內各數值的設定
                        $("#eve_title").html(calEvent.title); 
                        $("#eve_content").html(calEvent.description);
                        $("#eve_charge").html(calEvent.money);
                        $("#eve_location").html(calEvent.location);
                        
                        $("#eve_startdate").html(moment(calEvent.start).format("YYYY-MM-DD hh:mm A"));
                        $("#eve_enddate").html(moment(calEvent.end).format("YYYY-MM-DD hh:mm A"));
                        $("#eve_chargeToback").val(calEvent.moneytobackend);
                        $("#eve_idTochange").val(calEvent.eveidtochange);
                       
                        $('#evedialog').dialog('open');//對話框開啟
                        
                    }else if(eventcheck.indexOf('PLAN00')>-1){
                    	     $("#plandialog").dialog({ //對話框的設定
                                 autoOpen: false,
                                 draggable: true,
                                  height: 520,
                                 width:620,
                                 title: "work it out!",
                             });
                    	     
                    	     $("#plan_id").val(calEvent.id);
                    	     $("#plan_name").val(calEvent.title);
                    	     $("#plan_start_date").val(moment(calEvent.start).format("YYYY-MM-DD hh:mm"));
                    	     $("#plan_end_date").val(moment(calEvent.end).format("YYYY-MM-DD hh:mm"));
//                     	     $("#plan_vo").html(calEvent.description);
                    	     $("#plan_idToDelete").val(calEvent.planidToDelete);
                    	    
                    	     $('#plan_end_date').datetimepicker({
                    	         theme: '',              //theme: 'dark',
                    	  	       timepicker:true,       //timepicker:true,
                    	  	       step: 5,                //step: 60 (這是timepicker的預設間隔60分鐘)
                    	  	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
                    	  		  // value:   new Date(),
                    	         //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
                    	         //startDate:	            '2017/07/10',  // 起始日
                    	         minDate:               '-1970-01-01', // 去除今日(不含)之前
                    	         //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
                    	      });
                    	     $('#plan_start_date').datetimepicker({
                    	         theme: '',              //theme: 'dark',
                    	  	       timepicker:true,       //timepicker:true,
                    	  	       step: 5,                //step: 60 (這是timepicker的預設間隔60分鐘)
                    	  	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
                    	  		    // value:   new Date(),
                    	         //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
                    	         //startDate:	            '2017/07/10',  // 起始日
                    	         minDate:               '-1970-01-01', // 去除今日(不含)之前
                    	         //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
                    	      });
                    	     

                             $('#summernote').summernote({

                             	height: 400, 
                             	toolbar: [
                             	    ["style", ["style"]],
                             	    ["font", ["bold", "italic", "underline", "clear"]],
                             	    ["fontsize", ["fontsize"]],
                             	    ["para", ["ul", "ol", "paragraph"]],
                             	    ["insert", ["link", "picture", "hr"]]
                             	  ],
//                              	 popover: {
//                              	   image: [],
//                              	   link: [],
//                              	   air: []
//                              	 }
                             	       });      

                             	  //summernote賦值(將文字顯示在summernote上)    
                             	  $("#summernote").summernote("code", calEvent.description);
                             	  //summernote取值
                             	  $("#updatePlan").click(function(){
                             		  
                             	        var markupStr = $('.note-editable').html();
                             	        $("#plan_vo").val(markupStr);
                             	      });    
                    	     
                    	     $('#plandialog').dialog('open');
                    	     
                    	     
                    	}else{
                    		 $("#courdialog").dialog({ //對話框的設定
                                 autoOpen: false,
                                 draggable: true,
                                  height: 620,
                                 width:620,
                                 title: "work it out!",
                             });
                    		 
                    		 $('#courdialog').dialog('open');
                    		 
                    	 };
                    	 
//                     	 if (calEvent.url) {
//                              window.open(calEvent.url);
//                              return false;
//                          }
                    }
                    
                   
                });
//             }());


		












        });

    </script>
    <!--    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>-->
      <!-- Script: Smooth scrolling between anchors in a same page -->

	 <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<!-- <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script> -->
<script src="<%=request.getContextPath() %>/front_end/calendar/js/summernote.js"></script>
</body>
</html>