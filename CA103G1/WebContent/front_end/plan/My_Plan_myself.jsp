<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*"%>

<%

	PlanVO planVO = (PlanVO) request.getAttribute("planVO");
	pageContext.setAttribute("planVO", planVO);

	MemVO memVO = (MemVO) session.getAttribute("memVO");
	String mem_id = memVO.getMem_id();

	String perpageloc = request.getParameter("perpageloc");
	session.setAttribute("perpageloc", perpageloc);
	String sessionPerpageloc = (String) session.getAttribute("perpageloc");

	PlanService planSvc = new PlanService();
	List<PlanVO> list = planSvc.getPlansByMem(mem_id);
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="sptypeSvc" scope="page" class="com.sptype.model.SptypeService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">


<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>7WORK it OUT</title>

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
<link rel="stylesheet" crossorigin="anonymous" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ">


<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">

<style>


	/*頁面設定*/
	body {
		overflow-x: hidden;
	}
	
	h5 {
		font-size: 23px;
		color: #00FFFF;
	}
	
	p {
		font-size: 18px;
	}

/* 
</style>

<!-- navbar setting -->

<style type="text/css">
	a, .fontstyle {
		font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
	}
	
	.navbar-dark .navbar-nav .nav-link{
		color:rgba(255, 255, 255, 0.8)!important;
		font-weight:bold!important;
	
	}

</style>

</head>

<body class="text-center">

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

	


		<%@ include file="file/page1_ForVisitor.file"%>

		<div class="py-5 text-light opaque-overlay section-fade-in-out"
			style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/img/CreatPlan_picture.jpg&quot;);">
			<div class="container">
				<div class="row">
					<c:forEach var="planVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<div class="col-12 col-md-4">
							<div class="card">
								<a href="<%=request.getContextPath()%>/front_end/plan/test.jsp" >
									<img class="card-img-top" style="height:250px; overflow:hidden;"
										src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
								</a>
								
								<div class="card-body">
									<h5 class="plan_name">${planVO.plan_name}</h5>
									
									<p class="sptype_id">運動種類: 
										<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
											<c:if test="${planVO.sptype_id ==sptypeVO.sptype_id }">${sptypeVO.sport}</c:if>
										</c:forEach>

									</p> 
									
									<p class="plan_start_date">運動開始:　
										<fmt:formatDate value="${planVO.plan_start_date}" pattern="yyyy-MM-dd HH:mm " />
									</p>
									
									<p class="plan_end_date">運動結束:　
										<fmt:formatDate value="${planVO.plan_end_date}" pattern="yyyy-MM-dd HH:mm " />
									</p>
									<form method="post"  action="<%= request.getContextPath()%>/plan/plan.do">
										<button type='submit' class="btn btn-info" style="font-size: 16px">Read More</button>
										<input type="hidden" name="action" value="getOne_For_Display">
										<input type="hidden" name="plan_id" value="${planVO.plan_id }">
										<input type="hidden" name="mem_id" value="${planVO.mem_id }">
									</form>
								</div>
							</div><br>
						</div>
					</c:forEach>
				</div><br>
			</div>
		</div>
	</div>
	<%@ include file="file/page2_ForVisitor.file"%>
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->


</body>


</html>