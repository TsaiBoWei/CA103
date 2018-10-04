package com.plan.model;

import java.util.List;

public interface PlanDAO_interface {

	public void insert(PlanVO planVO);

	public void update(PlanVO planVO);
	
	public void delete(String plan_id);

	public PlanVO findByPrimaryKey(String plan_id);

	public PlanVO findPlanByKeyWord(String plan_name);

	// (未完成) New Method 輸入計畫名稱關鍵字，可找到該計畫。
	public List<PlanVO> getAll();
	
	/******************1004增加計畫interface*************/
		//以會員id找到計畫
		public List<PlanVO> getPlansByMem(String mem_id);		
		//更新計畫(行事曆)
		public void updateInCal(PlanVO planVO);
		//刪除計畫(行事曆)
		public void updatePlanStatusCal(String plan_id,String plan_status);
	/*************************************************/	
}
