<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %> 

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
<!-- 20181009 建廷 -->
<jsp:useBean id="eventsaveSvc" scope="page" class="com.eventsave.model.EventSaveService" />
   
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>listOneEvent.jsp</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- CSS dependencies -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <!--  self-defined css  -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>
  <!--For Modal-->
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
  
  <!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>		
 
  
  
  

 <style>  
  .eveImg{
  width:100%;
  }
   #eve_contentDiv,#eve_contentDiv ul,#eve_contentDiv ul li,#eve_contentDiv li,#eve_contentDiv span, #eve_contentDiv span span,#eve_contentDiv p,#eve_contentDiv div,#eve_contentDiv div p,#eve_contentDiv strong,#eve_contentDiv td{
  color:#efefef !important;
  background-color:#1f1f1f!important;
  font-size:20px!important;
  }
  
  #eve_locationP{
  font-size:20px;
  }
  #showElistCheck{
  
  font-size:20px;
  
  }
  
.evelistTable { font-size:20px}
   		
#countdown input{
background-color:transparent; 
border:0px; 
text-align:center;
}

.payinput{
background-color:#e1e1e1;
color:#10451b; 
font-weight:bold;

}

.navbar-dark .navbar-nav .nav-link{
color:rgba(255, 255, 255, 0.8)!important;
font-weight:bold!important;

}
 
</style>

<style type="text/css">
    #map { height: 400px; }

    #floating-panel {
        position: absolute;
        top: 10px;
        left: 25%;
        z-index: 5;
        background-color: #fff;
        padding: 5px;
        border: 1px solid #999;
        text-align: center;
        font-family:  "Montserrat","Arial","微軟正黑體","Microsoft JhengHei";
        line-height: 30px;
        padding-left: 10px;
    }

    #floating-panel {
        background: #fff;
        padding: 5px;
        font-family:  "Montserrat","Arial","微軟正黑體","Microsoft JhengHei";
        border: 1px solid #ccc;
        box-shadow: 0 2px 2px rgba(33, 33, 33, 0.4);
        display: none;
    }

     #right-panel {
     	 font-size: 18px;
        font-family:  "Montserrat","Arial","微軟正黑體","Microsoft JhengHei";
        line-height: 30px;
        margin-left: 0px;

      }

      #right-panel {
        height: 400px;	
        overflow-y: auto;
      }
      @media print {
        #right-panel {        	 
          float: none;
          width: auto;
        }
      }

      #mode,#start{
      	height:36px;
      	font-size: 20px;
      	color:black;
      	font-weight: bold;
      }
      strong,#routeBtn{
      	color:black;
      	font-size: 20px;
      	font-weight: bold;
      }

      .rpanel_div{
      	 padding-left: 0px;
      }
      
      #mode{
      	 font-family: 'FontAwesome', 'Second Font name';
      }

</style>

<!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>


</head>





