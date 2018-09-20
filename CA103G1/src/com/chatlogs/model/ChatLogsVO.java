package com.chatlogs.model;

import java.sql.Blob;
import java.sql.Clob;
import java.sql.Timestamp;

public class ChatLogsVO implements java.io.Serializable {
	private String chat_id;
	private String chat_memA_id;
	private String chat_memB_id;
	private Timestamp chat_date;
	private String chat_content;
	private byte[] chat_image;
	
	public String getChat_id() {
		return chat_id;
	}
	public void setChat_id(String chat_id) {
		this.chat_id = chat_id;
	}
	public String getChat_memA_id() {
		return chat_memA_id;
	}
	public void setChat_memA_id(String chat_memA_id) {
		this.chat_memA_id = chat_memA_id;
	}
	public String getChat_memB_id() {
		return chat_memB_id;
	}
	public void setChat_memB_id(String chat_memB_id) {
		this.chat_memB_id = chat_memB_id;
	}
	public Timestamp getChat_date() {
		return chat_date;
	}
	public void setChat_date(Timestamp chat_date) {
		this.chat_date = chat_date;
	}
	public String getChat_content() {
		return chat_content;
	}
	public void setChat_content(String chat_content) {
		this.chat_content = chat_content;
	}
	public byte[] getChat_image() {
		return chat_image;
	}
	public void setChat_image(byte[] chat_image) {
		this.chat_image = chat_image;
	}
	
//	ChatLogsVO
//	chatlogsVO
	

}
