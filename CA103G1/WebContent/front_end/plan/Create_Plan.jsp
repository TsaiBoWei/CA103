<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*" %>

<%
	PlanVO planVO = (PlanVO) request.getAttribute("planVO");
	pageContext.setAttribute("planVO", planVO);

	MemVO memVO = (MemVO) request.getAttribute("memVO");
	session.setAttribute("memVO", memVO);
	
%>

<%/*1.下拉式選單做<請選擇>選項，並作錯誤驗證及導向。 
	2.計畫封面圖片沒上傳錯誤處理不做。
	3.計畫內容拖拉圖片未做。
	4.set/cancel 按鈕未做完全。
	5.觀看次數

*/%>


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>

<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>WORK it OUT</title>

<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
<!-- Script: Make my navbar transparent when the document is scrolled to top -->
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<!-- Script: Animated entrance -->
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">
	
<!-- fafaicon -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">

<style>
/*頁面設定*/
	body {
		overflow-x: hidden;
	}
	
	.date{
		width: 170px;
		height: 33px;
		font-size: 18px;
	}
	
</style>

<%--上傳圖片 --%>
<script
	src="<%=request.getContextPath()%>/front_end/plan/js/UploadPlan_Cover.js"></script>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/plan/css/img.css">


</head>


<body class="text-center">
<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
	
	
	<div class="py-5 text-light opaque-overlay section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/img/CreatPlan_picture.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 mx-auto">
					<form method="post"
						action="<%=request.getContextPath()%>/plan/plan.do"
						enctype="multipart/form-data">

						<div class="form-group text-primary" style="font-size: 24px">
							Create A New Plan
						</div>
						<br>
						
						<%-- 錯誤表列 --%>
							<c:if test="${not empty errorMsgs}">
								<font style="color:red" size="5">Amend　The　Following　Errors</font><br>
								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color:red ; font-size:20px ">${message}</li>
									</c:forEach>
								</ul>
							</c:if>
						

						<div class="form-group">
							<h3>Plan Name</h3>
							<input type="text" name="plan_name"
								value="<%= (planVO==null) ? "MyFirstDay" : planVO.getPlan_name()%>"
								class="form-control"/>
						</div>
						<br>

				 		<div class="form-group">
							<label><h3>PlanStartDate</h3></label> 
							<input type="text" name="plan_start_date" id="f_date1" class="date"/>
						</div>


					 	<div class="form-group">
							<label><h3>Plan EndDate</h3></label> 
							<input type="text" name="plan_end_date" id="f_date2" class="date"/>
						</div>

						
						
 						<jsp:useBean id="sptypeSvc"  scope="page" class="com.sptype.model.SptypeService"/>
						
 						<div class="form-group">  
							<label><h3>Sport Type　</h3></label> <select size="1"
								name="sptype_id" style="width: 150px; font-size: 18px;">
								<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
									<option value="${sptypeVO.sptype_id}" ${(planVO.sptype_id==sptypeVO.sptype_id)? 'selected':''}>${sptypeVO.sport}
								</c:forEach>
							</select>
						</div>


						<div class="form-group">  
							<label><h3>Privacy　　　</h3></label> <select size="1"
								name="plan_privacy" style="width: 150px; font-size: 18px;">
								<option value="PLANPR0">公開</option>
								<option value="PLANPR1">不公開</option>
								<option value="PLANPR2">只對朋友公開</option>
							</select>
						</div>

						<div class="form-group">
							<label><h3>Plan Cover　</h3></label> 
							<label class="btn btn-info btn-lg"> 
								<input type="file" id="upload_img" name="plan_cover" accept="image/*" 
									 onchange="openFile(event)" style="display: none;" 
									 <%--  value="= (planVO==null) ?"= request.getContextPath()>/front_end/plan/images/photo.png":planVO.getPlan_cover%>"--%>/>
									<i class="fa fa-photo">　Upload</i>
							</label>
						</div>
						
						
						<div class="form-group">
							　　　　　　　　　<img class="img" id="output"  style="display: none;">
						</div>

						<div class="form-group">
							<label><h3>Plan Content</h3></label><br>
							<textarea name="plan_vo" rows="10" class="form-control" style="font-size: 22px"><%=(planVO == null) ? "Enter Your Plan Content" : planVO.getPlan_vo()%></textarea>
							<br>
						</div>
	
		
						<div class="from-group">
<!-- 							<h5> -->
<%--     							瀏覽數：${planVO.plan_view}  --%>
							<input type="hidden" name="plan_view" value="50">
<!-- 							</h5> -->
						</div>
						<div class="form-group">
							<input type="hidden" name="action" value="insert">
							<button type="submit" class="btn btn-primary">Create</button>
<!-- 							<button type="submit" class="btn btn-primary" -->
<%-- 								formaction="<%= request.getContextPath()%>/front_end/plan/Interesting_Plan.jsp">Reset</button> --%>
<!-- 							<button type="submit" class="btn btn-primary"  -->
<%-- 								formaction="<%= request.getContextPath()%>/front_end/plan/HomePage.jsp">cancel</button> --%>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container containerHrB ">
		<hr>
	</div>
	<!-- Here you go -->
	
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->

	<!-- Script: Smooth scrolling between anchors in a same page -->
	<script src="<%=request.getContextPath()%>/js/smooth-scroll.js"></script>
	<h1>20181004-6</h1> 
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

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/front_end/plan/datetimepicker/jquery.datetimepicker.full.js"></script>



<script>
$.datetimepicker.setLocale('zh'); // kr ko ja en
$(function(){
	$('#f_date1').datetimepicker({
		format:'Y-m-d H:i',
	  	timepicker:true,
	  	step: 5,
		onShow:function(){
			this.setOptions({
				maxDate:$('#f_date2').val()?$('#f_date2').val():false
			})
		}
	});
	 
	$('#f_date2').datetimepicker({
		format:'Y-m-d H:i',
		timepicker:true,
		step: 5,
		onShow:function(){
			this.setOptions({
				minDate:$('#f_date1').val()?$('#f_date1').val():false
			})
		}
	});
});
</script>

</html>