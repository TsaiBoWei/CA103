<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>Conference Neon - Pingendo template</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/front_end/mem/login/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/front_end/mem/login/js/animate-in.js"></script>
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
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="#">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">activity</a>
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
  <div class="d-flex py-5 cover section-fade-in-out align-items-center" style="background-image: url(&quot;<%=request.getContextPath() %>/front_end/mem/login/assets/conference/Top-5-Best-Running-Shoes-for-Women-in-2015.jpg&quot;);">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="display-1">Log Into
            <br>Work It Out</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-6 offset-3 col-md-6 offset-md-3">
          <form method="post" action= "<%=request.getContextPath() %>/mem/mem.do">
          ---
            <c:if test="${not empty errorMsgs}">
				<font style="color:red">請修正以下錯誤:</font>
					<ul>
						<c:forEach var="message" items="${errorMsgs}">
						<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
			</c:if>
          ---
            <div class="form-group">
              <label>電子郵件</label>
              <input type="email" name="email" class="form-control" placeholder="電子郵件"> 
            </div>
            
            <div class="form-group">
              <label>密碼</label>
              <input type="password" name="password" class="form-control" placeholder="密碼"> 
            </div>
            <br>
			<input type="hidden" name="action" value="login">
            <button type="submit" class="btn btn-primary flex-row-reverse form-control" id="btnLogIn">
           		 登入
            </button>
            
            <div class="col-md-12" style="margin-bottom: 14px;">
              <a href="#">忘記密碼</a>
              <a href="#" data-toggle="modal" data-target="#exampleModalCenter">快速註冊</a>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Modal -->
  <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="exampleModalLongTitle">會員註冊</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="false">&times;</span>
          </button>
        </div>
        <div class="modal-body">
        ---
        <c:if test="${not empty errorMsgs}">
			<font style="color:red">請修正以下錯誤:</font>
			<ul>
				<c:forEach var="message" items="${errorMsgs}">
					<li style="color:red">${message}</li>
				</c:forEach>
			</ul>
		</c:if>
        ---
          <form METHOD="post" action="<%=request.getContextPath() %>/mem/mem.do" > 
            <div class="input-group input-group-lg">
              <div class="input-group-prepend">
                <span class="input-group-text" >信箱*</span>
              </div>
              <input type="email" name="regEmail" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm" >
            </div><br>

            <div class="input-group input-group-lg">
              <div class="input-group-prepend">
                <span class="input-group-text" >暱稱 </span>
              </div>
              <input type="text" name="regName" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm" >
            </div><br>



            <div class="input-group input-group-lg">
              <div class="input-group-prepend">
                <span class="input-group-text" >密碼*</span>
              </div>
              <input type="password" name="regPassword" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm " >
            </div><br>

            <div class="input-group input-group-lg">
              <div class="input-group-prepend">
                <span class="input-group-text" >確認密碼*</span>
              </div>
              <input type="password" name="confirmedPsw" class="form-control" aria-label="Large" aria-describedby="inputGroup-sizing-sm">
            </div><br>
            <div class="modal-footer">
              <input type="hidden" name="action" value="mem_signUp">
              <button type="submit" class="btn btn-primary" id="regSend">送出</button>
              <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
              
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>

  <!-- Intro section -->
  <!-- Speakers -->
  <!-- Schedule -->
  <!-- Sponsor logos -->
  <div class="py-5 section">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="mb-4">Sponsors</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/mem/login/assets/conference/logo_1.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/mem/login/assets/conference/logo_4.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/mem/login/assets/conference/logo_3.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/mem/login/assets/conference/logo_2.png"> </div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url(&quot;<%=request.getContextPath() %>/front_end/mem/login/assets/conference/cover_2.jpg&quot;);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3">Something Here</h1>
          <p>Pre-register to get a priority access to the event. Fares will be published later on.&nbsp;
            <br>Get the maximum from the lectures together with the possibility of joining exclusive side-events.</p>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="text-md-left text-center p-4">
    <div class="container">
      <div class="row">
        <div class="col-lg-12"> </div>
      </div>
      <div class="row">
        <div class="col-md-12">
          <p class="text-muted">
            <br>
            <br>© Copyright 2018 Pingendo - All rights reserved.
            <br>
            <br> </p>
        </div>
      </div>
    </div>
  </footer>
  <!-- JavaScript dependencies -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script>
<!--   <pingendo onclick="window.open('https://pingendo.com/', '_blank')" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:250px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">Made with Pingendo Free&nbsp;&nbsp; -->
<!--     <img src="https://pingendo.com/site-assets/Pingendo_logo_big.png" class="d-block" alt="Pingendo logo" height="16"> -->
<!--   </pingendo> -->
</body>

</html>
