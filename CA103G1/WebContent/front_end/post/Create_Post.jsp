<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.Post.model.*"%>

<%
  MemVO memVO=(MemVO)session.getAttribute("memVO");
  PostVO postVO = (PostVO) request.getAttribute("postVO");
%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <title>Jennifer Lawernce</title>
  
  <!-- summernote css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
<%--   <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/mem/editblog/css/PersonalPage.css"> --%>

  <link rel="stylesheet"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css">
  <!-- summernote -->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
  <!-- summernote -->
<!--   <link rel="stylesheet" type="text/css" href="lightcase.css"> -->
<!--   <script type="text/javascript" src="js/lightcase.js"></script> -->
  <script src="<%=request.getContextPath()%>/front_end/post/js/jquery.events.touch.js"></script>
  <script src="<%=request.getContextPath()%>/front_end/post/js/autotyping.js"></script>
 
<!--   <link rel="stylesheet" type="text/css" href="lightcasepostedit.css"> -->
  <link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/post/css/editpostform.css">
  <!-- fafaicon -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
 
    <!-- navbar setting -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	 
 
 
 
  <style>
  

    body {
      overflow-x: hidden;
    }
  </style>
  
  <!-- navbar setting -->
  <style type="text/css">

	a,.fontstyle  {
		font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
	}
	
	.navbar-dark .navbar-nav .nav-link{
	color:rgba(255, 255, 255, 0.8)!important;
	font-weight:bold!important;

	}
  </style>
</head>

<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->
  
  <!--blog1-->
  <!--blogEdition-->
  <div class="container">
    <div class="row">
      <div class="col-md-12">
        <div class="mb-4 ">
          <h1 class="text-gray-dark text-left text-light">
            <i class="fas fa-pencil-alt"></i>&nbsp;Edition</h1>
          <p class="lead mb-4 text-left text-primary">Share your work-out experience with your friends</p>
        </div>
        
          <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

        <form class="text-left" method="post" action="<%=request.getContextPath()%>/post/post.do" >
          <div class="form-group text-left mt-3">
            <label class="text-left">Post Title</label>
            <input type="text" name="post_title"  class="form-control bg-dark bg-dark-posteditinput text-light" placeholder="Post Title"> </div>
          <!--summernote-->
          <div class="form-group text-left mt-4">
            <div id="summernote">Make Post</div>
            <input type="hidden" name="post_con" id="post_con">
<!--             <script> -->
<%--             $("#summernote").summernote("code", '<%= (postVO==null)? "" : postVO.getPost_con()%>'); --%>
             
<!--             </script> -->
            <!--privacy-->
            <div class="col-4 form-group text-left mt-4 p-0">
              <label class="text-left">Privacy</label>
              <select class="form-control  bg-dark bg-dark-posteditinput" name="post_privacy">
                <option selected="" value="Who Should See this">Who Should See this</option>
                <option value="POSTPR1">Public</option>
                <option value="POSTPR2">MySelf</option>
                <option value="POSTPR3">MyFreinds</option>
              </select>
              
              <label class="text-left">Type</label>            
              <select class="form-control  bg-dark bg-dark-posteditinput" size="1" name="sptype_id">
                			<option selected="" value="What sport type is about your post?">What sport type is about your post?</option>
                <c:forEach var="sptype" items="${sportTypeMap}">
					<option value="${sptype.key}" ${(sptype.key==postVO.sptype_id)? 'selected':'' } >${sptype.value}
				</c:forEach>
              </select>
            </div>
            <div class="mt-4">
          	 
              <input type="hidden" name="action" value="insert">
   			 	 <input type="hidden" name="mem_id" value="${memVO.mem_id }">
              <button id="sendPost" type="submit" class="btn btn-primary my-2">送出</button>
               
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
   <!--blogEdition-->
  
  
<!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->

 
  <!-- JavaScript dependencies -->
  <!-- lightcasetest -->
  <!-- lightcasetest -->
  <!--  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>-->
  <script>
  $(document).ready(function () {
      $('#summernote').summernote({

height: 400,         
 popover: {
   image: [],
   link: [],
   air: []
 }
       });      

  //summernote賦值(將文字顯示在summernote上)    
  $("#summernote").summernote("code", '<%= (postVO==null)? "" : postVO.getPost_con()%>');
  //summernote取值
  $("#sendPost").click(function(){
        var markupStr = $('.note-editable').html();
        $("#post_con").val(markupStr);
      });    

  });
  </script>
  
 
  <!-- Script: Smooth scrolling between anchors in a same page -->

  <!--summernote-->
<%--   <script src="<%=request.getContextPath()%>/front_end/mem/editblog/js/summernotecutom.js"></script> --%>
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
  
