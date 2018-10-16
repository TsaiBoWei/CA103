<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.courlist.model.*"%>
<%@ page import="com.courunit.model.*"%>
<%@ page import="com.purchcour.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.watchedhr.model.*"%>
<%@ page import="com.coach.model.*"%>
<%
///模擬登入與瀏覽
// MemVO memVO1= new MemService().getOneMem("M000001");
// session.setAttribute("memVO", memVO1);
// CourlistService courlistSvc=new CourlistService(); 
// CourlistVO courlistVO1=courlistSvc.getOneCourlist("COUR000003");
// request.setAttribute("courlistVO", courlistVO1);
///end

///取出值
CourlistVO courlistVO = null; //CourlistServlet.java(Controller), 存入req的courlistVO物件
// session.setAttribute("brows_courlistVO", courlistVO);//存在瀏覽頁面的

if(request.getParameter("cour_id")==null){
	courlistVO =(CourlistVO)session.getAttribute("brows_courlistVO");
	session.setAttribute("brows_courlistVO", courlistVO);
}else{
	String brows_cour_id=request.getParameter("cour_id");
	CourlistService courlistSvc=new CourlistService();
	courlistVO=courlistSvc.getOneCourlist(brows_cour_id);
	session.setAttribute("brows_courlistVO", courlistVO);
};
CoachService coachSvc=new CoachService(); 
CoachVO ifmemcoachVO=null;
MemVO memVO=null;
if((MemVO) session.getAttribute("memVO")!=null){
	memVO = (MemVO) session.getAttribute("memVO"); //取出登入會員VO
	if( coachSvc.getOneCoachByMemId(memVO.getMem_id())!=null){
	ifmemcoachVO= coachSvc.getOneCoachByMemId(memVO.getMem_id());//if coach
	};
};
// System.out.print("courunit"+courlistVO.getCour_id());

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
  <!-- ASHLEY -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <!-- end ASHLEY -->
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/course/courlist/css/Course.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/course/courlist/css/font.css">
  <!-- ASHLEY -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/course/courlist/css/courunit.css">
  <!-- end ASHLEY -->
	
  
  <!-- lightcase settings -->
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
   
  <!-- include summernote css/js -->
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote-lite.js"></script>
   <!-- ASHLEY fafaicon -->
  <link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous"> 
	<!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>

  <!-- ASHLEY --> 
  
  
     
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
         
          <jsp:useBean id="coachSvc1" scope="page" class="com.coach.model.CoachService" /><jsp >
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
	               
	               <c:if test="${coachSvc1.getOneCoachByMemId(memVO.mem_id)!=null}">
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
          <a href="<%=request.getContextPath()%>/front_end/course/purchcour/page/purchcourform.jsp" class="btn btn-lg btn-primary mx-1">Buy It</a>
        </div>
        <div class="col-md-5  align-self-center" >
          <img class="img-fluid d-block mx-auto align-baseline" alt="Card image"
          src="<%=request.getContextPath()%>/courlist/Courlist_DBGifReader.do?cour_id=<%=courlistVO.getCour_id()%>"></div>
      </div>
    </div>
  </div>
    <!-- 分頁頁籤 -->

  <div class="container containerHrT " id="jys" >
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent&localhref=localhref">
        <!-- 第一個按鈕 -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?courpageloc=tabone&localhref=localhref" >
              <i class="fa fa-user"></i> &nbsp; Coach &nbsp;</a>
          </li>
          <!-- 第二個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?courpageloc=tabtwo&localhref=localhref">
              <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; Announcement &nbsp;</a>
          </li>
          <!-- 第三個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/oneCourlist.jsp?courpageloc=tabthree&localhref=localhref"  >
              <i class="fa fa-info-circle" aria-hidden="true"></i>&nbsp; Information&nbsp;</a>
          </li>
         <!-- 第四個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courlist/courunit.jsp?courpageloc=tabfour&localhref=localhref"  id="tabfourlink">
              <i class="fa fa-film" aria-hidden="true"></i>&nbsp; Course Unit &nbsp; </a>
          </li>
          <!-- 第五個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/front_end/course/courboar/page/maincourboar.jsp?courpageloc=tabfive&localhref=localhref" id="tabfivelink" >
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
	String courpageloclinkId="#"+courpageloc+"link";
	
	%>
	<script>
	 $(document).ready(function() {
      
        $("<%=courpagelocId%>").addClass('show active');
        $("<%=courpageloclinkId%>").css({"color": "#12bbad", "border-bottom": " 0.8px solid #12bbad"});

    
	 });
    </script>
 <% }%>
  
 
  <div class="container containerHrB" >
    <hr> </div>
    <!-- 分頁 -->
    <!-- 分頁 -->
   
 <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--><!--  單元--><!--  單元--><!--  單元--><!--  單元-->
 <%!
 public String timeformater(Double length){
     String time=null;
     String totalhour=null;
	 String totalmm=null;
	 String totalss=null;
     Double h=(length/3600);
	 Double m=(length%3600)/60;
	 Double s=(length%3600)%60;

	 
	 if(h.intValue()==0||h.intValue()<10){
		 totalhour="0"+h.intValue();
	 }else{
		 totalhour=Integer.toString(h.intValue());
	 }
	 
	 if(m.intValue()==0||m.intValue()<10){
		 totalmm="0"+m.intValue();
	 }else{
		 totalmm=Integer.toString(m.intValue());
	 }
	 
	 if(s.intValue()==0||s.intValue()<10){
		 totalss="0"+s.intValue();
	 }else{
		 totalss=Integer.toString(s.intValue());
	 }
     time=totalhour+":"+totalmm+":"+totalss;
     return time;
        }
 
 
 %>
 
 
 <%
 