<body class="text-center" onload="clock();return true">
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
	              <a href="<%=request.getContextPath()%>/front_end/friendlist/listfriendcomfirmed.jsp?perpageloc=friendlist#personalnav"><i class="fa fa-users " aria-hidden="true"><font class="fontstyle">&nbsp&nbsp好友</font></i></a>
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

  
  <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
  
  
  <!-- Cover -->
  <div class="align-items-center py-5 section-fade-in-out " id="coverfirstImg" style="background: url(&quot;<%=request.getContextPath() %>/front_end/event/eve/assets/conference/cover_marathon.png&quot;);"> </div>
  <div class="banner-div">
    <div class="container">
      <div class="row ">
        <div class="col-md-10 pt-3 text-left pl-0">
          <h1 class=" text-left">
            <span>${eveVO.eve_title} &nbsp;
              <button class="btn btn-sm " style="background:${sportTypeColor.get(eveVO.sptype_id)};color:white; font-weight:bold;">${sportTypeMap.get(eveVO.sptype_id)} </button>
            </span>
          </h1>
          <div class="m-1   pb-2">
            <span class="eveview">
            	<% 
            	   EventVO eveVO=(EventVO)request.getAttribute("eveVO");            	
            	   String eve_id=eveVO.getEve_id();           	   
            	 	int eveview=0;
            	   if((application.getAttribute(eve_id+"view"))==null){
            		   eveview=0;
            	   }else{
            		   eveview=(int)application.getAttribute(eve_id+"view");
            	   }
            	   System.out.println(eveview);
            	   application.setAttribute(eve_id+"view",++eveview);
            	%> 
            	瀏覽數 :<span><%=eveview %></span>&nbsp;&nbsp;
            	收藏數 :<span>10</span> &nbsp; </span>
            <span class="pull-right text-warning align-center" style="font-size:24px;"> 
              <form name="formnow" id="countdown">
				    報名截止倒數 :<input type="text" class="text-warning"name="dd" size=2 style="background-color:transparent; border:0px; text-align:center"> 天 <input 
				    type="text" class="text-warning" name="hh" size=1> 小時 <input class="text-warning" type="text" 
				    name="mm" size=1> 分 <input type="text" class="text-warning" name="ss" 
				    size=1> 秒
			 </form>
          </div>
          <DIV style="display:none;" id="ereg_endtime"><%=eveVO.getEreg_enddate() %></DIV>
                 
          <div>
         	 <img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
<!--              <img src="assets/eventpic/run/banner_maokong_run.jpg" style="height:100%;">  -->
		 </div>        
        </div>
        <div class="col-md-2">
          <div>
            <h4 class=" pt-5 mt-3">活動發起人</h4>
          </div>
          <div>
            <a href="">
              <img src="<%=request.getContextPath()%>/courboar/Mem_DBGifReader4.do?mem_id=${eveVO.mem_id}" style="height:100%;">
              <h5 class="p-1 pt-2">${memSvc.getOneMem(eveVO.mem_id).mem_name}</h5>
            </a>
          </div>
          <!-- 結束的活動 報名按鈕要改顯示評價 -->
          
          <jsp:useBean id="eveListSvc" scope="page" class="com.eventlist.model.EventlistService" />
          
          	<!-- 立即報名按鈕顯示條件:會員清單無資料.活動狀態可報名.非活動主辦人.在報名期間內 -->
		  	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)==null&&(eveVO.eve_status=='E2'||eveVO.eve_status=='E3')}"> 
		  		<c:if test="${memVO.mem_id!=eveVO.mem_id&&eveVO.ereg_enddate.getTime()>System.currentTimeMillis()&&eveVO.ereg_startdate.getTime()<System.currentTimeMillis()}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				    <input type="submit" value="立即報名" class="btn btn-lg btn-block btn-danger my-3 p-1"> 
				    <input type="hidden" name="action"      value="openAddElModal">
				    <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
				    <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			  		</FORM>
			  	</c:if>					
			</c:if>			
                
<!--           <a class="btn btn-lg btn-block btn-danger my-3 p-1" href="#">立即報名</a> -->
          <div class="d-flex align-self-center align-items-center justify-content-center">
          
          <!-- 活動收藏的按鈕    20181009完成  建廷 -->
          <c:if test="${memVO.mem_id!=eveVO.mem_id}">
				<c:if test="${eventsaveSvc.getOneEventSave(memVO.mem_id,eveVO.eve_id)==null}">
			        <form method="post" action="<%=request.getContextPath()%>/eventsave/eventsave.do">
					    <input type="submit" class="btn  m-1 btn-outline-success btn-lg" value="收藏">
					    <input type="hidden" name="mem_id" value="${memVO.mem_id}">
					    <input type="hidden" name="eve_id" value="${eveVO.eve_id}">
						<input type="hidden" name="es_status" value="ESS1">
						<input type="hidden" name="action" value="insert">
					</form>
				</c:if>
				<c:if test="${eventsaveSvc.getOneEventSave(memVO.mem_id,eveVO.eve_id)!=null}">
				        <input type="submit" class=" btn-success btn-lg"  value="已收藏">
				</c:if>
		</c:if>			
				
				
