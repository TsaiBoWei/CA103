<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.*"%>
    <%@ page import="com.mem.model.*"%>
    <%@ page import="com.eve.model.*" %>
	<%@ page import="com.eventlist.model.*"%>
	<%@ page import="java.text.*"%>
	
<!DOCTYPE html>

<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />


<%--	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
--%>
<%-- /*以會員id取出對應的evelist*/
	List<EventListVO> list =evelistSvc.getEveListsByMem(memVO.getMem_id());
--%>
<% /*以會員id(先用假資料)取出對應的evelist*/
	List<EventListVO> list =evelistSvc.getEveListsByMem("M000001");
	
%>

<%
	List<EventVO> listEve = new ArrayList<EventVO>();
	for(EventListVO eve:list){
		EventVO vo = eveSvc.getOneEve(eve.getEve_id());
		listEve.add(vo);
	}//取出evelist裡的eve_id再查出eve_id所對應的event 並存進listEve
	
%>

<html>
<head>
<meta charset="BIG5">
<title>行事曆</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- PAGE settings -->
    <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">

    <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
    <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
    <!-- CSS dependencies -->
    <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/calendar/css/neon_cal.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/PersonalPageBase.css">
<!--    <link rel="stylesheet" type="text/css" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">-->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.theme.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.structure.css">
    <!-- Script: Make my navbar transparent when the document is scrolled to top -->
    <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
    <!-- Script: Animated entrance -->
    <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
    <!-- lightcase settings -->
    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
    <!--  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>-->
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/calendar/css/fullcalendar.css">
    <script src="<%=request.getContextPath() %>/front_end/calendar/js/jquery-ui.min.js"></script>
    <script src="<%=request.getContextPath() %>/front_end/calendar/js/moment.min.js"></script>
    <script src="<%=request.getContextPath() %>/front_end/calendar/js/fullcalendar.js">
    </script>
    <script src="<%=request.getContextPath() %>/front_end/calendar/jquery-ui-1.12.1.custom/jquery-ui.min.js"></script>
    <style>
        /*頁面設定*/

    body {
      overflow-x: hidden;
      height: 0%;
    }

    .eventCard {
      color: #fff;
    }
    
    .dialog_inpu input{width: 100%;} 
        .dialog_inpu textarea{width: 100%;} 
      
        
  </style>
