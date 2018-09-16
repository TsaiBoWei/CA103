package com.evecomment.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class EveCommentVO implements Serializable{
	private String ecomment_id;
	private String mem_id;
	private String eve_id;
	private String ecomment;
	private Timestamp ecom_time;
	private String ecom_status;
	
	public EveCommentVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public EveCommentVO(String ecomment_id, String mem_id, String eve_id, String ecomment, Timestamp ecom_time,
			String ecom_status) {
		super();
		this.ecomment_id = ecomment_id;
		this.mem_id = mem_id;
		this.eve_id = eve_id;
		this.ecomment = ecomment;
		this.ecom_time = ecom_time;
		this.ecom_status = ecom_status;
	}

	public String getEcomment_id() {
		return ecomment_id;
	}

	public void setEcomment_id(String ecomment_id) {
		this.ecomment_id = ecomment_id;
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

	public String getEcomment() {
		return ecomment;
	}

	public void setEcomment(String ecomment) {
		this.ecomment = ecomment;
	}

	public Timestamp getEcom_time() {
		return ecom_time;
	}

	public void setEcom_time(Timestamp ecom_time) {
		this.ecom_time = ecom_time;
	}

	public String getEcom_status() {
		return ecom_status;
	}

	public void setEcom_status(String ecom_status) {
		this.ecom_status = ecom_status;
	}
	
	
	


}
