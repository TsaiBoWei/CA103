package com.city.model;

import java.util.List;

public class CityService {
	
	private CityDAO_interface dao;
	
	public CityService() {
		dao=new CityDAO();
	}
	
	public CityVO getOneCity(String city_id) {
		return dao.findByPrimaryKey(city_id);
	}
	
	public String getCityName(String city_id) {
		return dao.findNameById(city_id);
	}
	
	public List<CityVO> getall(){
		return dao.getAll();
	}

}
