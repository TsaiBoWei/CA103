package com.plan.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

//用計畫關鍵字找到該計畫在DAO中未定義完全。

public class PlanService {

	private PlanDAO_interface dao;

	public PlanService() {
		dao = new PlanDAO();
	}

	public PlanVO addPlan(String mem_id, String plan_name, byte[] plan_cover, Timestamp plan_start_date,
			Timestamp plan_end_date, String sptype_id, String plan_privacy, String plan_vo, Integer plan_view) {
		PlanVO planVO = new PlanVO();

		planVO.setMem_id(mem_id);
		planVO.setPlan_name(plan_name);
		planVO.setPlan_cover(plan_cover);
		planVO.setPlan_start_date(plan_start_date);
		planVO.setPlan_end_date(plan_end_date);
		planVO.setSptype_id(sptype_id);
		planVO.setPlan_privacy(plan_privacy);
		planVO.setPlan_vo(plan_vo);
		planVO.setPlan_view(plan_view);
		dao.insert(planVO);

		return planVO;
	}

	public PlanVO updatePlan(String plan_name, String plan_vo, byte[] plan_cover, Timestamp plan_start_date,
			Timestamp plan_end_date, String sptype_id, String plan_privacy, String plan_status, String plan_id) {
		PlanVO planVO = new PlanVO();

		planVO.setPlan_name(plan_name);
		planVO.setPlan_vo(plan_vo);
		planVO.setPlan_cover(plan_cover);
		planVO.setPlan_start_date(plan_start_date);
		planVO.setPlan_end_date(plan_end_date);
		planVO.setSptype_id(sptype_id);
		planVO.setPlan_privacy(plan_privacy);
		planVO.setPlan_status(plan_status);
		planVO.setPlan_id(plan_id);
		dao.update(planVO);
		return planVO;
	}

	public void deletePlan(String plan_id) {
		dao.delete(plan_id);
	}

	public PlanVO getOnePlan(String plan_id) {
		return dao.findByPrimaryKey(plan_id);
	}

	public List<PlanVO> getAll() {
		return dao.getAll();
	}

	public List<PlanVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}

	public List<PlanVO> getAllforVisitor() {
		return dao.getAllforVisitor();
	}

	public List<PlanVO> getAllforVisitor(Map<String, String[]> map) {
		return dao.getAll(map);
	}

	/********************* 1004增加計畫service ***************/
	// 以會員id查詢計畫
	public List<PlanVO> getPlansByMem(String mem_id) {
		return dao.getPlansByMem(mem_id);
	}

	// 新增計畫(在行事曆)
	public PlanVO updateInCal(String plan_name, String plan_vo, Timestamp plan_start_date, Timestamp plan_end_date,
			String plan_id) {
		PlanVO planVO = new PlanVO();

		planVO.setPlan_name(plan_name);
		planVO.setPlan_vo(plan_vo);

		planVO.setPlan_start_date(plan_start_date);
		planVO.setPlan_end_date(plan_end_date);

		planVO.setPlan_id(plan_id);
		dao.updateInCal(planVO);

		return planVO;
	}

	// 刪除計畫(改狀態碼)於行事曆
	public PlanVO changePlanStatusCal(String plan_id, String plan_status) {
		dao.updatePlanStatusCal(plan_id, plan_status);
		return dao.findByPrimaryKey(plan_id);
	}

	/************************************************************/

	/********************* 1010 首頁用 ****************************/
	public List<PlanVO> getNewPlan() {
		return dao.getNewPlan();
	}

	public List<PlanVO> getPopularPlan() {
		return dao.getPopularPlan();
	}

	/************************************************************/

	/********************* 1015 給訪客和朋友的個人頁面用 *****************/
	public List<PlanVO> getPlanForVisitorByMem(String mem_id) {
		return dao.getPlanForVisitorByMem(mem_id);
	}

	public List<PlanVO> getPlanForFriendByMem(String mem_id) {
		return dao.getPlanForFriendByMem(mem_id);
	}

	/*************************************************/

}
