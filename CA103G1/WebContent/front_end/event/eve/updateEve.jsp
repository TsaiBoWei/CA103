<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="com.eve.model.*"%>
<%@ page import="com.mem.model.*" %>
<%
  MemVO memVO=(MemVO)session.getAttribute("memVO");
  EventVO eveVO = (EventVO) request.getAttribute("eveVO");
%>

<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  
  <!-- CSS  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!--  self-defined css  -->
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/SingleEventPage.css">
  
  <!-- JS  -->
  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>
 
 <!-- datetimepicker-->	
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
  <script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
  <script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>	
 
 
 <!-- summernote-->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
  <link href="<%=request.getContextPath() %>/front_end/event/eve/summernote/summernote-bs4.css" rel="stylesheet">
  <script src="<%=request.getContextPath() %>/front_end/event/eve/summernote/summernote-bs4.js"></script>
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  
  <!-- navbar setting -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>	
  
    
  <title>修改活動 - updateEve.jsp</title>

    <style type="text/css">
    body {
      font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei";
      font-weight: bold;
      
    }

    h1,h2,h3,h4,h5,h6 {
        font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei";
        color: #efefef;
      }

    .form-group label{
      font-size: 20px;
    }

    .form-check-input,.form-check{
       font-size: 20px;
    }
    #addEveBtn{
       font-weight: bold;
    }
    
    #upload_pic1, .eveImg{
    	width:100%;
    }
    
    .errorMsg{
    	color:red;
    
    }
    
    .navbar-dark .navbar-nav .nav-link{
		color:rgba(255, 255, 255, 0.8)!important;
		font-weight:bold!important;	
	}
	    
    

  </style>
  
  <!-- navbar setting -->
<style type="text/css">

a,.fontstyle  {
	font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
}
</style>

</head>

<body>


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

  
  <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message.value}</li>
		</c:forEach>
	</ul>
