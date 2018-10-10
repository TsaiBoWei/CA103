<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ page import="java.util.*"%>
    <%@ page import="com.mem.model.*"%>
    <%@ page import="com.eve.model.*" %>
	<%@ page import="com.eventlist.model.*"%>
	<%@ page import="java.text.*"%>
	<%@ page import="com.plan.model.*" %>
	<%@ page import="com.purchcour.model.*" %>
	<%@ page import="com.courlist.model.*" %>
	<%@ page import="java.util.regex.*"%>
<!DOCTYPE html>

<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<jsp:useBean id="planSvc" scope="page" class="com.plan.model.PlanService" />
<%-- <jsp:useBean id="purSvc" scope="page" class="com.purchcour.model.PurchcourService" /> --%>
<jsp:useBean id="courlistSvc" scope="page" class="com.courlist.model.CourlistService" />
<%--	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO");  
--%>
<%-- /*以會員id取出對應的evelist*/
	List<EventListVO> list =evelistSvc.getEveListsByMem(memVO.getMem_id());
--%>
<% /*以會員id(先用假資料)取出對應的evelist*/
	List<EventListVO> list =evelistSvc.getEveListsByMemToCal("M000001");
	
%>

<%
	List<EventVO> listEve = new ArrayList<EventVO>();
	for(EventListVO eve:list){
		EventVO vo = eveSvc.getOneEve(eve.getEve_id());
		listEve.add(vo);
	}//取出evelist裡的eve_id再查出eve_id所對應的event 並存進listEve
	
%>


<%
	List<PlanVO> listPlan = planSvc.getPlansByMem("M000001");

%>

<%-- <% --%>
<!-- // 	List<PurchCourVO> listPurchCour = purSvc.findByMemToCal("M000001"); -->
<!-- // 	System.out.println(listPurchCour); -->
<%-- %> --%>
<%-- <% --%>
<!-- // 	List<CourlistVO> listCour = new ArrayList<CourlistVO>(); -->
<!-- // 	for(PurchCourVO pur:listPurchCour){ -->
<!-- // 		CourlistVO vo  = courlistSvc.getOneToCal(pur.getCour_id()); -->
<!-- // 		System.out.println(vo); -->
<!-- // 		listCour.add(vo); -->
<!-- // 		System.out.println(listCour); -->
<!-- // 	} -->
<%-- %> --%>

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
<!--     <link rel="stylesheet" -->
<%-- 	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/PersonalPage.css"> --%>
    <link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/front_end/course/purchcour/css/buttonfix.css">
	<!-- fafaicon -->
	<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
	integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
	crossorigin="anonymous">
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
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/front_end/calendar/css/jquery.datetimepicker.css" />
	
<script src="<%=request.getContextPath()%>/front_end/calendar/js/jquery.datetimepicker.full.js"></script>
    
    
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
      
     .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }  
  </style>
</head>
<!-- =========================================以下為原personlhead.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlhead.jsp"/>
<!-- =========================================以上為原personlhead.jsp的內容========================================== -->

   
    
      <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
    <div class="py-5">
        <div class="container">
            <div class="row">
                <!--行事曆-->
                <div class="col-md-12 cal1" id="calendar1"></div>
                <!-- 計畫列表-->
                  
              <div class="dialog_inpu" id="evedialog" title="My dialog" style="display:none">
    <div class="container">
    




      <div id="eve_id" style="display:none"></div>
      <div class="row m-1">
        <div class="" >活動標題:</div>
        <div id="eve_title"></div>
      </div>
      <div class="row m-1">
        <div>活動內容:</div>
        <div id="eve_content"></div>
        
