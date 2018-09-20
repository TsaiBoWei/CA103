package com.courboar.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class CourBoarVO implements Serializable {
	
	private String crpost_id; 
	private String crpos_tit;
	private Timestamp crpos_time ;
	private String cour_id; 
	private String mem_id;
	private String crpos_text;
	private String crpos_sta;
	
	public CourBoarVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getCrpost_id() {
		return crpost_id;
	}

	public void setCrpost_id(String crpost_id) {
		this.crpost_id = crpost_id;
	}

	public String getCrpos_tit() {
		return crpos_tit;
	}

	public void setCrpos_tit(String crpos_tit) {
		this.crpos_tit = crpos_tit;
	}

	public Timestamp getCrpos_time() {
		return crpos_time;
	}

	public void setCrpos_time(Timestamp crpos_time) {
		this.crpos_time = crpos_time;
	}

	public String getCour_id() {
		return cour_id;
	}

	public void setCour_id(String cour_id) {
		this.cour_id = cour_id;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getCrpos_text() {
		return crpos_text;
	}

	public void setCrpos_text(String crpos_text) {
		this.crpos_text = crpos_text;
	}

	public String getCrpos_sta() {
		return crpos_sta;
	}

	public void setCrpos_sta(String crpos_sta) {
		this.crpos_sta = crpos_sta;
	}
	
}	