package com.plancollection.model;

import java.sql.Date;
import java.sql.Timestamp;

public class PlanCollectionVO {
	private String plan_col_id;
	private String plan_col_mem_id;
	private String creat_plan_mem_id;
	private String plan_col_name;
	private String plan_col_vo;
	private Timestamp plan_colcreat_time;
	private Date plan_colstart_date;
	private String plan_col_status;
	
	public PlanCollectionVO() {
		super();
	}

	public PlanCollectionVO(String plan_col_id, String plan_col_mem_id, String creat_plan_mem_id, String plan_col_name,
			String plan_col_vo, Timestamp plan_colcreat_time, Date plan_colstart_date, String plan_col_status) {
		super();
		this.plan_col_id = plan_col_id;
		this.plan_col_mem_id = plan_col_mem_id;
		this.creat_plan_mem_id = creat_plan_mem_id;
		this.plan_col_name = plan_col_name;
		this.plan_col_vo = plan_col_vo;
		this.plan_colcreat_time = plan_colcreat_time;
		this.plan_colstart_date = plan_colstart_date;
		this.plan_col_status = plan_col_status;
	}

	public String getPlan_col_id() {
		return plan_col_id;
	}

	public void setPlan_col_id(String plan_col_id) {
		this.plan_col_id = plan_col_id;
	}

	public String getPlan_col_mem_id() {
		return plan_col_mem_id;
	}

	public void setPlan_col_mem_id(String plan_col_mem_id) {
		this.plan_col_mem_id = plan_col_mem_id;
	}

	public String getCreat_plan_mem_id() {
		return creat_plan_mem_id;
	}

	public void setCreat_plan_mem_id(String creat_plan_mem_id) {
		this.creat_plan_mem_id = creat_plan_mem_id;
	}

	public String getPlan_col_name() {
		return plan_col_name;
	}

	public void setPlan_col_name(String plan_col_name) {
		this.plan_col_name = plan_col_name;
	}

	public String getPlan_col_vo() {
		return plan_col_vo;
	}

	public void setPlan_col_vo(String plan_col_vo) {
		this.plan_col_vo = plan_col_vo;
	}

	public Timestamp getplan_colcreat_time() {
		return plan_colcreat_time;
	}

	public void setplan_colcreat_time(Timestamp plan_colcreat_time) {
		this.plan_colcreat_time = plan_colcreat_time;
	}

	public Date getPlan_colstart_date() {
		return plan_colstart_date;
	}

	public void setPlan_colstart_date(Date plan_colstart_date) {
		this.plan_colstart_date = plan_colstart_date;
	}

	public String getPlan_col_status() {
		return plan_col_status;
	}

	public void setPlan_col_status(String plan_col_status) {
		this.plan_col_status = plan_col_status;
	}
	
}