<!--             <input type="hidden" name="eve_content" id="eve_content"> -->
<!--          <textarea class="form-control" id="eve_content" name="plan_vo" rows="5"></textarea> -->
        
      </div>
      <div class="row">
        <div>活動地點:</div>
        <div id="eve_location"></div>
      </div>
      <div class="row">
        <div>活動開始時間:</div>
        <div id="eve_startdate"></div>
      </div>
      <div class="row">
        <div>活動結束時間:</div>
        <div id="eve_enddate"></div>
      </div>
      <div class="row">
        <div>收費金額:</div>
        <div id="eve_charge"></div>
      </div>
      <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div>
          <input type="hidden" name="eve_idTochange" id="eve_idTochange">
          <input type="hidden" name="eve_chargeToback" id="eve_chargeToback">
          <input type="hidden" name="CaloutEvent" value="Cal_out_event" >
          <input type="submit" name="deleteEve" value="退出活動" class="m-1 btn btn-info"> </div>
      </form>
    </div>
  </div>
  
  
    <!-- 計畫列表-->
     <div class="col p-3" id="plandialog" style="display:none">
     
        <%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
     
       <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div class="form-group">
          <input type="text" class="form-control" id="plan_id" name="plan_id" style="display:none"> </div>
        <div class="form-group">
          <label for="plan_name">計畫名稱</label>
          <input type="text" placeholder="計畫名稱" id="plan_name" name="plan_name" class="form-control" id="plan_name"> </div>
        <div class="form-row">
          <div class="form-group col m-1">
            <label for="plan_start_date">計畫開始日</label>
            <input type="text" class="form-control date1" placeholder="" id="plan_start_date" name="plan_start_date"> </div>
          <div class="form-group col m-1">
            <label for="plan_end_date">計畫結束日</label>
            <input type="text" class="form-control date1" placeholder="" id="plan_end_date" name="plan_end_date"> </div>
        </div>
        <div class="form-group">
          <label for="plan_vo">計畫內容</label>
           <div id="summernote"></div>
        
            <input type="hidden" name="plan_vo" id="plan_vo">
