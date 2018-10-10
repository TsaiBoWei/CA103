<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.mem.model.*" %>

<%
  MemVO memVO=(MemVO)session.getAttribute("memVO");
%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">


   <!--moving letter-->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/2.0.2/anime.min.js"></script>

  <!--runoobEx-->
  <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/4.1.0/css/bootstrap.min.css">
  <script src="https://cdn.bootcss.com/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://cdn.bootcss.com/popper.js/1.12.5/umd/popper.min.js"></script>
  <script src="https://cdn.bootcss.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>


  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>index.jsp</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  
  <!--self definine 若放在上方cover輪播格式會跑掉 -->
 <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">

  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>



<style type="text/css">
  
.imgcepp{
  height:196px;
  overflow: hidden;
}

</style>





</head>


<body class="text-center">
  <!-- Navbar -->
  
 <nav   class="navbar navbar-expand-md fixed-top navbar-dark bg-dark">
    <span class="navbar-text"></span>
    <div class="container">
      <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#navbar2SupportedContent" aria-controls="navbar2SupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse justify-content-center" id="navbar2SupportedContent">
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="<%=request.getContextPath()%>/index.jsp">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
         
          
          <c:if test="${memVO!=null}">
	          <li class="nav-item mx-2 btn-lg dropdown" >
	            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">${memVO.mem_name}
	              <i class="fa fa-caret-down dropbtn"></i>
	            </a>
	            <div class="dropdown-content" id="myDropdown">
	               <a href="<%=request.getContextPath() %>/front_end/post/listAllPostByMem09.jsp"><i class="fa fa-file">&nbsp&nbsp個人頁面</i></a>
	              <a href=""><i class="fa fa-calculator">&nbsp&nbsp計畫</i></a>
	              <a href="#"><i class="fa fa-users" aria-hidden="true">&nbsp&nbsp好友</i></a>
	              <a href="#"><i class="fa fa-film" aria-hidden="true">&nbsp&nbsp課程</i></a>
	              <a href="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp"> <i class="fa fa-hand-spock-o" aria-hidden="true">&nbsp&nbsp活動</i></a>
	<!--               <a href=""><i class="fa fa-file">&nbsp&nbsp貼文</i></a> -->
	              <a href="<%=request.getContextPath() %>/front_end/calendar/page/Calendar.jsp"><i class="fa fa-check" aria-hidden="true">&nbsp&nbsp行事曆</i></a>
	              <a href="<%=request.getContextPath() %>/front_end/mem/updateMember/updateMember.jsp"><i class="fa fa-address-card" aria-hidden="true">&nbsp&nbsp會員資料</i></a>
	              <a href="<%=request.getContextPath() %>/mem/mem.do?action=loggedout">登出</a>
	            </div>
	          </li>
          </c:if>
        </ul>
        
         <c:if test="${memVO==null}">
        	<a class="btn btn-lg btn-primary" href="<%=request.getContextPath() %>/Mem_Login_Signup.jsp" id="registerBtn">Register now</a>
		 </c:if>      	
      </div>
    </div>	
  </nav>




  <!-- Cover -->
  <div class="align-items-center py-5 cover section-fade-in-out" id="coverFirstImg" style="background: url(&quot;img/index/cover_run.jpg&quot;);background-size: cover;">
    <div class="container">
      <div class="row">
        <div class="mt-5 text-right col-12">
          <h1 class="display-6 moveLetter1"style="padding-top: 350px;">WORK it OUT</h1>
          <p class="lead moveLetter2"> TURN Your Goals INTO ACTION </p>
        </div>
      </div>
    </div>
  </div>
 <div class=" py-5 align-items-center cover" id="coverImgad"style="display:none;">
   <div id="coverImgs" class="container">
    <div id="cover_bg1" class="cover_bgimg row">
        <div class="mt-5 text-right col-10">
          <h1 class="display-6 pr-4"style="padding-top: 430px;"> WORK it OUT</h1>
          <p class="lead pr-4">  TURN Your Goals INTO ACTION </p>
        </div>
    </div>
    <div id="cover_bg2" class="cover_bgimg row " style="background-position:-30px">
        <div class="mt-5 text-right col-10">
          <h1 class="display-6 pr-4" style="padding-top: 430px;"> WORK it OUT</h1>
          <p class="lead pr-4">  TURN Your Goals INTO ACTION </p>
        </div>
      
    </div>
    <div id="cover_bg3" class="cover_bgimg row">
        <div class="mt-5 text-right col-10">

          <h1 class="display-6 pr-4" style="padding-top: 430px;">  WORK it OUT</h1>
          <p class="lead pr-4">  TURN Your Goals INTO ACTION </p>
        </div>      
    </div>
  </div>

  </div>
