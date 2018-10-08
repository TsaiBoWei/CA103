<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.mem.model.*"%>   
<%
  CoachVO coachVO = (CoachVO) request.getAttribute("coachVO");
%>
    
<!DOCTYPE html>
<html>
<head>
<title>addCourlist</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
<!--   <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico"> -->
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- summernote css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/course/courlist/css/Course.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/course/courlist/css/font.css">
  
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="js/navbar-ontop.js"></script>
  
  <!-- Script: Animated entrance -->
  <script src="js/animate-in.js"></script>
  
  <!-- summernote-->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
 
  <!-- summernote -->
  <script src="<%=request.getContextPath() %>/front_end/course/courlist/js/jquery.events.touch.js"></script> 
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/editpostform.css">

  
  <style>  
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }
  </style>
</head>

<body class="text-center">

  <!-- Navbar -->
  <nav class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" 
        	href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">User</a>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#register">Register now</a>
      </div>
    </div>
  </nav>
  <!-- Cover -->
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(<%=request.getContextPath() %>/front_end/course/courlist/assets/conference/024.jpg);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-md-left text-center align-self-center my-5" style="height:13rem;"> </div>
      </div>
    </div>
  </div>

  <!-- Sponsors -->
  <div class="py-5 text-white opaque-overlay">
    <div class="container">
      <div class="row">
        <div class="col-md-2"></div>
        <div class="col-md-8">
          <h2 class="text-gray-dark text-md-left text-primary">
          <i class="fa fa-address-book text-md-left"></i> &nbsp; 修改教練資訊 &nbsp; <br>
          </h2>
          
          
		<%-- 錯誤表列 --%>
		<div class="text-md-left">
			<c:if test="${not empty errorMsgs}">
				<font style="color:#f70655">請修正以下錯誤:</font>
				<ul>
					<c:forEach var="message" items="${errorMsgs}">
						<li style="color:#f70655">${message}</li>
					</c:forEach>
				</ul>
			</c:if>
		</div>
          
<!--           <p class="text-md-left">" * " 為必填項目</p> -->
          
          <form METHOD="post" ACTION="<%=request.getContextPath()%>/coach/coach.do" name="form1" enctype="multipart/form-data">
             
           <!-- 修改教練資訊  -->
            <div class="form-group">
				<h4 class="text-md-left">教練編號：<%=coachVO.getCoa_id()%></h4>
			</div>
			<br>
			
            <div class="form-group">
				<input type="hidden" name="mem_id" value="<%=coachVO.getMem_id()%>" />
			</div>
			<br>
            
            <div class="form-group">
				<h4 class="text-md-left">教練資訊*</h4>
				<textarea name="coa_text" cols="50" rows="5" class="form-control"><%= (coachVO==null)? "請輸入教練資訊" : coachVO.getCoa_text()%></textarea>
			</div>
			<br>
			
			<div class="form-group text-md-left">
              <h4 class="text-md-left">帳號狀態*</h4>
				<input type="radio" name="coa_status" value="CS01">待認證 &nbsp;
				<input type="radio" name="coa_status" value="CS02" checked>取得資格 &nbsp;
				<input type="radio" name="coa_status" value="CS03">停權 
			</div>
			<br>
              				
			<!-- 送出  -->
			<input type="hidden" name="action" value="update">
			<input type="hidden" name="cour_id" value="<%=coachVO.getCoa_id()%>">
			<div class="text-md-right">
				<button id="addBtnSubmit" type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
			</div>
            
            
          </form>
        </div>
      </div>
    </div>
  </div>
 
					
  
  
  <div class="py-5 section">
    <div class="container">
      <div class="row">
        <div class="col-md-12"></div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/gymback.jpg');">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3"></h1>
          <p></p>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="text-md-left text-center p-4">
    <div class="container">
      <div class="row">
		<div class="col-lg-12"></div>
	  </div>
	  <div class="row">
		<div class="col-md-12">
		  <p class="text-muted">
		  <br> <br> <br>
		  </p>
		</div>
	  </div>
	</div>
  </footer>

  
  
<!-- JavaScript dependencies -->
<!--   <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
<!--   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script> -->
<!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script> 
<!--summernote-->
<!--   <script src="js/summernotecutom.js"></script> -->
<!--   <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet"> -->
<!--   <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script> -->
  
  

  
</body>
</html>