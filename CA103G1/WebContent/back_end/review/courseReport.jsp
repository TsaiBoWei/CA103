<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*"%>
<%@ page import="com.Mgr.model.*"%>
<%@ page import="com.coursereport.model.*"%>

<%
 	MgrVO mgrVO = (MgrVO) session.getAttribute("islogin");
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
    
    a,.fontstyle{
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
	color:rgba(255, 255, 255, 0.8)!important;
	font-weight:bold!important;
}
    
    input#recipient-name {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
	color:rgba(0, 0, 0, 0.8)!important;
	font-weight:bold!important;
	font-size:150% !important;
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
 
   						<a data-toggle="modal" data-target="#courseRepModal" data-reportid="${courseReportVO.courrepo_id }" data-replymgrid="<%=mgrVO.getMgr_id() %>" href="#">未處理</a> 				
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
     
     <!-- 點擊未處理的燈箱 -->
     <div class="modal fade" id="courseRepModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form method="post" action="<%=request.getContextPath() %>/coursereport/coursereport.do">
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">管理員編號:</label>
            <input type="text" class="form-control" name="courrepoID" id="recipient-name">
          </div>
          <div class="form-group">
            <label for="actionList" class="col-form-label">審核檢舉 : </label>
            <select class="form-control" id="actionList" name="courrepStatus">
            <option value="CR2">檢舉通過</option>
            <option value="CR3">檢舉不通過</option>
            </select>
          </div>
      	<div class="modal-footer">
      	<input type="hidden" name="action1" value="updateState">
<!--         <button type="button" class="btn btn-primary"><a href="" id="submitBtn">送 出</a></button> -->
        <button type="button" class="btn btn-primary"><a href="" id="submitBtn">送 出</a></button>
        <button type="button" class="btn btn-secondary" data-dismiss="modal">取 消</button>
      	</div>
        </form>
      </div>
    </div>
  </div>
</div>
     
<!--      	點擊未處理的燈箱 -->
<!-- 	<div class="modal fade" id="courseRepModal" tabindex="-1" role="dialog" -->
<!-- 		aria-labelledby="idModal" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog modal-dialog-centered" role="document"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h4 class="center modal-title" id="exampleModalLongTitle">會員註冊</h4> -->
<!-- 					<button type="button" class="close cancel" data-dismiss="modal" -->
<!-- 						aria-label="Close"> -->
<!-- 						<span aria-hidden="false">&times;</span> -->
<!-- 					</button> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body"> -->

<!-- 						<div class="input-group input-group-lg"> -->
<!-- 							<div class="input-group-prepend"> -->
<!-- 								<a class="btn btn-primary mb-2"  -->
<%-- 								href="<%=request.getContextPath() %>/coursereport/coursereport.do?action=updateState&courrepoID=${courseReportVO.courrepo_id}&courrepStatus=CR2&replyMgrID=${mgrVO.mgr_id}"> --%>
<!-- 								檢舉通過</a> -->
<!-- 							</div>						 -->
<!-- 						</div> -->

<!-- 						<div class="input-group input-group-lg"> -->
<!-- 							<div class="input-group-prepend"> -->
<!-- 								<a class="btn btn-primary mb-2"  -->
<%-- 								href="<%=request.getContextPath() %>/coursereport/coursereport.do?action=updateState&courrepoID=<%=courrepoID %>&courrepStatus=CR3&replyMgrID=${mgrVO.mgr_id}"> --%>
<!-- 								檢舉不通過</a> -->
<!-- 							</div> -->
<!-- 						</div> -->

<!-- 						<br> -->
<!-- 						<div class="modal-footer"> -->
<!-- 							<button type="button" class="btn btn-secondary cancel" -->
<!-- 								data-dismiss="modal">取消</button> -->

<!-- 						</div> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->
     
    
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

<script>
$('#courseRepModal').on('show.bs.modal', function (event) {
	  var button = $(event.relatedTarget) // Button that triggered the modal
// 	  var state = function(){ document.getelementbyid("actionList").value};
//	  var state = $('actionList').val();
	 
	  var reportid = button.data('reportid') 
	  var replymgrid = button.data('replymgrid') // Extract info from data-* attributes
	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
	  var modal = $(this)
	  modal.find('.modal-title').text('檢舉單號　:　' + reportid)
	  modal.find('.modal-body input').val(replymgrid)
	  $('#submitBtn').attr('href', '<%=request.getContextPath() %>/coursereport/coursereport.do?action1=updateState&courrepoID='+reportid+'&courrepStatus=CR2&replyMgrID='+replymgrid);
	})
	
	
	
	$('#actionList').change(function(){	 
		var button = $(event.relatedTarget)
		var reportid = button.data('reportid') 
		var replymgrid = button.data('replymgrid')
		var courrepStatus = $(this).val()
		$('#submitBtn').attr('href', '<%=request.getContextPath() %>/coursereport/coursereport.do?action1=updateState&courrepoID='+reportid+'&courrepStatus='+courrepStatus+'&replyMgrID='+replymgrid);
		 console.log("302-state: "+courrepStatus)
	})
	
	
	
	
// 	$('#courseRepModal').on('show.bs.modal', function (event) {
// 	  var button = $(event.relatedTarget) // Button that triggered the modal
// 	  // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
// 	  // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
// 	  var modal = $(this)
// 	})
</script>


</body>
</html>