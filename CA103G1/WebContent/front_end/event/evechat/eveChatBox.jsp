<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>


<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />


<%  //模擬會員的SESSION
	session.setAttribute("memVO", memSvc.getOneMem("M000001"));
%>


<%	//取出會員的SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>

<!DOCTYPE html>    
    
<html>
<head>
<!-- https://bootsnipp.com/tags/chat -->
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.css" type="text/css" rel="stylesheet">
 <link rel="stylesheet" href="<%=request.getContextPath() %>/css/neon.css">


<style type="text/css">

img{ max-width:100%;}
.inbox_people {
  background: #f8f8f8 none repeat scroll 0 0;
  overflow: hidden;
  position: fixed;
  top: 0;
  bottom: 0;
  right: 15px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}


.recent_heading {float: left; width:40%;}
.srch_bar {
  display: inline-block;
  text-align: right;
  width: 60%; padding:
}
.headind_srch{ padding:10px 29px 10px 20px; overflow:hidden; border-bottom:1px solid #c4c4c4;}

.recent_heading h4 {
  color: #05728f;
  font-size: 21px;
  margin: auto;
}
.srch_bar input{ border:1px solid #cdcdcd; border-width:0 0 1px 0; width:80%; padding:2px 0 4px 6px; background:none;}
.srch_bar .input-group-addon button {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  padding: 0;
  color: #707070;
  font-size: 18px;
}
.srch_bar .input-group-addon { margin: 0 0 0 -27px;}

.chat_ib h5{ font-size:15px; color:#464646; margin:0 0 8px 0;}
.chat_ib h5 span{ font-size:13px; float:right;}
.chat_ib p{ font-size:14px; color:#989898; margin:auto}
.chat_img {
  float: left;
  width: 11%;
}
.chat_ib {
  float: left;
  padding: 0 0 0 15px;
  width: 88%;
}

.chat_people{ overflow:hidden; clear:both;}
.chat_list {
  border-bottom: 1px solid #c4c4c4;
  margin: 0;
  padding: 18px 16px 10px;
}
.inbox_chat { height: 550px; overflow-y: scroll;}

.active_chat{ background:#ebebeb;}

.incoming_msg_img {
  display: inline-block;
  width: 10%;
}
.received_msg {
  display: inline-block;
  padding: 0 0 0 10px;
  vertical-align: top;
  width: 88%;
 }
 .received_withd_msg p {
  background: #ebebeb none repeat scroll 0 0;
  border-radius: 3px;
  color: #646464;
  font-size: 14px;
  margin: 0;
  padding: 5px 10px 5px 12px;
  width: 100%;
}
.time_date {
  color: #747474;
  display: block;
  font-size: 12px;
  margin: 8px 0 0;
}
.received_withd_msg { width: 85%;}
.mesgs {
  height:300px;
  background-color:white;

}

 .sent_msg p {
  background: #05728f none repeat scroll 0 0;
  border-radius: 3px;
  font-size: 14px;
  margin: 0; color:#fff;
  padding: 5px 10px 5px 12px;
  width:100%;
}
 .sent_msg img {
  background: #05728f none repeat scroll 0 0;
  border-radius: 3px;
  margin: 0; color:#fff;
  padding: 5px 10px 5px 12px;

}

.outgoing_msg{ overflow:hidden; margin:26px 0 26px;}
.sent_msg {
  float: right;
  width: 80%;
}
.input_msg_write input {
  background: rgba(0, 0, 0, 0) none repeat scroll 0 0;
  border: medium none;
  color: #4c4c4c;
  font-size: 15px;
  min-height: 48px;
  width: 72%;
}

.type_msg {border-top: 1px solid #c4c4c4;position: relative;}
.msg_send_btn {
  background: #05728f none repeat scroll 0 0;
  border: medium none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  font-size: 17px;
  height: 33px;
  position: absolute;
  right: 0;
  top: 11px;
  width: 33px;
}

.img_send_btn {
  background: #05728f none repeat scroll 0 0;
  border: medium none;
  border-radius: 50%;
  color: #fff;
  cursor: pointer;
  font-size: 17px;
  height: 33px;
  position: absolute;
  right: 40px;
  top: 11px;
  width: 33px;
}

.msg_history {
  height: 260px;
  width: 280px;
  overflow-y: auto;
  color:black;
}


</style>

<style type="text/css">
  .open-button {
  background-color: #555;
  color: white;
  padding: 16px 20px;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  position: fixed;
  bottom: 23px;
  right: 380px;
  width: 280px;
}

/* The popup chat - hidden by default */
.chat-popup {
  display: none;
  position: fixed;
  bottom: 0;
  right: 500px;
  border: 3px solid #f1f1f1;
  z-index: 9;
}

/* Add styles to the form container */
.form-container {
  max-width: 300px;
  padding: 10px;
  background-color: white;
}


/* Set a style for the submit/send button */
.form-container .btn {
  color: white;
  border: none;
  cursor: pointer;
  opacity: 0.8;
  background-color: red;
}

/* Add some hover effects to buttons */
.form-container .btn:hover, .open-button:hover {
  opacity: 1;
}


input[type="file"] {
    display: none;
}
.custom-file-upload {
    display: inline-block;
    cursor: pointer;
}



</style>

</head>
<body>

<div class="container-fluid">

	<!-- 確認連線 -->
	<div class="container mt-5">
		<h3 id="statusOutput" class="statusOutput">111</h3>
		<input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
		<input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
	</div>
	
	
	
  <div class="inbox_people col-md-3">
    <div class="headind_srch">
      <div class="recent_heading">
        <h4>Recent</h4>
      </div>
      <div class="srch_bar">
        <div class="stylish-input-group">
          <input type="text" class="search-bar"  placeholder="Search" >
          <span class="input-group-addon">
          <button type="button"> <i class="fa fa-search" aria-hidden="true"></i> </button>
          </span> </div>
      </div>
    </div>

    <div class="inbox_chat">
     <input id="userName" type="hidden" value="${memVO.mem_name}"/>
     <input id="userId" type="hidden" value="${memVO.mem_id}"/>
     
    <jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" /> 
    <jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
	
<!-- 	列出會員參加活動的聊天群組 -->
	<c:forEach var="evelsVO" items="${evelistSvc.getEveListsByMem(memVO.mem_id)}">	
		
		<div class="chat_people chat_list">
          <div class="chat_img"> <img src="<%=request.getContextPath() %>/eve/DBPicReader?eve_id=${evelsVO.eve_id}"> </div>
          <div class="chat_ib">
            <h5>${eveSvc.getOneEve(evelsVO.eve_id).eve_title} </h5>
            <input type="hidden"  value='${evelsVO.eve_id}'>
            <p>Test, which is a new approach .</p>
          </div>
        </div>
					
	</c:forEach>
     

    </div>
  </div>


  <div id="openChatPopUP">
    <button class="open-button" onclick="openForm()">Chat</button>
      <div class="chat-popup" id="popUpContent">
        <div class="form-container ">
          <div class="row">
            <div class="col-md-8"><h3 class="text-dark" id="popUpHeader">Chat</h3></div>
             <input type="hidden" id="popUpChatName" value=''>
            <div class="col-md-1  offset-md-1 pr-1 "><button type="button" class="btn cancel  btn-sm" onclick="closeForm()">-</button></div>
            <div class="col-md-1 "><button type="button" class="btn cancel  btn-sm" onclick="closeChatPopUp()">x</button></div>
          </div>

          <div class="mesgs">
            <div class="msg_history" id="messagesArea">
 
            </div>
            <div class="type_msg">
              <div class="input_msg_write d-flex">
                <input id="message" type="text" class="write_msg" placeholder="Type a message" autofocus onkeydown="if (event.keyCode == 13) sendMessage();"/>
                <button class="msg_send_btn" type="submit" id="sendMessage" onclick="sendMessage();"><i class="fa fa-paper-plane-o" aria-hidden="true"></i></button>
                
                <button class="img_send_btn" type="button">
                  <label class="custom-file-upload ">
                      <input type="file" id="sendPicture" onchange="sendPicture();"/>
                      <i class="fa fa-image"></i>
                  </label>
                </button>

              </div>
            </div>
          </div>
        </div>    
    </div>
  </div>

</div>

<script>

    var statusOutput = document.getElementById("statusOutput");
	var openChatPopUP=document.getElementById("openChatPopUP");
	var chat_people=document.getElementsByClassName("chat_people");
	var popUpContent=document.getElementById("popUpContent");
	var popUpHeader=document.getElementById("popUpHeader");
	var popUpChatName=document.getElementById("popUpChatName");
	var userId=document.getElementById("userId");
	var chatId;
	var webSocket;
	
	
	openChatPopUP.style.display = "none";
	
	for(var i=0;i<chat_people.length;i++){
	  chat_people[i].ondblclick=openChatPopUp;
	}
	
	function closeChatPopUp(){
	      openChatPopUP.style.display = "none";
	}
	
	function openChatPopUp(e){
		console.log("webSocket : "+(webSocket!= undefined));
		if(webSocket!=undefined){
			disconnect ();
		}
	   var messagesArea = document.getElementById("messagesArea");
	   messagesArea.innerHTML="";
	   
	   openChatPopUP.style.display = "block";
	   popUpContent.style.display = "block";  
	   for(var i=0;i<chat_people.length;i++){
	      chat_people[i].style.backgroundColor="#f8f8f8";
	    } 
	   var curTargetObj=e.currentTarget;      
	   curTargetObj.style.backgroundColor="#ebebeb";
	   
	   var name=curTargetObj.children[1].children[0].innerText;
	   popUpHeader.innerText=name;
	   chatId=curTargetObj.children[1].children[1].value;
	   popUpChatName.value=chatId;
	   console.log(popUpChatName.value);
	   connect();
	
	}
	
	
	function openForm() {
	    popUpContent.style.display = "block";
	}
	
	function closeForm() {
	    popUpContent.style.display = "none";
	}
    
    
	
	
	function connect() {
		var MyPoint = '/EchatEchoServer/'+chatId+'/<%=memVO.getMem_id() %>';
	    console.log("MyPoint : "+ MyPoint);
	    var host = window.location.host;
	    var path = window.location.pathname;
	    var webCtx = path.substring(0, path.indexOf('/', 1));
	    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
	    			
		// 建立 websocket 物件
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket 成功連線");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
			
		};
		var history=true;
		webSocket.onmessage = function(event) {
			
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
			
	        //第一次進入websocket 取得歷史訊息
	        if(history){	        	
	        	 for(i=0;i<jsonObj.length;i++){
	 	        	var jobj=JSON.parse(jsonObj[i]);
	 	        	
	 	        	
	 	        	if(jobj.userId!=userId.value){
		        		//訊息是圖片
		        		if(jobj.message.indexOf('data:image')!=-1&& jobj.message.indexOf('base64')!=-1){
			        		 var message = '<div class="incoming_msg">'+
						                 '<div class="incoming_msg_img">'+
						                 '<img  style="width:100%;height:100%;" src="<%=request.getContextPath() %>/DBChatPicReader?mem_id='+ jobj.userId +'"> </div>'+
						                 '<div class="received_msg">'+
						                 '<div class="received_withd_msg">'+
						                 '<img style="width:100%;height:100%;" src="'+jobj.message+'" height="200">'+
						                 '<span class="time_date"> 11:01 AM | June 9</span></div></div></div>';
						//訊息是文字
			        	}else{	  
			        		
			        		 var message =  '<div class="incoming_msg">'+
						                 '<div class="incoming_msg_img">'+
						                 '<img  style="width:100%;height:100%;" src="<%=request.getContextPath() %>/DBChatPicReader?mem_id='+ jobj.userId +'"> </div>'+
						                 '<div class="received_msg">'+
						                 '<div class="received_withd_msg">'+
						                 '<p>'+jobj.message+'</p>'+
						                 '<span class="time_date"> 11:01 AM | Yesterday</span></div></div></div>';		        		 
			        	}
		        		
		        	//	自己發送的訊息	        		
		        	}else{
		        		//訊息是圖片
		        		if(jobj.message.indexOf('data:image')!=-1&& jobj.message.indexOf('base64')!=-1){
			        		 var message ='<div class="outgoing_msg">'+
						                 '<div class="sent_msg">'+
						                 '<img style="width: 92%;float: right;" src="'+jobj.message+'">'+
						                 '<span class="time_date"> 11:01 AM | June 9</span> </div>'+
						                 '</div>';
						//訊息是文字
			        	}else{	  
			        		
			        		 var message = '<div class="outgoing_msg">'+
						                 '<div class="sent_msg">'+
						                 '<p>'+jobj.message+'</p>'+
						                 '<span class="time_date"> 11:01 AM | June 9</span> </div>'+
						              	 '</div>';
			        	}
		        		
		        		
		        	}
		        	
		           
		 	        messagesArea.innerHTML = messagesArea.innerHTML + message;
		 	        messagesArea.scrollTop = messagesArea.scrollHeight;
	 	  	        
	 	  	        
	 	  	        
	 	  	        
	 	  	        
	 	        }
	        	 history=false;  
	        	 
	        //非歷史訊息 再判斷是由誰發送的訊息	 
	        }else{
	        	
	        	//系統發送的訊息
	        	if(jsonObj.userId=='system'){	        		
	        		var message = jsonObj.message + "<br>";
	        	//其他會員發送的訊息	
	        	}else if(jsonObj.userId!=userId.value){
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
	    var userName = inputUserName.value.trim()+":";
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
	        var jsonObj = {"userName" : userName, "message" : message,"userId":userId.value};
	        console.log(JSON.stringify(jsonObj));
	        webSocket.send(JSON.stringify(jsonObj));
	        inputMessage.value = "";
	        inputMessage.focus();
	    }
	}
	
	function sendPicture() {
	    var userName = inputUserName.value.trim()+":";
	    if (userName === ""){
	        alert ("使用者名稱請勿空白!");
	        inputUserName.focus();	
			return;
	    }
	    
		  var file    = document.querySelector('input[type=file]').files[0];
		  var reader  = new FileReader();
		  var message;

		  reader.addEventListener("load", function () {
			message=reader.result;
		    console.log(  message.indexOf('data:image')!=-1&& message.indexOf('base64')!=-1);
		    console.log(  message );
		    if (message === ""){
		        alert ("請選擇檔案!");
		    }else{
		        var jsonObj = {"userName" : userName, "message" : message,"userId":userId.value};
		        webSocket.send(JSON.stringify(jsonObj));
		    }
		    
		    
		  }, false);

		  if (file) {
		    reader.readAsDataURL(file);
		  }
	    	    
	   
	}

	
	function disconnect () {
		webSocket.close();
		document.getElementById('sendMessage').disabled = true;
		document.getElementById('connect').disabled = false;
		document.getElementById('disconnect').disabled = true;
	}

	
	function updateStatus(newStatus) {
		statusOutput.innerHTML = newStatus;
	}
    
</script>




  <script src="https://code.jquery.com/jquery-3.2.1.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>