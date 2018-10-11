<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>

<%
	PlanVO planVO = (PlanVO) request.getAttribute("planVO");
	pageContext.setAttribute("planVO", planVO);
%>

<jsp:useBean id="sptypeSvc" scope="page"
	class="com.sptype.model.SptypeService" />



<!DOCTYPE html>
<html>

<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<link rel="icon" href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
<title>Jennifer Lawernce</title>

<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
	
<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	



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

/*圖片專區*/
table {
	width: 1800px;
	/* 	background-color: #E0FFFF; */
	color: #FFFFFF;
	font-size: 18px;
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

.plan_cover {
	width: 165px;
	depth: 165px;
	border-radius: 100%;
}

.select, label {
	color: #FFFF00;
	font-size: 18px;
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
<body>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlhead.jsp" />
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>
	
	<%-- 萬用複合查詢-以下欄位-可隨意增減 --%>
	
	<div class="py-5 text-light opaque-overlay section-fade-in-out" 
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/img/CreatPlan_picture.jpg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 mx-auto">

					<form method="post" class="select" action="<%=request.getContextPath()%>/plan/plan.do" name="form1">
						<font>萬用複合查詢40</font><br>            
						<label for="inputPassword4">輸入關鍵字(只可查計畫名稱，計畫內容未加入):</label>
							<div class="input-group">
								<div class="input-group-prepend">
									<span class="input-group-text">Search</span>
								</div>
								<input type="text" name="plan_name" id="" class="form-control" placeholder="Key Word"  style="font-size: 17px">
								<div class="input-group-append">
									<button class="btn btn-info">
										<i class="fa fa-search"></i>
									</button>
								</div>
							</div><br>
						<div class="form-row">
						
							<div class="form-group col-md-4">
								<label for="inputPassword4">運動種類</label> 
								<select	class="form-control" id="inputPassword4" name="sptype_id" style="font-size: 17px">
									<option value="">請選擇
									<c:forEach var="sptypeVO" items="${sptypeSvc.all}">
										<option value="${sptypeVO.sptype_id}">${sptypeVO.sport}
									</c:forEach>
								</select>
							</div>
							
							<div class="form-group col-md-4">
								<label for="inputPassword4">隱私權</label> 
								<select	class="form-control" name="plan_privacy" id="inputPassword4" style="font-size: 17px">
									<option value="">請選擇
									<option value="PLANPR0">公開
									<option value="PLANPR1">不公開
									<option value="PLANPR2">只對朋友公開
								</select>
							</div>
							
							<div class="form-group col-md-4">
								<label for="inputPassword4">執行狀態</label>
								<select	class="form-control" name="plan_status" id="inputPassword4" style="font-size: 17px">
									<option value="">請選擇
									<option value="PLANST0">進行中
									<option value="PLANST1">已完成
								</select>
							</div>
						</div><br>
							<input type="submit" value="送出"> 
							<input type="hidden" name="action" value="listPlans_ByCompositeQuery">
						
					<div class="form-row">
<!-- 							<div class="form-group col-md-4"> -->
<!-- 								<label for="inputPassword4">計畫開始時間</label>  -->
<!-- 								<input type="text" name="plan_start_date" id="f_date1" class="form-control" /><br> -->
<!-- 							</div> -->
<!-- 							<div class="form-group col-md-4"> -->
<!-- 								<label for="inputPassword4">計畫結束時間</label>  -->
<!-- 								<input type="text" name="plan_end_date" id="f_date2" class="form-control" /><br> -->
<!-- 							</div> -->
<!-- 							<div class="form-group col-md-4"> -->
<!-- 								<label for="inputPassword4">計畫創建時間</label>  -->
<!-- 								<input type="text" name="plan_create_time" id="f_date3" class="form-control" /><br> -->
<!-- 							</div> -->
<!-- 						</div> -->
					</form>
				</div>
			</div>
		</div>
	</div>
<br>本網頁的路徑:<br><b>
   <font color=white size=5px>request.getServletPath():→ <%=request.getServletPath()%></font><br>
   <font color=white size=5px>request.getRequestURI():→ <%=request.getRequestURI()%></font> </b>

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

	$('#f_date3').datetimepicker({
		theme : 'dark-mint',
		timepicker : false,
		format : 'Y-m-d',
		value : '',
	});
</script>




</html>
