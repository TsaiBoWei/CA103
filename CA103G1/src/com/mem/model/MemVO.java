package com.mem.model;

import java.sql.Date;

public class MemVO implements java.io.Serializable{
	private String memID;
	private String memAcccount;
	private String memName;
	private String memPsw;
	private Date memBirDay;
	private byte[] memPhoto;
	private String memMail;
	private String memStatus;
	private String MemIntro;
	
	public MemVO() {
		super();
	}
	
	public MemVO(String memID, String memAcccount, String memName, String memPsw, Date memBirDay, byte[] memPhoto,
			String memMail, String memStatus, String memIntro) {
		super();
		this.memID = memID;
		this.memAcccount = memAcccount;
		this.memName = memName;
		this.memPsw = memPsw;
		this.memBirDay = memBirDay;
		this.memPhoto = memPhoto;
		this.memMail = memMail;
		this.memStatus = memStatus;
		MemIntro = memIntro;
	}
	public String getMemID() {
		return memID;
	}
	public void setMemID(String memID) {
		this.memID = memID;
	}
	public String getMemAcccount() {
		return memAcccount;
	}
	public void setMemAcccount(String memAcccount) {
		this.memAcccount = memAcccount;
	}
	public String getMemName() {
		return memName;
	}
	public void setMemName(String memName) {
		this.memName = memName;
	}
	public String getMemPsw() {
		return memPsw;
	}
	public void setMemPsw(String memPsw) {
		this.memPsw = memPsw;
	}
	public Date getMemBirDay() {
		return memBirDay;
	}
	public void setMemBirDay(Date memBirDay) {
		this.memBirDay = memBirDay;
	}
	public byte[] getMemPhoto() {
		return memPhoto;
	}
	public void setMemPhoto(byte[] memPhoto) {
		this.memPhoto = memPhoto;
	}
	public String getMemMail() {
		return memMail;
	}
	public void setMemMail(String memMail) {
		this.memMail = memMail;
	}
	public String getMemStatus() {
		return memStatus;
	}
	public void setMemStatus(String memStatus) {
		this.memStatus = memStatus;
	}
	public String getMemIntro() {
		return MemIntro;
	}
	public void setMemIntro(String memIntro) {
		MemIntro = memIntro;
	}
	 

	
	
}