//  pageContext.setAttribute("courlistVO",courlistVO);
 CourunitService courunitSvc=new CourunitService();
 
 List<CourunitVO> unitlist=courunitSvc.getCourUnit(courlistVO.getCour_id());
//  pageContext.setAttribute("unitlist",unitlist);


 Double totalCourLength=courunitSvc.getCourTotalLength(courlistVO.getCour_id());
 String totalhour=timeformater(totalCourLength);
 

 %>

 
     <div class="tab-pane fade" id="tabfour" role="tabpanel">
      <div class="py-5 text-white">
        <div class="container">
     <!-- courunite List-->
      <div class="row purlistrow">
        <div class="col-md-8 pb-5 offset-md-2">
          <ul class="rolldown-list" id="myList">
            <!--title -->
            <li>
              <div class="col_md_1_list pt-2">
                <h3 >
                  <i class="fa fa-film" aria-hidden="true"></i>
                </h3>
              </div>
              <div class="col_md_2_list mt-2 ">
                <h3 class="text-primary"> 課程單元內容</h3>
                
                <p>Totoal Duration&nbsp;· &nbsp;<%=(totalCourLength==0.0)? "00:00:00" : totalhour%>  </p>
                <c:if test="<%=(ifmemcoachVO!=null)&&( courlistVO.getCoa_id().equals(ifmemcoachVO.getCoa_id()))%>">
                <span data-target="#unitaddampleModal" data-toggle="modal"  style="cursor:pointer; ">
                  <p class="h5 text-right hovereditunit" id="uploadalesson" > Add A Lesson
                    <i class="far fa-plus-square"></i>
                  </p>
                </span>
                </c:if>	
              </div>
            </li>
            <!--title -->
            <!-- unit -->
           
            <% 
            
         
            
            
             for (int i=0; i<unitlist.size();i++){
            	CourunitVO courunitVO=unitlist.get(i);
                List<String> srclist=new ArrayList();//src用
          	 
            	Double unitLength = courunitVO.getCour_length();
            	String unitLeng=timeformater(unitLength);
            	 
            	String view="view"+i;
            	String viewClass=".view"+i;
            	
            	String src=(request.getContextPath())+"/courunit/Cour_filmReader4.do?cour_unit_id="+(courunitVO.getCour_unit_id());            
            	srclist.add(src);
            	
            	
            	
            	
            	
            %>
            
            <li class="courunitli">
              <div class="row px-2 unitlist">
                <div class="col-9  align-self-center px-0 ">
                  <span class=" px-0 spanunit mr-1 align-self-center   ">&nbsp;</span>
                  <a href="#" class="text-light <%=view%>" data-target="#vieweampleModal" data-toggle="modal" style="cursor:pointer;"
                   > &nbsp;Unit &nbsp;<%=i+1%> &nbsp;·&nbsp;<%=courunitVO.getCu_name()%>&nbsp;
                    <i class="far fa-play-circle "></i>
                  </a>
                </div>
                <div class="col-3 px-0 text-right align-self-center">
                  <span class=" px-1 editcourunit "><%=unitLeng%>&nbsp;&nbsp;
                    <i class="far fa-edit hovereditunit" style="cursor:pointer;"></i>
                  </span>
                </div>
              </div>
            </li>
            <!-- unit -->
            
             
           <% 
             
             //會員登入看影片
         	String crorder_id=null;
            Double watchedhr=0.0;
         	if(memVO!=null){
	         	PurchcourService purchcourSvc=new PurchcourService();
	            crorder_id=purchcourSvc.getCrorder_idByCrMemId(courlistVO.getCour_id(), memVO.getMem_id());
             
	             if (crorder_id!=null){
	         	
	              WatchedhrService watchedhrSvc=new WatchedhrService();
	              watchedhr=watchedhrSvc.getWatched_hr(crorder_id, courunitVO.getCour_unit_id());
	              
                  if (watchedhr!=null){
            	  pageContext.setAttribute("unitwatchedhr",watchedhr); }
              
         	    }
	             
         	}
              
           %>


            
<!--        會員登入看影片 -->
            <%if(crorder_id!=null){ %>
            <script>
			            
                   
  
					 $(document).ready(function() {
						$("<%=viewClass%>").click(function() {
													           

                                  $("#viewTitle").text("Unit <%=i+1%> · <%=courunitVO.getCu_name()%>");
                                  $("#updaterecordcrun_id").val("<%=courunitVO.getCour_unit_id()%>");
                          						  
								   $("#viewcourunit").attr("src","<%=src%>");
								 

                                  $("#indexforbackfor").val("<%=i%>");
                                  $("#updaterecordcrorder_id").val("<%=crorder_id%>");
                                  $("#hiddenwatchhr").val("${unitwatchedhr}");
                                  var unitLength=<%=unitLength%>;
                                  var watchedhr=<%=watchedhr%>;
                 	              if(unitLength>watchedhr){ 
	               	            	  if ($("#hiddenwatchhr").val()!=0 && $("#hiddenwatchhr").val()!=null){
	                                  var r=confirm("接續上次觀看進度"+(Math.floor((${unitwatchedhr})/60))+"分"+(Math.floor((${unitwatchedhr})%60))+"秒?");
	               	            	    
	               	            	    if (r ==true){
	               	            	    	
	               	            	    	document.getElementById('viewcourunit').addEventListener('loadedmetadata', function() {
	                              	    	  this.currentTime = Math.floor(${unitwatchedhr});
	                              	    	  this.play();
	                              	     }, false);
	           
	               	            	    }
	               	            	
	               	            	  }

                              }    
 
                       	  });

					 });         
					  
					
		   </script>
		   
		   
            <%}else{%>
            <script>
           
            
	       	 $(document).ready(function() { 
	       		$("<%=viewClass%>").click(function () {
			
// 			    if ($(this).attr("disabled") == "disabled") {
			
// 			                event.preventDefault();
			
// 			            }


              $('#vieweampleModal').on('show.bs.modal', function (e) {
            	  if (!data) return e.preventDefault() 
              });
              alert("您尚未購買此課程");


			        });
			
			    });
	       	   
	            
// 	         }); 
          </script>  
                <%} %>
            <%} %>
             
           
           <!-- unit -->

          </ul>
          <button id="btnReload" style="visibility: hidden;">Reload</button>
        </div>
      </div>
      <!-- courunite List-->
				</div>
				</div>
			</div>
          
          
       
           
			
