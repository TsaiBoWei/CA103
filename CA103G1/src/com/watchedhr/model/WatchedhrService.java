package com.watchedhr.model;

import java.util.List;

import com.courboar.model.CourBoarVO;

public class WatchedhrService {
	
   private WatchedhrDAO_interface dao;
	
	public WatchedhrService() {
		dao = new WatchedhrDAO();
	}
	
	public Double getWatchSumBycrorder_id(String crorder_id){
		return dao.getWatchSum(crorder_id);
	}
	
	public List <String> getCour_unit_idByCrorder_id(String crorder_id){
		return  dao.getCour_unit_idByCrorder_id(crorder_id);
	}
	public void insert(String cour_unit_id,String crorder_id,Double watched_hr) {
		WatchedhrVO watchedhrVO=new WatchedhrVO ();
		watchedhrVO.setCour_unit_id(cour_unit_id);
		watchedhrVO.setCrorder_id(crorder_id);
		watchedhrVO.setWatched_hr(watched_hr);
		dao.insert(watchedhrVO);
	}
	
	public Double getWatched_hr(String crorder_id, String cour_unit_id) {
		 return dao.getWatched_hr(crorder_id, cour_unit_id);
	}
	
	
	 public WatchedhrVO getFirstByCrorder_id(String crorder_id){
		 return dao.getFirstByCrorder_id(crorder_id);
	 } 
	
	
}
