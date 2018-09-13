package com.eventlist.model;

import java.util.List;


public interface EventListDAO_interface {
	public void insert(EventListVO eventListVO);
    public void update(EventListVO eventListVO);
    public EventListVO findByPrimaryKey(String mem_id,String eve_id);
    public List<EventListVO> findByMemId(String mem_id);
    public List<EventListVO> findByEveId(String eve_id);
    public List<EventListVO> getAll();
//  public void delete(String mem_id,String eve_id);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EventListVO> getAll(Map<String, String[]> map); 

}
