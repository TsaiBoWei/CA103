package com.courunit.model;

import java.util.List;

import com.courunit.model.CourunitJDBCDAO;
import com.courunit.model.CourunitVO;

public class CourunitTestJDBCDAO {
	public static void main(String[] args) {

		CourunitJDBCDAO dao = new CourunitJDBCDAO();

		// 新增
//		CourunitVO courunitVO01 = new CourunitVO();
//		courunitVO01.setCour_id("COUR000001");
//		courunitVO01.setCu_name("單元名稱1");
//		courunitVO01.setCour_film_vc("單元影片暫時用文字測試");
//		courunitVO01.setCour_length(300.5);
//		courunitVO01.setCour_vtype("影片檔案格式暫用文字測試");
//		dao.insert(courunitVO01);

		// 修改
//		CourunitVO courunitVO02 = new CourunitVO();
//		courunitVO02.setCour_unit_id("CU000001");
//		courunitVO02.setCour_id("COUR000001");
//		courunitVO02.setCu_name("單元名稱1");
//		courunitVO02.setCour_film_vc("文字測試1");
//		courunitVO02.setCour_length(100.5);
//		courunitVO02.setCour_vtype("文字測試2");
//		dao.update(courunitVO02);


		// 刪除
//		dao.delete("CU000016");

		// 單一查詢
//		CourunitVO courunitVO03 = dao.findByPK("CU000009");
//		System.out.print(courunitVO03.getCour_unit_id() + ",");
//		System.out.print(courunitVO03.getCour_id() + ",");
//		System.out.print(courunitVO03.getCu_name() + ",");
//		System.out.print(courunitVO03.getCour_film_vc() + ",");
//		System.out.print(courunitVO03.getCour_length() + ",");
//		System.out.println(courunitVO03.getCour_vtype());
//		System.out.println("---------------------");

		// 列表查詢
		List<CourunitVO> list = dao.getAll();
		for (CourunitVO aEmp : list) {
			System.out.print(aEmp.getCour_unit_id() + ",");
			System.out.print(aEmp.getCour_id() + ",");
			System.out.print(aEmp.getCu_name() + ",");
			System.out.print(aEmp.getCour_film_blob() + ",");  //目前要裡面有資料才行
			System.out.print(aEmp.getCour_film_vc() + ",");
			System.out.print(aEmp.getCour_length() + ",");
			System.out.println(aEmp.getCour_vtype());
			System.out.println();
		}
	}

}
