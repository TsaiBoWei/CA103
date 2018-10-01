package com.plancollection.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class PlanCollectionService {

	PlanCollectionDAO_interface dao;
	
	public PlanCollectionService() {
		dao = new PlanCollectionDAO();
	}
	
	public void addPlanCol(String plan_col_id,String plan_col_mem_id,String creat_plan_mem_id,String plan_col_name,
			String plan_col_vo,Date plan_colstart_date,Timestamp plan_colcreat_time,String plan_col_status) {
		
		PlanCollectionVO planCollectionVO = new PlanCollectionVO();
		planCollectionVO.setPlan_col_id(plan_col_id);
		planCollectionVO.setPlan_col_mem_id(plan_col_mem_id);
		planCollectionVO.setCreat_plan_mem_id(creat_plan_mem_id);
		planCollectionVO.setPlan_col_name(plan_col_name);
		planCollectionVO.setPlan_col_vo(plan_col_vo);
		planCollectionVO.setPlan_colstart_date(plan_colstart_date);
		planCollectionVO.setplan_colcreat_time(plan_colcreat_time);
		planCollectionVO.setPlan_col_status(plan_col_status);
		dao.insert(planCollectionVO);
	}
	public void updatePlanCol(String plan_col_id,String plan_col_mem_id,String creat_plan_mem_id,String plan_col_name,
			String plan_col_vo,Date plan_colstart_date,Timestamp plan_colcreat_time,String plan_col_status) {
		
		PlanCollectionVO planCollectionVO = new PlanCollectionVO();
		planCollectionVO.setPlan_col_id(plan_col_id);
		planCollectionVO.setPlan_col_mem_id(plan_col_mem_id);
		planCollectionVO.setCreat_plan_mem_id(creat_plan_mem_id);
		planCollectionVO.setPlan_col_name(plan_col_name);
		planCollectionVO.setPlan_col_vo(plan_col_vo);
		planCollectionVO.setPlan_colstart_date(plan_colstart_date);
		planCollectionVO.setplan_colcreat_time(plan_colcreat_time);
		planCollectionVO.setPlan_col_status(plan_col_status);
		dao.update(planCollectionVO);
	}
	
	public void updateStatesPlanCol(String plan_col_id , String plan_col_status) {
		
		PlanCollectionVO planCollectionVO = new PlanCollectionVO();
		planCollectionVO.setCreat_plan_mem_id(plan_col_id);
		planCollectionVO.setPlan_col_status(plan_col_status);
		dao.update_states(plan_col_id, plan_col_status);
		
	}
	
	public PlanCollectionVO getOnePlanColletion(String plan_col_id) {
		
		return dao.findByPrimaryKey(plan_col_id);
	}
	
	public List<PlanCollectionVO> getall() {
		return dao.getAll();
	}
	
}
