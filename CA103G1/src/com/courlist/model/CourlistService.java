package com.courlist.model;
import java.util.List;

public class CourlistService {
	private CourlistDAO_interface dao;

	public CourlistService() {
		dao = new CourlistDAO();
	}

	public CourlistVO addCourlist(String sptype_id, String coa_id, String cname,
			String cour_text, Integer cour_cost, byte[] cour_pho,  String cour_lau, 
			String cour_ann) {

		CourlistVO courlistVO = new CourlistVO();

		courlistVO.setSptype_id(sptype_id);
		courlistVO.setCoa_id(coa_id);
		courlistVO.setCname(cname);
		courlistVO.setCour_text(cour_text);
		courlistVO.setCour_cost(cour_cost);
		courlistVO.setCour_pho(cour_pho);
		courlistVO.setCour_lau(cour_lau);
		courlistVO.setCour_ann(cour_ann);
		dao.insert(courlistVO);

		return courlistVO;
	}

	public CourlistVO updateCourlist(String cour_id, String sptype_id, String coa_id, String cname,
			String cour_text, Integer cour_cost, byte[] cour_pho,  String cour_lau, 
			String cour_ann) {

		CourlistVO courlistVO = new CourlistVO();

		courlistVO.setCour_id(cour_id);
		courlistVO.setSptype_id(sptype_id);
		courlistVO.setCoa_id(coa_id);
		courlistVO.setCname(cname);
		courlistVO.setCour_text(cour_text);
		courlistVO.setCour_cost(cour_cost);
		courlistVO.setCour_pho(cour_pho);
		courlistVO.setCour_lau(cour_lau);
		courlistVO.setCour_ann(cour_ann);
		dao.update(courlistVO);

		return courlistVO;
	}

	public void deleteCourlist(String cour_id) {
		dao.delete(cour_id);
	}

	public CourlistVO getOneCourlist(String cour_id) {
		return dao.findByPK(cour_id);
	}

	public List<CourlistVO> getAll() {
		return dao.getAll();
	}
	
	//ashley
	
	public List<CourlistVO> getCourlistByCoa_id(String coa_id) {
		return dao.getCourlistByCoa_id(coa_id);
	}
	
	//首頁用
	public List<CourlistVO> getPopularCour() {
		return dao.getPopularCour();
	}
	//首頁用
	public List<CourlistVO> getNewCour() {
		return dao.getNewCour();
	}
	
	//課程檢舉後下架
	public void updateStates(String cour_lau,String cour_id) {
		dao.updateState(cour_lau, cour_id);
	}

}
