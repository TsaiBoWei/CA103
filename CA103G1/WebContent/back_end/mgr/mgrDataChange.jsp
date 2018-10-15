<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
  <%@ page import="com.Mgr.model.*"%>
    <%  MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");%>
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
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <!-- lightcase settings -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
  <script>
    $(function (){
   
      function format_float(num, pos)
      {
          var size = Math.pow(10, pos);
          return Math.round(num * size) / size;
      }
   
      function preview(input) {
   
          if (input.files && input.files[0]) {
              var reader = new FileReader();
              
              reader.onload = function (e) {
                  $('.preview').attr('src', e.target.result);
                  var KB = format_float(e.total / 1024, 2);
                  $('.size').text("檔案大小：" + KB + " KB");
              }
   
              reader.readAsDataURL(input.files[0]);
          }
      }
   
      $("body").on("change", ".upl", function (){
          preview(this);
      })
      
  })
  </script>
  <style>
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }

    .loginbox {
      background-color: #808080
    }

    .logbt {
      width: 100px
    }
  </style>
<title>修改密碼</title>
</head>
<body class="text-center">
	 <!-- Navbar -->
  <nav class="navbar navbar-expand-md  ">
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
							<li style="color:red">${message}</li>
						</c:forEach>
					</ul>
				</c:if>
            
            
               <h2 class="mb-4">修改管理員資料</h2>
              <form METHOD="post" action="<%=request.getContextPath() %>/mgr/MgrLg.do" enctype="multipart/form-data">
                
                <div class="form-group">
                  <label>新密碼</label>
                  <input type="password" name="new_password" class="form-control"> </div>
                <div class="form-group">
                  <label>姓名</label>
                  <input type="text" name="mgr_name" class="form-control" placeholder="name" value="<%=mgrVO.getMgr_name()%>"> </div>
                <div class="form-group">
                  <label>大頭照</label>
                  <input type="file" name="mgr_photo" class="form-control upl" id="mgrphotoup">
                  <div>
                    <img class="preview" style="max-width: 150px; max-height: 150px;">
                    <div class="size"></div>
                  </div>
                </div>
                
                 <div>
                  
                 <input type="hidden" name="action" value="Mgr_updateD" >
                 <input type="submit" value="送出"  class="btn btn-info logbt m-3">
                </div>
              
                
                
              </form>
            
            
            
            </div>
          </div>
        </div>
      </div>
    </div>
     </div>
     <div>
     <br>
     </div>
    <!-- Here you go -->
    <!-- Sponsor logos -->
    <!-- Call to action -->

    
    <!-- JavaScript dependencies -->
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Script: Smooth scrolling between anchors in a same page -->
    <script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>
   
 
</body>
</html>