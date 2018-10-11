<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.plan.model.*"%>
<%@ page import="com.mem.model.*" %>

<%
	PlanVO planVO = (PlanVO) request.getAttribute("planVO");
	pageContext.setAttribute("planVO", planVO);
	
//	MemVO memVO = (MemVO) session.getAttribute("memVO");
	MemVO memVO = new MemVO();
	memVO.setMem_id("M000002");
	pageContext.setAttribute("memVO",memVO); 
	
	PlanService planSvc = new PlanService();
	List<PlanVO> list = planSvc.getAll();
	pageContext.setAttribute("list", list);
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
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/PersonalPageBase.css">

<<!-- navbar setting -->
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
</style>

<style>
table {
	width: 1200px;
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
			<form method="post" action="plan.do" name="form1">
				<table>
	
					<tr>
						<td>計畫編號<font color=red><b>*</b></font></td>
						<td><%=planVO.getPlan_id()%></td>
					</tr>
					<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService"/>
					<tr>
						<td>計畫創建人</td>
						<td>
							<%= planVO.getMem_id() %>
							<%= memVO %>
							${ memVO }...
							<c:if test="${planVO.mem_id == memVO.mem_id}" var="name"/>
							${name}
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
							<img class="plan_cover" src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id=${planVO.plan_id}">
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
								value="<%=planVO.getPlan_start_date()%>"  />
						</td>
					</tr>
					<tr>
						<td>計畫結束日</td>
						<td>
							<input type="text" name="plan_end_date" size="45" id="f_date2"
								value="<%=planVO.getPlan_end_date()%>"  />
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
						<td>瀏覽數</td>
						<td><%=planVO.getPlan_view()%></td>
					</tr>
					<tr>
						<td>執行狀態</td>
						<td>
							<select size="1" name="plan_status">
								<c:if test="${planVO.plan_status =='PLANST0'}"><option>進行中</option><option>已完成</option></c:if>
								<c:if test="${planVO.plan_status =='PLANST1'}"><option>已完成</option></c:if>
							</select>
						</td>
					</tr>
					<tr>
						<td>隱私權</td>
						<td>
							<select size="1" name="plan_status">
							
								<option value="planVO.plan_privacy">公開</option>
								<option value="planVO.plan_privacy">不公開</option>
								<option value="planVO.plan_privacy">只對朋友公開</option>
<%-- 								<c:if test="${planVO.plan_privacy =='PLANPR0'}">公開</c:if> --%>
<%-- 								<c:if test="${planVO.plan_privacy =='PLANPR1'}">不公開</c:if> --%>
<%-- 								<c:if test="${planVO.plan_privacy =='PLANPR2'}"> 只對朋友公開</c:if> --%>
							</select>
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