</head>
<body  class="text-center">
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
    <div class="d-flex align-items-center cover section-fade-in-out" style="background-image: url(&quot;assets/conference/jogback.jpg&quot;);">
        <div class="container">
            <div class="row">
                <div class="mt-5 text-right col-12">
                    <h1 class="display-6 text-light">WORK it OUT</h1>
                    <p class="lead"> TURN Your Goals INTO ACTION </p>
                    <!-- List -->
                </div>
            </div>
            <!-- 卡片row 移出-->
            <div class="row justify-content-end">
                <div class="card col-6 card-custom">
                    <div class="card-header card-header-custom text-right">Aug 11 , 2018</div>
                    <div class="card-body card-body-custom">
                        <h4 class="text-primary text-right">Plan Today</h4>
                        <h6 class="text-muted  text-right">Subtitle</h6>
                        <p class=" text-right">Some quick example text to build on the card title.</p>
                    </div>
                </div>
            </div>
            <!--  // 卡片row 移出-->
        </div>
    </div>
    <!-- Personal Pic -->
    <div class="row mb-5">
        <div class="col-md-3 offset-md-1">
            <div class="colProfile">
                <img class="img-fluid rounded-circle" alt="Card image" src="assets/styleguide/people_2.jpg"> </div>
        </div>
        <div class="col-md-4 align-self-end ml-3">
            <h1 class="text-left text-primary">Jennifer Lawrence</h1>
            <p class="text-left">Paragraph. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet, consectetur adipiscing elit.Paragraph. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
        </div>
        <!--<div class="col-md-4  py-10"></div>-->
    </div>
    <!-- NavBar Personal-->
    <div class="container containerHrT ">
        <hr>
    </div>
    <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
        <div class="container">
            <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fa fa-file"></i> &nbsp; &nbsp; MyPage &nbsp; &nbsp;&nbsp;</a>
                    </li>
                    <!-- Workoutplan-->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" aria-expanded="false" aria-haspopup="true" data-toggle="dropdown" href="#" id="navbarDropdownMenuLink">
                            <i class="fa fa-calculator"></i> &nbsp; WorkOutPlan &nbsp;</a>
                        <div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom">
                            <a class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light" href="#">My Plan</a>
                            <a class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light" href="#">Interetsting Plan</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fa fa-users" aria-hidden="true"></i>&nbsp; &nbsp; Friends &nbsp;&nbsp;</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" aria-expanded="false" aria-haspopup="true" data-toggle="dropdown" id="navbarDropdownMenuLink">
                            <i class="fa fa-film" aria-hidden="true"></i>&nbsp; &nbsp; Course &nbsp; &nbsp; </a>
                        <div class="dropdown-menu bg-dark bg-dark-dropmenu-cutom ">
                            <a class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light" href="#">MyCourse</a>
                            <a class="dropdown-item bg-dark bg-dark-dropmenuitem-cutom text-light" href="#">Interetsting Course</a>
                        </div>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link" href="#">
                            <i class="fa fa-hand-spock-o" aria-hidden="true"></i>&nbsp;Event &nbsp;&nbsp; </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fa fa-sticky-note" aria-hidden="true"></i>&nbsp;&nbsp;Post&nbsp;&nbsp; </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">
                            <i class="fa fa-sticky-note" aria-hidden="true"></i> &nbsp;MyCalender&nbsp; </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="py-5">
        <div class="container">
            <div class="row">
                <!--行事曆-->
                <div class="col-md-12 cal1" id="calendar1"></div>
                <!-- 計畫列表-->
                <div id="dialog" class="dialog_inpu" title="My dialog" style="display:none">
                    <form>
                       <fieldset>
                        
       
                            <label for="Id">標題</label>
                            <input type="text" name="title" id="title" class="text <<<<u></u>i-w></ui-w>idg></ui-widg>et-></ui-widget->content ui-corner-all">
                     
                            <label for="con">內容</label>
                            <textarea name="title" id="con" class="text <<<<u></u>i-w></ui-w>idg></ui-widg>et-></ui-widget->content ui-corner-all"></textarea>
                           
                        <div>
                            <input type="submit" name="send" value="修改">
                            <input type="button" name="delete" value="刪除"> </div>  
                        </fieldset>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <div class="container containerHrB ">
        <hr>
    </div>
    <!-- Here you go -->
    <!-- Here you go -->
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
                    <img class="center-block img-fluid d-block" src="assets/conference/logo_1.png"> </div>
                <div class="col-md-2 col-6">
                    <img class="center-block img-fluid d-block" src="assets/conference/logo_4.png"> </div>
                <div class="col-md-2 col-6">
                    <img class="center-block img-fluid d-block" src="assets/conference/logo_3.png"> </div>
                <div class="col-md-2 col-6">
                    <img class="center-block img-fluid d-block" src="assets/conference/logo_2.png"> </div>
            </div>
        </div>
    </div>
    <!-- Call to action -->
    <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('assets/conference/cover_2.jpg');">
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
                       
                        <br>
                        <br> </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- JavaScript dependencies -->
    <script>
    var events = [
    	<% 	
    		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd");
    	for(EventVO ii: listEve){
    		System.out.println(sdFormat.format(ii.getEve_startdate()));
    			
    	%>
    	
    		{
        	id: '<%=ii.getEve_id()%>',
        	title: '<%=ii.getEve_title()%>',
        	start: '<%=sdFormat.format(ii.getEve_startdate())%>',
        	end: '<%=sdFormat.format(ii.getEve_enddate())%>',
        	allDay: true
    		},
      
    	<%
          }
        %>   
    {
        id: 'test2',
        title: 'Birthday Party',
        start: '2018-09-15',
        end: '2018-09-22',
        allDay: true
    }]
        $(document).ready(function() {
            (function() {
                var date = new Date();
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();



                $('#calendar1').fullCalendar({
                    editable: true,
                    height: 650,
                    width: 500,
                    eventLimit: true,
                    header: {
                        left: 'title',
                        center: '',
                        right: 'today prev,next'
                    },

                    eventClick: function(calEvent, jsEvent, view) { //表示點擊計畫之後要衝三小
                    	

                        $("#dialog").dialog({ //對話框的設定
                            autoOpen: false,
                            draggable: true,
                             height: 480,
                            width:480,
                            title: "work it out!",

                            //                 buttons: {
                            //        "Ok": function() {
                            //            $(this).dialog("close");
                            //        },
                            //        "Cancel": function() {
                            //            $(this).dialog("close");
                            //        }
                            //    }

                        });

                        $("#name").val(calEvent.id); //關於對話框內各數值的設定，從後端叫資料
                        $("#title").val(calEvent.title); 
                        $("#con").val("拉筋10分鐘,啞鈴3套，間隔1分鐘");
                        $('#dialog').dialog('open');
                    },

                    
                    events: events
                });
            }());
        });

    </script>
    <!--    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- Script: Smooth scrolling between anchors in a same page -->
    <script src="<%=request.getContextPath() %>/js/smooth-scroll.js"></script>
</body>
</html>