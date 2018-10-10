<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%
	PlanService planSvc = new PlanService();
	List<PlanVO> list = planSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="sptypeSvc" scope="page"
	class="com.sptype.model.SptypeService" />


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon"
	href="<%=request.getContextPath()%>/front_end/plan/img/PersonalPage_icon.png">
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




</head>

<body>

	<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlhead.jsp" />
	<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
	<div class="py-5 text-light opaque-overlay section-fade-in-out"
		style="background-image: url(&quot;<%=request.getContextPath()%>/front_end/plan/img/CreatPlan_picture.jpeg&quot;);">
		<div class="container">
			<div class="row">
				<div class="col-12 col-md-6 mx-auto">
					<form>

						<label>信用卡5</label>
						<div class="form-inline">
							<div class="form-group w-100">
								<select class="form-control w-20 d-block">
								</select> <select class="form-control w-20 d-block">
								</select> <select class="form-control w-20 d-block">
								</select> <select class="form-control w-20 d-block">
								</select>
							</div>
						</div>

						<div class="form-row">
							<div class="form-group col-md-4">
								<label for="inputPassword4">查詢選項</label> <select
									class="form-control" id="inputPassword4">
									<option value="">計畫創建人</option>
									<option value="">計畫名稱</option>
									<option value="">計畫內容</option>
									<option value="">開始日</option>
									<option value="">結束日</option>
									<option value="">運動類別</option>
									<option value="">隱私權</option>
									<option value="">創建時間</option>
									<option value="">執行狀態</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label for="inputPassword4">Password</label> <select
									class="form-control" id="inputPassword4">
									<option value="">計畫創建人</option>
									<option value="">計畫名稱</option>
									<option value=""></option>
									<option value="">4</option>
									<option value="">5</option>
									<option value="">6</option>
									<option value="">7</option>
									<option value="">8</option>
									<option value="">9</option>
									<option value="">10</option>
								</select>
							</div>
							<div class="form-group col-md-4">
								<label for="inputPassword4">Password</label> <select
									class="form-control" id="inputPassword4">
									<option value="">計畫創建人</option>
									<option value="">計畫名稱</option>
									<option value=""></option>
									<option value="">4</option>
									<option value="">5</option>
									<option value="">6</option>
									<option value="">7</option>
									<option value="">8</option>
									<option value="">9</option>
									<option value="">10</option>
								</select>
							</div>
						</div>


						<div class="form-group">
							<label>選擇你想查詢的計畫</label> <select class="form-control">
								<option value="">計畫創建人</option>
								<option value="">計畫名稱</option>
								<option value=""></option>
								<option value="">4</option>
								<option value="">5</option>
								<option value="">6</option>
								<option value="">7</option>
								<option value="">8</option>
								<option value="">9</option>
								<option value="">10</option>
							</select>
						</div>
						<div class="form-group">
							<label>name</label>
							<textarea class="form-control" rows="10"></textarea>
						</div>
					</form>
					<form>
						<div class="input-group">
							<div class="input-group-prepend">
								<span class="input-group-text">Search</span>
							</div>
							<input type="text" name="" id="" class="form-control">
							<div class="input-group-append">
								<button class="btn btn-warning">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>

	<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
	<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->

</body>


</html>