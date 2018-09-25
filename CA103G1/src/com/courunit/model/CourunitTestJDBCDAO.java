package com.courunit.model;

import java.util.List;

import com.courunit.model.CourunitJDBCDAO;
import com.courunit.model.CourunitVO;

public class CourunitTestJDBCDAO {
	public static void main(String[] args) {

		CourunitJDBCDAO dao = new CourunitJDBCDAO();

		// �s�W
//		CourunitVO courunitVO01 = new CourunitVO();
//		courunitVO01.setCour_id("COUR000001");
//		courunitVO01.setCu_name("�椸�W��1");
//		courunitVO01.setCour_film_vc("�椸�v���ȮɥΤ�r����");
//		courunitVO01.setCour_length(300.5);
//		courunitVO01.setCour_vtype("�v���ɮ׮榡�ȥΤ�r����");
//		dao.insert(courunitVO01);

		// �ק�
//		CourunitVO courunitVO02 = new CourunitVO();
//		courunitVO02.setCour_unit_id("CU000001");
//		courunitVO02.setCour_id("COUR000001");
//		courunitVO02.setCu_name("�椸�W��1");
//		courunitVO02.setCour_film_vc("��r����1");
//		courunitVO02.setCour_length(100.5);
//		courunitVO02.setCour_vtype("��r����2");
//		dao.update(courunitVO02);


		// �R��
//		dao.delete("CU000016");

		// ��@�d��
//		CourunitVO courunitVO03 = dao.findByPK("CU000009");
//		System.out.print(courunitVO03.getCour_unit_id() + ",");
//		System.out.print(courunitVO03.getCour_id() + ",");
//		System.out.print(courunitVO03.getCu_name() + ",");
//		System.out.print(courunitVO03.getCour_film_vc() + ",");
//		System.out.print(courunitVO03.getCour_length() + ",");
//		System.out.println(courunitVO03.getCour_vtype());
//		System.out.println("---------------------");

		// �C��d��
		List<CourunitVO> list = dao.getAll();
		for (CourunitVO aEmp : list) {
			System.out.print(aEmp.getCour_unit_id() + ",");
			System.out.print(aEmp.getCour_id() + ",");
			System.out.print(aEmp.getCu_name() + ",");
			System.out.print(aEmp.getCour_film_blob() + ",");  //�ثe�n�̭�����Ƥ~��
			System.out.print(aEmp.getCour_film_vc() + ",");
			System.out.print(aEmp.getCour_length() + ",");
			System.out.println(aEmp.getCour_vtype());
			System.out.println();
		}
	}

}