</c:if>
  <!-- Cover -->
  <div class="align-items-center py-5 section-fade-in-out " id="coverfirstImg" style="background: url(&quot;<%=request.getContextPath() %>/front_end/event/eve/assets/conference/cover_marathon.png&quot;);"> </div>
  <div class="container" style="padding-top: 100px;">
    <div class="py-1">
      <div class="container">
        <div class="row">
          <div class="col-md-10 offset-md-1">
            <div class="card text-white p-5 bg-info">
              <div>
                <h1 class="mb-4 bg-info text-center text-white">修改活動</h1>
              </div>
              <div class="card-body bg-info">
              
                <form METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" name="form1" enctype="multipart/form-data">
                  
                  <div id="updateImgDiv">
					<img class="eveImg" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=<%=eveVO.getEve_id()%>">
				  </div>
                  <div class="imgdiv" style="display: none;"><img src="#" id="upload_pic1"  /></div>
				  <input type="file" name="eve_photo" id="eve_photo"/>
				  <input type="button" id="btn_cancel" value="取消更換圖片">
                  
                  <div class="form-row">
                    <div class="form-group col-md-10"> 
                      <label for="eve_title">活動標題</label><b class='errorMsg'>${errorMsgs.eve_title}</b>
                      <input type="text"  name="eve_title" class="form-control" id="eve_title"  value="<%=eveVO.getEve_title()%>">
                    
                    </div>
                    <div class="form-group col-md-2">
                      <label for="sportType">類別</label>
                      <select class="custom-select" id="sportType" size="1" name="sptype_id">
                        <c:forEach var="sptype" items="${sportTypeMap}">
							<option value="${sptype.key}" ${(sptype.key==eveVO.sptype_id)? 'selected':'' } >${sptype.value}
						</c:forEach>
                      </select>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-7 py-2">
                      <label for="mem_name">主辦人姓名</label><b class='errorMsg'> ${errorMsgs.mem_id}</b>
                      <input type="text" class="form-control" id="mem_name" readonly="readonly" value="<%= (memVO==null)? "" :memVO.getMem_name() %>"> 
                     	
                    </div>
                    <div class="form-group col-md-5 py-2">
                      <label for="econtact_info">主辦人手機號碼</label> <b class='errorMsg'>${errorMsgs.econtact_info}</b> 
                      <input type="text" class="form-control" id="econtact_info" name="econtact_info" placeholder="格式09XX-XXXXXX"
                     	 value="<%= (eveVO==null)? "" : eveVO.getEcontact_info()%>" >      	  
                    </div>
                     	
                  </div>
                  <div class="form-row">                
                    <div class="form-group col-md-6 pt-3">
                      <label for="ereg_startdate">報名開始日期</label> <b class='errorMsg'>${errorMsgs.ereg_startdate}</b>
                      <input type="text" class="form-control" name="ereg_startdate" id="ereg_startdate" value="${eveVO.ereg_startdate}" > </div>
                    <div class="form-group col-md-6 pt-3">
                      <label for="ereg_enddate">報名結束日期</label>
                      <input type="text" class="form-control" name="ereg_enddate" id="ereg_enddate"  value="${eveVO.ereg_enddate}">                     
                    </div>
                    
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-6">
                      <label for="eve_startdate">活動開始時間</label><b class='errorMsg'> ${errorMsgs.eve_startdate}</b>
                      <input name="eve_startdate" id="eve_startdate" type="text" class="form-control"  > </div>
                    <div class="form-group col-md-6">
                      <label for="eve_enddate">活動結束時間</label>
                      <input type="text" class="form-control" name="eve_enddate" id="eve_enddate" >
                     </div>
                    
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-2">
                      <label  class="pt-3">活動人數</label>
                    </div>
                    <div class="form-group col-md-12">
                    <div class='errorMsg'>  ${errorMsgs.estart_max}</div> 
                      <div class="form-check form-check-inline col-md-4
                      "> 是否有活動最低人數限制 </div>
                      <div class="form-check form-check-inline justify-content-between">
                        <input class="form-check-input" type="radio" name="estart_limit_check" id="estart_limit_no" 
                        	value="0" <%=(eveVO.getEstart_limit()==0) ? "checked":"" %>>
                        <label class="form-check-label" for="estart_limit_no" >無</label>
                      </div>
                      <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="estart_limit_check" id="estart_limit_yes" 
                        	value="1" <%=(eveVO.getEstart_limit()>0) ? "checked":"" %>>
                        <label class="form-check-label" for="estart_limit_yes">有</label>
                      </div>
                      <div class="form-check form-check-inline col-md-2">
                        <input type="text" class="form-control" name="estart_limit" id="estart_limit" 
                        	value="<%= (eveVO.getEstart_limit()==0)? "" : eveVO.getEstart_limit()%>"/> </div>
                      <div class="form-check form-check-inline col-md-1"> 人 </div>
                    </div>
                    
                    
                    
                    
                    
                    <div class="form-group col-md-12">
                      <div class="form-check form-check-inline col-md-4
                      "> 是否有活動人數上限 </div> 
                      
                      <div class="form-check form-check-inline justify-content-between">
                        <input class="form-check-input" type="radio"name="estart_max_check" id="estart_max_no" 
                        	value="0" <%=(eveVO.getEstart_max()==0) ? "checked":"" %>>
                        <label class="form-check-label" for="estart_max_no">無</label>
                      </div>
                      <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="estart_max_check" id="estart_max_yes" 
                        	value="1" <%=(eveVO.getEstart_max()>0) ? "checked":"" %> >
                        <label class="form-check-label" for="estart_max_yes">有</label>
                      </div>
                      <div class="form-check form-check-inline col-md-2">
                        <input type="text" class="form-control" name="estart_max" id="estart_max"  
                        	value="<%= (eveVO.getEstart_max()==0)? "" : eveVO.getEstart_max() %>"> </div>
                      <div class="form-check form-check-inline col-md-1"> 人 </div>
                                         
                    </div>
                    
                    <div class="form-group col-md-12">
                      <div class="form-check form-check-inline col-md-4
                      "> 報名活動費用 </div>
                      <div class="form-check form-check-inline justify-content-between">
                        <input class="form-check-input" type="radio" name="eve_charge_check" id="eve_charge_no" 
                        	value="0" <%=(eveVO.getEve_charge()==0) ? "checked":"" %>>
                        <label class="form-check-label" for="eve_charge_no">免費</label>
                      </div>
                      <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="eve_charge_check" id="eve_charge_yes" 
                        	value="1"<%=(eveVO.getEve_charge()>0) ? "checked":"" %>>
                        <label class="form-check-label" for="eve_charge_yes">每人</label>
                      </div>
                      <div class="form-check form-check-inline col-md-2">
                        <input type="text" class="form-control" name="eve_charge" id="eve_charge" 
                        	value="<%=(eveVO.getEve_charge()==0)? "" : eveVO.getEve_charge()%>" > </div>
                      <div class="form-check form-check-inline col-md-1"> 元 </div>
                    </div>
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-2 py-2">
                      
                      <jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
                      <label for="city_id">活動地區</label>
                      <select size="1" name="city_id" class="custom-select" id="city_id">
						  <c:forEach var="cityVO" items="${citySvc.all}">
							<option value="${cityVO.city_id}" ${(cityVO.city_id==eveVO.city_id)? 'selected':'' } >${cityVO.city_name}
						  </c:forEach>
					  </select>
                      
                    </div>
                    <div class="form-group col-md-10 py-2">
                      <label for="eve_loc">活動地點</label> <b class='errorMsg'> ${errorMsgs.eve_location}</b>
                      <input type="text" class="form-control" id="eve_loc" name="eve_location" 
                      	value="<%= (eveVO==null)? "" : eveVO.getEve_location()%>"> 
                      <input type="hidden" name="eve_long"  id="eve_long" value="${eveVO.eve_long>0?eveVO.eve_long:''}">          
 					  <input type="hidden" name="eve_lat"  id="eve_lat" value="${eveVO.eve_long>0?eveVO.eve_lat:''}">            	
                    </div>	               
                  </div>
                  <div class="form-row">
                    <div class="form-group col-md-12 py-2">
                      <label >活動敘述</label> <b class='errorMsg'> ${errorMsgs.eve_content}</b>
                    </div>
                    <div class="col-md-12 py-2">
                      <textarea id="econtent_summernote" name="editordata"></textarea></textarea>
                      <input type="hidden" name="eve_content"  id="eve_content">
                      
                    </div>
                  </div>
                  <div>
                  	活動建立時間:<fmt:formatDate value="${eveVO.eestablish_date}" pattern="yyyy-MM-dd HH:mm "/> 
                  	${errorMsgs.eve_content}               
                  </div>
                  
                  
                  <div class="col-md-5 offset-md-3">
                  	<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
					<input type="hidden" name="action" value="update">
					<input type="hidden" name="mem_id" value="${memVO.mem_id}">
					<input type="hidden" name="requestURL" value="<%=request.getParameter("requestURL")%>"> <!--接收原送出修改的來源網頁路徑後,再送給Controller準備轉交之用-->
					<input type="hidden" name="whichPage"  value="<%=request.getParameter("whichPage")%>">  
                    <button id="addBtnSubmit" type="submit" class="btn m-3 btn-lg btn-block btn-warning" id="addEveBtn">確認修改</button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <br>送出修改的來源網頁路徑:<br><b>
   <font color=blue>request.getParameter("requestURL"):</font> <%=request.getParameter("requestURL")%><br>
   <font color=blue>request.getParameter("whichPage"): </font> <%=request.getParameter("whichPage")%></b>
      <script>
      
