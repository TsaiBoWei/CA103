package com.courboar.model;

import java.sql.Timestamp;
import java.util.List;

public class CourBoarService {

	private CourBoarDAO_interface dao;

	public CourBoarService() {
		dao = new CourBoarDAO();
	}

	public CourBoarVO addCourboar(String crpos_tit, Timestamp crpos_time, String cour_id, String mem_id,
			String crpos_text) {

		CourBoarVO courboarVO = new CourBoarVO();

		courboarVO.setCrpos_tit(crpos_tit);
		courboarVO.setCrpos_time(crpos_time);
		courboarVO.setCour_id(cour_id);
		courboarVO.setMem_id(mem_id);
		courboarVO.setCrpos_text(crpos_text);
		// 直接SQL預設Crpos_sta("CP1")
		dao.add(courboarVO);
		return courboarVO;
	}

	public CourBoarVO updateCourboar(String crpost_id, String crpos_tit, String crpos_text) {

		CourBoarVO courboarVO = new CourBoarVO();

		courboarVO.setCrpost_id(crpost_id);
		courboarVO.setCrpos_tit(crpos_tit);
		courboarVO.setCrpos_text(crpos_text);
		dao.update(courboarVO);
		return courboarVO;
	}

	public void hideCourboar(String crpost_id) {
		dao.hide( crpost_id);
	}

	public CourBoarVO getOneCourboar(String crpost_id) {
		return dao.findByPK(crpost_id);
	}

	public List<CourBoarVO> keyWordSearch(String keyWord, String cour_id) {
		return dao.findByKeyWord(keyWord, cour_id);
	}
	
	public List<CourBoarVO> findByCour_id(String cour_id) {
		return dao.findByCour_id(cour_id);
	}

}