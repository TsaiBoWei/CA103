package com.watchedhr.model;

import java.sql.Timestamp;

public class WatchedhrVO {
	
	private String cour_unit_id;
	private String crorder_id;
	private Double watched_hr;
	private Timestamp brows_time;
	
	public Timestamp getBrows_time() {
		return brows_time;
	}
	public void setBrows_time(Timestamp brows_time) {
		this.brows_time = brows_time;
	}
	public String getCour_unit_id() {
		return cour_unit_id;
	}
	public void setCour_unit_id(String cour_unit_id) {
		this.cour_unit_id = cour_unit_id;
	}
	public String getCrorder_id() {
		return crorder_id;
	}
	public void setCrorder_id(String crorder_id) {
		this.crorder_id = crorder_id;
	}
	public Double getWatched_hr() {
		return watched_hr;
	}
	public void setWatched_hr(Double watched_hr) {
		this.watched_hr = watched_hr;
	}

}
