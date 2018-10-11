<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.mem.model.*"%> 


<%
// MemVO memVO1= new MemService().getOneMem("M000001");
// session.setAttribute("memVO", memVO1);

%>

<%
CourlistService courlistSvc = new CourlistService();
    List<CourlistVO> list = courlistSvc.getAll();
    pageContext.setAttribute("list",list);

//為啥跳錯誤5555
// CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //CourlistServlet.java(Controller), 存入req的courlistVO物件
// CoachVO coachVO = (CoachVO) request.getAttribute("coachVO"); 
// MemVO memVO = (MemVO) request.getAttribute("memVO"); 

//     CoachService coachService = new CoachService();
//     CoachVO coachVO2 = coachService.getOneCoach(courlistVO.getCoa_id());
    
//     MemService coamemSvc= new MemService();
//     MemVO coamemVO= coamemSvc.getOneMem(coachVO2.getMem_id());
%>



    
<!DOCTYPE html>
<html>
<head>
<title>allCourlist</title>
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
  
  
  <!-- fafaicon -->
	<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
  
  <style>  
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }
    
    .courboarsearchbar {
      background: none;
      border: 0.7px solid #303030;
    }

    .courboarsearchbar:focus {
      background: none;
    }
    
    
    
    .courboarimg {
      overflow: hidden;
      height: 196px;
      
    }
    .courcost{
    color:rgba(247, 6, 85,0.6)!important;
    
    }
    
    .bg-dark-posteditinput{
    background-color: #1f1f1f!important; 
    border-radius: 10px;
    border: 0.8px solid rgba(239, 239, 239,0.5)!important;
    color: rgba(239, 239, 239,0.9)!important;
    
}


	.imgcourlist {
	    -webkit-filter: grayscale(30%); /* Safari */
	    filter: grayscale(30%);
	    opacity:0.9;
	}
    
    
      .courboarqform {
      background: rgba(48, 48, 48, 0.8);
      /*width: 700px;*/
    }

    .courboardqtext {
      border-radius: 2px;
      background: none;
      border: 0.5px solid rgba(204, 204, 204, 0.5);
    }

    .courboardqtext:focus {
      background: none;
    }

    .courboarmodalheader {
      border-bottom: none;
    }

    .courboarmodal {
      border-top: 0.5px solid rgba(204, 204, 204, 0.5);
    }

    .courboarlistinnerline {
      border-bottom: 0.5px solid rgba(239, 239, 239, 0.4);
    }
    
    .crposticon:hover{
    
    color:#009ac0;
    }
    
  </style>


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
  <div class="d-flex align-items-center cover section-fade-in-out" style="background-image: url(<%=request.getContextPath() %>/front_end/course/courlist/assets/conference/fitness.jpg);" draggable="true" >
    <div class="container">
      <div class="row">
        <div class="mt-5 text-right col-12">
          <h1 class="display-6">ONLINE TRAINING COURSE</h1>
          <p class="lead"> TURN Your Goals INTO ACTION </p>
        </div>
      </div>
    </div>
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

   <!--searchbar1-->
   <div class="mt-5" id="speakers">
    <div class="container">
      <div class="row">
        <div class=" col-md-6 mb-0 pl-0 pr-5">
          <form>
            <div class="input-group">
              <div class="input-group-prepend">
                <span class="input-group-text bg-primary border-primary border text-white">Search</span>
              </div>
              <input type="text" name="" class="form-control courboarsearchbar">
              <div class="input-group-append">
                <button class="btn btn-primary border-primary border text-dark">
                  <i class="fa fa-search text-white"></i>
                </button>
              </div>
            </div>
          </form>
        </div>
        <!--Searchbar2-->
        <div class=" col-12 col-md-2 mb-0 px-1">
          <jsp:useBean id="coa_idSvc" scope="page" class="com.coach.model.CoachService" />
          <jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
          <select name="coa_id" class="form-control bg-dark-posteditinput">
			<c:forEach var="coachVO" items="${coa_idSvc.all}">
				<option value="${coachVO.coa_id}" ${(courlistVO.coa_id==coachVO.coa_id)?'selected':'' } >${memSvc.getOneMem(coachVO.mem_id).mem_name}
			</c:forEach>
          </select>
        </div>
        <!--Searchbar3-->
        <div class=" col-12 col-md-2 mb-0 px-1">
          <jsp:useBean id="sportSvc" scope="page" class="com.sptype.model.SptypeService" />
          <select name="sptype_id" class="form-control bg-dark-posteditinput">
			<c:forEach var="sptypeVO" items="${sportSvc.all}">
			<option value="${sptypeVO.sptype_id}" ${(courlistVO.sptype_id==sptypeVO.sptype_id)? 'selected':'' } >${sptypeVO.sport}
			</c:forEach>
          </select>
        </div>
        <!--Send-->
        <div class=" col-12 col-md-2 mb-0 px-0">
          <button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#exampleModal"> Send </button>
        </div>
      </div>
    </div>
  </div>

      

    <!-- LIST -->
    <div style="visibility:hidden;">
	<%@ include file="page1.file" %> 
	</div>
