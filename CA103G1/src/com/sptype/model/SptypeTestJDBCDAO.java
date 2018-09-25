package com.sptype.model;

import java.util.List;

import com.sptype.model.SptypeJDBCDAO;
import com.sptype.model.SptypeVO;

public class SptypeTestJDBCDAO {
	
	public static void main(String[] args) {

		SptypeJDBCDAO dao = new SptypeJDBCDAO();

		// �s�W
//		SptypeVO sptypeVO01 = new SptypeVO();
//		sptypeVO01.setSport("�k��");
//		dao.insert(sptypeVO01);

		// �ק�
//		SptypeVO sptypeVO02 = new SptypeVO();
//		sptypeVO02.setSptype_id("SP000002");
//		sptypeVO02.setSport("�樮");
//		dao.update(sptypeVO02);


		// �R��
//		dao.delete("SP000009");

		// ��@�d��
		SptypeVO sptypeVO03 = dao.findByPK("SP000002");
		System.out.print(sptypeVO03.getSptype_id() + ",");
		System.out.print(sptypeVO03.getSport() + ",");
		System.out.println(sptypeVO03.getSport_logo());
		System.out.println("---------------------");

		// �C��d��
//		List<SptypeVO> list = dao.getAll();
//		for (SptypeVO aEmp : list) {
//			System.out.print(aEmp.getSptype_id() + ",");
//			System.out.print(aEmp.getSport() + ",");
//			System.out.println(aEmp.getSport_logo());  //�ثe�n�̭�����Ƥ~��
//			System.out.println();
//		}
	}

}
