<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- PAGE settings -->
<link rel="icon" href="images/weight-lifting.png">
<title>WORK it OUT</title>
<meta name="description"
	content="Free Bootstrap 4 Pingendo Neon template for unique events.">
<meta name="keywords"
	content="Pingendo conference event neon free template bootstrap 4">


<style>
table {
	width: 1800px;
	background-color: #AFEEEE;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>




</head>
<body>
<body>

	<div class="container">
		<div class="row-12">
			<h5>我的計畫清單，可供修改、刪除。</h5>
			<%-- 錯誤表列 --%>
			<c:if test="${not empty errorMsgs}">
				<font style="color: red">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color: red">${message}</li>
					</c:forEach>
				</ul>
			</c:if>

			<table>
				<tr>
					<th>計畫封面</th>
					<th>計畫名稱</th>
					<th>計畫編號</th>
					<th>計畫創建人ID</th>
					<th>計畫內容</th>
					<th>計畫開始日</th>
					<th>計畫結束日</th>
					<th>運動類別</th>
					<th>計畫瀏覽數</th>
					<th>計畫隱私權</th>
					<th>計畫創建時間</th>
					<th>計畫執行狀態</th>
					<th>修改</th>
					<th>刪除</th>
				</tr>
				<%@ include file="page1.file"%>
				<c:forEach var="planVO" items="${list}" begin="<%=pageIndex%>"
					end="<%=pageIndex+rowsPerPage-1%>">
 
					<tr ${(planVO.plan_id==param.plan_id) ? 'bgcolor=#CCCCFF':''}>
						<td>${planVO.plan_cover}</td>
						<td>${planVO.plan_name}</td>
						<td>${planVO.plan_id}</td>
						<td>${planVO.mem_id}</td>
						<td>${planVO.plan_vo}</td>
						<td>${planVO.plan_start_date}</td>
						<td>${planVO.plan_end_date}</td>
						<td><c:forEach var="sptypeVO" items="${sptypeSvc.all}">
								<c:if test="${planVO.sptype_id ==sptypeVO.sptype_id }">
								【${sptypeVO.sport}】
								</c:if>
							</c:forEach></td>
						<td>${planVO.plan_view}</td>
						<td>${planVO.plan_privacy}</td>
						<td>${planVO.plan_create_time}</td>
						<td>${planVO.plan_status}</td>
						<td>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/plan/plan.do"
								style="margin-bottom: 0px;">
								<input type="submit" value="修改"> <input type="hidden"
									name="plan_id" value="${planVO.plan_id}"> <input
									type="hidden" name="action" value="getOne_For_Update">
							</FORM>
						</td>
						<td>
							<FORM METHOD="post"
								ACTION="<%=request.getContextPath()%>/plan/plan.do"
								style="margin-bottom: 0px;">
								<input type="submit" value="刪除"> <input type="hidden"
									name="plan_id" value="${planVO.plan_id}"> <input
									type="hidden" name="action" value="delete">
							</FORM>
						</td>
					</tr>
				</c:forEach>
			</table>
			<%@ include file="page2.file"%>
		</div>
	</div>

</body>


</html>