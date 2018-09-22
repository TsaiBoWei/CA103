<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/PersonalPageBase.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/back_end/css/mgr.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/back_end/mgr/css/mgrlogin.css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <!-- lightcase settings -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  
<title>管理員登入</title>
</head>
<body class="text-center">
 <!-- Navbar -->
  <nav class="navbar navbar-expand-md">
    <span class="navbar-text"></span>
    <div class="container">
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <div class="container">
          <div class="row">
            <div class="mt-4 text-right col-12">
              <h1 class="display-6 text-light">WORK it OUT</h1>
              <p class="lead"> TURN Your Goals INTO ACTION </p>
            </div>
          </div>
        </div>
      </div>
    </div>
  </nav>
  <!-- Cover -->
  <!-- 卡片row 移出-->
  <!--  // 卡片row 移出-->
  <!-- Personal Pic -->
  <!-- NavBar Personal-->
  <!-- Here you go -->
  <div class="section-fade-in-out" id="mgrbackground">
    <div class="container">
      <div class="row">
        <div class="offset-3 col-6 w-50 h-75">
          <div class="card text-white p-4 loginbox">
            <div class="card-body">
              <h1 class="mb-4">Welcome Manager</h1>
               <c:if test="${not empty errorMsgs}">
					<font class="errormsg">請修正以下錯誤:</font>
					<ul>
	    				<c:forEach var="message" items="${errorMsgs}">
							<li class="errormsg">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
              <form METHOD="post" ACTION="<%=request.getContextPath() %>/mgr/MgrLg.do">
                <div class="form-group">
             
                  <label>Account</label>
                  <input type="text" name="mgr_account" class="form-control" placeholder="account"> </div>
                <div class="form-group">
                  <label>Password</label>
                  <input type="password" name="mgr_password" class="form-control" placeholder="Password"> </div>
                <div>
                  <input type="hidden" name="actionMgrLogin" value="Mgr_try_login" >
                  <input type="submit" value="Log in" class="btn btn-info logbt m-3" >
                 <input type="button" class="btn btn-info logbt m-3" value="Register" onclick="location.href='<%=request.getContextPath() %>/back_end/mgr/mgrregist.jsp'">  
                  <!--button type="button" class="btn btn-info logbt m-3">Register</button-->
                 </div>
              </form>
                             
             
              <div>
                <a href="<%=request.getContextPath() %>/back_end/mgr/mgrLostPS.jsp">Lost your password?</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Here you go -->
  <!-- Sponsor logos -->
  <!-- Call to action -->
  <!-- Footer -->
 
  <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>
  

</body>
</html>