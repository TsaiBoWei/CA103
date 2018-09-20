package com.purchcour.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class PurchCourVO implements Serializable{
	private String crorder_id;
	private Date crorder_time;
	private String cour_id;
	private String mem_id;
	private String refund;
	private Integer coursco;
	
	public PurchCourVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public String getCrorder_id() {
		return crorder_id;
	}

	public void setCrorder_id(String crorder_id) {
		this.crorder_id = crorder_id;
	}

	public Date getCrorder_time() {
		return crorder_time;
	}

	public void setCrorder_time(Date crorder_time) {
		this.crorder_time = crorder_time;
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

	public String getRefund() {
		return refund;
	}

	public void setRefund(String refund) {
		this.refund = refund;
	}

	public Integer getCoursco() {
		return coursco;
	}

	public void setCoursco(Integer coursco) {
		this.coursco = coursco;
	}

}
