package com.eve.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

public class EveService {
	
	private EventDAO_interface dao;
	
	public EveService() {
		dao=new EveDAO();
	}
	
	public EventVO addEve(String mem_id, byte[] eve_photo, byte[] eve_logo, String eve_ptype, String eve_title,
			String eve_content, Timestamp eve_startdate, Timestamp eve_enddate, Date ereg_startdate, Date ereg_enddate,
			Integer estart_limit,Integer estart_max, String eve_status, String eve_location, Double eve_long, Double eve_lat,
			String city_id, String sptype_id, Integer eve_view, Integer eve_charge, String econtact_info) {
		
		
		EventVO eventVO=new EventVO();
		eventVO.setMem_id(mem_id);		
		eventVO.setEve_photo(eve_photo);
		eventVO.setEve_logo(eve_logo);
		eventVO.setEve_ptype(eve_ptype);
		eventVO.setEve_title(eve_title);
		eventVO.setEve_content(eve_content);
		eventVO.setEve_startdate(eve_startdate);
		eventVO.setEve_enddate(eve_enddate);
		eventVO.setEreg_startdate(ereg_startdate);
		eventVO.setEreg_enddate(ereg_enddate);
		eventVO.setEstart_limit(estart_limit);
		eventVO.setEstart_max(estart_max);
		eventVO.setEve_status(eve_status);
		eventVO.setEve_location(eve_location);
		eventVO.setEve_long(eve_long);
		eventVO.setEve_lat(eve_lat);
		eventVO.setCity_id(city_id);
		eventVO.setSptype_id(sptype_id);
		eventVO.setEve_view(eve_view);
		eventVO.setEve_charge(eve_charge);
		eventVO.setEcontact_info(econtact_info);
		
		dao.insert(eventVO);
		return eventVO;
		
	}
	
	public EventVO updateEve(String eve_id,String mem_id, byte[] eve_photo, byte[] eve_logo, String eve_ptype, String eve_title,
			String eve_content, Timestamp eve_startdate, Timestamp eve_enddate, Date ereg_startdate, Date ereg_enddate,
			Integer estart_limit,Integer estart_max, String eve_status, String eve_location, Double eve_long, Double eve_lat,
			String city_id, String sptype_id, Integer eve_view, Integer eve_charge, String econtact_info) {
		
		EventVO eventVO=new EventVO();
		eventVO.setEve_id(eve_id);
		eventVO.setMem_id(mem_id);		
		eventVO.setEve_photo(eve_photo);
		eventVO.setEve_logo(eve_logo);
		eventVO.setEve_ptype(eve_ptype);
		eventVO.setEve_title(eve_title);
		eventVO.setEve_content(eve_content);
		eventVO.setEve_startdate(eve_startdate);
		eventVO.setEve_enddate(eve_enddate);
		eventVO.setEreg_startdate(ereg_startdate);
		eventVO.setEreg_enddate(ereg_enddate);
		eventVO.setEstart_limit(estart_limit);
		eventVO.setEstart_max(estart_max);
		eventVO.setEve_status(eve_status);
		eventVO.setEve_location(eve_location);
		eventVO.setEve_long(eve_long);
		eventVO.setEve_lat(eve_lat);
		eventVO.setCity_id(city_id);
		eventVO.setSptype_id(sptype_id);
		eventVO.setEve_view(eve_view);
		eventVO.setEve_charge(eve_charge);
		eventVO.setEcontact_info(econtact_info);
	
		
		dao.update(eventVO);
		return eventVO;
		
	}
	
	public EventVO updateEveStatus(String eve_id,String eve_status) {
		dao.update_status(eve_id, eve_status);
		return dao.findByPrimaryKey(eve_id);		
	}
	
	public EventVO updatePhoto(byte[] eve_photo,String eve_id) {
		dao.updatePhoto(eve_photo, eve_id);
		return dao.findByPrimaryKey(eve_id);
	}
	
	
	public EventVO getOneEve(String eve_id) {
		return dao.findByPrimaryKey(eve_id);
	}
	
	public List<EventVO> getAll(){
		return dao.getAll();
	}
	
	public List<EventVO> getEvesByMem(String mem_id){
		return dao.getEvesByMem(mem_id);
	}
	
	public List<EventVO> getEvesInViewPage(){
		return dao.getAllinViewPage();
	}
	
	public List<EventVO> getReviewEves(){
		return dao.getReviewEves();
	}
	
	public List<EventVO> getCompositeQueryEves(Map<String, String[]> map){
		return dao.getAll(map);
	}
	
	public List<EventVO> getReviewEndEves(){
		return dao.getReviewEndEves();
	}
	
	public List<EventVO> getNewEves(){
		return dao.getNewEves();
	}
	public List<EventVO> getPopularEves(){
		return dao.getPopularEves();
	}
	
	
}
