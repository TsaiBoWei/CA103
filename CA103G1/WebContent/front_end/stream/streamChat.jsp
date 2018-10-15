<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*" %>
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/neon.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/front_end/stream/css/streamChat.css">
  
  <!-- navbar setting -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/index.css">


  <!-- navbar setting -->
  <style type="text/css">
	
	a,.fontstyle  {
		font-family: Montserrat,Arial,"微軟正黑體","Microsoft JhengHei"!important;
	}
  </style>	
	
</head>
    
<body onload="connect();" onunload="disconnect();">

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



<div class="container mt-5">
	
	
    <div class="row">
        <div class="inbox_people col-12 col-md-6 ">
          <div class="headind_srch">
            <div class="recent_heading">
              <h4>現正直播<span ></span></h4>
<!--          	chatId暫時寫死livechat1  之後不同的直播聊天室可動態改不同的chatId  以chatId為key將聊天記錄儲存在redis -->              
              <input type="hidden" id="chatId" value="livechat1">
            </div>
          </div>
          <div class="inbox_chat">
<!--           	直播連結要改動態寫法 -->
            <iframe width="100%" height="100%" id="liveSrc" src="https://www.youtube.com/embed/<%=application.getAttribute("Stream_id") %>" frameborder="0" allow="autoplay; encrypted-media" allowfullscreen></iframe>

          </div>
        </div>
        <div class="mesgs col-12 col-md-6 ">
          <div class="msg_history"  id="messagesArea">
          </div>
          <div class="type_msg">
            <div class="input_msg_write">
              <input id="message" type="text" class="write_msg" placeholder="Type a message" autofocus onkeydown="if (event.keyCode == 13) sendMessage();"/>
<!--           會員的id跟姓名 -->
              <input id="userName" type="hidden" value="${memVO.mem_name}"/>
     		  <input id="userId" type="hidden" value="${memVO.mem_id}"/>
              <button class="msg_send_btn pb-1 px-auto" type="button" id="sendMessage" onclick="sendMessage();"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
            </div>
          </div>
        </div>
    </div>  
    <h3 id="statusOutput" class="statusOutput"></h3>    