<%-- 	<c:forEach var="courlistVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>"> --%>

	<!-- CARD -->	
 	<div class="py-3 " id="speakers">
    <div class="container "> 
      <div class="row mt-5">
      <c:forEach var="courlistVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
        <div class="col-lg-4 col-md-1 py-3">
          <a href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?cour_id=${courlistVO.cour_id}&courpageloc=tabone"> </a>
          <div class="card">
            <a href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?cour_id=${courlistVO.cour_id}&courpageloc=tabone">
             <div class="courboarimg">
           		 <img class="card-img-top imgcourlist" alt="Card image"
         		 src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=${courlistVO.cour_id}">
           </div>
         		 
            </a>
            <div class="card-body">
           
              <a href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?cour_id=${courlistVO.cour_id}&courpageloc=tabone">
                <h5 class="card-title text-left"><span class="badge mb-1 badge-courpaycata" style="background-color:${sportTypeColor.get(courlistVO.sptype_id)};opacity:0.8;">${sportSvc.getOneSptype(courlistVO.sptype_id).sport}</span>&nbsp;&nbsp;&nbsp;</h5>
                <h4 class="">${courlistVO.cname} </h4>
                <div class="row">
                  <div class="col-12 col-md-2  px-2 ">
                 
                    <img class="img-fluid rounded-circle" alt="Card image" src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${coa_idSvc.getOneCoach(courlistVO.coa_id).mem_id}"> 
<!--                      <img class="img-fluid d-block w-100 img-thumbnail" alt="Card image" -->
<%-- 		  src="<%=request.getContextPath()%>/coach/Coach_DBGifReader.do?coa_id=<%=courlistVO.getCoa_id()%>"> --%>
                 
                  </div>
                  <div class="col-3 col-md-10  px-1 text-left align-self-center percenatext text-white "> 
                  Coach · ${memSvc.getOneMem(coa_idSvc.getOneCoach(courlistVO.coa_id).mem_id).mem_name}
<%--                   <%=coamemVO.getMem_name()%> --%>
                  </div>
                </div>
                <h4 class="card-text text-right courcost" >$ ${courlistVO.cour_cost}</h4>
              </a>
            </div>
          </div>
        </div>
        </c:forEach>        
 	  </div>
   	</div>        
 </div>
  