<!--             <a href="#" class="btn btn-sm m-1 btn-outline-success">收藏 </a> -->

          </div>
        </div>
      </div>
      <div class="row pt-1">
        <div class="col-md-6  px-3  text-left"> </div>
        <div class="col-md-6">
          <h3 class="text-right text-warning m-1"> </h3>
        </div>
      </div>
    </div>
  </div>
  <div class="container containerHrT ">
    <hr> </div>
  <nav class="navbar navbar-expand-md bg-dark-cutom navbar-dark p-0" id="profile-navbar">
    <div class="container">
      <div class="collapse navbar-collapse text-right justify-content-center marignBun" id="navbar3SupportedContent">
        <!-- 第一個按鈕 -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabone" data-toggle="tab">
              <i class="fa fa-info-circle"></i> &nbsp; 活動資訊 &nbsp;</a>
          </li>
<!--           第二個按鈕 -->
<!--           <li class="nav-item"> -->
<!--             <a class="nav-link" href="" data-target="#tabtwo" data-toggle="tab"> -->
<!--               <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; 最新消息 &nbsp;</a> -->
<!--           </li> -->
          <!-- 第三個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabthree" data-toggle="tab">
              <i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; 報名查詢&nbsp;</a>
          </li>
          <!-- 第四個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfour" data-toggle="tab">
              <i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp; 交通資訊 &nbsp; </a>
          </li>
          <!-- 第五個按鈕 -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfive" data-toggle="tab">
              <i class="fa fa-quora" aria-hidden="true"></i> &nbsp; 問題諮詢 &nbsp; </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container containerHrB ">
    <hr> </div>
  <!-- 分頁 -->
  <div class="tab-content mt-2 px-5">
    <div class="tab-pane fade show active" id="tabone" role="tabpanel">
      <div class="container">
        <div class="row d-block text-left px-5">
          <h3 class="py-1">活動日期 :
            <div>
            	<fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy-MM-dd HH:mm "/>~			
				<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy-MM-dd HH:mm"/>           
            </div>
          </h3>
          <h3 class="py-1">報名時間 :
            <div>
            	<fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy-MM-dd "/>~					
				<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy-MM-dd"/>
            </div>
          </h3>
          <h3 class="py-1">活動成行人數 :
            <span>${eveVO.estart_limit}</span>人</h3>
          <h3 class="py-1">報名費用 :
            <span>
	            <c:if test="${eveVO.eve_charge==0}">
				    免費
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${eveVO.eve_charge}元/人
				</c:if>		          
            </span></h3>
          <h3 class="py-1">活動介紹 : </h3>
          <div class="px-4" id="eve_contentDiv" >${eveVO.eve_content=='null'?'':eveVO.eve_content} </div>
        </div>
      </div>
    </div>
