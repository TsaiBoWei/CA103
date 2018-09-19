package com.eventad.model;

import java.util.List;


public interface EventAdDAO_interface {
	
	public void insert(EventAdVO eventAdVO);
    public void update(EventAdVO eventAdVO);
    public void updateStatus(String ead_id,String ead_status);
    public EventAdVO findByPrimaryKey(String ead_id);
    public List<EventAdVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<EventAdVO> getAll(Map<String, String[]> map);
//  public void delete(String ead_id);


}
