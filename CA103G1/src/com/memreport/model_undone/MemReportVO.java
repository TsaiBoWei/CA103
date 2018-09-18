package com.memreport.model_undone;

import java.sql.Date;

public class MemReportVO implements java.io.Serializable {

	private String memre_id;
	private String mem_reporter_id;
	private String mem_reported_id;
	private String memre_item;
	private String memre_cont;
	private Date memre_time;
	private String memre_status;
	private String reply_mgrid;
	
	
	public String getMemre_id() {
		return memre_id;
	}
	public void setMemre_id(String memre_id) {
		this.memre_id = memre_id;
	}
	public String getMem_reporter_id() {
		return mem_reporter_id;
	}
	public void setMem_reporter_id(String mem_reporter_id) {
		this.mem_reporter_id = mem_reporter_id;
	}
	public String getMem_reported_id() {
		return mem_reported_id;
	}
	public void setMem_reported_id(String mem_reported_id) {
		this.mem_reported_id = mem_reported_id;
	}
	public String getMemre_item() {
		return memre_item;
	}
	public void setMemre_item(String memre_item) {
		this.memre_item = memre_item;
	}
	public String getMemre_cont() {
		return memre_cont;
	}
	public void setMemre_cont(String memre_cont) {
		this.memre_cont = memre_cont;
	}
	public Date getMemre_time() {
		return memre_time;
	}
	public void setMemre_time(Date memre_time) {
		this.memre_time = memre_time;
	}
	public String getMemre_status() {
		return memre_status;
	}
	public void setMemre_status(String memre_status) {
		this.memre_status = memre_status;
	}
	public String getReply_mgrid() {
		return reply_mgrid;
	}
	public void setReply_mgrid(String reply_mgrid) {
		this.reply_mgrid = reply_mgrid;
	}
	
	
}