<!--     <div class="tab-pane fade" id="tabtwo" role="tabpanel"> -->
<!--       <p class="">Tab pane two. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p> -->
<!--     </div> -->
    <div class="tab-pane fade" id="tabthree" role="tabpanel">
      <div class="container">
        <div class="row d- text-left">
          <div class="col-md-3"></div>
          <div class="col-md-3 offset-md-1" id="evelistCheck">

         	 <c:if test="${memVO==null}">
		            <h3>請輸入您的帳號 :<input type="text" name="mem_account" id="mem_account"></h3>
		            <h3>請輸入您的密碼 :<input type="password" name="mem_password" id="mem_password"></h3>
		            <div class="text-center">
		            	<button class="btn btn-lg  btn-info my-3 p-2" onClick="getEvelist();">查詢</button>
	            	</div>
	            
             </c:if>
           </div>
            
         
          <div class="col-md-3"></div>
          <div class="col-md-3"></div>
          <div  class="col-md-12 text-center" id="showElistCheck"> 
          	<c:if test="${(eveVO.mem_id==memVO.mem_id)}">
          		<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >
          			<button type="ssubmit" class="btn">查看活動報名狀態</button>
          			<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
          			<input type="hidden" name="action" value="getEvelists_By_EVE">
          		</FORM>
          	</c:if>         		
          	<c:if test="${(memVO!=null)&&(eveVO.mem_id!=memVO.mem_id)}">
             	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)==null }">
             		<h3>目前無活動清單資料</h3>
             	</c:if>
             	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)!=null }">
             		<table class='evelistTable text-left' align='center'>
             			<tr><th>姓名</th><td>&nbsp&nbsp ${memVO.mem_name}</td></tr>
             			<tr><th>活動名稱</th><td>&nbsp&nbsp ${eveVO.eve_title}</td></tr>
             			<tr><th>活動付款金額</th><td>&nbsp&nbsp ${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evepay_amount}元</td></tr>
             			<tr><th>活動付款截止日</th><td>&nbsp&nbsp ${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evepay_deadline==null?'無':eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evepay_deadline}</td></tr>
             			<tr><th >活動清單狀態</th><td>&nbsp&nbsp ${eveListStatusMap.get((eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evelist_status))}</td></tr>             		
     				</table>        	
             	</c:if>
          	 </c:if>		         
          </div> 
          <div class="col-md-3 offset-md-5"  >
		      <button class="btn btn-lg  btn-info my-3 p-2 " style="display:none;" id="reshowElBtn" onClick="reshowElCheck();">重新查詢</button>
	      </div>
        
        </div>
      </div>
    </div>
    
    <script>
    	
    
    
    </script>
      
    <div class="tab-pane fade" id="tabfour" role="tabpanel">
      <div class="container text-left px-5">
        <div class="row">
          <div class="col-md-12">
            <h3>活動地點 : </h3>
            <p class="px-4" id="eve_locationP">${eveVO.eve_location}</p>
          </div>
        </div>
        <h3 class="">活動地圖</h3>
        <div class="row">
			<div class="col-md-9">
				<div id="floating-panel">
				  <strong>路線查詢-</strong>
				      <strong>從</strong>
				      <input type="text"  size="8" value="目前位置" id="start">
				      <select id="mode" >
				      <option value="DRIVING">&#xf1b9</option>
				      <option value="WALKING" style="font-size: 30px;">&#x1f6b6</option>
				      <!-- <option value="BICYCLING">腳踏車</option> -->
				      <option value="TRANSIT">&#xf238</option>
				    </select>
				    <button type="button" id="routeBtn">GO</button>
				</div>				
				<div id="map"></div>
			</div>
			<div class="col-md-3 rpanel_div">
				<div id="right-panel"></div>
			</div>
		</div>
      </div>
    </div>
    
    <div class="tab-pane fade " id="tabfive" role="tabpanel">
      <div class="container px-5">
        <div class="row d-block text-left">
          <div class="col-md-6 offset-md-3" >
            <h3>連絡電話 : ${eveVO.econtact_info} </h3>
            <h3>連絡信箱 : ${memSvc.getOneMem(eveVO.mem_id).mem_email}</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
<!--   <div class="py-5" id="speakers"> -->
<!--     <div class="container "> -->
<!--       <div class="row "> -->
<!--         <div class="col-12 col-md-12"> -->
<!--           <h2>專屬推薦活動</h2> -->
<!--           <div class="tab-content mt-2"> -->
<!--             <div class="tab-pane fade" id="tabthree" role="tabpanel"> -->
<!--               <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p> -->
<!--             </div> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--     <div class="container"> -->
<!--       <div class="carousel slide" data-ride="carousel" id="bs4-multi-slide-carousel"> -->
<!--         <div class="carousel-inner"> -->
<!--           <div class="carousel-item active"> -->
<!--             <div class="row mr-4 ml-4"> -->
<!--               <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  "> -->
<!--                 <a href="#"> -->
<%--                   <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300"> --%>
<!--                   <div class="carousel-caption img-tip"> -->
<!--                     <h1>Event title1</h1> -->
<!--                     <h4>about the Event!</h4> -->
<!--                   </div> -->
<!--                 </a> -->