//       $(document).ready(function(){
    	  
//       	//初始化summernote
//           $('#econtent_summernote').summernote({
//               height: 200,                 
//               minHeight: 400,             
//               maxHeight: 400,             
//               focus: true ,
//             });
      	
//           //summernote賦值(將文字顯示在summernote上)     
<%--   		$("#econtent_summernote").summernote("code", '<%= (eveVO==null)? "" : eveVO.getEve_content()%>'); --%>
  		
//           //summernote取值
//           $("#addBtnSubmit").click(function(){
//             var markupStr = $('#econtent_summernote').summernote('code');
//             $("#eve_content").val(markupStr);
//             console.log( $("#eve_content").val());

//           });

//         });

      </script> 
      <div class="py-5" id="speakers">
        <div class="container ">
          <div class="row ">
            <div class="col-12 col-md-12">
              <h2>專屬推薦活動</h2>
              <div class="tab-content mt-2">
                <div class="tab-pane fade" id="tabthree" role="tabpanel">
                  <p class="text-primary">Tab pane three. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="container">
          <div class="carousel slide" data-ride="carousel" id="bs4-multi-slide-carousel">
            <div class="carousel-inner">
              <div class="carousel-item active">
                <div class="row">
                  <div class="col-lg-4 col-md-4 img-group ">
                    <a href="#">
                      <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                      <div class="carousel-caption img-tip">
                        <h1>Event title1</h1>
                        <h4>about the Event!</h4>
                      </div>
                    </a>
               
                    <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev">
                      <span class="carousel-control-prev-icon"></span>
                    </a>
                  </div>
                  <div class="col-lg-4 col-md-4 img-group">
                    <a href="#">
                      <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                      <div class="carousel-caption img-tip">
                        <h1>Event title2</h1>
                        <h4>about the Event!</h4>
                      </div>
                    </a>
                  </div>
                  <div class="col-lg-4 col-md-4 img-group">
                    <a href="#">
                      <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                      <div class="carousel-caption img-tip">
                        <h1>Event title3</h1>
                        <h4>about the Event!</h4>
                      </div>
                    </a>
                 
                    <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next">
                      <span class="carousel-control-next-icon"></span>
                    </a>
                  </div>
                </div>
              </div>
              <div class="carousel-item">
                <div class="row">
                  <div class="col-lg-4 col-md-4 img-group">
                    <a href="#">
                      <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/03.png" class="center-block img-fluid my-3 shadowed" width="300">
                      <div class="carousel-caption img-tip">
                        <h1>Event title4</h1>
                        <h4>about the Event!</h4>
                      </div>
                    </a>
                  
                    <a class="carousel-control-prev multprev1" href="javascript:void(0)" data-slide="prev">
                      <span class="carousel-control-prev-icon"></span>
                    </a>
                  </div>
                  <div class="col-lg-4 col-md-4 img-group">
                    <a href="#">
                      <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                      <div class="carousel-caption img-tip">
                        <h1>Event title5</h1>
                        <h4>about the Event!</h4>
                      </div>
                    </a>
                  </div>
                  <div class="col-lg-4 col-md-4 img-group">
                    <a href="#">
                      <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                      <div class="carousel-caption img-tip">
                        <h1>Event title6</h1>
                        <h4>about the Event!</h4>
                      </div>
                    </a>
              
                    <a class="carousel-control-next multnext1" href="javascript:void(0)" data-slide="next">
                      <span class="carousel-control-next-icon"></span>
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
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
    
    </div>
  </div>
  
  <script>
      function initMap(){
    	 
    	  var eve_location= document.getElementById("eve_loc");
          var addBtnSubmit=document.getElementById("addBtnSubmit");
          var eve_long= document.getElementById("eve_long");
		  var eve_lat= document.getElementById("eve_lat");
		  console.log("11:"+eve_long.value);
          eve_location.onchange= function(){ 
        	  console.log(22);
  		    var longitude;
  		    var latitude;
  		   
  		    
  		    var geocoder = new google.maps.Geocoder();
  		
  		    geocoder.geocode({
  		      address: eve_location.value
  		    }, function(results, status) {
  		      if (status == google.maps.GeocoderStatus.OK) {
  		         longitude=results[0].geometry.location.lng();
  		         latitude=results[0].geometry.location.lat();
  		         eve_long.value=longitude;
  		         eve_lat.value=latitude;
  		         console.log(eve_long.value);
  		         console.log(eve_lat.value);
  		      }
  		    }); 		
  		};
          console.log(11);
        
      }
    
      </script>	 
  
  
  <script>
