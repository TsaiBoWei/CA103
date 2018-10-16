<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.coach.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.courunit.model.*"%>
<%@ page import="com.courdiscount.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
///模擬登入與瀏覽
// MemVO memVO1= new MemService().getOneMem("M000001");
// session.setAttribute("memVO", memVO1);
String brows_courid= request.getParameter("cour_id");
if (brows_courid==null){
	brows_courid=((CourlistVO)session.getAttribute("brows_courlistVO")).getCour_id();
}
System.out.print("oneCourlist"+brows_courid);
CourlistService courlistSvc=new CourlistService(); 
// CourlistVO courlistVO1=courlistSvc.getOneCourlist(brows_courid);
// request.setAttribute("courlistVO", courlistVO1);
///end

///取出值
// CourlistVO courlistVO = (CourlistVO) request.getAttribute("courlistVO"); //CourlistServlet.java(Controller), 存入req的courlistVO物件
CourlistVO courlistVO=courlistSvc.getOneCourlist(brows_courid);
session.setAttribute("brows_courlistVO", courlistVO);//存在瀏覽頁面的, 之後改get parameter

MemVO memVO = (MemVO) session.getAttribute("memVO"); //取出登入會員VO

%>


<%
    CoachService coachService = new CoachService();
    CoachVO coachVO = coachService.getOneCoach(courlistVO.getCoa_id());
    
    MemService coamemSvc= new MemService();
    MemVO coamemVO= coamemSvc.getOneMem(coachVO.getMem_id());
    CourdiscountService courdiscountSvc=new CourdiscountService();
    CourdiscountVO courdiscountVO=courdiscountSvc.getOneCourdiscount("courdiscout:"+courlistVO.getCour_id());
    
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
  

  
  <!-- summernote-->
  <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js" integrity="sha384-b/U6ypiBEHpOf/4+1nzFpr53nxSS+GLCkfwBdFNTxtclqqenISfwAzpKaMNFNmj4" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
 
  <!-- summernote -->
  <script src="<%=request.getContextPath() %>/front_end/course/courlist/js/jquery.events.touch.js"></script> 
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/buttonfix.css">
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front_end/course/courlist/css/editpostform.css">
  <link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
	<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
  
  <style>  
    /*頁面設定*/

    body {
      overflow-x: hidden;
    }
  </style>
  
    <!-- navbar setting -->
  <style type="text/css">

   a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
  }
  </style>
  <style type="text/css">
/* * { */
/*   box-sizing: border-box; */
/*   margin: 0; */
/*   padding: 0; */
/* } */

.countdowndiv{
 
  
}
 p{
      font-family: Montserrat, Arial, "微軟正黑體", "Microsoft JhengHei" !important;
    }



.countdown {
  display: inline-block;
  font-size: 9px;
  list-style-type: none;
  padding: 0.7em; 
  border:0.8px dotted rgba(249, 249, 249, 0.1);
 
/*   text-transform: uppercase; */
}

li span {
  display: block;
/*   font-size: 4.5rem; */
}

.imgcourlist {
	-webkit-filter: grayscale(30%); /* Safari */
	filter: grayscale(30%);
	opacity:0.9;
}

/* buybtn */
 .buyit{
  background-color:rgba(18, 187, 173,0.4);
}

/* reportbtn */

