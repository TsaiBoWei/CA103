<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.Mgr.model.*"%>
<%@ page import="com.eve.model.*"%>

  <%  MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");%>
<%
	EveService eveSvc = new EveService();
	List<EventVO> list = eveSvc.getReviewEves();
		
	pageContext.setAttribute("list",list);
%>
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
            <div class="mt-4 text-right col-11">
              <h1 class="display-6 text-center">Welcome Manager!</h1>
              <p class="lead text-center"><%=mgrVO.getMgr_name()%></p>
            </div>
            
            <div class="col-1 col-md-1">
              <div>
<%--                <input type="button" class="btn btn-info logoutbtn m-3" value="log out" onclick="location.href=&quot;<%=request.getContextPath() %>/back_end/mgr/mgrlogin.jsp&quot;"> --%>
				<a class="btn  btn-outline-primary logoutbtn m-3" href="<%=request.getContextPath() %>/back_end/mgrview.jsp">回首頁</a>              
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
  <div class="section-fade-in-out" id="mgrbackground" style="z-index:1 !important">
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
              <th style="width:9.3%">活動標題</th>
              <th style="width:6.4%">主辦人姓名</th>
              <th style="width:29.8%">活動敘述</th>
              <th style="width:12.2%">活動時間</th>
              <th style="width:14.2%">活動地點</th>
              <th style="width:7.3%">參加人數</th>
              <th style="width:5.8%">報名費用</th>
              <th style="width:15%">進行審核</th>
            </tr>
          </thead>
        
          <c:forEach var="eventVO" items="${list}" >
          
       
          <tbody>
            <tr>
              <td >${eventVO.eve_title}</td>
              <td>${memSvc.getOneMem(eventVO.mem_id).mem_name}</td>
              <td><div style="overflow: auto;width:100%; max-height:200px">${eventVO.eve_content}</div></td>
      
              <td>
               <fmt:formatDate value="${eventVO.eve_startdate}" pattern="yyyy/MM/dd HH:mm "/>
              									<br>~<br>		
			   <fmt:formatDate value="${eventVO.eve_enddate}" pattern="yyyy/MM/dd HH:mm"/>
              </td>
              <td>${eventVO.eve_location}</td>
              <td>${eventVO.estart_limit}~${eventVO.estart_max}人</td>
              <td>${eventVO.eve_charge}元</td>
              <td>
              <div class="row">
              
                <form method="post" action="<%=request.getContextPath() %>/eve/event.do" style="margin-bottom: 0px;">
                    <input type="submit" value="通過" class="btn btn-outline-primary m-1" style="width:70px">
                     <input type="hidden" name="result" value="review_pass">
                    <input type="hidden" name="eve_id" value="${eventVO.eve_id}">
                    <input type="hidden" name="action" value="review">
               	</form>
                <form method="post" action="" style="margin-bottom: 0px;">
                    <input type="submit" class="btn btn-outline-primary m-1" value="不通過" style="width:70px">
                      <input type="hidden" name="result" value="review_notpass">
                    <input type="hidden" name="eve_id" value="${eventVO.eve_id}">
                    <input type="hidden" name="action" value="review"> 
                </form>
                  
              </div> 
              </td>
            </tr>
           
          </tbody>
           </c:forEach>
        </table>
        
      </div>
     
    </div>
    
    
    <jsp:include page="eveReviewToincluded.jsp" />
    
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