<!--                 <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev"> -->
<!--                   <span class="carousel-control-prev-icon"></span> -->
<!--                 </a> -->
<!--               </div> -->
<!--               <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  "> -->
<!--                 <a href="#"> -->
<%--                   <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300"> --%>
<!--                   <div class="carousel-caption img-tip"> -->
<!--                     <h1>Event title2</h1> -->
<!--                     <h4>about the Event!</h4> -->
<!--                   </div> -->
<!--                 </a> -->
<!--               </div> -->
<!--               <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  "> -->
<!--                 <a href="#"> -->
<%--                   <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300"> --%>
<!--                   <div class="carousel-caption img-tip"> -->
<!--                     <h1>Event title3</h1> -->
<!--                     <h4>about the Event!</h4> -->
<!--                   </div> -->
<!--                 </a> -->
          
<!--                 <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next"> -->
<!--                   <span class="carousel-control-next-icon"></span> -->
<!--                 </a> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--           <div class="carousel-item"> -->
<!--             <div class="row mr-4 ml-4"> -->
<!--               <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  "> -->
<!--                 <a href="#"> -->
<%--                   <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300"> --%>
<!--                   <div class="carousel-caption img-tip"> -->
<!--                     <h1>Event title4</h1> -->
<!--                     <h4>about the Event!</h4> -->
<!--                   </div> -->
<!--                 </a> -->
               
<!--                 <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev"> -->
<!--                   <span class="carousel-control-prev-icon"></span> -->
<!--                 </a> -->
<!--               </div> -->
<!--               <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  "> -->
<!--                 <a href="#"> -->
<%--                   <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300"> --%>
<!--                   <div class="carousel-caption img-tip"> -->
<!--                     <h1>Event title5</h1> -->
<!--                     <h4>about the Event!</h4> -->
<!--                   </div> -->
<!--                 </a> -->
<!--               </div> -->
<!--               <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  "> -->
<!--                 <a href="#"> -->
<%--                   <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300"> --%>
<!--                   <div class="carousel-caption img-tip"> -->
<!--                     <h1>Event title6</h1> -->
<!--                     <h4>about the Event!</h4> -->
<!--                   </div> -->
<!--                 </a> -->
             
<!--                 <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next"> -->
<!--                   <span class="carousel-control-next-icon"></span> -->
<!--                 </a> -->
<!--               </div> -->
<!--             </div> -->
<!--           </div> -->
<!--         </div> -->
<!--       </div> -->
<!--     </div> -->
<!--   </div> -->
  <!-- Schedule -->
  <!-- Sponsor logos -->
  <div class="py-5 section sponsor-div mt-5">
    <div class="container">
      <div class="row">
        <div class="col-md-12">
          <h1 class="mb-4">Sponsors</h1>
        </div>
      </div>
      <div class="row">
        <div class="col-md-2 col-6"></div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/logo_1.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/logo_4.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/logo_3.png"> </div>
        <div class="col-md-2 col-6">
          <img class="center-block img-fluid d-block" src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/logo_2.png"> </div>
      </div>
    </div>
  </div>
  <!-- Call to action -->
  <div class="py-5 section section-fade-in-out" id="register" style="background-image: url('<%=request.getContextPath() %>/front_end/event/eve/assets/conference/cover_2.jpg');">
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
            <br> Copyright 2018 Pingendo - All rights reserved.
            <br>
            <br> </p>
        </div>
      </div>
    </div>
  </footer>
  
  
	   <!-- 報名開啟新增活動清單modal -->
 <c:if test="${openAddElModal!=null}">
	
	<div class="modal fade" id="addEvelistModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
		<div class="modal-dialog ">
			<div class="modal-content">
								
				<div class="modal-body">
	          		 <jsp:include page="/front_end/event/eventlist/addeveList.jsp" />
	        	</div>
	        			
			</div>
		</div>
	</div>
	        <script>
	    		 $("#addEvelistModal").modal({show: true});
	        </script>
 </c:if>
 
 

   <!-- The Modal -->
