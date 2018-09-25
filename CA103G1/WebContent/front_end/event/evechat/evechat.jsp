<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>


<%	//取出會員的SESSION
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
        <textarea id="messagesArea" class="panel message-area" readonly ></textarea>
        <div class="panel input-area">
            <input id="userName" class="text-field" type="text" value="${memVO.mem_name}"/>
            <input id="message"  class="text-field" type="text" placeholder="訊息"  autofocus onkeydown="if (event.keyCode == 13) sendMessage();"/>
            <input type="submit" id="sendMessage" class="button" value="送出" onclick="sendMessage();"/>
		    <input type="button" id="connect"     class="button" value="連線" onclick="connect();"/>
		    <input type="button" id="disconnect"  class="button" value="離線" onclick="disconnect();"/>
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
	        console.log(history);
	        if(history){	        	
	        	 for(i=0;i<jsonObj.length;i++){
	 	        	console.log(jsonObj[i]);
	 	        	var jobj=JSON.parse(jsonObj[i]);
	 	        	console.log(jobj);
	 	        	 var message = jobj.userName + jobj.message + "\r\n";
	 	  	        messagesArea.value = messagesArea.value + message;
	 	  	        messagesArea.scrollTop = messagesArea.scrollHeight;
	 	        }
	        	 history=false;        	
	        }else{
	            var message = jsonObj.userName + jsonObj.message + "\r\n";
	 	        messagesArea.value = messagesArea.value + message;
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
	        inputUserName.focus();	
			return;
	    }
	    
	    var inputMessage = document.getElementById("message");
	    var message = inputMessage.value.trim();
	    
	    if (message === ""){
	        alert ("訊息請勿空白!");
	        inputMessage.focus();	
	    }else{
	        var jsonObj = {"userName" : userName, "message" : message};
	        webSocket.send(JSON.stringify(jsonObj));
	        inputMessage.value = "";
	        inputMessage.focus();
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