<!--           <textarea class="form-control" id="plan_vo" name="plan_vo" rows="5"></textarea> -->
        </div>
       
        <input type="submit" id="updatePlan" name="changePlan" value="修改計畫" class="m-1 btn btn-info">
        <input type="hidden" name="CalChangePlan" value="Cal_Change_Plan" >
      </form>
      <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div>
          <input type="hidden" name="plan_idToDelete" id="plan_idToDelete">
          <input type="hidden" name="outPlan" value="out_Plan" >
          <input type="submit" name="deletePlan" value="刪除計畫" class="btn btn-primary my-2"> 
       </div>
      </form>
    </div>
    <!-- 計畫列表結束-->            
    
     <!-- 課程列表開始-->
     
     <div class="dialog_inpu" id="courdialog" title="My dialog" style="display:none">
     <div class="container">
      <div class="row">
        <div>課程名稱:</div>
        <div id="cname"></div>
      </div>
      <div class="row">
        <div>課程介紹:</div>
        <div id="cour_text" ></div>
      </div>
      <div class="row">
        <div>課程公告:</div>
        <div id="cour_ann"></div>
      </div>
      
      <!-- c:for -->
      <div class="row">
        <div>課程單元:</div>
        <div id="cu_name"></div>
        <a class="btn btn-link m-2" href="#" >前往觀看</a>
      </div>
      
      <form method="post" action="<%=request.getContextPath() %>/calendar/calendar.do">
        <div>
          <input type="hidden" name="eve_idTochange" id="eve_idTochange">
          <input type="hidden" name="eve_chargeToback" id="eve_chargeToback">
          <input type="hidden" name="CaloutEvent" value="Cal_out_event">
          <input type="submit" name="deleteEve" value="退訂" class="m-1 btn btn-info"> </div>
      </form>
    </div>
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
    <!-- =========================================以下為原personlfooter.jsp的內容========================================== -->
	                                      <jsp:include page="/front_end/course/purchcour/page/personlfooter.jsp"/>
	<!-- =========================================以上為原personlfooter.jsp的內容========================================== -->
	
    <!-- JavaScript dependencies -->
    <script>
    
    
    $.datetimepicker.setLocale('zh');
    
    <!-- 活動的值帶入 -->
    var events = [
    	<% 	
    		SimpleDateFormat sdFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    	for(EventVO ii: listEve){
    		
    	%>
    	
    		{
        	id: '<%=ii.getEve_id()%>',
        	title: '<%=ii.getEve_title()%>',
        	start: '<%=sdFormat.format(ii.getEve_startdate())%>',
        	end: '<%=sdFormat.format(ii.getEve_enddate())%>',
        	description:'<%=ii.getEve_content()%>',
        	money:'<%=ii.getEve_charge()%>',
        	location:'<%=ii.getEve_location()%>',
        	moneytobackend:'<%=ii.getEve_charge()%>',
        	eveidtochange:'<%=ii.getEve_id()%>',
        	
        	
    		},
      
    	<%
    	
    	
          }
        %>  
       
    	]
    <!-- 計畫的值帶入 -->
    	var plan = [
    		<% 	
    		SimpleDateFormat sdFormat1 = new SimpleDateFormat("yyyy-MM-dd hh:mm");
    	for(PlanVO planCal: listPlan){
    		
     		
    			String str = planCal.getPlan_vo();
     
  		  	%>
    	
    		{
    	        id: '<%=planCal.getPlan_id()%>',
    	        title: '<%=planCal.getPlan_name()%>',
    	        start: moment('<%=sdFormat1.format(planCal.getPlan_start_date())%>'),
    	        end: moment('<%=sdFormat1.format(planCal.getPlan_end_date()) %>'),
    	        <%    	       
   		 			 String dest = "";
  					 if (str!=null) {
  						Pattern p = Pattern.compile("\\s*|\r|\n");
  						Matcher m = p.matcher(str);
  						dest = m.replaceAll("");
  					}
  					            	        
    	        %>
    	        description: '<%=dest%>',
    	        planidToDelete:'<%=planCal.getPlan_id()%>',
    	      
    	    	},
    	    	
    		
    	<%
    	}
        %>  
    		
    	]
    	
    	<!-- 課程的值帶入 -->
    	var cour=[
    		
    		{id:'cour0001',
    		title:'測試',
    		start:'2018-10-07',
    		},
    			
    			
<%--     		<% --%>
//     		SimpleDateFormat sdFormat2 = new SimpleDateFormat("yyyy-MM-dd hh:mm");
//     		for(CourlistVO courCal: listCour){    		
<%--     		%> --%>
//     		{
<%--     		id:'<%=courCal.getCour_id()%>', --%>
<%--     		title:'<%=courCal.getCname()%>', --%>
    		
    		
<%--     		description:'<%=courCal.getCour_text()%>', --%>
//     		}, 
    		
    		
<%--     		<% --%>
//     		}
<%--     		%> --%>
    		
    		]
    	
    	
    	
    	
        $(document).ready(function() {
//             (function() {
                var date = new Date();
                var d = date.getDate();
                var m = date.getMonth();
                var y = date.getFullYear();

                <!-- 設定fullcalendar--> 
                $('#calendar1').fullCalendar({
                    editable: true,
                    height: 650,
                    width: 500,
                    eventLimit: true,
                    nextDayThreshold: "00:00:00",
                    header: {
                        left: 'title',
                        center: '',
                        right: 'today prev,next'
                    },

                    <!-- eventSources帶入活動和計畫到fullcalendar --> 
                    eventSources: [
                    	{
                    		events: events,
                    		 color: 'green',
                    		 
                    		 editable: false
                    	},
                    	{
                    		
                    		events:plan,
                    		 color: 'red',
                    		 
                    	},
                    	
                    	{
                    		events:cour,
                    		color:'blue',
                    		allDayDefault:true,
                    		editable: false
                    		
                    		
                    	},
                    	
                    ],
                    eventClick: function(calEvent, jsEvent, view) { //計畫條點選事件，表示點擊計畫條之後要幹嘛
                      
                    	var eventcheck = calEvent.id;
                    
                    if(eventcheck.indexOf('E00')>-1){

                        $("#evedialog").dialog({ //對話框的設定
                            autoOpen: false,
                            draggable: true,
                             height: 520,
                            width:620,
                            title: "work it out!",
                        });
                       
             
                        $("#eve_id").html(calEvent.id); //關於對話框(活動)內各數值的設定
                        $("#eve_title").html(calEvent.title); 
                        $("#eve_content").html(calEvent.description);
                        $("#eve_charge").html(calEvent.money);
                        $("#eve_location").html(calEvent.location);
                        
                        $("#eve_startdate").html(moment(calEvent.start).format("YYYY-MM-DD hh:mm A"));
                        $("#eve_enddate").html(moment(calEvent.end).format("YYYY-MM-DD hh:mm A"));
                        $("#eve_chargeToback").val(calEvent.moneytobackend);
                        $("#eve_idTochange").val(calEvent.eveidtochange);
                        
                        $('#evedialog').dialog('open');//對話框開啟
                        
                    }else if(eventcheck.indexOf('PLAN00')>-1){
                    	     $("#plandialog").dialog({ //對話框的設定
                                 autoOpen: false,
                                 draggable: true,
                                  height: 520,
                                 width:620,
                                 title: "work it out!",
                             });
                    	     
                    	     $("#plan_id").val(calEvent.id);
                    	     $("#plan_name").val(calEvent.title);
                    	     $("#plan_start_date").val(moment(calEvent.start).format("YYYY-MM-DD hh:mm"));
                    	     $("#plan_end_date").val(moment(calEvent.end).format("YYYY-MM-DD hh:mm"));
                    	     $("#plan_vo").html(calEvent.description);
                    	     $("#plan_idToDelete").val(calEvent.planidToDelete);
                    	     $('#plan_end_date').datetimepicker({
                    	         theme: '',              //theme: 'dark',
                    	  	       timepicker:true,       //timepicker:true,
                    	  	       step: 5,                //step: 60 (這是timepicker的預設間隔60分鐘)
                    	  	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
                    	  		  // value:   new Date(),
                    	         //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
                    	         //startDate:	            '2017/07/10',  // 起始日
                    	         //minDate:               '-1970-01-01', // 去除今日(不含)之前
                    	         //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
                    	      });
                    	     $('#plan_start_date').datetimepicker({
                    	         theme: '',              //theme: 'dark',
                    	  	       timepicker:true,       //timepicker:true,
                    	  	       step: 5,                //step: 60 (這是timepicker的預設間隔60分鐘)
                    	  	       format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
                    	  		    // value:   new Date(),
                    	         //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
                    	         //startDate:	            '2017/07/10',  // 起始日
                    	         //minDate:               '-1970-01-01', // 去除今日(不含)之前
                    	         //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
                    	      });
                    	     

                             $('#summernote').summernote({

                             	height: 400,         
                             	 popover: {
                             	   image: [],
                             	   link: [],
                             	   air: []
                             	 }
                             	       });      

                             	  //summernote賦值(將文字顯示在summernote上)    
                             	  $("#summernote").summernote("code", calEvent.description);
                             	  //summernote取值
                             	  $("#updatePlan").click(function(){
                             	        var markupStr = $('.note-editable').html();
                             	        $("#plan_vo").val(markupStr);
                             	      });    
                    	     
                    	     $('#plandialog').dialog('open');
                    	     
                    	     
                    	}else{
                    		 $("#courdialog").dialog({ //對話框的設定
                                 autoOpen: false,
                                 draggable: true,
                                  height: 620,
                                 width:620,
                                 title: "work it out!",
                             });
                    		 
                    		 $('#courdialog').dialog('open');
                    		 
                    	 }
                    	 
                    	 
                    }

                   
                });
//             }());


		












        });

    </script>
    <!--    <script src="https://code.jquery.com/jquery-3.2.1.js"></script>-->
      <!-- Script: Smooth scrolling between anchors in a same page -->

	 <link href="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.css" rel="stylesheet">
<script src="http://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.9/summernote.js"></script>
</body>
</html>