<%--   </c:forEach> --%>
  <%@ include file="page2.file" %>
  
  
    <!-- Sponsor logos -->
		<div class="py-5 mt-5 section" >
			<div class="container">
				<div class="row">
					<div class="col-md-12">
						<h1 class="mb-4">Sponsors</h1>
					</div>
				</div>
				<div class="row">
					<div class="col-md-2 col-6"></div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/assets/conference/logo_1.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/assets/conference/logo_4.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/assets/conference/logo_3.png">
					</div>
					<div class="col-md-2 col-6">
						<img class="center-block img-fluid d-block"
							src="<%=request.getContextPath()%>/front_end/assets/conference/logo_2.png">
					</div>
				</div>
			</div>
		</div>
		
	
		<!-- Call to action -->
		<div class="py-5 section mt-3 section-fade-in-out" id="register"
			style="background-image: url('<%=request.getContextPath()%>/front_end/assets/conference/cover_2.jpg');">
			<div class="container">
				<div class="row">
					<div class="col-md-12 text-left">
						<h1 class="mb-3">Set and Achieve Goals</h1>
						<p>
							By discovering the power of goal setting by committing to reaching an exercise milestone and then working out just how you’ll achieve it, you can enjoy the 
							benefits of exercise and the confidence that comes along with it.
						</p>
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
<!--broacastwindow-->
			
			<div class="col-md-12 ">
					<div class="modal fade mx-auto" aria-hidden="true"
						aria-labelledby="exampleModalLabel" id="broadcastwindow"
						role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
						<div class="modal-dialog " role="document">
							<div class="modal-content courboarqform">
								<div class="modal-header courboarmodalheader">
									<h5 class="modal-title text-secondary" id="exampleModalCenterTitle">限時3天</h5>
									<button type="button" class="close cancel" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true" class="text-light"><i
											class="fas fa-times cancel"></i></span>
									</button>
								</div>
								<div class="modal-body text-center text-light ">
									<p class="mb-1" id="discounttext"></p>
									<img id="discountimg" alt="" src="" style="width:300px;">
									<p class="mt-1"><a id="discounthref" href="">More Detials</a></p>
								</div>
								<div class="modal-footer courboarmodal">

								</div>
							</div>
						</div>
					</div>
				</div>
			
<!--broacastform-->




<script>
$(document).ready(function(){   
	connect();
});

</script>

		
<script>
    
    var MyPoint = "/MyEchoServer";
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
        console.log("WebSocket 成功連線");

		};
		var discounttext = document.getElementById("discounttext");
		var discountimg = document.getElementById("discountimg");
		var discounthref = document.getElementById("discounthref");
		var exampleModalCenterTitle=document.getElementById("exampleModalCenterTitle");
		
		
		webSocket.onmessage = function(event) {
// 			var messagesArea = document.getElementById("messagesArea");
// 	        var jsonObj = JSON.parse(event.data);
	        
// 	        messagesArea.value = messagesArea.value + message;
// 	        messagesArea.scrollTop = messagesArea.scrollHeight;
            var jsonObj = JSON.parse(event.data);
            var message = jsonObj.discountcname+jsonObj.finaldiscount + "折";
            alert(message);
            var courno=jsonObj.discountcour_id;
            var expiryunitl=jsonObj.expiryunitl;
            discounttext.innerHTML=message;
            discounthref.href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?cour_id="+courno+"&courpageloc=tabone";
            discountimg.src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id="+courno;
            exampleModalCenterTitle.innerHTML="限時"+expiryunitl+"天";
            $("#broadcastwindow").modal({show: true});
           
           
		};

// 		webSocket.onclose = function(event) {
// 			updateStatus("WebSocket 已離線");
// 		};
	}
	
	
// 	var discount = document.getElementById("discount");
// //// 	inputUserName.focus();
	
// 	function sendMessage() {
// 	    var finaldiscount = discount.value.trim();
// //// 	        var jsonObj = {"finaldiscount" : finaldiscount};
// //// 	        webSocket.send(JSON.stringify(jsonObj));
// 	        webSocket.send(finaldiscount+"折");
// 	}

	
// 	function disconnect () {
// 		webSocket.close();
// 		document.getElementById('sendMessage').disabled = true;
// 		document.getElementById('connect').disabled = false;
// 		document.getElementById('disconnect').disabled = true;
// 	}

///改變的狀態	
// 	function updateStatus(newStatus) {
// 		statusOutput.innerHTML = newStatus;
// 	}
	
	
    
</script>


  
  
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