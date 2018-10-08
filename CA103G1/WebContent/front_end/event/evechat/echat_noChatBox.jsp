<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>


<%	//���X�|����SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>


<!DOCTYPE html>
<html>
    <head>
        <title>Chat Room</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link rel="stylesheet" href="css/styles.css" type="text/css"/>
    </head>
    
    <body onload="connect();" onunload="disconnect();">
        <h1> Chat Room </h1>
	    <h3 id="statusOutput" class="statusOutput"></h3>
        <div id="messagesArea" class="panel message-area"></div>
        <div class="panel input-area">
            <input id="userName" class="text-field" type="text" value="${memVO.mem_name}"/>
            <input id="message"  class="text-field" type="text" placeholder="�T��"  autofocus onkeydown="if (event.keyCode == 13) sendMessage();"/>
            <input type="submit" id="sendMessage" class="button" value="�e�X" onclick="sendMessage();"/>
            <input type="file" id="sendPicture" class="button" value="�Ϥ�" onchange="sendPicture();"/>
		    <input type="button" id="connect"     class="button" value="�s�u" onclick="connect();"/>
		    <input type="button" id="disconnect"  class="button" value="���u" onclick="disconnect();"/>
	    </div>
    </body>
    
<script>
    
    var MyPoint = '/EchatEchoServer/<%=request.getParameter("eve_id") %>/<%=memVO.getMem_id() %>';
    var host = window.location.host;
    var path = window.location.pathname;
    var webCtx = path.substring(0, path.indexOf('/', 1));
    var endPointURL = "ws://" + window.location.host + webCtx + MyPoint;
    
	var statusOutput = document.getElementById("statusOutput");
	var webSocket;
	
	
	function connect() {
		// �إ� websocket ����
		webSocket = new WebSocket(endPointURL);
		
		webSocket.onopen = function(event) {
			updateStatus("WebSocket ���\�s�u");
			document.getElementById('sendMessage').disabled = false;
			document.getElementById('connect').disabled = true;
			document.getElementById('disconnect').disabled = false;
			
		};
		var history=true;
		webSocket.onmessage = function(event) {
			
			var messagesArea = document.getElementById("messagesArea");
	        var jsonObj = JSON.parse(event.data);
	        console.log(history);
	        if(history){	        	
	        	 for(i=0;i<jsonObj.length;i++){
	 	        	console.log(jsonObj[i]);
	 	        	var jobj=JSON.parse(jsonObj[i]);
	 	        	console.log(jobj);
	 	        	if(jobj.message.indexOf('data:image')!=-1&& jobj.message.indexOf('base64')!=-1){
	 	        		 var message = jobj.userName +'<img src="'+jobj.message+'" height="200"><br>';
	 	        	}else{
	 	        		var message = jobj.userName + jobj.message + "<br>";
	 	        	}
	 	        	 
	 	  	        messagesArea.innerHTML = messagesArea.innerHTML + message;
	 	  	        messagesArea.scrollTop = messagesArea.scrollHeight;
	 	        }
	        	 history=false;        	
	        }else{
	        	if(jsonObj.message.indexOf('data:image')!=-1&& jsonObj.message.indexOf('base64')!=-1){
	        		 var message = jsonObj.userName +'<img src="'+jsonObj.message+'" height="200"><br>';
	        	}else{	        		
	        		 var message = jsonObj.userName + jsonObj.message + "<br>";
	        		 
	        	}
	           
	 	        messagesArea.innerHTML = messagesArea.innerHTML + message;
	 	        messagesArea.scrollTop = messagesArea.scrollHeight;
	        	
	        }
       
		};

		webSocket.onclose = function(event) {
			updateStatus("WebSocket �w���u");
		};
	}
	
	
	var inputUserName = document.getElementById("userName");


	
	function sendMessage() {
	    var userName = inputUserName.value.trim()+":";
	    if (userName === ""){
	        alert ("�ϥΪ̦W�ٽФŪť�!");
	        inputUserName.focus();	
			return;
	    }
	    
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	    
	    if (message === ""){
	        alert ("�T���ФŪť�!");
	        inputMessage.focus();	
	    }else{
	        var jsonObj = {"userName" : userName, "message" : message};
	        webSocket.send(JSON.stringify(jsonObj));
	        inputMessage.value = "";
	        inputMessage.focus();
	    }
	}
	
	function sendPicture() {
	    var userName = inputUserName.value.trim()+":";
	    if (userName === ""){
	        alert ("�ϥΪ̦W�ٽФŪť�!");
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
		        alert ("�п���ɮ�!");
		    }else{
		        var jsonObj = {"userName" : userName, "message" : message};
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
</html>
