<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*" %>

<%
	PlanVO planVO = (PlanVO) session.getAttribute("planVO");
	
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	
// 	PlanService planSvc = new PlanService();
// 	List<PlanVO> list = planSvc.getAll();
// 	pageContext.setAttribute("list", list);

String perpageloc = request.getParameter("perpageloc");
	session.setAttribute("perpageloc", perpageloc);
	String sessionPerpageloc = (String) session.getAttribute("perpageloc");

%>



<%/*
	1.更換圖片未做


*/%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>WORK it OUT</title>

<!-- CSS dependencies -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/post/css/PersonalPage_list.css">

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

</style>


<style>
table {
	width: 1200px;
	/* 	background-color: #E0FFFF; */
	color: #FFFFFF;
	font-size: 22px;
	margin-top: 10px;
	margin-bottom: 10px;
}

table, th, td {
	border: 1px solid #00FFFF;
}

th, td {
	padding: 8px;
	text-align: center;
}

h5, label {
	font-size: 30px;
	color: red;
}

/*圖片專區*/
.plan_cover {
	width: 165px;
	depth: 165px;
	border-radius: 100%;
}

</style>

<script
	src="<%=request.getContextPath()%>/front_end/plan/js/UploadPlan_Cover.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/plan/css/img.css">



<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>



</head>
<body>
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
	<div class="container" >
		<div class="row">
			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
			<form method="post" action="<%=request.getContextPath()%>/plan/plan.do" name="form1"  enctype="multipart/form-data">
				<table>
	
					<tr>
						<td>計畫編號<font color=red><b>*</b></font></td>
						<td><%=planVO.getPlan_id()%></td>
					</tr>
					<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService"/>
					<tr>
						<td>計畫創建人</td>
						<td>
<%-- 							<%= memVO.getMem_id() %> --%>
<%-- 							<%= memVO %> --%>
<%-- 							${ memVO }... --%>
							<c:if test="${planVO.mem_id == memVO.mem_id}" var="name"/>
							${memVO.mem_name}
<%-- 							<%= memVO.getMem_name() %> --%>
						</td>
					</tr>
					<tr>
						<td>計畫創建日</td>
						<td>
							<%= planVO.getPlan_create_time()%>
						</td>
					</tr>
					<tr>
						<td>計畫封面</td>
						<td>
							<input type="hidden" name="plan_cover">
							<img class="plan_cover" src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}"><br>
<!-- 	 						<label class="btn btn-info btn-lg">  -->
<!-- 								<input type="file" id="upload_img" name="plan_cover" accept="image/*" -->
<!-- 									onchange="openFile(event)" style="display: none;"/> -->
<!-- 								<i class="fa fa-photo">　Replace</i> -->
<!-- 							</label> -->
	 					
	 					</td>
	<!-- 					<td><input type="TEXT" name="ename" size="45" -->
	<%-- 						value="<%=empVO.getEname()%>" /></td> --%>
					</tr>
					<tr>
						<td>計畫名稱</td>
						<td><input type="TEXT" name="plan_name" size="45"
							value="<%=planVO.getPlan_name()%>" /></td>
					</tr>
					<tr>
						<td>計畫內容</td>
						<td><textarea  name="plan_vo" rows="4" class="form-control" style="font-size: 22px" ><%=planVO.getPlan_vo() %></textarea></td>
					</tr>
					<tr>
						<td>計畫開始日</td>
						<td>
							<input type="text" name="plan_start_date" size="45" id="f_date1"
								value="<fmt:formatDate
									value="${planVO.plan_start_date}" pattern="yyyy-MM-dd HH:mm " />">
