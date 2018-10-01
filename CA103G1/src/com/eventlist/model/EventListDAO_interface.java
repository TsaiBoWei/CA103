package com.eventlist.model;

import java.util.List;


public interface EventListDAO_interface {
	public void insert(EventListVO eventListVO);
    public void update(EventListVO eventListVO);
    public void updateListStatus(String mem_id,String eve_id,String evelist_status);
    public void updateShareStatus(String mem_id,String eve_id,String eve_share);
    public EventListVO findByPrimaryKey(String mem_id,String eve_id);
    public int getEveIncome(String eve_id);
    public int getNumOfMemByEve(String eve_id);
    public List<EventListVO> findByMemId(String mem_id);
    public List<EventListVO> findByEveId(String eve_id);
    public List<EventListVO> getAll();
//  public void delete(String mem_id,String eve_id);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<EventListVO> getAll(Map<String, String[]> map); 

}
