package com.postreport.model;

import java.sql.Date;

public class PostReportVO implements java.io.Serializable {

	private String postre_id;
	private String post_id;
	private String mem_id;
	private String postre_item;
	private String postre_cont;
	private Date postre_time;
	private String postre_status;
	private String reply_mgr_id;

	public String getPostre_id() {
		return postre_id;
	}

	public void setPostre_id(String postre_id) {
		this.postre_id = postre_id;
	}

	public String getPost_id() {
		return post_id;
	}

	public void setPost_id(String post_id) {
		this.post_id = post_id;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getPostre_item() {
		return postre_item;
	}

	public void setPostre_item(String postre_item) {
		this.postre_item = postre_item;
	}

	public String getPostre_cont() {
		return postre_cont;
	}

	public void setPostre_cont(String postre_cont) {
		this.postre_cont = postre_cont;
	}

	public Date getPostre_time() {
		return postre_time;
	}

	public void setPostre_time(Date postre_time) {
		this.postre_time = postre_time;
	}

	public String getPostre_status() {
		return postre_status;
	}

	public void setPostre_status(String postre_status) {
		this.postre_status = postre_status;
	}

	public String getReply_mgr_id() {
		return reply_mgr_id;
	}

	public void setReply_mgr_id(String reply_mgr_id) {
		this.reply_mgr_id = reply_mgr_id;
	}

}
