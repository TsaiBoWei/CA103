<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%@ page import="com.mem.model.*"%>
 <%@ page import="com.Post.model.*"%>
 <%@ page import="java.util.*"%>
  <%@ page import="java.text.*"%>
 <%--	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO");  
--%>
   
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <title>Jennifer Lawernce</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- summernote css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <!-- summernote -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  <!-- summernote -->
  <script src="<%=request.getContextPath() %>/front_end/post/js/jquery.events.touch.js"></script>
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/purchcour/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/post/css/editpostform.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/post/css/blogdetail.css">
  <!-- fafaicon -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
  <style>
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }

    .commenttextarea {
      height: 120px;
    }
    
    #post_con p,#post_con span,#post_con h1,#post_con h2,#post_con h3,#post_con h4,#post_con h5,#post_con h6{
    	color:#fff !important;
    	font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }
    
    h1,h2,h3,h4 {
      font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }
  </style>
</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
	<!--header  -->
	
	<div class="py-4" id="jys">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<h2 class="text-left">Post</h2>
					<hr>
				</div>
			</div>
		</div>
	</div>
	<!--fixbutton -->
	<a class="btn btn-lg btn-primary" id="bli_kontaktad_landing"
		href="#posteditlight" data-rel="lightcase:myCollection:slideshow">
		<i class="fab fa-rocketchat"></i>
	</a>
  <!--fixbutton-->
  <!--blogcontent-->
  <div class="container mb-3">
    <div class="row align-items-start ">
      <!--blogtitle-->
      <div class="col-md-2 offset-md-5  text-center  text-light mb-2 ">
        <div class="col-md-6 offset-md-3 postclassontop text-center bg-secondary mb-1"> ${sportTypeMap.get(postVO.sptype_id)} </div>
      </div>
      <div class=" col-md-12 mb-0">
        <div class=" blogcontent text-left px-2 text-center">
          <h1 class="mb-3 ">${postVO.post_title}</h1>
        </div>
        <!--bloglist-->
        <div class="text-center pr-4 ">
          <ul class="list-inline postsubtitle ">
            <li class="list-inline-item px-2 border-right ">            
            <fmt:formatDate value="${postVO.post_time}" pattern="yyyy-MM-dd HH:mm"/>
           </li>
<%--            <% --%>
<!-- //            		PostVO postVO=(PostVO)request.getAttribute("postVO"); -->
<!-- //            		String post_id=postVO.getPost_id(); -->
<!-- //            		int post_view=0; -->
<!-- //            		if((application.getAttribute(post_id+"view"))==null){ -->
           			
<!-- //            			post_view=0; -->
<!-- //            		}else{ -->
<!-- //            			post_view=(int)application.getAttribute(post_id+"view"); -->
           			
<!-- //            		} -->
<!-- //            		application.setAttribute(post_id+"view",++post_view); -->
           
           
<%--            %> --%>
            <li class="list-inline-item px-2 border-right ">瀏覽數:&nbsp;&nbsp;${postVO.post_view}</li>
            <li class="list-inline-item  px-2  "> 10k likes </li>
          </ul>
        </div>
        <!--bloglist-->
      </div>
      <!--blogblock-->
      <div class=" col-md-2 offset-md-5 mb-3 p-0">
        <hr> </div>
      <!--blogblock-->
      <!--blogtitle-->
      <div class=" col-md-12 ">
        <div id="post_con" class=" blogcontent text-left px-2 ">
           ${postVO.post_con}
        </div>
      </div>
      <div class=" col-md-12  mt-4 p-0">
        <hr> </div>
    </div>
  </div>
  <!--blogcontent-->
  <!--Post -->
  <!-- Sponsor logos -->
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	
  <!--summernote-->
  <script src="<%=request.getContextPath() %>/front_end/post/js/summernotecutom.js"></script>
 <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
  
