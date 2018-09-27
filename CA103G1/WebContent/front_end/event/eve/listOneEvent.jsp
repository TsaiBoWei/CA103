<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.*" %>
<%@ page import="com.eve.model.*" %> 

<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />
<jsp:useBean id="citySvc" scope="page" class="com.city.model.CityService" />
   
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
  <script src="<%=request.getContextPath() %>/js/navbar-ontop.js"></script>
  <!-- Script: Animated entrance -->
  <script src="<%=request.getContextPath() %>/js/animate-in.js"></script>
  <script src="<%=request.getContextPath() %>/front_end/event/eve/js/SingleEventPage.js"></script>

 <style>  
  .eveImg{
  width:100%;
  }
   #eve_contentDiv,#eve_contentDiv ul,#eve_contentDiv ul li,#eve_contentDiv li,#eve_contentDiv span, #eve_contentDiv span span{
  color:#efefef !important;
  font-size:20px;
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

  
</style>


</head>





<body class="text-center" onload="clock();return true">
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
            <a class="nav-link" href="#schedule">Event</a>
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
  
  <%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
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
              <button class="btn btn-sm  btn-outline-success">${sportTypeMap.get(eveVO.sptype_id)} </button>
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
            	�s���� :<span><%=eveview %></span>&nbsp;&nbsp;
            	���ü� :<span>10</span> &nbsp; </span>
            <span class="pull-right text-warning align-center" style="font-size:24px;"> 
              <form name="formnow" id="countdown">
				    ���W�I��˼� :<input type="text" class="text-warning"name="dd" size=2 style="background-color:transparent; border:0px; text-align:center"> �� <input 
				    type="text" class="text-warning" name="hh" size=1> �p�� <input class="text-warning" type="text" 
				    name="mm" size=1> �� <input type="text" class="text-warning" name="ss" 
				    size=1> ��
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
            <h4 class=" pt-5 mt-3">���ʵo�_�H</h4>
          </div>
          <div>
            <a href="">
              <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/styleguide/people_6.jpg" style="height:100%;">
              <h5 class="p-1 pt-2">${memSvc.getOneMem(eveVO.mem_id).mem_name}</h5>
            </a>
          </div>
          <!-- ���������� ���W���s�n����ܵ��� -->
          
          <jsp:useBean id="eveListSvc" scope="page" class="com.eventlist.model.EventlistService" />
		  	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)==null||eveVO.eve_status=='E4'}"> 
		  		<c:if test="${memVO.mem_id!=eveVO.mem_id}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/front_end/event/eventlist/addeveList.jsp" style="margin-bottom: 0px;">
				    <input type="submit" value="�ߧY���W" class="btn btn-lg btn-block btn-danger my-3 p-1"> 
				    <input type="hidden" name="eve_id"      value="${eveVO.eve_id}">
				    <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller-->
			  		</FORM>
			  	</c:if>					
			</c:if>			
                
<!--           <a class="btn btn-lg btn-block btn-danger my-3 p-1" href="#">�ߧY���W</a> -->
          <div class="d-flex align-self-center align-items-center justify-content-center">
            <a href="#" class="btn btn-sm m-1 btn-outline-success">���� </a>
            <a href="#" class="btn btn-outline-primary btn-sm m-1">���� </a>
            <a href="#" class="btn btn-sm btn-outline-secondary m-1">���| </a>
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
        <!-- �Ĥ@�ӫ��s -->
        <ul class="nav navbar-nav">
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabone" data-toggle="tab">
              <i class="fa fa-info-circle"></i> &nbsp; ���ʸ�T &nbsp;</a>
          </li>
