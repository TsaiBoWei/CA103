package com.purchcour.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;



public class PurchcourService {
	private PurchCourDAO_interface dao;
	
	public PurchcourService() {
		dao = new PurchCourDAO();
	}
	public String addPurchCour(Date crorder_time, String mem_id, String cour_id) {
		PurchCourVO purchCourVO= new PurchCourVO();
		purchCourVO.setCrorder_time(crorder_time);
		purchCourVO.setMem_id(mem_id);
		purchCourVO.setCour_id(cour_id);
		String crorder_id= dao.add(purchCourVO);

		return crorder_id;
	}
	public void updatePurchCourScore(Double coursco, String crorder_id) {
		 dao.updateScore(coursco,crorder_id);
	}
	
	public void updatePurchCourRefund(String refund, String crorder_id) {
		 dao.updateRefund(refund,crorder_id);
	}
	
	public List<PurchCourVO> getMemPurchCour(String mem_id) {
		return dao.findByMem_id(mem_id);
	}
	
	public List<PurchCourVO> searchByKeyWord(String keyWord, String mem_id) {
		return dao.findByKeyWord(keyWord,mem_id);
	}
	
	public List<String> findMemOwnCourse(String mem_id){
		return dao.findMemOwnCourse(mem_id);
	}
	
	public String getCrorder_idByCrMemId(String cour_id, String mem_id) {
		return dao.findByCourId_MenId(cour_id, mem_id);
	}
	 
	public Integer getCourCountNotRefund(String cour_id) {
		
		return dao.getCountByNotRefundCourId(cour_id);
	}
	
	public Integer getCourCountRefund(String cour_id) {
		
		return dao.getCountByRefundCourId(cour_id);
	}
	
	public List<PurchCourVO> getCourPurchCour(String cour_id) {

		return dao.findByCour_id(cour_id);
	}
	
	
	public PurchCourVO getonePurchCour(String crorder_id) {

		return dao.findByPK(crorder_id);
	}
	
	
	
	
}
