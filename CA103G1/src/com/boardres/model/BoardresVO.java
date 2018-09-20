package com.boardres.model;

import java.io.Serializable;
import java.sql.Timestamp;

public class BoardresVO implements Serializable{
	
	private String crres_id;
	private Timestamp crres_time;
	private String crpost_id;
	private String mem_id;
	private String crres_text;
	private String crres_sta;
	
	public BoardresVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getCrres_id() {
		return crres_id;
	}

	public void setCrres_id(String crres_id) {
		this.crres_id = crres_id;
	}

	public Timestamp getCrres_time() {
		return crres_time;
	}

	public void setCrres_time(Timestamp crres_time) {
		this.crres_time = crres_time;
	}

	public String getCrpost_id() {
		return crpost_id;
	}

	public void setCrpost_id(String crpost_id) {
		this.crpost_id = crpost_id;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getCrres_text() {
		return crres_text;
	}

	public void setCrres_text(String crres_text) {
		this.crres_text = crres_text;
	}

	public String getCrres_sta() {
		return crres_sta;
	}

	public void setCrres_sta(String crres_sta) {
		this.crres_sta = crres_sta;
	}

}
