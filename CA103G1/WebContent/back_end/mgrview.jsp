<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
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
  <link rel="stylesheet" href="<%=request.getContextPath() %>/back_end/css/mgrview.css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <!-- lightcase settings -->
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
 
<title>管理員頁面</title>
</head>
<body class="text-center">
<!-- Navbar -->
  <nav class="navbar navbar-expand-md">
    <span class="navbar-text"></span>
    <div class="container">
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <div class="container">
          <div class="row">
            <div class="mt-4 text-right col-11 col-md-11">
              <div>
                <img src="<%=request.getContextPath() %>/MgrPhototest?mgr_id= <%=mgrVO.getMgr_id()%>" class="rounded-circle float-left" width="200px" height="200px"> </div>
              <h1 class="display-6 text-center">Welcome Manager!</h1>
             
             
              <p class="lead text-center">  
               <%=mgrVO.getMgr_name()%>							  
                  
              </p>
            </div>
            <div class="col-1 col-md-1">
              <div>
<%--                <input type="button" class="btn btn-info logoutbtn m-3" value="log out" onclick="location.href=&quot;<%=request.getContextPath() %>/back_end/mgr/mgrlogin.jsp&quot;"> --%>
				<a class="btn btn-info logoutbtn m-3" href="<%=request.getContextPath() %>/mgr/MgrLg.do?action=logout">Log Out</a>              
              </div>
              <div>
<%--                <input type="button" class="btn btn-info logoutbtn m-3" value="log out" onclick="location.href=&quot;<%=request.getContextPath() %>/back_end/mgr/mgrlogin.jsp&quot;"> --%>
				<a class="btn btn-info logoutbtn m-3" href="<%=request.getContextPath() %>/back_end/mgr/mgrDataChange.jsp">修改資料</a>              
              </div>
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
        <nav class="navbar navbar-expand-lg navbar-light bg-success m-2 w-100" aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item active mgrlistbar" aria-current="page">教練審核</li>
            <li class="breadcrumb-item active mgrlistbar" aria-current="page">活動審核</li>
          </ol>
        </nav>
      </div>
      <div class="row">
        <div class="col-3 h-25">
          <div class="card bg-dark text-white h-24">
            <img class="card-img  imglist" src="<%=request.getContextPath() %>/back_end/img/coachcheck_img.png">
            <div class="card-img-overlay">
              <div>
                <h1 class="card-title text-dark d-flex justify-content-start m-0">教練審核</h1>
              </div>
              <div>
                <a href="<%=request.getContextPath() %>/back_end/review/coachReview.jsp" class="d-flex justify-content-start m-2 mgrwork">前往審核</a>
              </div>
            </div>
          </div>
        </div>
        <div class="col-3 h-25">
          <div class="card bg-dark text-white h-24">
            <img class="card-img  imglist" src="<%=request.getContextPath() %>/back_end/img/eventcheck_img.png">
            <div class="card-img-overlay">
              <div>
                <h1 class="card-title text-dark d-flex justify-content-start m-0">活動審核</h1>
              </div>
              <div>
                <a href="<%=request.getContextPath() %>/back_end/review/eveReview.jsp" class="d-flex justify-content-start m-2 mgrwork">前往審核</a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container">
      <div class="row">
        <nav class="navbar navbar-expand-lg navbar-light bg-success m-2 w-100" aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item active mgrlistbar" aria-current="page">課程檢舉</li>
            <li class="breadcrumb-item active mgrlistbar" aria-current="page">貼文檢舉</li>
          </ol>
        </nav>
      </div>
      <div class="row">
        <div class="col-3 h-25">
          <div class="card bg-dark text-white h-24">
            <img class="card-img  imglist" src="<%=request.getContextPath() %>/back_end/img/cour_report_img.png">
            <div class="card-img-overlay">
              <div>
                <h1 class="card-title text-dark d-flex justify-content-start m-0">課程檢舉</h1>
              </div>
              <div>
                <a href="<%=request.getContextPath() %>/back_end/review/courseReport.jsp" class="d-flex justify-content-start m-2 mgrwork">檢舉處理</a>
              </div>
            </div>
          </div>
        </div>
        <div class="col-3 h-25">
          <div class="card bg-dark text-white h-24">
            <img class="card-img  imglist" src="<%=request.getContextPath() %>/back_end/img/post_report_img.png">
            <div class="card-img-overlay">
              <div>
                <h1 class="card-title text-dark d-flex justify-content-start m-0">貼文檢舉</h1>
              </div>
              <div>
                <a href="#" class="d-flex justify-content-start m-2 mgrwork">檢舉處理</a>
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

    </div>
    <!-- Here you go -->
    <!-- Sponsor logos -->
    <!-- Call to action -->
    <!-- Footer -->
    <footer class="text-md-left text-center p-4">
      <div class="container">
        <div class="row">
          <div class="col-lg-12"></div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <p class="text-muted">
              <br>
             
              <br>
              <br> </p>
          </div>
        </div>
      </div>
    </footer>
    <!-- JavaScript dependencies -->
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Script: Smooth scrolling between anchors in a same page -->
    <script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>
 
</body>
</html>