<!--lessoneditform-->
<!-- <FORM METHOD="post" -->
<%-- 				ACTION="<%=request.getContextPath()%>/courunit/courunit.do" --%>
<!-- 				name="lessoneditform" id="lessoneditform" enctype="multipart/form-data"> -->
  <div class="col-md-12 text-center">
    <div class="modal fade  mx-auto" aria-hidden="true" aria-labelledby="exampleModalLabel" id="unitaddampleModal" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-dialog-700" role="document">
        <div class="modal-content courboarqform">
          <div class="modal-header courboarmodalheader">
            <h4 class="modal-title text-primary" id="exampleModalCenterTitle" >Edit A Lesson</h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true" class="text-light cancel"><i class="fas fa-times cancel"></i></span>
            </button>
            
          </div>
          <FORM METHOD="post"
				ACTION="<%=request.getContextPath()%>/courunit/courunit.do"
				name="lessoneditform" id="lessoneditform" enctype="multipart/form-data">
          <div class="modal-body text-left">
            <div class="form-group text-white">
              <label>Title</label>
              <input type="text" name="cu_name" class="form-control courboarformtitle text-light" > </div>
            <div class="form-group mt-3 mb-1 ">
              <input type="file" name="videofile" id="videofile" class="input-file text-light" style="visibility: hidden;">
              <label for="videofile" class="btn btn-tertiary js-labelFile">
                
             
                <i class="icon fa fa-check"></i>
                <span class="js-fileName text-light">Upload a Video for Lesson</span>
              </label>
               <!--- if erroMsg --->
					<c:if test="${not empty errorMsgs}">
													
						<div class="errorMsgs my-3 px-0 text-secondary text-left"><i class="fas fa-exclamation-triangle"></i>&nbsp;Please note&nbsp;:&nbsp;<c:forEach var="message" items="${errorMsgs}">${message}&nbsp;</c:forEach></div>
			
					</c:if>
			    <!--- if erroMsg --->
               <div class=" courboarmodal courboarmodalfooter mb-2 pt-2 mt-3 text-right">
		        
		          <input type="hidden" id="cour_length" value="" name="cour_length">
		          <input type="hidden" id="cour_id" value="${brows_courlistVO.cour_id}" name="cour_id">
		          <input type="hidden" value="insert" name="action">
		          <button type="submit" class="btn btn-outline-primary unitaddsubmit">Save Changes</button>
              </div>
            </div>
          </div>
          </FORM>
           <div class="preview preview2 mb-2"></div>
            
        </div>
        
      </div>
    </div>
  </div>