<!--           �ĤG�ӫ��s -->
<!--           <li class="nav-item"> -->
<!--             <a class="nav-link" href="" data-target="#tabtwo" data-toggle="tab"> -->
<!--               <i class="fa fa-bookmark-o" aria-hidden="true"></i>&nbsp; �̷s���� &nbsp;</a> -->
<!--           </li> -->
          <!-- �ĤT�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabthree" data-toggle="tab">
              <i class="fa fa-check-square-o" aria-hidden="true"></i>&nbsp; ���W�d��&nbsp;</a>
          </li>
          <!-- �ĥ|�ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfour" data-toggle="tab">
              <i class="fa fa-map-marker" aria-hidden="true"></i>&nbsp; ��q��T &nbsp; </a>
          </li>
          <!-- �Ĥ��ӫ��s -->
          <li class="nav-item">
            <a class="nav-link" href="" data-target="#tabfive" data-toggle="tab">
              <i class="fa fa-quora" aria-hidden="true"></i> &nbsp; ���D�Ը� &nbsp; </a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  <div class="container containerHrB ">
    <hr> </div>
  <!-- ���� -->
  <div class="tab-content mt-2 px-5">
    <div class="tab-pane fade show active" id="tabone" role="tabpanel">
      <div class="container">
        <div class="row d-block text-left px-5">
          <h3 class="py-1">���ʤ�� :
            <div>
            	<fmt:formatDate value="${eveVO.eve_startdate}" pattern="yyyy-MM-dd HH:mm "/>~			
				<fmt:formatDate value="${eveVO.eve_enddate}" pattern="yyyy-MM-dd HH:mm"/>           
            </div>
          </h3>
          <h3 class="py-1">���W�ɶ� :
            <div>
            	<fmt:formatDate value="${eveVO.ereg_startdate}" pattern="yyyy-MM-dd "/>~					
				<fmt:formatDate value="${eveVO.ereg_enddate}" pattern="yyyy-MM-dd"/>
            </div>
          </h3>
          <h3 class="py-1">���ʦ���H�� :
            <span>${eveVO.estart_limit}</span>�H</h3>
          <h3 class="py-1">���W�O�� :
            <span>
	            <c:if test="${eveVO.eve_charge==0}">
				    �K�O
				</c:if>
				
				<c:if test="${eveVO.eve_charge!=0}">
				   ${eveVO.eve_charge}��/�H
				</c:if>		          
            </span></h3>
          <h3 class="py-1">���ʤ��� : </h3>
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
		            <h3>�п�J�z���b�� :<input type="text" name="mem_account" id="mem_account"></h3>
		            <h3>�п�J�z���K�X :<input type="password" name="mem_password" id="mem_password"></h3>
		            <div class="text-center">
		            	<button class="btn btn-lg  btn-info my-3 p-2" onClick="getEvelist();">�d��</button>
	            	</div>
	            
             </c:if>
           </div>
            
         
          <div class="col-md-3"></div>
          <div class="col-md-3"></div>
          <div  class="col-md-12 text-center" id="showElistCheck"> 
          	<c:if test="${(eveVO.mem_id==memVO.mem_id)}">
          		<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" >
          			<button type="ssubmit" class="btn">�d�ݬ��ʳ��W���A</button>
          			<input type="hidden" name="eve_id" value="${eveVO.eve_id}">
          			<input type="hidden" name="action" value="getEvelists_By_EVE">
          		</FORM>
          	</c:if>         		
          	<c:if test="${(memVO!=null)&&(eveVO.mem_id!=memVO.mem_id)}">
             	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)==null }">
             		<h3>�ثe�L���ʲM����</h3>
             	</c:if>
             	<c:if test="${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id)!=null }">
             		<table class='evelistTable text-left' align='center'>
             			<tr><th>�m�W</th><td>&nbsp&nbsp ${memVO.mem_name}</td></tr>
             			<tr><th>���ʦW��</th><td>&nbsp&nbsp ${eveVO.eve_title}</td></tr>
             			<tr><th>���ʥI�ڪ��B</th><td>&nbsp&nbsp ${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evepay_amount}��</td></tr>
             			<tr><th>���ʥI�ںI���</th><td>&nbsp&nbsp ${eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evepay_deadline==null?'�L':eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evepay_deadline}</td></tr>
             			<tr><th >���ʲM�檬�A</th><td>&nbsp&nbsp ${eveListStatusMap.get((eveListSvc.getOneEveList(memVO.mem_id,eveVO.eve_id).evelist_status))}</td></tr>             		
     				</table>        	
             	</c:if>
          	 </c:if>		         
          </div> 
          <div class="col-md-3 offset-md-5"  >
		      <button class="btn btn-lg  btn-info my-3 p-2 " style="display:none;" id="reshowElBtn" onClick="reshowElCheck();">���s�d��</button>
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
            <h3>���ʦa�I : </h3>
            <p class="px-4" id="eve_locationP">${eveVO.eve_location}</p>
          </div>
        </div>
        <h3 class="">���ʦa��</h3>
        <div class="row">
          <div class="col-md-12">
            <img class="d-block img-fluid img-thumbnail mx-auto" src="https://maps.googleapis.com/maps/api/staticmap?key=AIzaSyDW8nO9JhT_pEjebobq9pgUF2cEp0EUb1I&amp;markers=%E4%B8%AD%E5%A4%AE%E5%A4%A7%E5%AD%B8&amp;center=%E4%B8%AD%E5%A4%AE%E5%A4%A7%E5%AD%B8&amp;zoom=16&amp;size=800x350&amp;sensor=false"> </div>
        </div>
      </div>
    </div>
    <div class="tab-pane fade" id="tabfive" role="tabpanel">
      <div class="container px-5">
        <div class="row d-block text-left">
          <div class="col-md-6 offset-md-3" >
            <h3>�s���q�� : ${eveVO.econtact_info} </h3>
            <h3>�s���H�c : ${memSvc.getOneMem(eveVO.mem_id).mem_email}</h3>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="py-5" id="speakers">
    <div class="container ">
      <div class="row ">
        <div class="col-12 col-md-12">
          <h2>�M�ݱ��ˬ���</h2>
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
            <div class="row mr-4 ml-4">
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
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
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/01.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title2</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
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
            <div class="row mr-4 ml-4">
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
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
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
                <a href="#">
                  <img src="<%=request.getContextPath() %>/front_end/event/eve/assets/conference/02.png" class="center-block img-fluid my-3 shadowed" width="300">
                  <div class="carousel-caption img-tip">
                    <h1>Event title5</h1>
                    <h4>about the Event!</h4>
                  </div>
                </a>
              </div>
              <div class="col-lg-4 col-md-4 img-group pr-0 pl-0  ">
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
  <!-- Schedule -->
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
			   str += "<tr><th>�m�W</th><td>&nbsp&nbsp"+ evelist.mem_name +"</td></tr>";
			   str += "<tr><th>���ʦW��</th><td>&nbsp&nbsp ${eveVO.eve_title}</td></tr>";
			   str += "<tr><th>���ʥI�ڪ��B</th><td>&nbsp&nbsp"+ evelist.evepay_amount+"</td></tr>";
			   str += "<tr><th>���ʥI�ںI���</th><td>&nbsp&nbsp"+ evelist.evepay_deadline +"</td></tr>";
			   str += "<tr><th>���ʲM�檬�A</th><td>&nbsp&nbsp"+ evelist.evelist_status +"</td></tr>";
			   str += "</table>"; 
			   document.getElementById("showElistCheck").innerHTML = str;
    		
    	}
    	
    
	    function getEvelist(){
	    	document.getElementById("evelistCheck").style.display="none";
	    	
	    	var xhr = new XMLHttpRequest();
		    //�]�w�n�^�I���   
		    xhr.onload = function (){
		        if( xhr.status == 200){
	// 		          
						console.log(xhr.responseText);
					  if(xhr.responseText=='noneMem'){
						  document.getElementById("showElistCheck").innerHTML = "<p class='text-center'>�d�L�|�����</p>";
						  document.getElementById("reshowElBtn").style.display="";
					  }	else if(xhr.responseText=='noneEvelist'){			  
						  document.getElementById("showElistCheck").innerHTML = "<p class='text-center'>�ثe�S���z�����ʸ�T</p>";
						  document.getElementById("reshowElBtn").style.display="";	
					  }else if(xhr.responseText=='organizer'){
						  document.getElementById("reshowElBtn").style.display="";	
						  document.getElementById("showElistCheck").innerHTML = "<p class='text-center'>�Ьd�ݬ��ʺ޲z����</p>";
					  }else{
						  showEvelist(xhr.responseText);
					  }
		        	 
		        }else{
		          alert( xhr.status );
		        }//xhr.status == 200
		    };//onload 
		    
		    //�إߦnGet�s��
		    var url= "<%=request.getContextPath() %>/eventlist/eventlist.do?action=get_Mem_Evelist&mem_account=" + document.getElementById("mem_account").value+
		    		"&mem_password="+document.getElementById("mem_password").value+"&eve_id=${eveVO.eve_id}";
		    xhr.open("Get",url,true); 
		    //�e�X�ШD 
		    xhr.send( null );    
	    	
	    }
	    
    </script>
    
    <script language="JavaScript">
       	  //�����W�I����
       	  var ereg_endtime=document.getElementById("ereg_endtime").innerText;
       	  var format_time =ereg_endtime.replace(/-/g,'/');
       	  var Tday = new Date(format_time)
       	  console.log(Tday>new Date());
       	 if(Tday<new Date()){
        		document.getElementById("countdown").innerText="���W�w����";
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
  
  
  
  
  
  <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  <button id="goTopBtn" style="cursor:pointer;position: fixed;bottom: 10px;right:10px;padding:4px;background-color: #00b0eb;border-radius: 8px; width:80px;display:flex;flex-direction:row;align-items:center;justify-content:center;font-size:14px;color:white">
  GoTop </button>
  
</body>

</html>