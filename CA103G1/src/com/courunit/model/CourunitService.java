package com.courunit.model;

import java.sql.Timestamp;
import java.util.List;

import com.courboar.model.CourBoarVO;
import com.watchedhr.model.WatchedhrVO;

public class CourunitService {
	
   private CourunitDAO_interface dao;
	
	public CourunitService() {
		dao = new CourunitDAO();
	}
	
	//ashley
	
	public Double getCourTotalLength(String cour_id){
		return dao.getUnitSum(cour_id);
	}
	
	//ashley
	public List<CourunitVO> getCourUnit(String cour_id){
		return dao.getCourUnitwithoutVideo(cour_id);
		
	}
	
	//ashley
	
	public CourunitVO addCourUnit(String cour_id, String cu_name, byte[] cour_film_blob, Double cour_length,
			String cour_vtype) {

		CourunitVO courunitVO = new CourunitVO();

		courunitVO.setCour_id(cour_id);
		courunitVO.setCu_name(cu_name);
		courunitVO.setCour_film_blob(cour_film_blob);
		courunitVO.setCour_length(cour_length);
		courunitVO.setCour_vtype(cour_vtype);
		 
		dao.insert(courunitVO);
		return courunitVO;
	}
	
	//ashley
	
	public CourunitVO updateCourUnit(String cour_id, String cu_name, byte[] cour_film_blob, Double cour_length,
			String cour_vtype) {

		CourunitVO courunitVO = new CourunitVO();

		courunitVO.setCour_id(cour_id);
		courunitVO.setCu_name(cu_name);
		courunitVO.setCour_film_blob(cour_film_blob);
		courunitVO.setCour_length(cour_length);
		courunitVO.setCour_vtype(cour_vtype);
		 
		dao.insert(courunitVO);
		return courunitVO;
	}
	
	public CourunitVO findByPK(String cour_unit_id) {
		return dao.findByPK(cour_unit_id);
	}
	
}
