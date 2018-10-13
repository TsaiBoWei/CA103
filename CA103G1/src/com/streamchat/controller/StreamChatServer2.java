package com.streamchat.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

import javax.websocket.CloseReason;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.json.JSONArray;

import com.streamchat.controller.JedisHandleMessage;

@ServerEndpoint(value="/StreamChatServer2/{chatId}")
public class StreamChatServer2 {
	
	
	//key�O�C�Ӳ�ѫǪ��s��(livechat�s��) value�O�C�Ӳ�ѫǤ���session���X	
	private static final Map<String, Set<Session>> rooms = new ConcurrentHashMap<>();
	
	@OnOpen
	public void onOpen(@PathParam("chatId") String chat_id, Session userSession) throws IOException {
		
		Set<Session> allSessions =null;
		if(!rooms.containsKey(chat_id)) {
			allSessions = Collections.synchronizedSet(new HashSet<Session>());
			allSessions.add(userSession);
			rooms.put(chat_id, allSessions);
		}else {
			allSessions=rooms.get(chat_id);
			allSessions.add(userSession);
		}
//		System.out.println(userSession.getId() + ": �w�s�u");
		
		//���Xredis ���v�T��
		List<String> historyData = JedisHandleMessage.getHistoryMsg(chat_id);	
		JSONArray jarray=new JSONArray (historyData);
		userSession.getBasicRemote().sendText(jarray.toString());
		
	}

	
	@OnMessage
	public void onMessage(@PathParam("chatId") String chat_id,Session userSession, String message) {
		for (Session session : rooms.get(chat_id)) {
			if (session.isOpen())
				try {
					session.getBasicRemote().sendText(message);
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
//		System.out.println("Message received: " + message);
		
		//�N�O���s�JRedis��(��import jedis��jar�ɸ�s�u����jar��)
		JedisHandleMessage.saveChatMessage(chat_id, message);
	}
	
	@OnError
	public void onError(Session userSession, Throwable e){
//		e.printStackTrace();
	}
	
	@OnClose
	public void onClose(@PathParam("chatId") String chat_id,Session userSession, CloseReason reason) {
		rooms.get(chat_id).remove(userSession);
		System.out.println(userSession.getId() + ": Disconnected: " + Integer.toString(reason.getCloseCode().getCode()));
	}

 
}
