package com.eve.model;

import java.util.List;

public interface EventDAO_interface {
    public void insert(EventVO eventVO);
    public void update(EventVO eventVO);
    public EventVO findByPrimaryKey(String eve_id);
    public List<EventVO> getAll();
//    public void delete(String eve_id);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 

}
