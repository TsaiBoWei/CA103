<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
   <%@ page import="java.util.*" %>
   <%@ page import="com.coach.model.*"%>
   
   <%
	CoachService coaSvc = new CoachService();
	List<CoachVO> list = coaSvc.getReview();
		
	pageContext.setAttribute("list",list);
	%>
	<%@ page import="com.Mgr.model.*"%>
    <%  MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");%>
	<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
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

    .mgrlistbar {
      font-size: 28px
    }

    .imglist {
      height: 200px;
      width: 270px
    }
  </style>
<title>教練審核</title>
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
              <h1 class="display-6 text-center">Welcome Manager!</h1>
              <p class="lead text-center"><%=mgrVO.getMgr_name()%></p>
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
        <nav class="navbar navbar-expand-lg navbar-light m-2 w-100 bg-info" aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item active mgrlistbar" aria-current="page">待審核</li>
          </ol>
        </nav>
      </div>
      <div class="card bg-dark">
        <%-- --c:foreach var="coachVO" items="${coachSvc.all}"> </c:foreach> --%>
        <table class="table table-hover table-striped table-bordered" style="table-layout:fixed;word-wrap:break-word">
        
          <thead class="thead-inverse">
          
            <tr>
              <th style="width:15%">教練編號</th>
              <th style="width:15%%">教練姓名</th>
              <th style="width:50%">教練介紹</th>
              <th style="width:20%">進行審核</th>
            </tr>
          </thead>
        
          <c:forEach var="coachVO" items="${list}" >
          
       
          <tbody>
            <tr>
              <td>${coachVO.coa_id}</td>
              <td>${memSvc.getOneMem(coachVO.mem_id).mem_name}</td>
              <td><div style="overflow: auto;width:100%; max-height:55px">${coachVO.coa_text}</div></td>
              <td>
              <div class="row">
              
                <form method="post" action="<%=request.getContextPath() %>/coaRv/coaRv.do" style="margin-bottom: 0px;">
                    <input type="submit" value="通過" class="btn btn-outline-primary m-1">
                     <input type="hidden" name="result" value="review_pass">
                    <input type="hidden" name="coa_id" value="${coachVO.coa_id}">
                    <input type="hidden" name="action" value="review"> </form>
                  <form method="post" action="<%=request.getContextPath() %>/coaRv/coaRv.do" style="margin-bottom: 0px;">
                    <input type="submit" class="btn btn-outline-primary m-1" value="不通過">
                      <input type="hidden" name="result" value="review_notpass">
                    <input type="hidden" name="coa_id" value="${coachVO.coa_id}">
                    <input type="hidden" name="action" value="review"> </form>
                  
                 </div> 
              </td>
            </tr>
           
          </tbody>
           </c:forEach>
        </table>
        
      </div>
     
    </div>
    
    
    <jsp:include page="coachReviewToincluded.jsp" />
    
    <!--include -->
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
  </div>
  <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>
  


</body>
</html>