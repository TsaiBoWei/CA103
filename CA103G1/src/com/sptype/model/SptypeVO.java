package com.sptype.model;

public class SptypeVO {

	private String sptype_id;
	private String sport;
	private byte[] sport_logo;

	public String getSptype_id() {
		return sptype_id;
	}

	public void setSptype_id(String sptype_id) {
		this.sptype_id = sptype_id;
	}

	public String getSport() {
		return sport;
	}

	public void setSport(String sport) {
		this.sport = sport;
	}

	public byte[] getSport_logo() {
		return sport_logo;
	}

	public void setSport_logo(byte[] sport_logo) {
		this.sport_logo = sport_logo;
	}

}
