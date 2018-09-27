package com.eventsave.model;

import java.util.List;


public class EventSaveService {

	private EventSaveDAO_interface dao;
	
	public EventSaveService() {
		dao = new EventSaveDAO();
	}
	
	public EventSaveVO addEventSave(String mem_id,String eve_id,String es_status) {
		EventSaveVO eventsaveVO = new EventSaveVO();
		eventsaveVO.setMem_id(mem_id);
		eventsaveVO.setEve_id(eve_id);
		eventsaveVO.setEs_status(es_status);
		dao.insert(eventsaveVO);
		
		return eventsaveVO;
	}
	
	public EventSaveVO UpdateEventSave(String mem_id,String eve_id,String es_status) {
		EventSaveVO eventsaveVO = new EventSaveVO();
		
		eventsaveVO.setMem_id(mem_id);
		eventsaveVO.setEve_id(eve_id);
		eventsaveVO.setEs_status(es_status);
		dao.update(eventsaveVO);
		
		return eventsaveVO;
	}
	
	public void deleteEventSave(String mem_id, String eve_id) {
		dao.delete(mem_id, eve_id);
	}
	
	public EventSaveVO getOneEventSave(String mem_id, String eve_id) {
		return dao.findByPrimaryKey(mem_id, eve_id);
	}
	
	public List<EventSaveVO> getAll(){
		return dao.getAll();
	}
	
}