$(document).ready(function(){
	$("#estart_limit_no").focus(function(){
		$('#estart_limit').attr('disabled', true);
		$('#estart_limit').val("");
	});
	$("#estart_limit_yes").focus(function(){
		$('#estart_limit').attr('disabled', false);
	});
	
	$("#estart_max_no").focus(function(){
		$('#estart_max').attr('disabled', true);
		$('#estart_max').val("");
	});
	$("#estart_max_yes").focus(function(){
		$('#estart_max').attr('disabled', false);
	});
	
	$("#eve_charge_no").focus(function(){
		$('#eve_charge').attr('disabled', true);
		$('#eve_charge').val("");
	});
	$("#eve_charge_yes").focus(function(){
		$('#eve_charge').attr('disabled', false);
	});
	
});



</script>
<!-- summernote	  -->
 <script>
      $(document).ready(function(){
 
    	//初始化summernote
        $('#econtent_summernote').summernote({
            height: 200,                 
            minHeight: 400,             
            maxHeight: 400,             
            focus: true ,
          });
    	
        //summernote賦值(將文字顯示在summernote上)     
		$("#econtent_summernote").summernote("code", '<%= (eveVO==null)||eveVO.getEve_content()==null? "" : eveVO.getEve_content()%>');
		
        //summernote取值
        $("#addBtnSubmit").click(function(){
          var markupStr = $('#econtent_summernote').summernote('code');
          $("#eve_content").val(markupStr);
          console.log( $("#eve_content").val());

        });

      });

    </script> 	
    
    <!--     更換上傳圖片 -->
  <script>
		$("#eve_photo").change(function(){
			
			if(this.files&&this.files[0]){
				$("#updateImgDiv").hide();
				$("#upload_pic1").parent().show();
				var reader=new FileReader();
				reader.onload=function(e){
				$("#upload_pic1").attr("src",e.target.result);
				}
				reader.readAsDataURL(this.files[0]);
			}
		});
		 $("#btn_cancel").click(function () {
			    $("#updateImgDiv").show();
		 		$("#upload_pic1").parent().hide();
			  $("#eve_photo").val("");        	 
	    });	
