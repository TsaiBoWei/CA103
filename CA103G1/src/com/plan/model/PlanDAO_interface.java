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
	
	/******************1004�W�[�p�einterface*************/
		//�H�|��id���p�e
		public List<PlanVO> getPlansByMem(String mem_id);		
		//��s�p�e(��ƾ�)
		public void updateInCal(PlanVO planVO);
		//�R���p�e(��ƾ�)
		public void updatePlanStatusCal(String plan_id,String plan_status);
	/*************************************************/	
		
	/********************* 1010 ������ *****************/
		public List<PlanVO> getNewPlan();
		
	    public List<PlanVO> getPopularPlan();
			
	/*************************************************/	
}
