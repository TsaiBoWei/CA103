<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.mem.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //CourlistServlet.java(Controller), 存入req的courlistVO物件
CoachVO coachVO = (CoachVO) request.getAttribute("coachVO"); 
MemVO memVO = (MemVO) request.getAttribute("memVO"); 
%>


<%
    CoachService coachService = new CoachService();
    CoachVO coachVO2 = coachService.getOneCoach(courlistVO.getCoa_id());
    
    MemService coamemSvc= new MemService();
    MemVO coamemVO= coamemSvc.getOneMem(coachVO2.getMem_id());
%>

<!DOCTYPE html>
<html>
<head>
<title>單一課程 - oneCourlist.jsp</title>
<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
<!--   <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico"> -->
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- summernote css -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" crossorigin="anonymous">
  
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/course/courlist/css/Course.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/course/courlist/css/font.css">
  
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="js/navbar-ontop.js"></script>
  
  <!-- Script: Animated entrance -->
  <script src="js/animate-in.js"></script>
  
  <!-- summernote-->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
 
  <!-- summernote -->
  <script src="<%=request.getContextPath() %>/front_end/course/courlist/js/jquery.events.touch.js"></script> 
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/editpostform.css">

  
  <style>  
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }
  </style>
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
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" 
        href="<%=request.getContextPath()%>/front_end/course/courlist/select_page.jsp">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#">Event</a>
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
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(<%=request.getContextPath() %>/front_end/course/courlist/assets/conference/024.jpg);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-md-left text-center align-self-center my-5" style="height:13rem;"> </div>
      </div>
    </div>
  </div>
  
    <!-- 主頁圖(圖片) -->
  <div class="py-5 text-white">
    <div class="container">
      <div class="row">
        <div class="col-md-7 text-md-left text-center align-self-center my-5">
          <h3><%=courlistVO.getCname()%>
            <br> </h3>
          <div class="text-md-right">
            <a href="#" class="btn btn-outline-primary btn-sm m-1">Share
              <br> </a>
            <a href="#" class="btn btn-sm btn-outline-secondary m-1">Report
              <br> </a>
          </div>
          <div>
<%--           <p class="coach_text_short"><%=coachVO2.getCoa_text()%></p> --%>
          <p class="coach_text_short"><%=courlistVO.getCour_text()%></p>
              <script>
             	 $(document).ready(function() {
            	    var len = 50; // 超過50個字以"..."取代
            	    $(".coach_text_short").each(function(i){
            	        if($(this).text().length>len){
            	            $(this).attr("title",$(this).text());
            	            var text=$(this).text().substring(0,len-1)+".......";
            	            $(this).text(text);
            	        }
            	    });
            	});   
  			  </script>
          </div>
          <a href="#" class="btn btn-lg btn-primary mx-1">Buy It</a>
        </div>
        <div class="col-md-5  align-self-center">
          <img class="img-fluid d-block mx-auto align-baseline" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>"></div>
      </div>
    </div>
  </div>
    <!-- 分頁頁籤 -->
  <div class="container containerHrT ">
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
        <!-- 第一個按鈕 -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabone" data-toggle="tab">
              <i class="fa fa-user"></i> &nbsp; Coach &nbsp;</a>
          </li>
          <!-- 第二個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabtwo" data-toggle="tab">
              <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; Announcement &nbsp;</a>
          </li>
          <!-- 第三個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabthree" data-toggle="tab">
              <i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; Information&nbsp;</a>
          </li>
         <!-- 第四個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfour" data-toggle="tab">
              <i class="fa fa-film" aria-hidden="true"></i>&nbsp; Course Unit &nbsp; </a>
          </li>
          <!-- 第五個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfive" data-toggle="tab">
              <i class="fa fa-comments" aria-hidden="true"></i> &nbsp; Forum &nbsp; </a>
          </li>
          <!-- 第六個按鈕 -->
<!--           <li class="nav-item"> -->
<!--             <a class="nav-link" href="" data-target="#tabsix" data-toggle="tab"> -->
<!--               <i class="fa fa-star" aria-hidden="true"></i> &nbsp; Mangenment &nbsp; </a> -->
<!--           </li> -->
        </ul>
      </div>
    </div>
  </nav>
  
  <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


  <div class="container containerHrB ">
    <hr> </div>
    <!-- 分頁 -->
   <div class="tab-content mt-2">
    <div class="tab-pane fade show active" id="tabone" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row mb-5">
            <div class="col-md-7">
              <h2 class="text-primary text-md-left"> <i class="fa fa-user"></i> &nbsp; <%=coamemVO.getMem_name()%>  &nbsp;  <br> </h2>
              <p class="text-md-left"><%=coachVO2.getCoa_text()%></p>
            </div>
            <div class="col-md-5 align-self-center">
         	  <img class="img-fluid d-block w-100 img-thumbnail" alt="Card image"
		  src="<%=request.getContextPath()%>/coach/Coach_DBGifReader.do?coa_id=<%=courlistVO.getCoa_id()%>"> 
		  </div>
	    
			 
          </div>
        </div>
      </div>
    </div>
    
    
    <div class="tab-pane fade" id="tabtwo" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-3"></div>
            <div class="col-md-6">
              <h2 class="text-primary text-md-left"><i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; 課程公告 &nbsp;
                <br> </h2>
              <p class="text-md-left"><%=courlistVO.getCour_ann()%></p>
            </div>
            <div class="col-md-3"></div>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabthree" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <div class="col-md-12">
              <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">
                  <h2 class="text-primary text-md-left"><i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; 課程介紹  &nbsp;<br> </h2>
                  <p class="text-md-left"><%=courlistVO.getCour_text()%></p>
                </div>
                <div class="col-md-1"></div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
     <div class="tab-pane fade" id="tabfour" role="tabpanel">
      <div class="py-5 text-white">
        <div class="container">
          <div class="row">
            <div class="col-md-7 text-md-left text-center align-self-center my-5">
              <h3 class="text-primary"><i class="fa fa-film" aria-hidden="true"></i>&nbsp; 恬心空中瑜珈教室 單元一 &nbsp;</h3>
              
