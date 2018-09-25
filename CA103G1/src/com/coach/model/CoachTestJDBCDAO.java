package com.coach.model;

import java.util.List;

import com.coach.model.CoachJDBCDAO;
import com.coach.model.CoachVO;

public class CoachTestJDBCDAO {
	public static void main(String[] args) {

		CoachJDBCDAO dao = new CoachJDBCDAO();

		// 新增
//		CoachVO coachVO01 = new CoachVO();
//		coachVO01.setMem_id("M000001");
//		coachVO01.setCoa_text("教練介紹4");
//		coachVO01.setCoa_status("CS02");
//		coachVO01.setCoa_recount(3);
//		dao.insert(coachVO01);

		// 修改
//		CoachVO coachVO02 = new CoachVO();
//		coachVO02.setCoa_id("C000001");		
//		coachVO02.setMem_id("M000002");
//		coachVO02.setCoa_text("教練介紹2");
//		coachVO02.setCoa_status("CS01");
//		coachVO02.setCoa_recount(5);
//		dao.update(coachVO02);

		// 單一查詢
//		CoachVO coachVO03 = dao.findByPK("C000001");
//		System.out.print(coachVO03.getCoa_id() + ",");
//		System.out.print(coachVO03.getMem_id() + ",");
//		System.out.print(coachVO03.getCoa_text() + ",");
//		System.out.print(coachVO03.getCoa_status() + ",");
//		System.out.println(coachVO03.getCoa_recount());
//		System.out.println("---------------------");

		// 列表查詢
		List<CoachVO> list = dao.getAll();
		for (CoachVO aEmp : list) {
			System.out.print(aEmp.getCoa_id() + ",");
			System.out.print(aEmp.getMem_id() + ",");
			System.out.print(aEmp.getCoa_text() + ",");
			System.out.print(aEmp.getCoa_status() + ",");
			System.out.print(aEmp.getCoa_recount());
			System.out.println();
		}
	}

}