<!-- </FORM> -->

<%-- <c:if test="<%=courlistVO.getCoa_id().equals(ifmemcoachVO.getCoa_id())%>"> --%>
<!-- 	<script> -->
<!-- // 			$(document).ready(function() { -->
<%-- 				<%System.out.println("courlistVO.getCoa_id().equals(ifmemcoachVO.getCoa_id())="+courlistVO.getCoa_id().equals(ifmemcoachVO.getCoa_id()));%> --%>
													           
<!-- // 					$("#uploadalesson").show(); -->
														   
<!-- // 						}); -->
<!--    </script> -->
						  
<%-- </c:if>	 --%>


<c:if test="${openaddunitform!=null}">
			<script>
			$(document).ready(function(){  
	    		 $("#unitaddampleModal").modal({show: true});
	    		 
			});
	        </script>
</c:if>

  <!--lessoneditform-->
   
  
  <!--VIEW-->
  <div class="col-md-12 text-center">
    <div class="modal fade mx-auto modal-view" aria-hidden="true" aria-labelledby="exampleModalLabel" id="vieweampleModal" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
      <div class="modal-dialog modal-dialog-view" role="document">
        <div class="modal-content courboarqformview">
          <div class="modal-header courboarmodalheaderview mt-3">
            <h4 class="modal-title text-light" id="viewTitle"></h4>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true" class="text-light cancelview"><i class="fas fa-times cancel"></i></span>
            </button>
          </div>
          <div class="modal-body text-left">
          <input type="hidden" id="updaterecordcrun_id" name="cour_unit_id" value="">
          <input type="hidden" id="updaterecordcrorder_id" name="crorder_id" value="">
          <input type="hidden" id="indexforbackfor" name="" value="">
          <input type="hidden" id="hiddenwatchhr" name="" value="">
          <video controls="controls" id="viewcourunit" width="900px" height="auto" preload="none" >
			  <source src="" type="video/mp4" />
			
		  </video>
            
          </div>
        </div>
       