<!--               <p class="">空中瑜珈簡介&nbsp; -->
<!--                 <br>＊空中瑜珈設備。&nbsp; -->
<!--                 <br>＊如何進入與離開布掛。&nbsp; -->
<!--                 <br>＊進入動作前，布掛的預備位置。&nbsp; -->
<!--                 <br>練習提醒： 影片之示範動作練習須於課程上有專業老師於一旁指導。 空中瑜珈不建議患有高低血壓、心臟病、骨質疏鬆和孕婦參與大眾課程，適逢生理期者應避免倒掛的動作練習。</p> -->
			  <div class="accordion" id="courunit_update_1">
			   	<div class="text-md-right" id="courunit_update_hide_1">
			       	<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
			       			data-target="#courunit_update_text_1" aria-expanded="false" aria-controls="courunit_update_text_1"> 
			       	<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
			        </button>
			    </div>
			    <div id="courunit_update_text_1" class="col-md-12 collapse" aria-labelledby="courunit_update_hide_1" data-parent="#courunit_update_1">
			     	<div class="card-body">
			        	<br>
			       		<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; 修改單元名稱</h5>
			         	<form class="" method="post" action="https://formspree.io/">
			            	<div class="form-group">
				  				<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="1"></textarea>
				  			</div>
				  			<br>
				  			<div class="text-md-right">
			            		<button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
			            	</div>
						</form>
					</div>
				</div>
			</div>
              <h5 class="text-md-left">觀看進度</h5>
              <div class="progress">
                <div class="progress-bar progress-bar-striped bg-primary progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
              </div>
              <br>              
            </div>
            <div class="col-md-5">
              <div class="embed-responsive embed-responsive-4by3  rounded">
                <iframe class="embed-responsive-item" allowfullscreen="" src="https://www.youtube.com/embed/8GRCuzUmkpY?autoplay=0"> </iframe>
              </div>
            </div>
          </div>
          <br>
          <div class="row">
            <div class="col-md-7 text-md-left text-center align-self-center my-5" >
              <h3 class="text-primary"><i class="fa fa-film" aria-hidden="true"></i>&nbsp; 恬心空中瑜珈教室 單元二</h3>
              <div class="accordion" id="courunit_update_2">
				<div class="text-md-right" id="courunit_update_hide_2">
					<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
						    data-target="#courunit_update_text_2" aria-expanded="false" aria-controls="courunit_update_text_2"> 
					<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
					</button>
				</div>
				<div id="courunit_update_text_2" class="col-md-12 collapse" aria-labelledby="courunit_update_hide_2" data-parent="#courunit_update_2">
					<div class="card-body">
						<br>
						<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; 修改單元名稱</h5>
						<form class="" method="post" action="https://formspree.io/">
						    <div class="form-group">
							  	<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="1"></textarea>
							</div>
							<br>
							<div class="text-md-right">
						        <button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
						    </div>
						</form>
					</div>
				</div>
			</div>
<!--               <p class="">空中瑜珈課程中進入前彎、下犬式、倒立動作等動作，布掛的預備位置。 -->
<!--                 <br>＊如何進入布掛 -->
<!--                 <br>＊離開布掛的方式 -->
<!--                 <br>＊空中瑜珈大休息式介紹&nbsp;</p> -->
              <h5 class="text-md-left">觀看進度</h5>
              <div class="progress">
                <div class="progress-bar progress-bar-striped bg-primary progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
              </div>
            </div>
            <div class="col-md-5">
              <div class="embed-responsive embed-responsive-4by3  rounded">
                <iframe class="embed-responsive-item" allowfullscreen="" src="https://www.youtube.com/embed/8GRCuzUmkpY?autoplay=0"> </iframe>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabfive" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <p class="text-md-left">這裡放討論區。</p>
          </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabsix" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row">
            <p class="text-md-left">這裡放評價。</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="py-5 section">
    <div class="container">
      <div class="row">
        <div class="col-md-12"></div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6"></div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/gymback.jpg');">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-left">
          <h1 class="mb-3"></h1>
          <p></p>
        </div>
      </div>
    </div>
  </div>
  <!-- Footer -->
  <footer class="text-md-left text-center p-4">
    <div class="container">
      <div class="row">
		<div class="col-lg-12"></div>
	  </div>
	  <div class="row">
		<div class="col-md-12">
		  <p class="text-muted">
		  <br> <br> <br>
		  </p>
		</div>
	  </div>
	</div>
  </footer>

  
  
<!-- JavaScript dependencies -->
<!--   <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script> 
<!--summernote-->
  <script src="js/summernotecutom.js"></script>
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
  
  


</body>
</html>