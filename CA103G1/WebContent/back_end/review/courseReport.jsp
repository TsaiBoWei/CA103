<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.Mgr.model.*"%>
<%@ page import="com.coursereport.model.*"%>
<%--  MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");--%>

<%
	CourseReportService courseReportSvc = new CourseReportService();
	List<CourseReportVO> courseReport = courseReportSvc.getByCourStatus("CR1");
	pageContext.setAttribute("courseReport",courseReport);
%>

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
    
    div>p,li,span,td{
    color:#fff !important
    
    }
    
/*     .btn{ */
/*     position: absolute */
/*     	z-index:2 !important    	 */
/*     } */
  </style>
<title>活動審核</title>
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
              <p class="lead text-center">Login successed</p>
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
			  <th style="width:9.3%;">課程檢舉編號</th>
              <th style="width:9.4%">課程編號</th>
              <th style="width:10.8%">檢舉人之會員編號</th>
              <th style="width:12.2%">檢舉項目</th>
              <th style="width:14.2%">檢舉內容</th>
              <th style="width:7.3%">檢舉時間</th>
              <th style="width:8.8%">檢舉處理狀態</th>
              <th style="width:10%">回覆管理員ID</th>
            </tr>
          </thead>
          
        
          <c:forEach var="courseReportVO" items="${courseReport}">
          
          <tbody>
            <tr>
              <td>${courseReportVO.courrepo_id}</td>         	
              <td>${courseReportVO.cour_id}</td>
              <td>${courseReportVO.mem_id}</td>          
              <td>
   				<c:choose>
   					<c:when test="${courseReportVO.courrep_item=='CRN1'}">   					
   						課程內容不當    					
   					</c:when>
   					<c:when test="${courseReportVO.courrep_item=='CRN2'}">   					
   						課程收費不當    					
   					</c:when>   				
   					<c:otherwise>   					
   						其他
   					</c:otherwise>   			
   				</c:choose>   				   		
              </td>
              <td><div style="overflow: auto;width:100%; max-height:200px">${courseReportVO.courrep_text}</div></td>      
              <td>
              	<fmt:formatDate value="${courseReportVO.courre_time}" pattern="yyyy/MM/dd HH:mm "/>
			   </td>
              <td><c:choose>
   					<c:when test="${courseReportVO.courrep_status =='CR1'}">   					
   						<a href="<%=request.getContextPath() %>/coursereport/coursereport.do?action=updateState">未處理</a>  					
   					</c:when>
   					<c:when test="${courseReportVO.courrep_status =='CR2'}">   					
   						檢舉通過    					
   					</c:when>   				
   					<c:otherwise>   					
   						檢舉未通過
   					</c:otherwise>   			
   				</c:choose></td>
              <td><c:choose>
   					<c:when test="${courseReportVO.reply_mgr_id==null}">   					
   						尚無管理員處理   					
   					</c:when> 				
   					<c:otherwise>   					
   						${courseReportVO.reply_mgr_id}
   					</c:otherwise>   			
   				</c:choose></td>
         
            </tr>           
          </tbody>
          </c:forEach>
        </table>
        
      </div>
     
    </div>
     <jsp:include page="courseReportToincluded.jsp" /> 
    
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