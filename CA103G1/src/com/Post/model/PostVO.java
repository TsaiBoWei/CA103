package com.Post.model;

import java.sql.Timestamp;

public class PostVO implements java.io.Serializable {
	private String post_id;
	private String mem_id;
	private String post_con;
	private Timestamp post_time;
	private Integer post_view;
	private String sptype_id; 
	private String post_status;
	private String post_title;
	private String post_privacy;
	private String post_img;
	
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
	public String getPost_con() {
		return post_con;
	}
	public void setPost_con(String post_con) {
		this.post_con = post_con;
	}
	public Timestamp getPost_time() {
		return post_time;
	}
	public void setPost_time(Timestamp post_time) {
		this.post_time = post_time;
	}
	public Integer getPost_view() {
		return post_view;
	}
	public void setPost_view(Integer post_view) {
		this.post_view = post_view;
	}
	public String getSptype_id() {
		return sptype_id;
	}
	public void setSptype_id(String sptype_id) {
		this.sptype_id = sptype_id;
	}
	
	public String getPost_status() {
		return post_status;
	}
	public void setPost_status(String post_status) {
		this.post_status = post_status;
	}
	
	public String getPost_title() {
		return post_title;
	}
	public void setPost_title(String post_title) {
		this.post_title = post_title;
	}
	public String getPost_privacy() {
		return post_privacy;
	}
	public void setPost_privacy(String post_privacy) {
		this.post_privacy = post_privacy;
	}
	public void setPost_img(String post_img) {
		this.post_img = post_img;
	}
}