<c:if test="${openPayModal!=null}">

<div class="modal fade " id="elPayModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog ">
		<div class="modal-content bg-dark">
		
			<div class="modal-header " >
				<h3 class="modal-title text-success" id="myModalLabel" style='font-weight:bold !important;'>付款資訊<button  id="lbtn" type="button" class="btn m-3 btn-sm " ></button></h3>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>                
            </div>
							
			<div class="modal-body " >
				 <div class="row"><div class="col-md-4  h4 text-success " style='font-weight:bold !important;'>活動名稱 </div><div class="col-md h4 text-success" style='font-weight:bold !important;'>  ${eveVO.eve_title}</div></div>
				 <div class="row"><div class="col-md-4 h4 text-success" style='font-weight:bold !important;'> 付款金額 </div><div class="col-md h4 text-success" style='font-weight:bold !important;'>${eventListVO.evepay_amount}&nbsp元</div></div>
				 <div class="row"><div class="col-md-4 h4 text-success" style='font-weight:bold !important;'>信用卡卡號 </div><div class="col-md h4 text-success" style='font-weight:bold !important;'><input type="text" class="payinput" id="credit_card"><div class="mt-2"> 月<input type="text" id="mon" class="payinput" size="1">年<input type="text" id="year" class="payinput" size="1"> CVC<input type="text"  class="payinput" id="cvc" size="1" ></div></div></div>
				 <div class="row"><div class="col-md-4 h4 text-success" style='font-weight:bold !important;'>持卡人姓名 </div><div class="col-md h4 text-success" style='font-weight:bold !important;'><input type="text"  class="payinput" value="${memVO.mem_name}"></div></div>
				 <div class="row"><div class="col-md-4 h4 text-success" style='font-weight:bold !important;'>付款截止日 </div><div class="col-md h4 text-success" style='font-weight:bold !important;'>${eventListVO.evepay_deadline}</div></div>
				 <div class="row"><div class="col-md-4 h4 text-success" style='font-weight:bold !important;'>手機號碼 </div><div class="col-md h4 text-success" style='font-weight:bold !important;'><input type="text"  class="payinput" id="phone"></div></div>

        	</div>
        	
			<div class="modal-footer ">
			    <form action="<%=request.getContextPath() %>/eventlist/eventlist.do?action=pay_Update_Status&mem_id=${memVO.mem_id}&eve_id=${eveVO.eve_id}">
                 	<button type="submit" class="btn btn-success text-dark" id="paycheckBtn">
						確認付款
               		</button>
               		<input type="hidden" name="phone_number" id="phone_number">
               		<input type="hidden" name="action" value="pay_Update_Status">
               		<input type="hidden" name="mem_id" value="${memVO.mem_id}">
               		<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
                </form>
                <button type="button" class="btn btn-success">
                	<A href="<%=request.getContextPath() %>/front_end/event/eventlist/listEvesByMem.jsp" class='text-dark'>稍後付款</A>
                </button>
            </div>
		
		</div>
	</div>
