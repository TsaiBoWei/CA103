<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.friendlist.model.*"%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="friendListSvc" scope="page" class="com.friendlist.model.FriendListService" />

<%
	//模擬會員
	session.setAttribute("memVO", memSvc.getOneMem("M000001"));

	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO");

	//	多這一串會送500 status code
		List<FriendListVO> list = friendListSvc.findFriendListByMem(memVO.getMem_id());
		pageContext.setAttribute("list",list);
%>

<!DOCTYPE html>
<html>
<head>

<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- PAGE settings -->
<title>Jennifer Lawernce</title>

<!-- CSS dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
	type="text/css">
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

table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
	display: inline;
}
</style>

<style>
table {
	width: 100%;
	background-color: #1f1f1f;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #12bbad;
}

th, td {
	padding: 5px;
	text-align: center;
}

.eveImg {
	width: 100%;
	height: 180px;
}

#dylan_memPhoto {
	width:270px;
	height: 230px;
	border-radius: 60%;
}

#form1{
	margin:0px; 
	display:inline
}

</style>
</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
<jsp:include page="/front_end/course/purchcour/page/personlhead.jsp" />
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

<c:if test="${not empty errorMsgs}">
	<font style="color: red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color: red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<%
	session.removeAttribute("errorMsgs");
%>


<!-- code寫在這記得加container -->

<div class="container">
	<div class="row">
		<div class="col-12">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div class="collapse navbar-collapse " id="navbarSupportedContent">
					<ul class="nav nav-tabs mr-auto">
						<li class="nav-item"><a class="nav-link  text-white active"><h4>我的好友清單</h4></a>
						</li>
						<li class="nav-item"><a class="nav-link text-white disabled"
							href="<%=request.getContextPath()%>/front_end/friendlist/listfriendunconfirmed.jsp"><h4>待確認</h4></a></li>
					</ul>

					<form class="form-inline my-2 my-lg-0">
						<input class="form-control mr-sm-2" type="search"
							placeholder="Search" aria-label="Search">
						<button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
					</form>
				</div>
			</nav>
		</div>
		<!-- 				好友卡片 -->
			<div class="container">
				<div class="row">
				
<!-- 	========================================================================================== -->
				<c:forEach var="friendlistVO" items="${list}">
					<div class="col-12 col-md-4">
						<div class="card" style=" padding:20px;margin: 20px;">
							<img id="dylan_memPhoto" src="<%=request.getContextPath()%>/friendlist/FriendList_DBGifReader.do?mem_id=${friendlistVO.fl_memB_id}">
							<div class="card-body">
								
								<input type="image" src="<%=request.getContextPath()%>/front_end/friendlist/images/chat03.png" align="left">
								
								<h3 id=dylan_fl_name align="center" style="display: inline;">
									${memSvc.getOneMem(friendlistVO.fl_memB_id).mem_name}
								</h3>
								
<!-- 								刪除好友清單內的會員 -->
								<form  id="form1"  name="form1"  method="post"  action="<%=request.getContextPath()%>/friendlist/friendlist.do" >
									 <input type="image" src="<%=request.getContextPath()%>/front_end/friendlist/images/remove.png" align="right">
									 <input type="hidden" name="fl_memA_id" value="${memVO.mem_id}">
									 <input type="hidden" name="fl_memB_id" value="${memSvc.getOneMem(friendlistVO.fl_memB_id).mem_id}">
									 <input type="hidden" name="action" value="delete">
								</form>
							</div>
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
		</div>
	</div>

	<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	<jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp" />
	<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->