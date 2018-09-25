package com.sptype.model;

import java.util.List;

import com.sptype.model.SptypeJDBCDAO;
import com.sptype.model.SptypeVO;

public class SptypeTestJDBCDAO {
	
	public static void main(String[] args) {

		SptypeJDBCDAO dao = new SptypeJDBCDAO();

		// 新增
//		SptypeVO sptypeVO01 = new SptypeVO();
//		sptypeVO01.setSport("攀岩");
//		dao.insert(sptypeVO01);

		// 修改
//		SptypeVO sptypeVO02 = new SptypeVO();
//		sptypeVO02.setSptype_id("SP000002");
//		sptypeVO02.setSport("單車");
//		dao.update(sptypeVO02);


		// 刪除
//		dao.delete("SP000009");

		// 單一查詢
		SptypeVO sptypeVO03 = dao.findByPK("SP000002");
		System.out.print(sptypeVO03.getSptype_id() + ",");
		System.out.print(sptypeVO03.getSport() + ",");
		System.out.println(sptypeVO03.getSport_logo());
		System.out.println("---------------------");

		// 列表查詢
//		List<SptypeVO> list = dao.getAll();
//		for (SptypeVO aEmp : list) {
//			System.out.print(aEmp.getSptype_id() + ",");
//			System.out.print(aEmp.getSport() + ",");
//			System.out.println(aEmp.getSport_logo());  //目前要裡面有資料才行
//			System.out.println();
//		}
	}

}
