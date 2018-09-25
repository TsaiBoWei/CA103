package com.courlist.model;

import java.util.List;

import com.courlist.model.CourlistJDBCDAO;
import com.courlist.model.CourlistVO;

public class CourlistTestJDBCDAO {
	public static void main(String[] args) {

		CourlistJDBCDAO dao = new CourlistJDBCDAO();

		// �s�W
//		CourlistVO courlistVO01 = new CourlistVO();
//		courlistVO01.setSptype_id("SP000001");
//		courlistVO01.setCoa_id("C000001");
//		courlistVO01.setCname("�ҵ{�W��1");
//		courlistVO01.setCour_text("�ҵ{����1");
//		courlistVO01.setCour_cost(5000);
//		
//		courlistVO01.setCour_lau("CL01");
//		courlistVO01.setCour_ann("�ҵ{���i3");
//		courlistVO01.setCour_view(0);
//		dao.insert(courlistVO01);
//
//		// �ק�
//		CourlistVO courlistVO02 = new CourlistVO();
//		courlistVO02.setCour_id("COUR000002");
//		courlistVO02.setSptype_id("SP000001");
//		courlistVO02.setCoa_id("C000001");
//		courlistVO02.setCname("�ҵ{�W��1");
//		courlistVO02.setCour_text("�ҵ{����1");
//		courlistVO02.setCour_cost(2000);
//		courlistVO02.setCour_lau("CL02");
//		courlistVO02.setCour_ann("�ҵ{���i2");
//		courlistVO02.setCour_view(2);
//		dao.update(courlistVO02);

		// �R��
//		dao.delete("COUR000007");
//
		// ��@�d��
//		CourlistVO courlistVO03 = dao.findByPK("COUR000001");
//		System.out.print(courlistVO03.getCour_id() + ",");
//		System.out.print(courlistVO03.getSptype_id() + ",");
//		System.out.print(courlistVO03.getCoa_id() + ",");
//		System.out.print(courlistVO03.getCname() + ",");
//		System.out.print(courlistVO03.getCour_text() + ",");
//		System.out.print(courlistVO03.getCour_cost() + ",");
//		System.out.print(courlistVO03.getCour_lau() + ",");
//		System.out.print(courlistVO03.getCour_ann() + ",");
//		System.out.println(courlistVO03.getCour_view());
//		System.out.println("---------------------");

//		// �C��d��
		List<CourlistVO> list = dao.getAll();
		for (CourlistVO aEmp : list) {
			System.out.print(aEmp.getCour_id() + ",");
			System.out.print(aEmp.getSptype_id() + ",");
			System.out.print(aEmp.getCoa_id() + ",");
			System.out.print(aEmp.getCname() + ",");
			System.out.print(aEmp.getCour_text() + ",");
			System.out.print(aEmp.getCour_cost() + ",");
			System.out.print(aEmp.getCour_pho() + ","); //�ثe�n�̭�����Ƥ~��
			System.out.print(aEmp.getCour_lau() + ",");
			System.out.print(aEmp.getCour_ann() + ",");
			System.out.println(aEmp.getCour_view());
			System.out.println();
		}
	}

}
