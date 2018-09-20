package com.eventsave.model;

public class EventSaveVO implements java.io.Serializable{
	private String mem_id;
	private String eve_id;
	private String es_status;
	
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
	public String getEs_status() {
		return es_status;
	}
	public void setEs_status(String es_status) {
		this.es_status = es_status;
	}

}
