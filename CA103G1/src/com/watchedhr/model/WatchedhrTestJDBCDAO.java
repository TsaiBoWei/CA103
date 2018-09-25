package com.watchedhr.model;

import com.watchedhr.model.WatchedhrJDBCDAO;
import com.watchedhr.model.WatchedhrVO;

public class WatchedhrTestJDBCDAO {
	public static void main(String[] args) {

		WatchedhrJDBCDAO dao = new WatchedhrJDBCDAO();

		// ·s¼W
//		WatchedhrVO watchedhrVO01 = new WatchedhrVO();
//		watchedhrVO01.setCour_unit_id("CU000001");
//		watchedhrVO01.setCrorder_id("CO000002");
//		watchedhrVO01.setWatched_hr(360.5);
//		dao.insert(watchedhrVO01);

		// ­×§ï
		WatchedhrVO watchedhrVO02 = new WatchedhrVO();
		watchedhrVO02.setCour_unit_id("CU000001");
		watchedhrVO02.setCrorder_id("CO000001");
		watchedhrVO02.setWatched_hr(123.5);
		dao.update(watchedhrVO02);
	}
}