</div>
        <script>
    		 $("#elPayModal").modal({show: true});
    		 $("#paycheckBtn").click(function(){
    			 $("#phone_number").val($("#phone").val());
    			 console.log($("#phone_number").val());
    		 });
    		 
    		 
    		 
        </script>
        
        <!--        小按鈕 -->
      <script>
      	$("#lbtn").click(function(){
      		$("#credit_card").val("1234567890123456");
      		$("#year").val("21");
      		$("#mon").val("11");
      		$("#cvc").val("123");
      		$("#phone").val("0975976761");
      	});
      
      
      </script>
 </c:if>
  
  
  
  
  
  
  
   <script>  
	   function reshowElCheck(){
			document.getElementById("reshowElBtn").style.display="none";
			document.getElementById("showElistCheck").style.display="none";
			document.getElementById("evelistCheck").style.display="";
			
		}
	   
    	function showEvelist(jsonStr){
    		document.getElementById("showElistCheck").style.display="";
			 var evelist = JSON.parse(jsonStr); 
			 var str = "<table class='evelistTable text-left' align='center'>";
			   str += "<tr><th>姓名</th><td>&nbsp&nbsp"+ evelist.mem_name +"</td></tr>";
			   str += "<tr><th>活動名稱</th><td>&nbsp&nbsp ${eveVO.eve_title}</td></tr>";
			   str += "<tr><th>活動付款金額</th><td>&nbsp&nbsp"+ evelist.evepay_amount+"</td></tr>";
			   str += "<tr><th>活動付款截止日</th><td>&nbsp&nbsp"+ evelist.evepay_deadline +"</td></tr>";
			   str += "<tr><th>活動清單狀態</th><td>&nbsp&nbsp"+ evelist.evelist_status +"</td></tr>";
			   str += "</table>"; 
			   document.getElementById("showElistCheck").innerHTML = str;
    		
    	}
    	
    
	    function getEvelist(){
	    	document.getElementById("evelistCheck").style.display="none";
	    	
	    	var xhr = new XMLHttpRequest();
		    //設定好回呼函數   
		    xhr.onload = function (){
		        if( xhr.status == 200){
	// 		          
						console.log(xhr.responseText);
					  if(xhr.responseText=='noneMem'){
						  document.getElementById("showElistCheck").innerHTML = "<p class='text-center'>查無會員資料</p>";
						  document.getElementById("reshowElBtn").style.display="";
					  }	else if(xhr.responseText=='noneEvelist'){			  
						  document.getElementById("showElistCheck").innerHTML = "<p class='text-center'>目前沒有您的活動資訊</p>";
						  document.getElementById("reshowElBtn").style.display="";	
					  }else if(xhr.responseText=='organizer'){
						  document.getElementById("reshowElBtn").style.display="";	
						  
						  var str=
						 '<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >'+
		          			'<button type="ssubmit" class="btn">查看活動報名狀態</button>'+
		          			'<input type="hidden" name="eve_id" value="${eveVO.eve_id}">'+
		          			'<input type="hidden" name="action" value="getEvelists_By_EVE">'+
		          	 	'</FORM>';
		          	 	console.log(str);
						 document.getElementById("showElistCheck").innerHTML =str; 

					  }else{
						  showEvelist(xhr.responseText);
					  }
		        	 
		        }else{
		          alert( xhr.status );
		        }//xhr.status == 200
		    };//onload 
		    
		    //建立好Get連接
		    var url= "<%=request.getContextPath() %>/eventlist/eventlist.do?action=get_Mem_Evelist&mem_account=" + document.getElementById("mem_account").value+
		    		"&mem_password="+document.getElementById("mem_password").value+"&eve_id=${eveVO.eve_id}";
		    xhr.open("Get",url,true); 
		    //送出請求 
		    xhr.send( null );    
	    	
	    }
	    
    </script>
    
    <script language="JavaScript">
       	  //取報名截止日期
       	  var ereg_endtime=document.getElementById("ereg_endtime").innerText;
       	  var format_time =ereg_endtime.replace(/-/g,'/');
       	  var Tday = new Date(format_time)
       	  console.log(Tday>new Date());
       	 if(Tday<new Date()){
        		document.getElementById("countdown").innerText="報名已結束";
        	  }
		  
		  var daysms = 24 * 60 * 60 * 1000
		  var hoursms = 60 * 60 * 1000
		  var Secondms = 60 * 1000
		  var microsecond = 1000
		  var DifferenceHour = -1
		  var DifferenceMinute = -1
		  var DifferenceSecond = -1
		
		function clock()
		{
		  var time = new Date()
		  var hour = time.getHours()
		  var minute = time.getMinutes()
		  var second = time.getSeconds()
		  var timevalue = ""+((hour > 12) ? hour-12:hour)
		  timevalue +=((minute < 10) ? ":0":":")+minute
		  timevalue +=((second < 10) ? ":0":":")+second
		  timevalue +=((hour >12 ) ? " PM":" AM")
		//  document.formnow.now.value = timevalue
		  var convertHour = DifferenceHour
		  var convertMinute = DifferenceMinute
		  var convertSecond = DifferenceSecond
		  var Diffms = Tday.getTime() - time.getTime()
		  DifferenceHour = Math.floor(Diffms / daysms)
		  Diffms -= DifferenceHour * daysms
		  DifferenceMinute = Math.floor(Diffms / hoursms)
		  Diffms -= DifferenceMinute * hoursms
		  DifferenceSecond = Math.floor(Diffms / Secondms)
		  Diffms -= DifferenceSecond * Secondms
		  var dSecs = Math.floor(Diffms / microsecond)
		  if(convertHour != DifferenceHour) document.formnow.dd.value=DifferenceHour
		  if(convertMinute != DifferenceMinute) document.formnow.hh.value=DifferenceMinute
		  if(convertSecond != DifferenceSecond) document.formnow.mm.value=DifferenceSecond
		  document.formnow.ss.value=dSecs
		//  document.formnow.Tnow.value= DifferenceHour  DifferenceMinute + DifferenceSecond + dSecs
		  setTimeout("clock()",1000)
		} 
