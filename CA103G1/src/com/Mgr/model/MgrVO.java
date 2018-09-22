package com.Mgr.model;

public class MgrVO  implements java.io.Serializable{
	private String mgr_id;
	private String mgr_account;
	private String mgr_name;
	private String mgr_password;
	private byte [] mgr_photo;
	private String mgr_mail;
	private String mgr_status;
	
	public String getMgr_id() {
		return mgr_id;
	}
	public void setMgr_id(String mgr_id) {
		this.mgr_id = mgr_id;
	}
	public String getMgr_account() {
		return mgr_account;
	}
	public void setMgr_account(String mgr_account) {
		this.mgr_account = mgr_account;
	}
	public String getMgr_name() {
		return mgr_name;
	}
	public void setMgr_name(String mgr_name) {
		this.mgr_name = mgr_name;
	}
	public String getMgr_password() {
		return mgr_password;
	}
	public void setMgr_password(String mgr_password) {
		this.mgr_password = mgr_password;
	}
	public byte[] getMgr_photo() {
		return mgr_photo;
	}
	public void setMgr_photo(byte[] mgr_photo) {
		this.mgr_photo = mgr_photo;
	}
	public String getMgr_mail() {
		return mgr_mail;
	}
	public void setMgr_mail(String mgr_mail) {
		this.mgr_mail = mgr_mail;
	}
	public String getMgr_status() {
		return mgr_status;
	}
	public void setMgr_status(String mgr_status) {
		this.mgr_status = mgr_status;
	}
	
	
}