.reportbtn{
   background-color:rgba(247, 6, 85,0.4);
}
 /*  大nav bar */
    .navbar-dark .navbar-nav .nav-link{
	color:rgba(255, 255, 255, 0.7)!important;
	font-weight:bold!important;
	
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
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/plan/My_Plan.jsp">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/AllCourlist.jsp">Course</a>
          </li>
         
          <jsp:useBean id="coachSvc" scope="page" class="com.coach.model.CoachService" /><jsp >
          <c:if test="${memVO!=null}">
	          <li class="nav-item mx-2 btn-lg dropdown" >
	            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">${memVO.mem_name}
	              <i class="fa fa-caret-down dropbtn"></i>
	            </a>
	            <div class="dropdown-content" id="myDropdown">
	               <a href="<%=request.getContextPath() %>/front_end/post/listAllPostByMem09.jsp"><i class="fa fa-file "><font class="fontstyle">&nbsp&nbsp個人頁面</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/plan/My_Plan_myself.jsp"><i class="fa fa-calculator"><font class="fontstyle">&nbsp&nbsp計畫</font></i></a>
	              <a href="#"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/course/purchcour/page/purchcour.jsp"><i class="fa fa-film" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp課程</font></i></a>
	              <a href="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp"> <i class="fa fa-hand-spock-o" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp活動</font></i></a>
	<!--               <a href=""><i class="fa fa-file">&nbsp&nbsp貼文</i></a> -->
	              <a href="<%=request.getContextPath() %>/front_end/calendar/page/Calendar.jsp"><i class="fa fa-check" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp行事曆</font></i></a>
	               
	               <c:if test="${coachSvc.getOneCoachByMemId(memVO.mem_id)!=null}">
	               	<a href="<%=request.getContextPath() %>/front_end/course/coach/page/coach.jsp"><i class="fa fa-sticky-note"><font class="fontstyle">&nbsp&nbsp教練管理</font></i></a>
	               </c:if>
	              <a href="<%=request.getContextPath() %>/front_end/mem/updateMember/updateMember.jsp"><i class="fa fa-address-card" aria-hidden="true"><font class="fontstyle">&nbsp&nbsp會員資料</font></i></a>
	              <a href="<%=request.getContextPath() %>/mem/mem.do?action=loggedout"><font class="fontstyle">登出</font></a>
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
  <div class="align-items-center d-flex section-fade-in-out" style="background-image: url(<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>);">
    <div class="container">
      <div class="row">
        <div class="col-md-12 text-md-left text-center align-self-center my-5" style="height:20rem;"> </div>
      </div>
    </div>
  </div>
  
    <!-- 主頁圖(圖片) -->
  <div class="pb-3 text-white">
    <div class="container">
      <div class="row">
        <div class="col-md-7 pr-5 text-md-left text-center align-self-center my-5">
        
          <h3><%=courlistVO.getCname()%><br> </h3>
          <div class="text-md-right pr-2"><p><i class="fas fa-star"></i> &nbsp; 4.5</p></div>
          <div>
<%--           <p class="coach_text_short"><%=coachVO2.getCoa_text()%></p> --%>
          <p class="coach_text_short"><%=courlistVO.getCour_text()%></p>
              <script>
             	 $(document).ready(function() {
            	    var len = 100; // 超過50個字以"..."取代
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
         
          <a class="btn btn-sm btn-primary buyit" href="<%=request.getContextPath()%>/front_end/course/purchcour/page/purchcourform.jsp?localhref=localhref" class="btn btn-lg btn-primary mx-1">Buy It</a>
          <a href="#" data-toggle="modal" data-target="#idModal" class="btn btn-sm btn-secondary m-1 reportbtn">Report<br></a>
          
          
<<<<<<< HEAD
    
=======
    <!-- 課程檢舉燈箱 -->
	<div class="modal fade" id="idModal" tabindex="-1" role="dialog"
		aria-labelledby="idModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="center modal-title" id="exampleModalLongTitle">課程檢舉</h4>
					<button type="button" class="close cancel" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="false">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="from-group mx-auto">
							<c:if test="${not empty errorMsgs}">

								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color: red">${message}</li>
									</c:forEach>
								</ul>
							</c:if>
						</div>
					</div>
					<form METHOD="post" action="<%=request.getContextPath()%>/coursereport/coursereport.do">
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text">會員信箱</span>
							</div>
							<input value="${memVO.mem_email }" type="email" name="Email" class="form-control"
								aria-label="Large" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>

						<div class="input-group-lg">
							<div class="input-group-prepend">
							<span class="input-group-text">檢舉項目</span>
							<select name= "reportItem">
								<option value="CRN1">課程內容不當</option>
								<option value="CRN2">課程收費不當</option>
								<option value="CRN3">其它</option>
							</select>
							</div>
						</div>
						<br>

						<div class="input-group-lg">
							<label style="font-size: 150%">狀況敘述 :</label>
							<textarea class="form-control" name="courrepText"
								style="height: 300px"></textarea>
						</div>
						<br>
						<div class="modal-footer">
							<input type="hidden" name="action" value="addReport">
							<button type="submit" class="btn btn-primary" id="regSend">送出</button>
							<button type="button" class="btn btn-secondary cancel"
								data-dismiss="modal">取消</button>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
      
>>>>>>> 1f8d9a29f02623ca551e31f99ebc9e430fe0d98a
      
      <!--  discount -->

        <div class="mt-2 text-secondary" id="countdowntitle"><i class="fas fa-bullhorn"></i>&nbsp;限時<%=courdiscountVO.getFinaldiscount()%>折</div>
         <div class="col-6 pl-2 mb-2 pt-1 countdowndiv ">
         
<%--          <c:if test="${not empty courdiscountSvc.getOneCourdiscount('courdiscout:'+brows_courlistVO.cour_id)}"> --%>
          
          <ul id="ulcountdown">
           
		    <li class="countdown"><span class="text-center" id="days"></span>Days</li>
		    <li class="countdown"><span class="text-center" id="hours"></span>Hour</li>
		    <li class="countdown"><span class="text-center" id="minutes"></span>Mins</li>
		    <li class="countdown"><span class="text-center" id="seconds"></span>Secs</li>
		  </ul>
<%-- 		</c:if> --%>
<!--   discount -->
 
  </div>
  <!--   discount -->

<%if(courdiscountVO.getDiscountcour_id ()==null){ 
System.out.println("courdiscountVO.getDiscountcour_id()="+courdiscountVO.getDiscountcour_id());
%>    <script type="text/javascript"> 
        
        $(document).ready(function(){
        	$("#ulcountdown").hide();
        	$("#countdowntitle").hide();
        	
        	});
    
</script>
<%} %>
<!--   discount -->
 <script type="text/javascript">
 $(document).ready(function(){ 
		const second = 1000,
		      minute = second * 60,
		      hour = minute * 60,
		      day = hour * 24;

		let countDown = new Date('<%=courdiscountVO.getExpiredateval()%>').getTime(),
		                                                             
		    x = setInterval(function() {

		      let now = new Date().getTime(),
		          distance = countDown - now;

		      	document.getElementById('days').innerText = Math.floor(distance / (day)),
		        document.getElementById('hours').innerText = Math.floor((distance % (day)) / (hour)),
		        document.getElementById('minutes').innerText = Math.floor((distance % (hour)) / (minute)),
		        document.getElementById('seconds').innerText = Math.floor((distance % (minute)) / second);
		      
		      //do something later when date is reached
		      //if (distance < 0) {
// 		       clearInterval(x);
		      //  'IT'S MY BIRTHDAY!;
		      //}

		    }, second)

 });
    </script>

 <!--   discount -->   

         
        
        </div>
        <div class="col-md-5  align-self-center">
          <img class="img-fluid d-block mx-auto align-baseline imgcourlist" style="border-radius:10px" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>"></div>
      </div>
    </div>
  </div>
  
    <!-- 分頁頁籤 -->
  <div class="container containerHrT " id="jys">
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
        <!-- 第一個按鈕 -->
        <ul class="nav navbar-nav">
          <li class="nav-item cournav">
            <a class="nav-link cournav" href="" data-target="#tabone" data-toggle="tab">
              <i class="fa fa-user"></i> &nbsp; Coach &nbsp;</a>
          </li>
          <!-- 第二個按鈕 -->
          <li class="nav-item cournav">
            <a class="nav-link cournav" href="" data-target="#tabtwo" data-toggle="tab">
              <i class="fa fa-bookmark" aria-hidden="true"></i>&nbsp; Announcement &nbsp;</a>
          </li>
          <!-- 第三個按鈕 -->
          <li class="nav-item cournav">
            <a class="nav-link cournav" href="" data-target="#tabthree" data-toggle="tab">
              <i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; Information&nbsp;</a>
          </li>
         <!-- 第四個按鈕 -->
          <li class="nav-item cournav">
            <a class="nav-link cournav" href="<%=request.getContextPath()%>/front_end/course/courlist/courunit.jsp?courpageloc=tabfour&localhref=localhref" >
              <i class="fa fa-film" aria-hidden="true"></i>&nbsp; Course Unit &nbsp; </a>
          </li>
          <!-- 第五個按鈕 -->
          <li class="nav-item cournav">
            <a class="nav-link cournav" href="<%=request.getContextPath()%>/front_end/course/courboar/page/maincourboar.jsp?courpageloc=tabfive&localhref=localhref" >
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
  
  
  <%
  
  String courpageloc=request.getParameter("courpageloc");
	if(courpageloc!=null){
	String courpagelocId="#"+courpageloc;
	
	%>
	<script>
	 $(document).ready(function() {
      
        $("<%=courpagelocId%>").addClass('show active');
    
	 });
    </script>
 <% }%>
 
 <c:if test="${localhref!=null}">
			
        <script>

           $(document).ready(function(){       
           $('html,body').animate({scrollTop:$('#jys').offset().top}, 800); 
           }); 
        </script>
</c:if>

<c:if test="${param.localhref!=null}">
			
	<script>
    window.onload=function(){
    	location.hash="#jys";
    	console.log(location.href);
    };
           
 </script>
</c:if>
 
 
  
  <%-- 錯誤表列 --%>
<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<font style="color:red">請修正以下錯誤:</font> -->
<!-- 	<ul> -->
<%-- 		<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>


  <div class="container containerHrB ">
    <hr> </div>
    <!-- 分頁 -->
   <div class="tab-content mt-2">
    <div class="tab-pane fade show" id="tabone" role="tabpanel">
      <div class="py-5">
        <div class="container">
          <div class="row mb-5">
            <div class="col-md-7">
              <h2 class="text-primary text-md-left">  &nbsp; <%=coamemVO.getMem_name()%>  &nbsp;  <br> </h2>
              <p class="text-md-left pr-5"><%=coachVO.getCoa_text()%></p>
            </div>
            <div class="col-md-5">
            <div class="col-md-10 offset-md-1 ">
         	  <img class="img-fluid d-block w-100" style="border-radius:10px" alt="Card image"
		  src="<%=request.getContextPath()%>/coach/Coach_DBGifReader.do?coa_id=<%=courlistVO.getCoa_id()%>"> </div>
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
              <h2 class="text-primary text-md-left"><i class="fa fa-bookmark" aria-hidden="true"></i>&nbsp; 課程公告 &nbsp;
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
 <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--><!--  單元--><!--  單元--><!--  單元--><!--  單元-->
 
<!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--><!--  單元--><!--  單元--><!--  單元--><!--  單元-->
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
<!--   <script src="https://code.jquery.com/jquery-3.2.1.js"></script> -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<!-- Script: Smooth scrolling between anchors in a same page -->
  <script src="js/smooth-scroll.js"></script> 
<!--summernote-->
  <script src="js/summernotecutom.js"></script>
  <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
  <script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
  
  <!-- 註冊失敗,打開燈箱 -->
  	<c:if test="${openModal!=null}">
		<script>
    		 $("#idModal").modal({show: true});
        </script>
	</c:if>

	<script>
   $(function() {
       $(".cancel").click(function() {
            $(location).attr('href', '<%= request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?cour_id=${brows_courlistVO.getCour_id()}&courpageloc=tabone');
							});
		});
		var width = document.body.offsetWidth;
		$(function() {
			$(window).resize(function() {
				$("#errorUL").css("padding-left", "2000 px")
			})
		});
	</script>
	
	<!-- 課程檢舉燈箱 -->
	<div class="modal fade" id="idModal" tabindex="-1" role="dialog"
		aria-labelledby="idModal" aria-hidden="true">
		<div class="modal-dialog modal-dialog-centered" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h4 class="center modal-title" id="exampleModalLongTitle">課程檢舉</h4>
					<button type="button" class="close cancel" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="false">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<div class="row">
						<div class="from-group mx-auto">
							<c:if test="${not empty errorMsgs}">

								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color: red">${message}</li>
									</c:forEach>
								</ul>
							</c:if>
						</div>
					</div>
					<form METHOD="post" action="<%=request.getContextPath()%>/coursereport/coursereport.do">
						<div class="input-group input-group-lg">
							<div class="input-group-prepend">
								<span class="input-group-text">會員信箱</span>
							</div>
							<input value="${param.regEmail }" type="email" name="Email" class="form-control"
								aria-label="Large" aria-describedby="inputGroup-sizing-sm">
						</div>
						<br>

						<div class="input-group-lg">
							<div class="input-group-prepend">
							<span class="input-group-text">檢舉項目</span>
							<select name= "reportItem">
								<option value="CRN1">課程內容不當</option>
								<option value="CRN2">課程收費不當</option>
								<option value="CRN3">其它</option>
							</select>
							</div>
						</div>
						<br>

						<div class="input-group-lg">
							<label style="font-size: 150%">狀況敘述 :</label>
							<textarea class="form-control" name="courrepText"
								style="height: 300px"></textarea>
						</div>
						<br>
						<div class="modal-footer">
							<input type="hidden" name="action" value="addReport">
							<button type="submit" class="btn btn-primary" id="regSend">送出</button>
							<button type="button" class="btn btn-secondary cancel"
								data-dismiss="modal">取消</button>

						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
      


</body>
</html>