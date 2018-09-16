package com.evechat.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class EveChatVO implements Serializable{
	
	private String echat_id;
	private String mem_id;
	private String eve_id;
	private String echat_content;
	private Timestamp echat_time;
	private String echat_status;
	
	
	public EveChatVO() {
		super();
	}
	public EveChatVO(String echat_id, String mem_id, String eve_id, String echat_content, Timestamp echat_time,
			String echat_status) {
		super();
		this.echat_id = echat_id;
		this.mem_id = mem_id;
		this.eve_id = eve_id;
		this.echat_content = echat_content;
		this.echat_time = echat_time;
		this.echat_status = echat_status;
	}
	public String getEchat_id() {
		return echat_id;
	}
	public void setEchat_id(String echat_id) {
		this.echat_id = echat_id;
	}
	public String getMem_id() {
		return mem_id;
	}
	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}
	public String getEve_id() {
		return eve_id;
	}
	public void setEve_id(String eve_id) {
		this.eve_id = eve_id;
	}
	public String getEchat_content() {
		return echat_content;
	}
	public void setEchat_content(String echat_content) {
		this.echat_content = echat_content;
	}
	public Timestamp getEchat_time() {
		return echat_time;
	}
	public void setEchat_time(Timestamp echat_time) {
		this.echat_time = echat_time;
	}
	public String getEchat_status() {
		return echat_status;
	}
	public void setEchat_status(String echat_status) {
		this.echat_status = echat_status;
	}
	
	
	
	


}
