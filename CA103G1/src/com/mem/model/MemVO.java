package com.mem.model;

import java.io.Serializable;
import java.sql.Date;

public class MemVO implements Serializable{
	
 	private String mem_id;
 	private String mem_account;
	private String mem_name;
	private String	mem_passward;
	private Date mem_birth;
	private byte[]	mem_photo;
	private String	mem_mail;
	private String	mem_status;
	private Integer	mem_like_type;
	private String	mem_intro;
	private Date mem_create_time;
	
	
	public MemVO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public MemVO(String mem_id, String mem_account, String mem_name, String mem_passward, Date mem_birth,
			byte[] mem_photo, String mem_mail, String mem_status, Integer mem_like_type, String mem_intro,
			Date create_time) {
		super();
		this.mem_id = mem_id;
		this.mem_account = mem_account;
		this.mem_name = mem_name;
		this.mem_passward = mem_passward;
		this.mem_birth = mem_birth;
		this.mem_photo = mem_photo;
		this.mem_mail = mem_mail;
		this.mem_status = mem_status;
		this.mem_like_type = mem_like_type;
		this.mem_intro = mem_intro;
		this.mem_create_time = create_time;
	}


	public String getMem_id() {
		return mem_id;
	}


	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}


	public String getMem_account() {
		return mem_account;
	}


	public void setMem_account(String mem_account) {
		this.mem_account = mem_account;
	}


	public String getMem_name() {
		return mem_name;
	}


	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}


	public String getMem_passward() {
		return mem_passward;
	}


	public void setMem_passward(String mem_passward) {
		this.mem_passward = mem_passward;
	}


	public Date getMem_birth() {
		return mem_birth;
	}


	public void setMem_birth(Date mem_birth) {
		this.mem_birth = mem_birth;
	}


	public byte[] getMem_photo() {
		return mem_photo;
	}


	public void setMem_photo(byte[] mem_photo) {
		this.mem_photo = mem_photo;
	}


	public String getMem_mail() {
		return mem_mail;
	}


	public void setMem_mail(String mem_mail) {
		this.mem_mail = mem_mail;
	}


	public String getMem_status() {
		return mem_status;
	}


	public void setMem_status(String mem_status) {
		this.mem_status = mem_status;
	}


	public Integer getMem_like_type() {
		return mem_like_type;
	}


	public void setMem_like_type(Integer mem_like_type) {
		this.mem_like_type = mem_like_type;
	}


	public String getMem_intro() {
		return mem_intro;
	}


	public void setMem_intro(String mem_intro) {
		this.mem_intro = mem_intro;
	}


	public Date getMem_Create_time() {
		return mem_create_time;
	}


	public void setMem_Create_time(Date create_time) {
		this.mem_create_time = create_time;
	}	
	


}