</script>

<!-- Google Map -->
<script type="text/javascript">
		   var map;
		   var position = {
							lat: ${eveVO.eve_lat},
							lng: ${eveVO.eve_long}
					      };
			var contentString = '<h2 style="color:black!important;">${eveVO.eve_title}</h2>';
			var start ;
			
			
			function initMap() {
			  var directionsDisplay = new google.maps.DirectionsRenderer;
        	  var directionsService = new google.maps.DirectionsService;
        	  
			  map = new google.maps.Map(document.getElementById('map'), {
			    zoom: 15,
			    center: position
			  });
			  var marker = new google.maps.Marker({
			    map: map,
			    position: position
			  });
			  var infowindow = new google.maps.InfoWindow({
			    content: contentString,
			    position: position,
			
			  });
			  infowindow.open(map,marker);
			  
			  directionsDisplay.setMap(map);
			  directionsDisplay.setPanel(document.getElementById('right-panel'));	


			  var control = document.getElementById('floating-panel');
     		  control.style.display = 'block';
    		  map.controls[google.maps.ControlPosition.TOP_CENTER].push(control);

    		  var onClickHandler = function() {
    		  start = document.getElementById('start').value;
    		  		
	      			if(start=='目前位置'){
			        	if (navigator.geolocation) {
					        navigator.geolocation.getCurrentPosition(function(position) {
					            start = {
					                lat: position.coords.latitude,
					                lng: position.coords.longitude
					            };
					            console.log(start);
					            marker.setMap(null);
					            calculateAndDisplayRoute(directionsService, directionsDisplay,start);
			
					        });
					    } else {
					        // Browser doesn't support Geolocation
					        alert("未允許或遭遇錯誤！");
					        return;
					    }

			        }else{
			        	calculateAndDisplayRoute(directionsService, directionsDisplay,start);

			        }	
	          		
      		};
     			 document.getElementById('routeBtn').addEventListener('click', onClickHandler);

			}


			function calculateAndDisplayRoute(directionsService, directionsDisplay,start) {
				document.getElementById('right-panel').style.backgroundColor='white';
				var selectedMode = document.getElementById('mode').value;	       
		        directionsService.route({
		          origin: start,
		          destination: { lat: ${eveVO.eve_lat}, lng: ${eveVO.eve_long} },
		          travelMode: selectedMode
		        }, function(response, status) {
		          if (status === 'OK') {
		            directionsDisplay.setDirections(response);
		          } else {
		            window.alert('Directions request failed due to ' + status);
		          }
		        });
		    }
			
  </script>    
  
  
  <!-- Google Map -->
  <script async defer
     src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASI3sgz6P-wisrPe6D4N59Ro0RrodnHJM&callback=initMap">
  </script>
  
  <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <button id="goTopBtn" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:80px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">
  GoTop </button>
  
  <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
  
</body>

</html>