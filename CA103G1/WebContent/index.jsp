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
  <link rel="stylesheet" href="css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  
  <!--self definine 若放在上方cover輪播格式會跑掉 -->
 <link rel="stylesheet" href="css/index.css">

  <script src="js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="js/animate-in.js"></script>
  <script type="text/javascript" src="js/index.js"></script>





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
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="#">WORK it OUT</a>
        <ul class="navbar-nav ml-auto">
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#schedule">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
          <li class="nav-item mx-2 btn-lg dropdown" id="navUserBtn">
            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">User&nbsp
              <i class="fa fa-caret-down dropbtn"></i>
            </a>
            <div class="dropdown-content" id="myDropdown">
              <a href="#"><i class="fa fa-file">&nbsp&nbsp個人頁面</i></a>
              <a href="#"><i class="fa fa-calculator">&nbsp&nbsp計畫</i></a>
              <a href="#"><i class="fa fa-users" aria-hidden="true">&nbsp&nbsp好友</i></a>
              <a href="#"><i class="fa fa-film" aria-hidden="true">&nbsp&nbsp課程</i></a>
              <a href="#"> <i class="fa fa-hand-spock-o" aria-hidden="true">&nbsp&nbsp活動</i></a>
              <a href="#"><i class="fa fa-sticky-note" aria-hidden="true">&nbsp&nbsp貼文</i></a>
              <a href="#"><i class="fa fa-sticky-note" aria-hidden="true">&nbsp&nbsp行事曆</i></a>
              <a href="#">登出</a>
            </div>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#" id="registerBtn">Register now</a>
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
  <div class="py-5 " id="speakers">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h1 class="px-2 text-justify">POPULAR</h1>
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="#home" class="nav-link active" data-toggle="tab" aria-controls="home" aria-selected="true" id="home-tab" role="tab">貼文</a>
            </li>
            <li class="nav-item">
              <a href="#profile" class="nav-link" data-toggle="tab" aria-controls="profile" aria-selected="false" id="profile-tab" role="tab">計畫</a>
            </li>
            <li class="nav-item">
              <a href="#contact" class="nav-link" data-toggle="tab" aria-controls="contact" aria-selected="false" id="contact-tab" role="tab">活動</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#contact" data-toggle="tab" aria-controls="contact" aria-selected="false" id="course-tab" role="tab">課程</a>
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
                      <a href="#">
                        <img src="img/index/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title1</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title2</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title3</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
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
                      <a href="#">
                        <img src="img/index/04.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title4</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title5</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/05.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title6</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
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
                      <a href="#">
                        <img src="img/index/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title7</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/05.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title8</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/04.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title9</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
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

  <div class="py-5 " id="speakersNew">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h1 class="px-2 text-justify">NEW</h1>
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="#home" class="nav-link active" data-toggle="tab" aria-controls="home" aria-selected="true" id="home-tab2New" role="tab">貼文</a>
            </li>
            <li class="nav-item">
              <a href="#profile" class="nav-link" data-toggle="tab" aria-controls="profile" aria-selected="false" id="profile-tab2New" role="tab">計畫</a>
            </li>
            <li class="nav-item">
              <a href="#contact" class="nav-link" data-toggle="tab" aria-controls="contact" aria-selected="false" id="contact-tabNew" role="tab">活動</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#contact" data-toggle="tab" aria-controls="contact" aria-selected="false" id="course-tabNew" role="tab">課程</a>
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
                        <img src="img/index/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title1</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title2</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title3</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
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
                        <img src="img/index/04.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title4</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title5</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/05.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title6</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
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
                        <img src="img/index/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title7</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/05.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title8</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/04.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title9</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post
                          <br>about the post</p>
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

  <div class="py-5 " id="speakersFriend">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h1 class="px-2 text-justify">FRIEND</h1>
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a href="#home" class="nav-link active" data-toggle="tab" aria-controls="home" aria-selected="true" id="home-tab" role="tab">貼文</a>
            </li>
            <li class="nav-item">
              <a href="#profile" class="nav-link" data-toggle="tab" aria-controls="profile" aria-selected="false" id="profile-tab" role="tab">計畫</a>
            </li>
            <li class="nav-item">
              <a href="#contact" class="nav-link" data-toggle="tab" aria-controls="contact" aria-selected="false" id="contact-tab" role="tab">活動</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#contact" data-toggle="tab" aria-controls="contact" aria-selected="false" id="course-tab" role="tab">課程</a>
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
                        <img src="img/index/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title1</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post1
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title2</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post2
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title3</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post3
                          <br>about the post</p>
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
                        <img src="img/index/04.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title4</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post4
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title5</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post5
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/05.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title6</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post6
                          <br>about the post</p>
                      </a>
                    </div>
                    <div>  
                      <a class="btn2Friend text-right" style="display: block;"  >
                        <span class="carousel-control-next-icon"></span>
                      </a>
                    </div>   
                </div>

                <div class="row picImgFriend " >
                    <div class="col-lg-4 col-md-4" style="display:relative;">
                      <div style="display: block;">
                        <a class="btn1Friend text-left  " style="display: block;" >
                          <span class="carousel-control-prev-icon"></span>    
                        </a>
                      </div>
                      <a href="#">
                        <img src="img/index/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title7</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post7
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/05.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title8</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post8
                          <br>about the post</p>
                      </a>
                    </div>
                    <div class="col-lg-4 col-md-4">
                      <a href="#">
                        <img src="img/index/04.png" class="center-block img-fluid my-3 shadowed" width="300">
                        <h3 class="mb-0 text-left text-primary">
                          <b>Post title9</b>
                        </h3>
                        <p class="text-muted text-right">author name</p>
                        <p class="text-light text-left">about the post
                          <br>about the post9
                          <br>about the post</p>
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