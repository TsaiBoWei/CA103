package com.eventlist.model;

import java.sql.Date;
import java.util.List;

public class EventlistService {
	
	private EventListDAO_interface dao;
	
	public EventlistService() {
		dao = new EventListDAO();
	}
	public EventListVO addEveList(String mem_id, String eve_id, Integer eve_rating, String evelist_status, Integer evepay_amount,
			String eve_share, Date evepay_deadline) {
		EventListVO eventListVO =new EventListVO();
		eventListVO.setMem_id(mem_id);
		eventListVO.setEve_id(eve_id);
		eventListVO.setEve_rating(eve_rating);
		eventListVO.setEvelist_status(evelist_status);
		eventListVO.setEvepay_amount(evepay_amount);
		eventListVO.setEvepay_deadline(evepay_deadline);
 //		eventListVO.setEvepay_deadline(null);
		eventListVO.setEve_share(eve_share);
		dao.insert(eventListVO);
		return eventListVO;
		
	}
	
	public EventListVO updateEveList(String mem_id, String eve_id, Integer eve_rating, String evelist_status, Integer evepay_amount,
			String eve_share, Date evepay_deadline) {
		EventListVO eventListVO =new EventListVO();
		eventListVO.setMem_id(mem_id);
		eventListVO.setEve_id(eve_id);
		eventListVO.setEve_rating(eve_rating);
		eventListVO.setEvelist_status(evelist_status);
		eventListVO.setEvepay_amount(evepay_amount);
		eventListVO.setEvepay_deadline(evepay_deadline);
 //		eventListVO.setEvepay_deadline(null);
		eventListVO.setEve_share(eve_share);
		dao.update(eventListVO);
		return eventListVO;
		
	}
	
	public EventListVO changeEveListStatus(String mem_id, String eve_id,  String evelist_status) {
		
		dao.updateListStatus(mem_id, eve_id, evelist_status);
		return  dao.findByPrimaryKey(mem_id,eve_id); 
		
	}
	
	public void changeShareStatus(String mem_id, String eve_id,  String eve_share) {
		
		dao.updateShareStatus(mem_id, eve_id, eve_share);
		
	}
	
	

	public EventListVO getOneEveList(String mem_id,String eve_id) {
		return dao.findByPrimaryKey(mem_id,eve_id);
	}

	public List<EventListVO> getEveListsByEve(String eve_id) {
		return dao.findByEveId(eve_id);
	}

	public List<EventListVO> getEveListsByMem(String mem_id)  {
		return dao.findByMemId(mem_id);
	}
	
	public int getEveIncome(String eve_id) {
		return dao.getEveIncome(eve_id);
	};
    public int getNumOfMemByEve(String eve_id) {
    	return dao.getNumOfMemByEve(eve_id);
    };

}