<!--         <div class="modal-footer courboarmodal courboarmodalfooter"> -->
          
<!--         </div> -->
      </div>
    </div>
  </div>
 

  
  
  <!--updateform-->
  
   <script> 

             
           $(document).ready(function(){
				   
				    $("#viewcourunit").on(
				      "timeupdate", 
				      function(event){
				        onTrackedVideoFrame(this.currentTime, this.duration);
				      });
				  });
				  var maxcurrentTime=0;
				  function onTrackedVideoFrame(currentTime, duration){
				     
				      console.log(currentTime);
				      if (maxcurrentTime<currentTime){
				          maxcurrentTime=currentTime;
				      }
				      console.log("c="+currentTime);
				      console.log("m="+maxcurrentTime);
				  }  	
				  
				 
				  
				  $(document).ready(function() {
				        $(".cancelview").click(function() {
				        
				        	var cour_unit_id= $("#updaterecordcrun_id").val();
				        	var crorder_id= $("#updaterecordcrorder_id").val();
			        	
				        	$.ajax({
						        url:'<%=request.getContextPath()%>/courunit/GiveMeRecord.do',
						        method:'POST',
						        data:{
						           maxcurrentTime:maxcurrentTime,
						           cour_unit_id:cour_unit_id,
						           crorder_id:crorder_id
						        },

						     })
						     
						    
						     
						  })   
						  
		                 });
					
   
				 $(document).ready(function() {
				        $(".cancel").click(function() {
			           
				             $(location).attr('href', '<%=request.getContextPath()%>/front_end/course/courlist/courunit.jsp?courpageloc=tabfour');

				                 });
				 });
				       
	</script>
	
	
	
	      
	
	
<%-- 	       <c:if test="${localhref!=null}"> --%>
			
<!-- 		   <script> -->
<%-- <%-- 	    		 location.href="<%=request.getContextPath()%>${localhref}#jys"; --%> 
<!-- //            $(document).ready(function(){        -->
<!-- //            $('html,body').animate({scrollTop:$('#jys').offset().top}, 800);  -->
<!-- //            });  -->
<!--            </script> -->
<%-- 	        </c:if> --%>
	        
<%-- 	        <c:if test="${param.localhref!=null}"> --%>
			
<!-- 			<script> -->
<%-- 	<%-- 	    		 location.href="<%=request.getContextPath()%>${localhref}#jys"; --%>
<!-- // 	           $(document).ready(function(){        -->
<!-- // 	           $('html,body').animate({scrollTop:$('#jys').offset().top}, 800);  -->
<!-- // 	           }); -->
<!-- 	           </script> -->
<%-- 			 </c:if> --%>
<script>
    window.onload=function(){
    	location.hash="#jys";
    	console.log(location.href);
    };
           
 </script>
 
 
 
	      
			
 <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元--> <!--  單元-->

              
    <div class="tab-pane fade" id="tabfive" role="tabpanel">
      <div class="py-5 ">
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
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <!-- Script: Smooth scrolling between anchors in a same page -->
 
  <script src="<%=request.getContextPath()%>/js/smooth-scroll.js"></script> 
  <!-- ASHLEY -->
  <script src="<%=request.getContextPath()%>/front_end/course/courlist/js/courunit.js"></script> 
  <!-- end ASHLEY -->



</body>
</html>