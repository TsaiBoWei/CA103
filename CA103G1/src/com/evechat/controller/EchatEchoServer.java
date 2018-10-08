package com.evechat.controller;
import java.io.*;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;
import javax.websocket.Session;
import javax.websocket.OnOpen;
import javax.websocket.OnMessage;
import javax.websocket.OnError;
import javax.websocket.OnClose;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.websocket.CloseReason;
import javax.websocket.EndpointConfig;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.mem.model.*;



import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
/*
 * 如果想取得HttpSession與ServletContext必須實作
 * ServerEndpointConfig.Configurator.modifyHandshake()，
 * 參考https://stackoverflow.com/questions/21888425/accessing-servletcontext-and-httpsession-in-onmessage-of-a-jsr-356-serverendpoint
 * 
 *多聊天室https://blog.csdn.net/zhengholien/article/details/76696509
 */







@ServerEndpoint(value="/EchatEchoServer/{eveId}/{memId}", configurator=ServletAwareConfig.class)
public class EchatEchoServer {

//keyˊ是每個聊天室的編號(活動編號) value是每個聊天室內的session集合	
private static final Map<String, Set<Session>> rooms = new ConcurrentHashMap<>();

private EndpointConfig config;
Gson gson =  new Gson();


	@OnOpen
	public void onOpen(@PathParam("eveId") String eve_id, @PathParam("memId") String userName, Session userSession,EndpointConfig config) throws IOException, JSONException {
		this.config = config;
		
		userSession.setMaxTextMessageBufferSize(200000);
		
		Set<Session> allSessions =null;
		if(!rooms.containsKey(eve_id)) {
			allSessions = Collections.synchronizedSet(new HashSet<Session>());
			allSessions.add(userSession);
			rooms.put(eve_id, allSessions);
		}else {
			allSessions=rooms.get(eve_id);
			allSessions.add(userSession);
		}
		
		
		
		
//		String historyMsg = gson.toJson(historyData);
//		System.out.println(historyMsg);
//		ChatMessage cmHistory = new ChatMessage("history", userName, historyMsg);
//		if (userSession != null && userSession.isOpen()) {
//			userSession.getAsyncRemote().sendText(gson.toJson(cmHistory));
//			return;
//		}
		
//		JsonParser parser=new JsonParser();
//		JsonArray Jarray = parser.parse(historyMsg).getAsJsonArray();
//		for(JsonElement obj : Jarray ){
//			
//			System.out.println(gson.toJson(obj));
//			userSession.getAsyncRemote().sendText(gson.toJson(obj));
//
//		}
		
		List<String> historyData = JedisHandleMessage.getHistoryMsg(eve_id);
		
		JSONArray jarray=new JSONArray (historyData);
		userSession.getBasicRemote().sendText(jarray.toString());
		
		
	
				
		System.out.println(userSession.getId() + ": 已連線");
//		System.out.println(eve_id + ": 聊天室連線");
//		System.out.println(mem_id + ": 上線");
		
		MemService memSvc=new MemService();
		String mem_name=memSvc.getOneMem(userName).getMem_name();		
		String connectStr = "{\"userId\" : \"system\", \"message\" :\"-----------"+mem_name+"已上線 -----------\"}";

		for (Session session : allSessions) {
			if (session.isOpen())			
				session.getBasicRemote().sendText(connectStr);
		}
		
		
	}

	
	@OnMessage
	public void onMessage(@PathParam("eveId") String eve_id,Session userSession, String message) {
				
		for (Session session : rooms.get(eve_id)) {
			if (session.isOpen())
				try {
					session.getBasicRemote().sendText(message);
				} catch (IOException e) {
					e.printStackTrace();
				}			
		}
		System.out.println("Message received: " + message);
		
		//將記錄存入Redis內(需import jedis的jar檔跟連線池的jar檔)
		JedisHandleMessage.saveChatMessage(eve_id, message);
		

		
		
		
		
		//取得 session 跟context物件
		HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");
	    ServletContext servletContext = httpSession.getServletContext();
	  	    
	    //將聊天訊息以List存在context內 context以活動編號作為key 
//	    List<String> msgList= (List<String>)servletContext.getAttribute(eve_id);
//	    if( msgList==null) {
//	    	msgList= Collections.synchronizedList(new ArrayList());
//	    }
//	    msgList.add(message);
//	    servletContext.setAttribute(eve_id,msgList);
//	    for(String msg:msgList) {
//	    	System.out.println("eve_id :"+eve_id+"msg :"+msg);
//	    }
	    	    
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(@PathParam("eveId") String eve_id,Session userSession, CloseReason reason) {
		rooms.get(eve_id).remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

 
}
