package com.eventad.model;

import java.util.List;

public class EventAdService {
	
	private EventAdDAO_interface dao;
	
	public EventAdService() {
		dao=new EventAdDAO();
	}
	
	public EventAdVO addEventAd(String mem_id, byte[] ead_pic, String ead_ptype) {
		
		EventAdVO eventAdVO=new EventAdVO();
		eventAdVO.setMem_id(mem_id);
		eventAdVO.setEad_pic(ead_pic);
		eventAdVO.setEad_ptype(ead_ptype);
		dao.insert(eventAdVO);
		return eventAdVO;
		
	}
	
	public EventAdVO updateEventAd(String ead_id,String mem_id,byte[] ead_pic, String ead_ptype) {
		EventAdVO eventAdVO=new EventAdVO();
		eventAdVO.setEad_id(ead_id);
		eventAdVO.setMem_id(mem_id);
		eventAdVO.setEad_pic(ead_pic);
		eventAdVO.setEad_ptype(ead_ptype);
		dao.update(eventAdVO);
		return eventAdVO;
	}
	
	public void updateStatus(String ead_id,String ead_status) {
		dao.updateStatus(ead_id, ead_status);
	}
	
	public EventAdVO getOneEveAd(String ead_id) {
		return dao.findByPrimaryKey(ead_id);
	}
	
	public List<EventAdVO> getAll(){
		return dao.getAll();
	}
	

}
