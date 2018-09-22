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
}
