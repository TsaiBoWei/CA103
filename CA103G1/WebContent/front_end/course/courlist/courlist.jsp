<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>


<%
CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //EmpServlet.java (Concroller) 存入req的empVO物件 (包括幫忙取出的empVO, 也包括輸入資料錯誤時的empVO物件)
%>


<!DOCTYPE html>
<html>
<head>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  
 
  
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>TRY</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="css/Course.css">
  <link rel="stylesheet" href="css/font.css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <script src="js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="js/animate-in.js"></script>
  <!-- lightcase settings -->
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
   
  <!-- include summernote css/js -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
  
  
     
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
        <a class="btn navbar-btn mx-2 justify-content-start btn-outline-primary btn-lg" href="#">WORK it OUT</a>
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
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(&quot;assets/conference/024.jpg&quot;);">
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
          <h3>時尚恬心 王心恬－空中瑜珈教室
            <br> </h3>
          <div class="text-md-right">
            <a href="#" class="btn btn-outline-primary btn-sm m-1">Share
              <br> </a>
            <a href="#" class="btn btn-sm btn-outline-secondary m-1">Report
              <br> </a>
          </div>
          <p class="">要在空中一邊施力一邊取得平衡其實不容易，但是這是空中瑜珈和一般瑜珈最不同的地方，從一開始不適應不熟悉，做每個動作肌肉都會顫抖，到後來習慣後終於可以專注在調整姿勢，看著鏡子裡的自己，終於可以做到懸吊飛翔的動作，相當有成就感！之後一定要再來挑戰全身的肌肉，讓自己在空中懸吊會更自在、更舒適！</p>
          <a href="#" class="btn btn-lg btn-primary mx-1">Buy It</a>
        </div>
        <div class="col-md-5">
          <img class="img-fluid d-block mx-auto" src="assets/conference/course_A_01_S.png"> </div>
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
              <i class="fa fa-film" aria-hidden="true"></i>&nbsp; Course &nbsp; </a>
          </li>
          <!-- 第五個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfive" data-toggle="tab">
              <i class="fa fa-comments" aria-hidden="true"></i> &nbsp; Forum &nbsp; </a>
          </li>
          <!-- 第六個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabsix" data-toggle="tab">
              <i class="fa fa-star" aria-hidden="true"></i> &nbsp; Review &nbsp; </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container containerHrB ">
    <hr> </div>
    <!-- 分頁 -->
   <div class="tab-content mt-2">
    <div class="tab-pane fade show active" id="tabone" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row mb-5">
            <div class="col-md-7">
              <h2 class="text-primary text-md-left"> <i class="fa fa-user"></i> &nbsp; 王心恬  &nbsp;  <br> </h2>
              
              <p class="text-md-left">要在空中一邊施力一邊取得平衡其實不容易，但是這是空中瑜珈和一般瑜珈最不同的地方，從一開始不適應不熟悉，做每個動作肌肉都會顫抖，到後來習慣後終於可以專注在調整姿勢，看著鏡子裡的自己，終於可以做到懸吊飛翔的動作，相當有成就感！之後一定要再來挑戰全身的肌肉，讓自己在空中懸吊會更自在、更舒適！
                <br>
                <br>許多人不知道名模王心恬與超馬悍將林義傑兩人是好友關係，兩人透過慢跑認識，也接觸到更多特殊運動形態的馬拉松，也曾參加過林義傑舉辦的《SUPERACE超級馬拉松-吳哥窟站》。
                <br> 喜愛嘗試各種挑戰的心恬，這次再次挑戰三天兩夜 111 公里《SUPERACE超級馬拉松-內蒙站》，挑戰用徒步的方式自行背負行李、食物、急救品及各式裝備，除了要克服體能負荷外，也得克服嚴峻、高溫、風沙、早晚溫差大的沙漠氣候。 </p>
              <div class="accordion" id="coach_update">
   				  <div class="text-md-right" id="coach_update_hide">
       				 <button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
       				 data-target="#coach_update_text" aria-expanded="false" aria-controls="coach_update_text"> 
       				 <i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
        			 </button>
    			  </div>
    			  <div id="coach_update_text" class="col-md-12 collapse" aria-labelledby="coach_update_hide" data-parent="#coach_update">
     				 <div class="card-body">
        				<br>
       					<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; 修改教練資訊</h5>
         				<form class="" method="post" action="https://formspree.io/">
            				<div class="form-group">
	  							<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="5"></textarea>
	  						</div>
	  						<br>
	  						<div class="text-md-right">
            					<button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
            				</div>
				        </form>
				      </div>
				    </div>
				</div>
            </div>
            <div class="col-md-5 align-self-center">
              <img class="img-fluid d-block w-100 img-thumbnail" src="assets/conference/coach_001.jpg"> </div>
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
              <p class="text-md-left">9/28(五)影片上傳暫停一周。</p>
              <div class="accordion" id="announcement_update">
   				<div class="text-md-right" id="announcement_update_hide">
       				<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" 
       				data-target="#announcement_update_text" aria-expanded="false" aria-controls="announcement_update_text"> 
       				<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
        			</button>
    			</div>
    			<div id="announcement_update_text" class="col-md-12 collapse" aria-labelledby="announcement_update_hide" data-parent="#announcement_update">
     				<div class="card-body">
        				<br>
       					<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; 修改課程公告</h5>
         				<form class="" method="post" action="https://formspree.io/">
            				<div class="form-group">
	  							<textarea class="form-control text-light" style="background-color:#1f1f1f; border-color:#505050;" rows="5"></textarea>
	  						</div>
	  						<br>
	  						<div class="text-md-right">
            					<button type="submit" class="btn btn-outline-primary btn-sm m-1">Send</button>
            				</div>
				        </form>
				    </div>
				 </div>
			  </div>
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
                  <p class="text-md-left">空中瑜伽聽起來很玄，查了一查發現，空中瑜伽（Aerial Yoga），又稱為反重力瑜伽（Anti-gravity Yoga）。 <br>
                  						     主要利用懸掛在半空中，垂墜高度至人體腰部的繩索吊床支撐身體，藉由與吊床/吊繩的互動，練習傳統的哈達瑜珈。空中瑜珈有五個特點，雕塑體態、促進血液循環、舒緩脊椎壓力、訓練身體協調性、讓身心放鬆。</p>
                  <img class="img-fluid d-block w-100 mb-3 rounded" src="assets/conference/course_002.jpg">
                  <p class="text-md-left">空中瑜珈是運用懸垂的絹布，藉助反地心引力與布掛支撐身體的力量，幫助我們在空中進行瑜珈練習，使平時部分難以完成的瑜珈動作變得較輕鬆，體會更深度的無壓力肌群伸展。<br>
                  						   空中瑜珈同時著重於平衡、核心、柔軟度、專注力，可幫助練習者提升全身性的協調感，有覺知的感受身體，體驗身心飛翔的輕盈舒展。</p>
					<div class="accordion" id="information_update">
					   	<div class="text-md-right" id="information_update_hide">
					       	<button class="btn btn-outline-primary btn-sm m-1 " type="button" data-toggle="collapse" data-target="#information_update_text" 
					       			aria-expanded="false" aria-controls="information_update_text"> 
					       	<i class="fa fa-edit" aria-hidden="true"></i> &nbsp; Edit &nbsp;
					        </button>
					    </div>
						<div id="information_update_text" class="col-md-12 collapse" aria-labelledby="information_update_hide" data-parent="#information_update">
						    <div class="card-body">
						        <br>
						       	<h5 class="text-md-left"><i class="fa fa-pencil" aria-hidden="true"></i> &nbsp; 修改課程介紹</h5>
						         						       
								    <div id="summernote"></div>
								    <script>
								      $('#summernote').summernote({
								        placeholder: 'Hello stand alone ui',
								        tabsize: 2,
								        height: 100
								      });
								    </script>
    								
							</div>
						</div>
					</div>
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
    <!-- Sponsors -->
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
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script> 



</body>
</html>