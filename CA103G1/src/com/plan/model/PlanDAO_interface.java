package com.plan.model;

import java.util.List;

public interface PlanDAO_interface {

	public void insert(PlanVO planVO);

	public void update(PlanVO planVO);
	
	public void delete(String plan_id);

	public PlanVO findByPrimaryKey(String plan_id);

	public PlanVO findPlanByKeyWord(String plan_name);

	// (������) New Method ��J�p�e�W������r�A�i���ӭp�e�C
	public List<PlanVO> getAll();
}
