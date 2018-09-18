package com.plan.model;

import java.sql.Timestamp;
import java.util.List;

//用計畫關鍵字找到該計畫在DAO中未定義完全。

public class PlanService {

	private PlanDAO_interface dao;

	public PlanService() {
		dao = new PlanDAO();
	}

	public PlanVO addPlan(String plan_name, String plan_vo, byte[] plan_cover,

			Timestamp plan_start_date, Timestamp plan_end_date, String sptype_id, String plan_privacy) {

		PlanVO planVO = new PlanVO();

		planVO.setPlan_name(plan_name);
		planVO.setPlan_vo(plan_vo);
		planVO.setPlan_cover(plan_cover);
		planVO.setPlan_start_date(plan_start_date);
		planVO.setPlan_end_date(plan_end_date);
		planVO.setSptype_id(sptype_id);
		planVO.setPlan_privacy(plan_privacy);
		dao.insert(planVO);

		return planVO;
	}

	public PlanVO updatePlan(String plan_id, String plan_name, String plan_vo, byte[] plan_cover,
			Timestamp plan_start_date, Timestamp plan_end_date, String sptype_id, String plan_privacy,
			String plan_status) {

		PlanVO planVO = new PlanVO();

		planVO.setPlan_id(plan_id);
		planVO.setPlan_name(plan_name);
		planVO.setPlan_vo(plan_vo);
		planVO.setPlan_cover(plan_cover);
		planVO.setPlan_start_date(plan_start_date);
		planVO.setPlan_end_date(plan_end_date);
		planVO.setSptype_id(sptype_id);
		planVO.setPlan_privacy(plan_privacy);
		planVO.setPlan_status(plan_status);

		return planVO;

	}

	public PlanVO getOnePlan(String plan_id) {
		return dao.findByPrimaryKey(plan_id);
	}

	public PlanVO getOnePlanByKeyWord(String plan_name) {
		return dao.findPlanByKeyWord(plan_name);
	}

	public List<PlanVO> getAllPlan() {
		return dao.getAll();
	}
}
