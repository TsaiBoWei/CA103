<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*" %>
<%@ page import="java.util.*, com.memsplike.model.MemSpLikeVO" %>
<%@ page import="com.mem.model.*" %>
<%@ page import="com.coach.model.*" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- CSS  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!--  self-defined css  -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  
  

  
  <!-- JS  -->
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
 
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>
  <!-- navbar setting -->
   <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
 
  <title>會員修改</title>

    <style type="text/css">
    body {
      font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei";
      font-weight: bold;
      
    }

    h1,h2,h3,h4,h5,h6 {
        font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei";
        color: #efefef;
      }

    .form-group label{
      font-size: 20px;
    }

    .form-check-input,.form-check{
       font-size: 20px;
    }
    #addEveBtn{
       font-weight: bold;
    }
    
    #upload_pic1{
    	width:100%;
    }
    
    .errorMsg{
    	color:red;
    
    }
    
    input{
      font-size:18px;
      color:black;
      font-weight:bold;
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
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
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
	               
	               <c:if test="${coachSvc.getOneCoachByMemId(memVO.mem_id).coa_status=='CS02'}">
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
	<div class="container" style="padding-top: 65px;">
		<div class="col-sm-12 formContent center text-light">
			<form action="<%=request.getContextPath()%>/mem/mem.do"
				method="post" enctype="multipart/form-data">
				<div class="form-group">
					<h4 class="mt-3 text-light" align="center">修改資料</h4>
				</div>
				<div class="form-group ">
					<div>
						<img src="<%=request.getContextPath() %>/mem/MemberDBPicReader?memID=${memVO.mem_id }" class="preview" style="max-width: 150px; max-height: 150px;">
						<div class="size"></div>
					</div>
					<label style="font-size: 150%">上傳圖片 : </label> <input type="file" class="upl"
						name="memPhoto" >
				</div>
				<div class="form-group">
					<label style="font-size: 150%">會員暱稱 :</label> <input type="text" name="memName"
						class="form-control" value=${memVO.mem_name }>
				</div>
				<div class="form-group">
					<label style="font-size: 150%">會員生日 :</label> <input type="date" name="memBirth"
						class="form-control" value="${memVO.mem_birth }">
				</div>
				<div class="form-group">
					<label style="font-size: 150%">會員信箱 :</label> <input type="email" name="memEmail"
						class="form-control">
				</div>
				<div class="form-group" style="padding-top: 10px;">
					<fieldset >
						<legend>運動喜好 :</legend>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000001" value="SP000001">田徑</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000002" value="SP000002">單車</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000003" value="SP000003">球類</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000004" value="SP000004">重訓</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000005" value="SP000005">有氧</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000006" value="SP000006">武術</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000007" value="SP000007">水上</label>
						<label class="checkbox-inline" style ="zoom: 1.5; margin:10px"><input type="checkbox" name="memSpLike" id="SP000008" value="SP000008">其他</label>
					</fieldset>
				</div>
				<div class="form-group">
					<label style="font-size: 150%">個人簡介 :</label>
					<textarea class="form-control" name="memIntro" placeholder=""
						style="height: 300px"></textarea>
				</div>

				<div class="form-group">
					<input type="hidden" name="action" value="mem_update">
					<!-- 進入servlet -->
					<button type="submit" class="btn btn-lg btn-primary" id="regSend">送出</button>
					<a class="btn btn-lg btn-secondary" href="<%=request.getContextPath() %>/index.jsp">取消</a>
					<%
					CoachService coachSvc1=new CoachService(); 
					MemVO memVO=(MemVO)session.getAttribute("memVO");
					
					if((coachSvc1.getOneCoachByMemId(memVO.getMem_id()))!=null){
						if("CS01".equals(coachSvc1.getOneCoachByMemId(memVO.getMem_id()).getCoa_status())){ %>
						<P>教練申請待認證</P>
						<%}else if("CS02".equals(coachSvc1.getOneCoachByMemId(memVO.getMem_id()).getCoa_status())){ %>
						<P>認證教練</P>
						<%}else{ %>
						<a class="btn btn-lg btn-primary" href="../../course/coach/addCoachText.jsp">申請教練</a>
					 <%}%>
					  <%}else{%>
					  <a class="btn btn-lg btn-primary" href="../../course/coach/addCoachText.jsp">申請教練</a>
					  <% }%>
				</div>
			</form>
		</div>
	</div>

<!-- JavaScript dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- Script: Smooth scrolling between anchors in a same page -->
<script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>

	<script>
		$(function() {
			var arr = [];
			<% 	
				List<MemSpLikeVO> memSpLikeVOList = (ArrayList<MemSpLikeVO>)session.getAttribute("memSpLikeVOList");
				ArrayList<String> sports = new ArrayList<String>();
				if(memSpLikeVOList!=null){
				for(MemSpLikeVO memSpLikeVO:memSpLikeVOList){
				sports.add(memSpLikeVO.getSptype_id());
				}
				for(String sport: sports){
			%>
				arr.push("<%=sport %>");
			<%
				}}
			%>
			
			for(var i = 0; i< arr.length; i++){
				$('#'+arr[i]).attr('checked', true);
			}
			
			function format_float(num, pos) {
				var size = Math.pow(10, pos);
				return Math.round(num * size) / size;
			}
			
			function preview(input) {

				if (input.files && input.files[0]) {
					var reader = new FileReader();

					reader.onload = function(e) {
						$('.preview').attr('src', e.target.result);
						var KB = format_float(e.total / 1024, 2);
						$('.size').text("檔案大小：" + KB + " KB");
					}

					reader.readAsDataURL(input.files[0]);
				}
			}

			$("body").on("change", ".upl", function() {
				preview(this);
			})

		});
		
	</script>
	  <!-- navbar setting -->
  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>

</body>
</html>