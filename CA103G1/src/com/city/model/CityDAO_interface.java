package com.city.model;

import java.util.List;


public interface CityDAO_interface {
    public void insert(CityVO cityVO);
    public void update(CityVO cityVO);
    public void delete(String city_id);
    public CityVO findByPrimaryKey(String city_id);
    public List<CityVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<CityVO> getAll(Map<String, String[]> map); 

}
