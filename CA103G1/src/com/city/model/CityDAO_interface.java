package com.city.model;

import java.util.List;


public interface CityDAO_interface {
    public void insert(CityVO cityVO);
    public void update(CityVO cityVO);
    public void delete(String city_id);
    public CityVO findByPrimaryKey(String city_id);
    public String findNameById(String city_id);
    public List<CityVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<CityVO> getAll(Map<String, String[]> map); 

}