<%-- 							<fmt:formatDate --%>
<%-- 									value="${planVO.plan_start_date}" pattern="yyyy-MM-dd HH:mm " />  --%>
						</td>
					</tr>
					<tr>
						<td>計畫結束日</td>
						<td>
							<input type="text" name="plan_end_date" size="45" id="f_date2"
								value="<fmt:formatDate
									value="${planVO.plan_end_date}" pattern="yyyy-MM-dd HH:mm " />"  />
						</td>
					</tr>
					<jsp:useBean id="sptypeSvc" scope="page" class="com.sptype.model.SptypeService" />
					<tr>
						<td>運動種類:<font color=red><b>*</b></font></td>
						<td><select size="1" name="sptype_id">
								<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
									<option value="${sptypeVO.sptype_id}"
										${(planVO.sptype_id==sptypeVO.sptype_id)?'selected':'' }>${sptypeVO.sport}
								</c:forEach>
						</select></td>
					</tr>
					<tr>
						<td>執行狀態</td>
						<td align="center">
							<select size="1" name="plan_status">
								<c:if test="${planVO.plan_status =='PLANST0'}"><option value="PLANST0">進行中</option><option value="PLANST1">已完成</option></c:if>
								<c:if test="${planVO.plan_status =='PLANST1'}"><option value="PLANST1" readonly>已完成</option></c:if>
							</select>
						</td>
					</tr>
					<tr>
						<td>隱私權</td>
						<td align="center">
							<select size="1" name="plan_privacy">
<%-- 								<c:forEach var="planVO" items="" --%>
								<c:if test="${planVO.plan_privacy =='PLANPR0'}"><option value="PLANPR0">公開</option><option value="PLANPR1">不公開</option><option value="PLANPR2">只對朋友公開</option></c:if>
								<c:if test="${planVO.plan_privacy =='PLANPR1'}"><option value="PLANPR1">不公開</option><option value="PLANPR0">公開</option><option value="PLANPR2">只對朋友公開</option></c:if>
								<c:if test="${planVO.plan_privacy =='PLANPR2'}"><option value="PLANPR2">只對朋友公開</option><option value="PLANPR0">公開</option><option value="PLANPR1">不公開</option></c:if>
							</select>
						</td>
					</tr>
					<tr> 
						<td>瀏覽數</td>
						<td><%=planVO.getPlan_view()%></td>
					</tr>
					<tr>
						<td colspan="2"  align="center">
							<input  class="btn btn-info btn-lg" value="Update" type="submit" >
							<input type="hidden" name="plan_id" value="${planVO.plan_id }">
							<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
							<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  <!--只用於:istAllEmp.jsp-->
							<input type="hidden" name="action" value="update"/>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<!-- 						<td> -->
	<!-- 							<FORM METHOD="post" -->
	<%-- 								ACTION="<%=request.getContextPath()%>/plan/plan.do" --%>
	<!-- 								style="margin-bottom: 0px;"> -->
	<!-- 								<input type="submit" value="刪除"> <input type="hidden" -->
	<%-- 									name="plan_id" value="${planVO.plan_id}"> <input --%>
	<!-- 									type="hidden" name="action" value="delete"> -->
	<!-- 							</FORM> -->
	<!-- 						</td> -->
	<!-- 						<td> -->
	<!-- 							<FORM METHOD="post" -->
	<%-- 								ACTION="<%=request.getContextPath()%>/plan/plan.do" --%>
	<!-- 								style="margin-bottom: 0px;"> -->
	<!-- 								<input type="submit" value="修改"> <input type="hidden" -->
	<%-- 									name="plan_id" value="${planVO.plan_id}"> <input --%>
	<!-- 									type="hidden" name="action" value="getOne_For_Update"> -->
	<!-- 							</FORM> -->
	<!-- 						</td> -->


	<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->

	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
	<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->



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
<%
	java.sql.Date plan_create_time = null;
	try {
		plan_create_time = planVO.getPlan_create_time();
	} catch (Exception e) {
		plan_create_time = new java.sql.Date(System.currentTimeMillis());
	}
%>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.css" />

<script
	src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.js"></script>

<script
	src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.full.js"></script>



<script>
	$.datetimepicker.setLocale('zh');
	$(function() {
		$('#f_date1').datetimepicker({
			format : 'Y-m-d H:i',
			timepicker : true,
			step : 5,
			onShow : function() {
				this.setOptions({
					maxDate : $('#f_date2').val() ? $('#f_date2').val() : false
				})
			}
		});

		$('#f_date2').datetimepicker({
			format : 'Y-m-d H:i',
			timepicker : true,
			step : 5,
			onShow : function() {
				this.setOptions({
					minDate : $('#f_date1').val() ? $('#f_date1').val() : false
				})
			}
		});
	});
</script>



</html>