<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %>

<%	
	List<EventVO> list =(List<EventVO>)session.getAttribute("listEves_ByCompositeQuery");
	Map sportTypeMap =(Map)application.getAttribute("sportTypeMap");
	EveService eveSvc = new EveService();
	
	if(list==null){		
		list = eveSvc.getEvesInViewPage();		
	}	
	pageContext.setAttribute("list",list);
	System.out.println(list.size());
%>

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- PAGE settings -->
  <link rel="icon" href="https://templates.pingendo.com/assets/Pingendo_favicon.ico">
  <title>Conference Neon - Pingendo template</title>
  <meta name="description" content="Free Bootstrap 4 Pingendo Neon template for unique events.">
  <meta name="keywords" content="Pingendo conference event neon free template bootstrap 4">
  <!-- CSS dependencies -->
    
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" type="text/css">
  <!-- Script: Make my navbar transparent when the document is scrolled to top -->
  <!--  self-defined css  -->

  <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
   <script src="<%=request.getContextPath() %>/front_end/event/eve/js/listAllView.js"></script>
   <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  
  <!-- datetimepicker-->	
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
  <script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
  <script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>	
 
  <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">
  <link rel="stylesheet" href="<%=request.getContextPath() %>/front_end/event/eve/css/listAllView.css">
  
  
    
  <style type="text/css">
  	#map {
    height: 400px;
    width: 100%;
  }
  
	.mapInfoText{
	   color:black !important;
	   font-weight: bold !important;
	   font-family: Montserrat,Arial,"�L�n������","Microsoft JhengHei" !important;
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
            <a class="nav-link" href="#schedule">WorkOutPlan</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="<%=request.getContextPath() %>/front_end/event/eve/listAllEve.jsp">Event</a>
          </li>
          <li class="nav-item mx-2 btn-lg">
            <a class="nav-link" href="#speakers">Course</a>
          </li>
          <li class="nav-item mx-2 btn-lg dropdown" id="navUserBtn">
            <a class="nav-link dropbtn" href="javascript:void(0)" id="navUserName">User&nbsp;
              <i class="fa fa-caret-down dropbtn"></i>
            </a>
            <div class="dropdown-content" id="myDropdown">
              <a href="#">
                <i class="fa fa-file">&nbsp;&nbsp;�ӤH����</i>
              </a>
              <a href="#">
                <i class="fa fa-calculator">&nbsp;&nbsp;�p�e</i>
              </a>
              <a href="#">
                <i class="fa fa-users" aria-hidden="true">&nbsp;&nbsp;�n��</i>
              </a>
              <a href="#">
                <i class="fa fa-film" aria-hidden="true">&nbsp;&nbsp;�ҵ{</i>
              </a>
              <a href="#">
                <i class="fa fa-hand-spock-o" aria-hidden="true">&nbsp;&nbsp;����</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;�K��</i>
              </a>
              <a href="#">
                <i class="fa fa-sticky-note" aria-hidden="true">&nbsp;&nbsp;��ƾ�</i>
              </a>
              <a href="#">�n�X</a>
            </div>
          </li>
        </ul>
        <a class="btn btn-lg btn-primary" href="#" id="registerBtn">Register now</a>
      </div>
    </div>
  </nav>
  <!-- Cover -->
  <div class="align-items-center  section-fade-in-out " id="coverfirstImg" style="background: url(&quot;<%=request.getContextPath() %>/front_end/event/eve/assets/conference/cover_marathon.png&quot;);"> 
  </div>
  
  <%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>


  <div class="container-fluid  pb-2 row   m-3">
    <div class="col-md-8 offset-md-2 bg-info  pt-3">
      <form  METHOD="post" class="form-inline eveComQuery" ACTION="<%=request.getContextPath()%>/eve/event.do" name="form1">
          <div class="col-md-3 mb-3 d-flex">
            <label for="keyword" class="orderBy ">����r&nbsp</label>
            <input type="text" class="form-control" name="keyword"  style="width: 60%;" id="keyword" >
          </div>
          <div class="col-md-6 mb-3  d-flex">
            <label for="eve_startdate " class="orderBy ">���ʮɶ�&nbsp</label>
            <input type="text" name="eve_startdate" class="form-control" id="eve_startdate"  >
             <input type="text" name="eve_enddate" class="form-control" id="eve_enddate" >
          </div>
          <div class="col-md-3 mb-3  d-flex">
            <label for="validationDefaultUsername" class="orderBy">���B&nbsp</label>
            <div class="input-group">
              <select size="1" name="eve_charge"  class="custom-select" style="width: 20%;" >
                <option value="">����
                <option value="0">�K�O        
                <option value="300">300���H�U
                <option value="500">300��~500��
                <option value="1000">500��~1000��
                <option value="1001">1000���H�W
              </select>
            </div>
          </div>
             
          <div class="col-md-3 mb-2  d-flex">
            <label for="validationDefault03" class="orderBy ">���ʦa��&nbsp</label>
              <select size="1" name="city_id" class="custom-select" name="city_id" style="width: 50%;">
                  <option value="">���x�W
                 <c:forEach var="cityVO" items="${citySvc.all}" > 
                  <option value="${cityVO.city_id}">${cityVO.city_name}
                 </c:forEach>   
               </select>
          </div>
          <div class="col-md-2   mb-2  d-flex">
            <label for="validationDefault04" class="orderBy " >���O&nbsp</label>
            <select size="1" name="sptype_id" class="custom-select" style="width: 60%;">
               <option value="">����
              <c:forEach var="sptype" items="${sportTypeMap}" > 
               <option value="${sptype.key}">${sptype.value}
              </c:forEach>   
            </select>
          </div>
          <div class="col-md-7 mb-2 form-inline">
            <div class="form-group">
              <div class="form-check form-check-inline">
                <div class="orderBy">�ƧǨ�&nbsp&nbsp</div>
                <input class="form-check-input" type="radio"  id="inlineRadio1" name="orderBy" value="hot" checked >
                <label class="form-check-label orderBy" for="inlineRadio1">��������</label>
              </div>
              <div class="form-check form-check-inline">

                <input class="form-check-input" type="radio" name="orderBy" id="inlineRadio2" value="eve_startdate">
                <label class="form-check-label orderBy" for="inlineRadio2">���ʮɶ�</label>
              </div>
              <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="orderBy" id="inlineRadio3" value="new" >
                <label class="form-check-label orderBy" for="inlineRadio3">�̷s�Z�n</label>
              </div>
              
            </div>
            <div >
          	  <button class="btn btn-primary btn-lg  ml-2" type="submit">Search</button>
              <input type="hidden" name="action" value="listEves_ByCompositeQuery">
          </div>
          </div>
          
      </form>      
    </div>
    
    <div class="btn btn-lg  btn-success  p-1 col-md-1  align-self-center addEveBtn mx-auto" ><a href='<%=request.getContextPath()%>/front_end/event/eve/addEve.jsp' class="text-light h3 text-center  ">New&nbsp ! <br>�s�W����</a></div>
  </div>
  
  
<c:if test='${eveQuery!=null}'>
	<div class='container' >
		<div class="row">
			<div class='col-md-8'>
				<p class=' text-left searchCondition'>�d�߱���-
					${eveQuery.keyword} ${eveQuery.eve_startdate} ${eveQuery.eve_enddate} ${eveQuery.eve_charge}
					${eveQuery.city_id} ${eveQuery.sptype_id} ${eveQuery.orderBy}
				</p>
			</div>
			<div class='col-md-4'>
				<p class='h4 text-right searchCondition' >��Ƶ���&nbsp<%=list.size() %></p>
			</div>	
		</div>
	</div>
</c:if>
  
  
  <!--Google MAP -->
  <div class="container pb-4">
    <div class="row"> 
    	<div class='col-md-12'>
	    	<div>   
			    <div id="map"></div>
			</div>
		</div>
    </div>
  </div> 


<div class='container' id='content-wrapper'>

	<div class='row py-2'>
		<div class='d-flex w-100'>
<c:forEach var="eveVO" items="${list}" begin="0" end="2">
						
				<div class='bg-warning mr-3 col-md-4  text-left' >					 
					 <img class='pt-2' style='width: 100%;' src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
					  <div class="text-center"><h4 class='eveCardText pt-1 px-2 text-center'> ${eveVO.eve_title} </h4></div>
					 <h4 class='eveCardText px-2'>���ʮɶ� : <fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy-MM-dd H��m�� "/>~</h4>
					 <h4 class='eveCardText px-2'><span style='visibility:hidden; '>���ʤ�� : </span><fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy-MM-dd H��m��"/></h4>
				     <h4 class='eveCardText px-2'>���W��� :
						<fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy-M-d "/>~					
						<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy-M-d"/></h4>
					<h4 class="eveCardText px-2">���O���B : ${eveVO.eve_charge}</h4>
					<div class='text-right px-2 h5'>						
						<button class="btn btn-sm  btn-info">${sportTypeMap.get(eveVO.sptype_id)} </button>
						<button class="btn btn-sm  btn-success">${citySvc.getCityName(eveVO.city_id)} </button>
						<i class="fa fa-eye"></i>${eveVO.eve_view}
					</div>
							
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" >
						<c:if test="${eveVO.eve_status!='E5'}">
							<button type='submit' class='btn btn-block regbtn'>${eveVO.eve_status=='E4'?'���W�w����':'�ߧY���W'}</button>
						</c:if>
						<c:if test="${eveVO.eve_status=='E5'}">
							<button type='submit' class='btn btn-block regbtn'>�d�ݬ���</button>
						</c:if>					
						<input type="hidden" name="action" value="getOne_For_Display">
						<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
				    </FORM>		
				</div>				
</c:forEach>
		</div>	
	</div>
	
		<div class='row py-2'>
		<div class='d-flex w-100'>
<c:forEach var="eveVO" items="${list}" begin="3" end="5">
					
				<div class='bg-warning mr-3  text-left col-md-4 ' >					 
					 <img class='pt-2' style='width: 100%;' src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
					  <div class="text-center"><h4 class='eveCardText pt-1 px-2 text-center'> ${eveVO.eve_title} </h4></div>
					 <h4 class='eveCardText px-2'>���ʮɶ� : <fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy-MM-dd H��m�� "/>~</h4>
					 <h4 class='eveCardText px-2'><span style='visibility:hidden; '>���ʤ�� : </span><fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy-MM-dd H��m��"/></h4>
				     <h4 class='eveCardText px-2'>���W��� :
						<fmt:formatDate value="${eveVO.ereg_startdate	}" pattern="yyyy-M-d "/>~					
						<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy-M-d"/></h4>
					<h4 class="eveCardText px-2">���O���B : ${eveVO.eve_charge}</h4>
					<div class='text-right px-2 h5'>						
						<button class="btn btn-sm  btn-info">${sportTypeMap.get(eveVO.sptype_id)} </button>
						<button class="btn btn-sm  btn-success">${citySvc.getCityName(eveVO.city_id)} </button>
						<i class="fa fa-eye"></i>${eveVO.eve_view}
					</div>		
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" >
						<button type='submit' class='btn btn-block regbtn'>${eveVO.eve_status=='E4'?'���W�w����':'�ߧY���W'}</button>
						<input type="hidden" name="action" value="getOne_For_Display">
						<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
				    </FORM>		
				</div>				
</c:forEach>
		</div>	
	</div>
	
	
		<div class='row py-2'>
		<div class='d-flex w-100'>		
<c:forEach var="eveVO" items="${list}" begin="6" end="8">	
		
				<div class='bg-warning mr-3  text-left col-md-4 ' >					 
					 <img class='pt-2' style='width: 100%;' src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${eveVO.eve_id}">
					  <div class="text-center"><h4 class='eveCardText pt-1 px-2 text-center'> ${eveVO.eve_title} </h4></div>
					 <h4 class='eveCardText px-2'>���ʮɶ� : <fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy-MM-dd H��m�� "/>~</h4>
					 <h4 class='eveCardText px-2'><span style='visibility:hidden; '>���ʤ�� : </span><fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy-MM-dd H��m��"/></h4>
				     <h4 class='eveCardText px-2'>���W��� :
						<fmt:formatDate value="${eveVO.ereg_startdate	}" pattern="yyyy-M-d "/>~					
						<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy-M-d"/></h4>
					<h4 class="eveCardText px-2">���O���B : ${eveVO.eve_charge}</h4>
					<div class='text-right px-2 h5'>						
						<button class="btn btn-sm  btn-info">${sportTypeMap.get(eveVO.sptype_id)} </button>
						<button class="btn btn-sm  btn-success">${citySvc.getCityName(eveVO.city_id)} </button>
						<i class="fa fa-eye"></i>${eveVO.eve_view}
					</div>							
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/eve/event.do" >
						<button type='submit' class='btn btn-block regbtn'>${eveVO.eve_status=='E4'?'���W�w����':'�ߧY���W'}</button>
						<input type="hidden" name="action" value="getOne_For_Display">
						<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
				    </FORM>		
				</div>				
</c:forEach>
		</div>	
	</div>	
</div>


<!-- Sponsor logos -->
  <div class="py-5 section sponsor-div">
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
            <br> Copyright 2018 Pingendo - All rights reserved.
            <br>
            <br> </p>
        </div>
      </div>
    </div>
  </footer>

  
  
  <script >
  //�ƨ쩳���e�Xajax�ШD���ͤ��e
    $(document).ready(function(){
        contentLoadTriggered = false;
        var index=3;
        $(window).scroll(function(){
//         	console.log($(window).scrollTop());
//         	console.log($(document).height() - $(window).height() );
            if($(window).scrollTop() > ( $(document).height() - $(window).height() - 50) && contentLoadTriggered == false)
            {
            	console.log(index);
                contentLoadTriggered = true;
                var result="";
                           
                $.ajax({
              	  url: "<%=request.getContextPath() %>/ScrollTest?index="+index,
              	  type: "GET",
              	  dataType: "json",
              	  success: function(JData) {
              	  index++;
              	  console.log(JData);
              	  contentLoadTriggered = false;
              		            		     
              	  if(JData[0].eve_charge>=0){
              		  
              	  	var id="scrollresult"+index;
              	  	var jid="#"+id;
              	  	result="<div class='row py-2 '  ><div class='d-flex w-100' id='"+id+"'></div></div>";
              			
          			$("#content-wrapper").append(result);
          			
              		$.each(JData, function(i, field) {
              	              			              		
	              		result="<div class='bg-warning mr-3 text-left col-md-4 ' >"+              				
	              				"<img class='pt-2' style='width: 100%;' src='<%=request.getContextPath() %>/eve/DBPicReader?eve_id="+ field.eve_id +"'>";
	              			
	              		var newDate =field.eve_startdate.replace(/-/g,'/');
	              		var eve_startdate=new Date(newDate);
	              		var eve_startStr=eve_startdate.getFullYear().toString() +"-" +(eve_startdate.getMonth() + 1)+"-"  + eve_startdate.getDate()+" "  + eve_startdate.getHours()+"��"+ eve_startdate.getMinutes()+"��";
	              		
	              		var newDate1 =field.eve_enddate.replace(/-/g,'/');
	              		var eve_enddate=new Date(newDate1);
	              		var eve_endStr=eve_enddate.getFullYear().toString() +"-" +(eve_enddate.getMonth() + 1)+"-"  + eve_enddate.getDate()+" "  + eve_enddate.getHours()+"��"+ eve_enddate.getMinutes()+"��";
	              		
	              		var newDate2 =field.ereg_startdate.replace(/-/g,'/');
	              		var ereg_startdate=new Date(newDate2);
	              		var ereg_startStr=ereg_startdate.getFullYear().toString() +"-" +(ereg_startdate.getMonth() + 1)+"-"  + ereg_startdate.getDate();
	              		
	              		var newDate3 =field.ereg_enddate.replace(/-/g,'/');
	              		var ereg_enddate=new Date(newDate3);
	              		var ereg_endStr=ereg_enddate.getFullYear().toString() +"-" +(ereg_enddate.getMonth() + 1)+"-"  + ereg_enddate.getDate();
	              		
	              		result+="<div class='text-center'><h4 class='eveCardText pt-1 px-2'>"+ field.eve_title +"</h4></div>"+
	              						 "<h4 class='eveCardText px-2'>���ʮɶ� : &nbsp"+ eve_startStr +"~</h4>"+
	              						 "<h4 class='eveCardText px-2'><span style='visibility:hidden; '>���ʤ�� : </span>"+ eve_endStr +"</h4>";
	              			               						 
	              		result+="<h4 class='eveCardText px-2'>���W��� : "+ ereg_startStr+"~" +ereg_endStr+"</h4>";
	              		
	              		var eve_charge=field.eve_charge==0?'�K�O':field.eve_charge+'��';
	              		
	              		var eve_status;
	              		if(ereg_startdate<new Date()){
	              			if(field.eve_status=='E4'){
	              				eve_status='�w�B��';		              				
	              			}else{
	              				eve_status='�ߧY���W';
		              		}
		              	}else{
		              		eve_status='�d�ݬ���'
		              	}
		              				              		
	              		var sport_id=["SP000001","SP000002","SP000003","SP000004","SP000005","SP000006","SP000007",];
	              		var sport_name=["�Ю|","�樮","�y��","���V","����","�Z�N","���W","�䥦"];
	              		var sp_index=sport_id.indexOf(field.sptype_id);
	              		var sptype=sport_name[sp_index];
	              		
	              		var city_id=["CITY01","CITY02","CITY03","CITY04","CITY05","CITY06","CITY07","CITY08","CITY09","CITY10","CITY11","CITY12","CITY13","CITY14","CITY15","CITY16"];
	              		var city_name=["�x�_","�s�_","���","�s��","�]��","�x��","����","���L","�n��","�Ÿq","�x�n","����","�̪F","�y��","�Ὤ","�x�F"];
	              		var city_index=city_id.indexOf(field.city_id);
	              		var city=city_name[city_index];
	              		
	              
	              		result+="<h4 class='eveCardText px-2'>���O���B : "+ eve_charge +"</h4>"+
	              				"<div class='text-right px-2 h5'>"+
	              				"<button class='btn btn-sm  btn-info mx-1'>"+sptype+"</button>"+
	    						"<button class='btn btn-sm  btn-success mr-1'>"+city+"</button>"+
	              				"<i class='fa fa-eye'></i>"+field.eve_view+"</div>"+
	              				"<FORM METHOD='post' ACTION='<%=request.getContextPath()%>/eve/event.do' ><button type='submit' class='btn btn-block regbtn'>"+eve_status+"</button>"+
	              				"<input type='hidden' name='action' value='getOne_For_Display'>"+
	              				"<input type='hidden' name='eve_id' value='"+field.eve_id+"'></FORM>";
              			              					
	              		result+="</div>";
	                    $(jid).append(result);
	                      	  
	              	});//.each
              	   }  //if JData[0].eve_charge>=0
              	 }  //sucess
              }); //.ajax                
            }  // if $(window).scrollTop()
        }); //window.scroll
    }); //document.ready
    
</script>


<script>
var map;
var markers = [];
var infoWindow ;
var map;

 //��l��Map
function initMap() { 	
    map = new google.maps.Map(document.getElementById('map'), {
      zoom: 14,
      center: {
        lat: 25.0336962,
        lng: 121.5643673
      }
    });
    
    //���ۭͦq���s 
    var centerControlDiv = document.createElement('div');
    var centerControl = new CenterControl(centerControlDiv, map);

    centerControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.TOP_CENTER].push(centerControlDiv);
    searchEve();
}


function searchEve(){ 
	  var xhr = new XMLHttpRequest();
	  xhr.onload = function (){
	      if( xhr.status == 200){
	        //document.getElementById("showPanel").innerHTML = xhr.responseText;
	        showEveMarker(xhr.responseText);
	      }else{
	        alert( xhr.status );
	      }//xhr.status == 200
	  };//onload 
	  
	  //�إߦnGet�s��
	  var url= "<%=request.getContextPath() %>/EveMap";
	  xhr.open("Get",url,true); 
	  //�e�X�ШD 
	  xhr.send( null );
}
 
 
function showEveMarker(jsonStr) {
	
  	infoWindow = new google.maps.InfoWindow();
    clearMarkers();
   
	var jArray = JSON.parse(jsonStr);
  	console.log(jArray);
  	  	
  	 // bounds���a�ϥi�Hzoom�H��ܩҦ�marker
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0; i < jArray.length; i++) {
      addMarker(i,bounds);
    }
    if(jArray.length<2){
    	var pos = {
          lat: jArray[0].eve_lat,
          lng: jArray[0].eve_long
        };
    	map.setZoom(12);
    	map.setCenter(pos);
    }else{
    	map.fitBounds(bounds);
    }



	function addMarker(e,bounds) {

		//infowindow�����e
		var html = '<h4 class="mapInfoText">'+ jArray[e].eve_title +'</h4>'+
		 	'<div style="width:200px;">'+
		 	'<a href="<%=request.getContextPath()%>/eve/event.do?action=getOne_For_Display&eve_id='+jArray[e].eve_id+'">'+
		 	'<img class="infoImg"  style="width:100%;" src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id='+ jArray[e].eve_id +'"></a></div>';
			    
  		var marker= new google.maps.Marker({
          position: {
            lat: jArray[e].eve_lat,
            lng: jArray[e].eve_long
          },
          map: map,
          animation: google.maps.Animation.DROP
        });

  		//�Nmarker��Jmarkers�}�C �]�winfowindow
	    setTimeout(function() {
	      markers.push(marker);
	    }, e * 150);
	    marker.addListener('click', function() {
	    	 infoWindow.setContent(html);
	   		 infoWindow.open(map, marker);
		});
	    
		bounds.extend({
            lat: jArray[e].eve_lat,
            lng: jArray[e].eve_long
          });
	}
	
	function clearMarkers() {
		infoWindow.close();		
	    for (var i = 0; i < markers.length; i++) {
	      markers[i].setMap(null);
	    }
	    markers = []; 
	}
	
}

