package com.coursereport.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

public class CourseReportTest {
	public static void main(String[] args) {

		// add
		CourseReportVO courseReportVO = new CourseReportVO();

		courseReportVO.setCourre_time(new Timestamp(System.currentTimeMillis()));
		courseReportVO.setCourrep_item("CRN1");
		courseReportVO.setCour_id("COUR000002");
		courseReportVO.setMem_id("M000001");
		courseReportVO.setCourrep_text("老師行為不當2");
		courseReportVO.setReply_mgr_id("MGR000001");
		CourseReportJDBCDAO courseReportDAO = new CourseReportJDBCDAO();
		courseReportDAO.add(courseReportVO);

		System.out.println("create successful");
		// update status
//		CourseReportJDBCDAO courseReportDAO1 = new CourseReportJDBCDAO();
//		courseReportDAO1.updateCourrep_Status("CR2", "CR000002");
//
//		// select by course_id and status
//		CourseReportJDBCDAO courseReportDAO2 = new CourseReportJDBCDAO();
//
//		List<CourseReportVO> courseReport_list = courseReportDAO2.findByCourIdplusStatus("COUR000001", "CR1");
////		List<CourseReportVO>courseReport_list1=courseReportDAO2.getAll();
//
//		for (CourseReportVO courseReportVO1 : courseReport_list) {
//			System.out.print(courseReportVO1.getCourrepo_id() + ",");
//
//			SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy HH:mm:ss", Locale.US);
//			System.out.print(sdf.format(courseReportVO.getCourre_time()) + ",");
//			System.out.print("COUR000001" + ",");
//			System.out.print(courseReportVO.getMem_id() + ",");
//			System.out.print(courseReportVO.getCourrep_text() + ",");
//			System.out.print("CR1" + ",");
//			System.out.print("CP000001" + ",");
//			System.out.print(courseReportVO.getReply_mgr_id() + ",");
//			System.out.println("");
//		}
//
//		// findbyPK
//		CourseReportVO courseReportVO3 = courseReportDAO2.findByPK("CR000002");
//		SimpleDateFormat sdf = new SimpleDateFormat("d MMM yyyy HH:mm:ss", Locale.US);
//		System.out.print(sdf.format(courseReportVO.getCourre_time()) + ",");
//		System.out.print(courseReportVO3.getCourrep_item() + ",");
//		System.out.print(courseReportVO3.getMem_id() + ",");
//		System.out.print(courseReportVO3.getCourrep_text() + ",");
//		System.out.print(courseReportVO3.getCourrep_status() + ",");
//		System.out.print(courseReportVO3.getReply_mgr_id() + ",");

	

	}

}
