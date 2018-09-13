package com.eventad.model;

import java.util.List;


public interface EventAdDAO_interface {
	
	public void insert(EventAdVO eventAdVO);
    public void update(EventAdVO eventAdVO);
    public EventAdVO findByPrimaryKey(String ead_id);
    public List<EventAdVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EventAdVO> getAll(Map<String, String[]> map);
//  public void delete(String ead_id);


}