//�]�wmap�W���ۭq���s�˦�
function CenterControl(controlDiv, map) {

  // �]�w�ۭq���s���~��css
  var controlUI = document.createElement('div');
  controlUI.style.backgroundColor = '#ffc343';
  controlUI.style.border = '2px solid #fff';
  controlUI.style.borderRadius = '3px';
  controlUI.style.boxShadow = '0 2px 6px rgba(0,0,0,.3)';
  controlUI.style.cursor = 'pointer';
  controlUI.style.marginBottom = '22px';
  controlUI.style.textAlign = 'center';
  controlUI.title = '�d�ݪ��񪺬���';
  controlDiv.appendChild(controlUI);

  // �]�w�ۭq���s������css
  var controlText = document.createElement('div');
  controlText.style.color = 'rgb(25,25,25)';
  controlText.style.fontSize = '16px';
  controlText.style.lineHeight = '38px';	
  controlText.style.paddingLeft = '5px';
  controlText.style.paddingRight = '5px';
  controlText.innerHTML = '���񬡰ʷj�M';
  controlUI.appendChild(controlText);

  // �]�w�I���ɱN���߲��ܷ�e��m �����marker
  controlUI.addEventListener('click', function() {	
		if (navigator.geolocation) {
	        navigator.geolocation.getCurrentPosition(function(position) {
	            var pos = {
	                lat: position.coords.latitude,
	                lng: position.coords.longitude
	            };
	            var marker = new google.maps.Marker({
	                position: pos,
	                icon:'assets/conference/logo_4.png',
	                map: map
	            });
	            map.setZoom(12);
	            map.setCenter(pos);
			    
	        });
	    } else {
	        // Browser doesn't support Geolocation
	        alert("�����\�ξD�J���~�I");	      
	    }
  });

}
</script>
 

	





<script>

//datetimepicker
$.datetimepicker.setLocale('zh');
$('#eve_startdate').datetimepicker({
   theme: '',              //theme: 'dark',
   timepicker:true,       //timepicker:true,
   step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
   format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
});


$.datetimepicker.setLocale('zh');
$('#eve_enddate').datetimepicker({
   theme: '',              //theme: 'dark',
   timepicker:true,       //timepicker:true,
   step: 30,                //step: 60 (�o�Otimepicker���w�]���j60����)
   format:'Y-m-d H:i',         //format:'Y-m-d H:i:s',
});

</script>
 

  <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <button id="goTopBtn" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:80px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">
  GoTop </button>
  <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyASI3sgz6P-wisrPe6D4N59Ro0RrodnHJM&callback=initMap" async defer></script>  
</body>

</html>