</div>


  <!-- 宣傳圖 -->
  <div class="py-5 section-fade-in" >
    <div id="myCarouse2" class="container p-4 carousel slide" data-ride="carousel">
      <ul class="carousel-indicators">
        <li data-target="#myCarouse2" data-slide-to="0" class="active"></li>
        <li data-target="#myCarouse2" data-slide-to="1"></li>
        <li data-target="#myCarouse2" data-slide-to="2"></li>
      </ul>
   <!-- The slideshow -->
      <div class="carousel-inner">
        <div class="carousel-item active">
          <img src="img/index/ad_marathon.png" class="slideimg">
        </div>
        <div class="carousel-item">
          <img src="img/index/ad_surf.png" class="slideimg">
        </div>
        <div class="carousel-item">
          <img src="img/index/ad_yoga_course.png" class="slideimg"> 
        </div>
      </div>
  <!-- Left and right controls -->
      <a class="carousel-control-prev" data-slide="prev">
        <span class="carousel-control-prev-icon"></span>
      </a>
      <a class="carousel-control-next"  data-slide="next">
        <span class="carousel-control-next-icon"></span>
      </a>
    </div>
  </div>
  
  <!-- Speakers -->
  <div class="pt-5 " id="speakers">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h1 class="px-2 text-justify">POPULAR</h1>
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="#home" class="nav-link active pnftab" data-toggle="tab" aria-controls="home" aria-selected="true" id="popular_course" role="tab">課程</a>
            </li>
            <li class="nav-item">
              <a href="#profile" class="nav-link pnftab" data-toggle="tab" aria-controls="profile" aria-selected="false" id="popular_plan" role="tab">計畫</a>
            </li>
            <li class="nav-item">
              <a href="#contact" class="nav-link pnftab" data-toggle="tab" aria-controls="contact" aria-selected="false" id="popular_event" role="tab">活動</a>
            </li>
            <li class="nav-item">
              <a class="nav-link pnftab" href="#contact" data-toggle="tab" aria-controls="contact" aria-selected="false" id="popular_post" role="tab">貼文</a>
            </li>
          </ul>
          <div class="tab-content mt-2">
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container ">
        <div id="banner">
            <div class="slidePic">
                <div class="row picImgPop " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1Pop text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id=E000001">
                         <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300" >
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title1</b>
                        </h3>
                        <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post1</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">11&nbsp</i>
                             <button class="btn btn-sm " style="background: #f70655">田徑</button>
                          </div>
                        </div>
                       
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id=E000002">
                       <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title2</b>
                        </h3>
                      <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post2</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">12&nbsp</i>
                             <button class="btn btn-sm  ">水上</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id=E000003">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title3</b>
                        </h3>
                      <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post3</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">13&nbsp</i>
                             <button class="btn btn-sm  ">球類</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2Pop text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>

                <div class="row picImgPop " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1Pop text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id=E000004">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title4</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post4</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">14&nbsp</i>
                             <button class="btn btn-sm  ">健身</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id=E000005">
                       <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title5</b>
                        </h3>
                      <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post5</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">跳舞</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id=E000006">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title6</b>
                        </h3>
                      <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post16</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">登山</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2Pop text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>


            </div>
        </div>
    </div>  
  </div>

  <div class="pt-5 " id="speakersNew">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h1 class="px-2 text-justify">NEW</h1>
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="#home" class="nav-link pnftab active" data-toggle="tab" aria-controls="home" aria-selected="true" id="new_course" role="tab">課程</a>
            </li>
            <li class="nav-item">
              <a href="#profile" class="nav-link pnftab" data-toggle="tab" aria-controls="profile" aria-selected="false" id="new_plan" role="tab">計畫</a>
            </li>
            <li class="nav-item">
              <a href="#contact" class="nav-link pnftab" data-toggle="tab" aria-controls="contact" aria-selected="false" id="new_event" role="tab">活動</a>
            </li>
            <li class="nav-item">
              <a class="nav-link pnftab" href="#contact" data-toggle="tab" aria-controls="contact" aria-selected="false" id="new_post" role="tab">貼文</a>
            </li>
          </ul>
          <div class="tab-content mt-2">
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
        </div>
      </div>
    </div>  

    <div class="container ">
        <div id="banner">
            <div class="slidePic">
                <div class="row picImgNew " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1New text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title11</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title12</b>
                        </h3>
                      <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title13</b>
                        </h3>
                      <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2New text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>

                <div class="row picImgNew " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1New text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title14</b>
                        </h3>
                     <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title15</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title16</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2New text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>

            </div>
        </div>
    </div>  
  </div>

  <div class="pt-5 " id="speakersFriend">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h1 class="px-2 text-justify">FRIEND</h1>
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="#home" class="nav-link pnftab active" data-toggle="tab" aria-controls="home" aria-selected="true" id="friend_course" role="tab">課程</a>
            </li>
            <li class="nav-item">
              <a href="#profile" class="nav-link pnftab" data-toggle="tab" aria-controls="profile" aria-selected="false" id="friend_plan" role="tab">計畫</a>
            </li>
            <li class="nav-item">
              <a href="#contact" class="nav-link pnftab" data-toggle="tab" aria-controls="contact" aria-selected="false" id="friend_event" role="tab">活動</a>
            </li>
            <li class="nav-item">
              <a class="nav-link pnftab" href="#contact" data-toggle="tab" aria-controls="contact" aria-selected="false" id="friend_post" role="tab">貼文</a>
            </li>
          </ul>
          <div class="tab-content mt-2">
            <div class="tab-pane fade" id="tabthree" role="tabpanel">
              <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="container ">
        <div id="banner">
            <div class="slidePic">
                <div class="row picImgFriend " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1Friend text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title21</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title22</b>
                        </h3>
                        <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title23</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2Friend text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>

                <div class="row picImgFriend  " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1Friend text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title24</b>
                        </h3>
                        <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title25</b>
                        </h3>
                        <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm  ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=E000031" class="center-block img-fluid my-3 shadowed imgcepp" width="300">
                        <h3 class="mb-0 text-left text-primary  mx-3">
                          <b>Post title26</b>
                        </h3>
                       <div class="row mr-2 ">
                          <div class="col-md-7 ">
                            <h5 class="text-light text-left mx-3 mt-2">about the post</h5>
          
                          </div>
                          <div class="col-md-5 text-muted text-right">
                            <i class="fa fa-eye">15&nbsp</i>
                             <button class="btn btn-sm ">田徑</button>
                          </div>
                        </div>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2Friend text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>

            </div>
        </div>
    </div>  
  </div>
  
  <script>

    var pnftab=document.getElementsByClassName("pnftab");
    for(var i=0;i<pnftab.length;i++){
       pnftab[i].onclick=getinfo;
    }

	var time=0;
    function getinfo(e){
    	
    	var targrtTab=e.target;
    	   	
   		if(time==1){
   			targrtTab=document.getElementById("new_course");
   			time++;
       		console.log(targrtTab);   			
   		}
   		if(time==0){
   			targrtTab=document.getElementById("popular_course");
       		console.log(targrtTab);   
       		time++;
       		getinfo(e);
   		}
    		

       //確認是POPULAR.NEW.FRIEND
      var type1=targrtTab.parentNode.parentNode.previousElementSibling.innerText;

      //確認是課程.計畫.活動.貼文
      var type2=targrtTab.innerText;

      var reqtype2;

      if(type2=='課程'){
         reqtype2='COURSE';
      }else if(type2=='計畫'){
         reqtype2='PLAN';
      }else if(type2=='活動'){
         reqtype2='EVENT';
      }else if(type2=='貼文'){
       reqtype2='POST';
      }


      var tabContainer=targrtTab.parentNode.parentNode.parentNode.parentNode.parentNode;

      var imgrow= tabContainer.nextElementSibling.children[0].children[0].children[0];

      var title1=imgrow.children[0].children[1].children[1].children[0];
      var title2=imgrow.children[1].children[0].children[1].children[0];
      var title3=imgrow.children[2].children[0].children[1].children[0];

      var image1=imgrow.children[0].children[1].children[0];
      var image2=imgrow.children[1].children[0].children[0];
      var image3=imgrow.children[2].children[0].children[0];
      
      var mem_name1=imgrow.children[0].children[1].children[2].children[0].children[0];
      var mem_name2=imgrow.children[1].children[0].children[2].children[0].children[0];
      var mem_name3=imgrow.children[2].children[0].children[2].children[0].children[0];
      
      var href1=imgrow.children[0].children[1];
      var href2=imgrow.children[1].children[0];
      var href3=imgrow.children[2].children[0];
      
 
      
      
      var view1=imgrow.children[0].children[1].children[2].children[1].children[0];
      var view2=imgrow.children[1].children[0].children[2].children[1].children[0];
      var view3=imgrow.children[2].children[0].children[2].children[1].children[0];
      
      var sptype1=imgrow.children[0].children[1].children[2].children[1].children[1];
      var sptype2=imgrow.children[1].children[0].children[2].children[1].children[1];
      var sptype3=imgrow.children[2].children[0].children[2].children[1].children[1];
      

      var imgrow2= tabContainer.nextElementSibling.children[0].children[0].children[1];
      
      var title4=imgrow2.children[0].children[1].children[1].children[0];
      var title5=imgrow2.children[1].children[0].children[1].children[0];
      var title6=imgrow2.children[2].children[0].children[1].children[0];

      var image4=imgrow2.children[0].children[1].children[0];
      var image5=imgrow2.children[1].children[0].children[0];
      var image6=imgrow2.children[2].children[0].children[0];
      
      var mem_name4=imgrow2.children[0].children[1].children[2].children[0].children[0];
      var mem_name5=imgrow2.children[1].children[0].children[2].children[0].children[0];
      var mem_name6=imgrow2.children[2].children[0].children[2].children[0].children[0];
      
      var href4=imgrow2.children[0].children[1];
      var href5=imgrow2.children[1].children[0];
      var href6=imgrow2.children[2].children[0];
      console.log(href4.href)
      console.log(href5.href)
      console.log(href6.href)
      
      
      
      var view4=imgrow2.children[0].children[1].children[2].children[1].children[0];
      var view5=imgrow2.children[1].children[0].children[2].children[1].children[0];
      var view6=imgrow2.children[2].children[0].children[2].children[1].children[0];
      
      var sptype4=imgrow2.children[0].children[1].children[2].children[1].children[1];
      var sptype5=imgrow2.children[1].children[0].children[2].children[1].children[1];
      var sptype6=imgrow2.children[2].children[0].children[2].children[1].children[1];
      
  
   
      
      

      var xhr = new XMLHttpRequest();
      //設定好回呼函數   
      xhr.onload = function (){
          if( xhr.status == 200){        
        	  
//         	  console.log(xhr.responseText);
         	 showresult(xhr.responseText);
 
          }else{
            alert( xhr.status );
          }//xhr.status == 200
      };//onload 
      
      //建立好Get連接
      var url= "<%=request.getContextPath() %>/index?reqtype1="+type1+"&reqtype2="+reqtype2;
      
      xhr.open("Get",url,true); 
      //送出請求 
      xhr.send( null ); 
      
      
      function  showresult(results){
    	  
    	  var jArray = JSON.parse(results);
    	  
    	  title1.innerText=jArray[0].title;
    	  title2.innerText=jArray[1].title;
    	  title3.innerText=jArray[2].title;
    	  title4.innerText=jArray[3].title;
    	  title5.innerText=jArray[4].title;
    	  title6.innerText=jArray[5].title;
    	  
    	  mem_name1.innerText=jArray[0].mem_name;
    	  mem_name2.innerText=jArray[1].mem_name;
    	  mem_name3.innerText=jArray[2].mem_name;
    	  mem_name4.innerText=jArray[3].mem_name;
    	  mem_name5.innerText=jArray[4].mem_name;
    	  mem_name6.innerText=jArray[5].mem_name;
    	  
    	  view1.innerText=jArray[0].view;
    	  view2.innerText=jArray[1].view;
    	  view3.innerText=jArray[2].view;
    	  view4.innerText=jArray[3].view;
    	  view5.innerText=jArray[4].view;
    	  view6.innerText=jArray[5].view;
    	  
    	  sptype1.innerText=jArray[0].sptype_name;
    	  sptype2.innerText=jArray[1].sptype_name;
    	  sptype3.innerText=jArray[2].sptype_name;
    	  sptype4.innerText=jArray[3].sptype_name;
    	  sptype5.innerText=jArray[4].sptype_name;
    	  sptype6.innerText=jArray[5].sptype_name;
    	  
    	  sptype1.style.background=jArray[0].sptype_color;
    	  sptype2.style.background=jArray[1].sptype_color;
    	  sptype3.style.background=jArray[2].sptype_color;
    	  sptype4.style.background=jArray[3].sptype_color;
    	  sptype5.style.background=jArray[4].sptype_color;
    	  sptype6.style.background=jArray[5].sptype_color;

    	  
    	  if(reqtype2=='EVENT'){
    		  image1.src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+jArray[0].eve_id;
    		  image2.src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+jArray[1].eve_id;
    		  image3.src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+jArray[2].eve_id;
    		  image4.src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+jArray[3].eve_id;
    		  image5.src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+jArray[4].eve_id;
    		  image6.src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+jArray[5].eve_id;
    		  
    		  href1.href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id="+jArray[0].eve_id;
    		  href2.href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id="+jArray[1].eve_id;
    		  href3.href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id="+jArray[2].eve_id;
    		  href4.href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id="+jArray[3].eve_id;
    		  href5.href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id="+jArray[4].eve_id;
    		  href6.href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id="+jArray[5].eve_id;
    		  
    	  }else if(reqtype2=='COURSE'){
    		  image1.src="<%=request.getContextPath() %>/courlist/Courlist_DBGifReader.do?cour_id="+jArray[0].cour_id;
    		  image2.src="<%=request.getContextPath() %>/courlist/Courlist_DBGifReader.do?cour_id="+jArray[1].cour_id;
    		  image3.src="<%=request.getContextPath() %>/courlist/Courlist_DBGifReader.do?cour_id="+jArray[2].cour_id;
    		  image4.src="<%=request.getContextPath() %>/courlist/Courlist_DBGifReader.do?cour_id="+jArray[3].cour_id;
    		  image5.src="<%=request.getContextPath() %>/courlist/Courlist_DBGifReader.do?cour_id="+jArray[4].cour_id;
    		  image6.src="<%=request.getContextPath() %>/courlist/Courlist_DBGifReader.do?cour_id="+jArray[5].cour_id;
    		  
    	  }else if(reqtype2=='PLAN'){
    		  image1.src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id="+jArray[0].plan_id;
    		  image2.src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id="+jArray[1].plan_id;
    		  image3.src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id="+jArray[2].plan_id;
    		  image4.src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id="+jArray[3].plan_id;
    		  image5.src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id="+jArray[4].plan_id;
    		  image6.src="<%=request.getContextPath() %>/plan/DBGifReader4?plan_id="+jArray[5].plan_id;
    		 
    	  
    	  }else if(reqtype2=='POST'){
    		  image1.src=jArray[0].post_img;
    		  image2.src=jArray[1].post_img;
    		  image3.src=jArray[2].post_img;
    		  image4.src=jArray[3].post_img;
    		  image5.src=jArray[4].post_img;
    		  image6.src=jArray[5].post_img;
    		 
    	  
    	  }
    	  
 	  
    	  
      }
       
     

    }
  

  window.onload=getinfo;
  
  </script>
  
  
  
  


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
          <img class="center-block img-fluid d-block" src="img/index/logo_1.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="img/index/logo_4.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="img/index/logo_3.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="img/index/logo_2.png"> </div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('img/index/cover_buttom.jpg');">
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
            <br>Copyright 2018 Pingendo - All rights reserved.
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
  <script src="js/smooth-scroll.js"></script>
  
  <button  id= "goTopBtn"style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:80px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">
    GoTop
  </button>


  
</body>

</html>