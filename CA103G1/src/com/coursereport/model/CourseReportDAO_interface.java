package com.coursereport.model;

import java.util.List;

public interface CourseReportDAO_interface {
	public void add(CourseReportVO courseReportVO);

	public void updateCourrep_Status(String courrep_status, String courrepo_id);// �B�˫�ĳ��courrepo_id�z���status

	public CourseReportVO findByPK(String ccourrepo_id);

	public List<CourseReportVO> findByCourIdplusStatus(String cour_id, String courrep_status);

	public List<CourseReportVO> getAll();

}
