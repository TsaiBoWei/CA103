package com.eventlist.model;

import java.io.Serializable;
import java.sql.Date;

public class EventListVO implements Serializable {
	
	private String mem_id;
	private String eve_id;
	private Integer eve_rating;
	private String evelist_status;
	private Integer evepay_amount;
	private String eve_share;
	private Date evepay_deadline;
	
	public EventListVO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public EventListVO(String mem_id, String eve_id, Integer eve_rating, String evelist_status, Integer evepay_amount,
			String eve_share, Date evepay_deadline) {
		super();
		this.mem_id = mem_id;
		this.eve_id = eve_id;
		this.eve_rating = eve_rating;
		this.evelist_status = evelist_status;
		this.evepay_amount = evepay_amount;
		this.eve_share = eve_share;
		this.evepay_deadline = evepay_deadline;
	}

	public String getMem_id() {
		return mem_id;
	}

	public void setMem_id(String mem_id) {
		this.mem_id = mem_id;
	}

	public String getEve_id() {
		return eve_id;
	}

	public void setEve_id(String eve_id) {
		this.eve_id = eve_id;
	}

	public Integer getEve_rating() {
		return eve_rating;
	}

	public void setEve_rating(Integer eve_rating) {
		this.eve_rating = eve_rating;
	}

	public String getEvelist_status() {
		return evelist_status;
	}

	public void setEvelist_status(String evelist_status) {
		this.evelist_status = evelist_status;
	}

	public Integer getEvepay_amount() {
		return evepay_amount;
	}

	public void setEvepay_amount(Integer evepay_amount) {
		this.evepay_amount = evepay_amount;
	}

	public String getEve_share() {
		return eve_share;
	}

	public void setEve_share(String eve_share) {
		this.eve_share = eve_share;
	}


	public Date getEvepay_deadline() {
		return evepay_deadline;
	}


	public void setEvepay_deadline(Date evepay_deadline) {
		this.evepay_deadline = evepay_deadline;
	}
	
	
	


}
