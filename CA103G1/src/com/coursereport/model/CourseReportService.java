package com.coursereport.model;

import java.sql.Timestamp;
import java.util.List;

public class CourseReportService {
	
	CourseReportDAO_interface dao;
	
	public CourseReportService() {
		dao = new CourseReportDAO();
	}
	
	public CourseReportVO addCourseRep(Timestamp courre_time,String cour_id,
			String mem_id, String courrep_item, String courrep_text) {
		
		CourseReportVO courseReportVO = new CourseReportVO();
		courseReportVO.setCour_id(cour_id);
		courseReportVO.setCourre_time(courre_time);
		courseReportVO.setCourrep_item(courrep_item);
		courseReportVO.setCourrep_status("CR1");
		courseReportVO.setCourrep_text(courrep_text);
		courseReportVO.setMem_id(mem_id);
		
		dao.add(courseReportVO);
		
		return courseReportVO;
	}
	
	public CourseReportVO updateCourseRepStatus(String courrep_status, String courrepo_id) {
		
		dao.updateCourrep_Status(courrep_status, courrepo_id);
		return dao.findByPK(courrepo_id);
		
	}
	
	public List<CourseReportVO> getByCourStatus(String courrep_status){
		return dao.findByCourStatus(courrep_status);
	}
	
	public List<CourseReportVO> getAllCourses(){
		return dao.getAll();
	}
	
	public List<CourseReportVO> getSolvedCours(){
		return dao.findSolvedCours();
	}

}
