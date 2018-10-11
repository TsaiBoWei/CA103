package com.eventsave.model;

import java.util.List;

public interface EventSaveDAO_interface {
	public void insert(EventSaveVO eventsaveVO);
	public void update(EventSaveVO eventsaveVO);
	public void delete(String mem_id,String eve_id);
	public EventSaveVO findByPrimaryKey(String mem_id,String eve_id);
	public List<EventSaveVO> findByMemId(String mem_id);
	public List<EventSaveVO> getAll();
}
