package com.coursereport.model;

import java.sql.Timestamp;

public class CourseReportVO {

	private String courrepo_id;
	private Timestamp courre_time;
	private String cour_id;
	private String mem_id;
	private String courrep_item;
	private String courrep_text;
	private String courrep_status;
	private String reply_mgr_id;

	public CourseReportVO() {
		super();
	}

	public String getCourrepo_id() {
		return courrepo_id;
	}

	public void setCourrepo_id(String courrepo_id) {
		this.courrepo_id = courrepo_id;
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

	public String getCourrep_item() {
		return courrep_item;
	}

	public void setCourrep_item(String courrep_item) {
		this.courrep_item = courrep_item;
	}

	public String getCourrep_text() {
		return courrep_text;
	}

	public void setCourrep_text(String courrep_text) {
		this.courrep_text = courrep_text;
	}

	public Timestamp getCourre_time() {
		return courre_time;
	}

	public void setCourre_time(Timestamp courre_time) {
		this.courre_time = courre_time;
	}

	public String getCourrep_status() {
		return courrep_status;
	}

	public void setCourrep_status(String courrep_status) {
		this.courrep_status = courrep_status;
	}

	public String getReply_mgr_id() {
		return reply_mgr_id;
	}

	public void setReply_mgr_id(String reply_mgr_id) {
		this.reply_mgr_id = reply_mgr_id;
	}

}