</script>           
    

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
        $.datetimepicker.setLocale('zh');
        $('#ereg_startdate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       //step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%= (eveVO==null)? "" : eveVO.getEreg_startdate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // 去除今日(不含)之前
        });
        
        $.datetimepicker.setLocale('zh');
        $('#ereg_enddate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       //step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%= (eveVO==null)? "" : eveVO.getEreg_enddate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // 去除今日(不含)之前
        });
        
        $.datetimepicker.setLocale('zh');
        $('#eve_startdate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
	       value: '<%= (eveVO==null)? "" : eveVO.getEve_startdate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // 去除今日(不含)之前
        });
        
        
        $.datetimepicker.setLocale('zh');
        $('#eve_enddate').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 30,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
		   value: '<%= (eveVO==null)? "" : eveVO.getEve_enddate()%>', // value:   new Date(),
           minDate:               '-1970-01-01', // 去除今日(不含)之前
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

//              1.以下為某一天之前的日期無法選擇
		 var ereg_startdateStr = $('#ereg_startdate').val()+" 00:00:00";
       	 var limitdate = new Date();
       	 limitdate.setDate(limitdate.getDate()+180); //設建活動的時間在半年內
       	 var newDate =ereg_startdateStr.replace(/-/g,'/');
       	 ereg_startdate=new Date(newDate);
       	 
       	 $('#ereg_startdate').datetimepicker({   		 
             beforeShowDay: function(date) {
            	 var today = new Date();
//              	 console.log("今天:"+today);
           	  if ( (date.getYear() < today.getYear()) || 
    		           (date.getYear() == today.getYear() && date.getMonth() < today.getMonth()) || 
    		           (date.getYear() == today.getYear() && date.getMonth() == today.getMonth() && date.getDate() < today.getDate())
    		           ||
    		           (date.getYear() >  limitdate.getYear()) || 
    		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
    		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())
                 ) {
                      return [false, ""]
                 }
                 return [true, ""];
          }});
       	 
       	 
       	 
    	
		 $('#eve_startdate,#ereg_enddate,#eve_enddate').datetimepicker({
		 
            beforeShowDay: function(date) {
          	  if ( (date.getYear() < ereg_startdate.getYear()) || 
   		           (date.getYear() == ereg_startdate.getYear() && date.getMonth() <  ereg_startdate.getMonth()) || 
   		           (date.getYear() == ereg_startdate.getYear() && date.getMonth() == ereg_startdate.getMonth() && date.getDate() < ereg_startdate.getDate())
   		           ||
   		           (date.getYear() >  limitdate.getYear()) || 
   		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
   		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())
                ) {
                     return [false, ""]
                }
                return [true, ""];
         }});
	       
	    $('#ereg_startdate').change(function(){ 
	    	if($('#eve_startdate').val()<$('#ereg_startdate').val()){
	    		 $('#eve_startdate').val($('#ereg_startdate').val()+" 00:00");
       	 	}
	    	if($('#ereg_enddate').val()<$('#ereg_startdate').val()){
	    		 $('#ereg_enddate').val($('#ereg_startdate').val());
       	 	}
	    	
	    	if($('#eve_enddate').val()<$('#ereg_startdate').val()){
	    		 $('#eve_enddate').val($('#ereg_startdate').val()+" 00:00");
     	 	}
      
        	 var ereg_startdateStr = $('#ereg_startdate').val()+" 00:00:00";
           	 var limitdate = new Date();
           	 limitdate.setDate(limitdate.getDate()+180); //設建活動的時間在半年內
           	 var newDate =ereg_startdateStr.replace(/-/g,'/');
           	 ereg_startdate=new Date(newDate);
        	
        	        	 
        	 if($('#eve_enddate').val()!=""){
        		 var latterTimeStr=$('#ereg_enddate').val();
            	 if($('#ereg_enddate').val()<$('#eve_startdate').val()){
            		  latterTimeStr=$('#eve_startdate').val();
            	 }
            	 var newDate =latterTimeStr.replace(/-/g,'/');
            	 latterTime=new Date(newDate);
//         		 $('#eve_enddate').val($('#ereg_startdate').val());
        		 $('#eve_enddate').datetimepicker({
                     beforeShowDay: function(date) {
                   	  if ( (date.getYear() <  latterTime.getYear()) || 
            		       (date.getYear() ==  latterTime.getYear() && date.getMonth() <   latterTime.getMonth()) || 
            		       (date.getYear() ==  latterTime.getYear() && date.getMonth() ==  latterTime.getMonth() && date.getDate() <  latterTime.getDate())
            		       ||
		 		           (date.getYear() >  limitdate.getYear()) || 
		 		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
		 		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())
                         ) {
                              return [false, ""]
                         }
                         return [true, ""];
                 }});
        	 }       	 
        });
        
        $('#ereg_enddate,#eve_startdate').change(function(){
//         	 console.log("活動開始時間"+$('#eve_startdate').val());
        	 var ereg_enddateStr = $('#ereg_enddate').val()+" 00:00:00";
        	 var eve_startdateStr= $('#eve_startdate').val()+":00";
     
//         	 console.log(ereg_enddateStr<eve_startdateStr);
        	 
        	 var latterTimeStr=ereg_enddateStr;
        	 if(ereg_enddateStr<eve_startdateStr){
        		  latterTimeStr=eve_startdateStr;
        	 }
//         	 console.log(latterTimeStr);
        	 
        	 var newDate =latterTimeStr.replace(/-/g,'/');
        	 latterTime=new Date(newDate);
        	 console.log(($('#eve_enddate').val()+":00")>latterTimeStr);
        	 
        	 if(($('#eve_enddate').val()+":00")<latterTimeStr){
        		 if($('#eve_startdate').val()!=""){
        			    var ereg_enddateStr = $('#ereg_enddate').val()+" 00:00";
                	    var eve_startdateStr= $('#eve_startdate').val();
                	    var latter= (ereg_enddateStr>eve_startdateStr)?ereg_enddateStr:eve_startdateStr;
        	 			$('#eve_enddate').val( latter);
        	 		 }else{
        	 			$('#eve_enddate').val($('#ereg_enddate').val());
        	 		 }
        	 }
   	 		
   	 		 
   	 		 if($('#eve_startdate').val()<$('#ereg_startdate').val()){
   	 			$('#ereg_startdate').val($('#eve_startdate').val());
   	 			if($('#eve_startdate').val()>$('#ereg_enddate').val()){
   	 			$('#ereg_enddate').val($('#eve_startdate').val());	
   	 			}
   	 		 }
   	 		 if($('#ereg_enddate').val()<$('#ereg_startdate').val()){
   	 			$('#ereg_startdate').val($('#ereg_enddate').val());
   	 		 }
        	 
        	 
        	 $('#eve_enddate').datetimepicker({
                 beforeShowDay: function(date) {
               	  if ( (date.getYear() < latterTime.getYear()) || 
        		       (date.getYear() == latterTime.getYear() && date.getMonth() <  latterTime.getMonth()) || 
        		       (date.getYear() == latterTime.getYear() && date.getMonth() == latterTime.getMonth() && date.getDate() < latterTime.getDate())
        		       ||
	 		           (date.getYear() >  limitdate.getYear()) || 
	 		           (date.getYear() == limitdate.getYear() && date.getMonth() >  limitdate.getMonth()) || 
	 		           (date.getYear() == limitdate.getYear() && date.getMonth() == limitdate.getMonth() && date.getDate() > limitdate.getDate())   
                     ) {
                          return [false, ""]
                     }
                     return [true, ""];
             }});
        });

        
        
       	
</script>
<!-- Google Map -->
<script async defer
     src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASI3sgz6P-wisrPe6D4N59Ro0RrodnHJM&callback=initMap">
</script>
<script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
<script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>
    
</body>



</html>