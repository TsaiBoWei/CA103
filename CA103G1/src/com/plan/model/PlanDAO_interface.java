package com.plan.model;

import java.util.List;
import java.util.Map;

public interface PlanDAO_interface {

	public void insert(PlanVO planVO);

	public void update(PlanVO planVO);
	
	public void delete(String plan_id);

	public PlanVO findByPrimaryKey(String plan_id);

	public List<PlanVO> getAll();
	
	public List<PlanVO> getAllforVisitor();
	
	public List<PlanVO> getAll(Map<String, String[]> map);
	
	/******************1004增加計畫interface*************/
		//以會員id找到計畫
		public List<PlanVO> getPlansByMem(String mem_id);		
		//更新計畫(行事曆)
		public void updateInCal(PlanVO planVO);
		//刪除計畫(行事曆)
		public void updatePlanStatusCal(String plan_id,String plan_status);
	/*************************************************/	
		
	/********************* 1010 首頁用 *****************/
		public List<PlanVO> getNewPlan();
		
	    public List<PlanVO> getPopularPlan();
			
	/*************************************************/	
}
