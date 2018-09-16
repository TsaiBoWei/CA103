package com.eventad.model;

import java.io.Serializable;

public class EventAdVO implements Serializable{
	private String ead_id;
	private String mem_id;
	private byte[] ead_pic;
	private String ead_status;
	
	public EventAdVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EventAdVO(String ead_id, String mem_id, byte[] ead_pic, String ead_status) {
		super();
		this.ead_id = ead_id;
		this.mem_id = mem_id;
		this.ead_pic = ead_pic;
		this.ead_status = ead_status;
	}

	public String getEad_id() {
		return ead_id;
	}

	public void setEad_id(String ead_id) {
		this.ead_id = ead_id;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public byte[] getEad_pic() {
		return ead_pic;
	}

	public void setEad_pic(byte[] ead_pic) {
		this.ead_pic = ead_pic;
	}

	public String getEad_status() {
		return ead_status;
	}

	public void setEad_status(String ead_status) {
		this.ead_status = ead_status;
	}
	
	


}