</div>
   
    
<script>
	var userId=document.getElementById("userId").value;
	var chatId=document.getElementById("chatId").value;
    console.log(userId);
    var MyPoint = "/StreamChatServer2/"+chatId;
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	var synth = window.speechSynthesis;
	
	
	function connect() {
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
		};
		
		var history=true;
		webSocket.onmessage = function(event) {			
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
			
	        //第一次進入websocket 取得歷史訊息
	        if(history){	        	
	        	 for(i=0;i<jsonObj.length;i++){
	 	        	var jobj=JSON.parse(jsonObj[i]);	 	        		 	        	
	 	        	showmsg(jobj);        
	 	        }
	        	 history=false;  
	        	 
	        //非歷史訊息 再判斷是由誰發送的訊息	 
	        }else{
	        	//若含有@字元 語音發話
	        	if ( jsonObj.message.includes('@') ) {
	 	        	jsonObj.message = jsonObj.message.replace( 'abc', '' );
	 	        	console.log( jsonObj.message);
	 	        	Speech(jsonObj.message);
	 	        }	        	
	        	showmsg(jsonObj);        	
	        }	        
	        
			function showmsg(jsonObj){				
				//系統發送的訊息
	        	if(jsonObj.userId=='system'){	        		
	        		var message = jsonObj.message + "<br>";
	        	//其他會員發送的訊息	
	        	}else if(jsonObj.userId!=userId){
	        		//訊息是圖片
	        		if(jsonObj.message.indexOf('data:image')!=-1&& jsonObj.message.indexOf('base64')!=-1){
		        		 var message = '<div class="incoming_msg">'+
					                 '<div class="incoming_msg_img">'+
					                 '<img  style="width:100%;height:100%;" src="<%=request.getContextPath() %>/DBChatPicReader?mem_id='+ jsonObj.userId +'"> </div>'+
					                 '<div class="received_msg">'+
					                 '<div class="received_withd_msg">'+
					                 '<img style="width:100%;height:100%;" src="'+jsonObj.message+'" height="200">'+
					                 '<span class="time_date"> 11:01 AM | June 9</span></div></div></div>';
					//訊息是文字
		        	}else{	  		        		
		        		 var message =  '<div class="incoming_msg">'+
					                 '<div class="incoming_msg_img">'+
					                 '<img  style="width:100%;height:100%;" src="<%=request.getContextPath() %>/DBChatPicReader?mem_id='+ jsonObj.userId +'"> </div>'+
					                 '<div class="received_msg">'+
					                 '<div class="received_withd_msg">'+
					                 '<p>'+jsonObj.message+'</p>'+
					                 '<span class="time_date"> 11:01 AM | Yesterday</span></div></div></div>';		        		 
		        	}	        		
	        	//	自己發送的訊息	        		
	        	}else{
	        		//訊息是圖片
	        		if(jsonObj.message.indexOf('data:image')!=-1&& jsonObj.message.indexOf('base64')!=-1){
		        		 var message ='<div class="outgoing_msg">'+
					                 '<div class="sent_msg">'+
					                 '<img style="width: 92%;float: right;" src="'+jsonObj.message+'">'+
					                 '<span class="time_date"> 11:01 AM | June 9</span> </div>'+
					                 '</div>';
					//訊息是文字
		        	}else{	  
		        		
		        		 var message = '<div class="outgoing_msg">'+
					                 '<div class="sent_msg">'+
					                 '<p>'+jsonObj.message+'</p>'+
					                 '<span class="time_date"> 11:01 AM | June 9</span> </div>'+
					              	 '</div>';
		        	}	        		
	        	}
	        	 messagesArea.innerHTML = messagesArea.innerHTML + message;
		 	     messagesArea.scrollTop = messagesArea.scrollHeight;				
			}
	        
		};
		
		
		
		webSocket.onclose = function(event) {
			updateStatus("WebSocket 已離線");
		};
		

	}
	
	
	var inputUserName = document.getElementById("userName");
	
	function sendMessage() {
	    var userName = inputUserName.value.trim();
	    if (userName === ""){
	        alert ("使用者名稱請勿空白!");
			return;
	    }
	    
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	    
	    if (message === ""){
	        alert ("訊息請勿空白!");
	        inputMessage.focus();	
	    }else{
	        var jsonObj = {"userName" : userName, "message" : message,"userId":userId};
	        console.log(JSON.stringify(jsonObj));
	        webSocket.send(JSON.stringify(jsonObj));
	        inputMessage.value = "";
	        inputMessage.focus();
	    }
	}

	
	function disconnect () {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
	}

	
	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
	
	function Speech( message ) {
		 if ('speechSynthesis' in window) with(speechSynthesis) {
				utterance = new SpeechSynthesisUtterance(message);
// 				console.log(getVoices());
				utterance.voice = getVoices()[22];
				speak(utterance); 
		 }
		 
		    else { /* speech synthesis not supported */
		        msg = document.createElement('h5');
		        msg.textContent = "Detected no support for Speech Synthesis";
		        msg.style.textAlign = 'center';
		        msg.style.backgroundColor = 'red';
		        msg.style.color = 'white';
		        msg.style.marginTop = msg.style.marginBottom = 0;
		        document.body.insertBefore(msg, document.querySelector('div'));
		    }
	}
	
	function getStreamId(){
		var url= "<%=request.getContextPath()%>/youtube/listStream.do";
		console.log(url);
		var xhr = new XMLHttpRequest();
		xhr.onload = function (){
	    	if( xhr.status == 200){        
	    		console.log(xhr.responseText);
	    		}
	    	else{
	            alert( xhr.status );
	          }//xhr.status == 200
	    };//onload 
	      
	    xhr.open("Post",url,true);
		xhr.send(null);	      
	}
    
	window.onload= getStreamId;
</script>
 <!-- JavaScript dependencies -->
  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
   <script src="<%=request.getContextPath()%>/js/navbar-ontop.js"></script>
  <script src="<%=request.getContextPath()%>/js/animate-in.js"></script>
  <script type="text/javascript" src="<%=request.getContextPath()%>/js/index.js"></script>

</body>  
</html>