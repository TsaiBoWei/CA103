package com.evecomment.model;

import java.sql.Timestamp;
import java.util.List;

public class EveCommentService {
	
	private EveCommentDAO_interface dao;
	public EveCommentService() {
		dao =new EveCommentDAO();
	}
	
	public EveCommentVO addEveComm( String mem_id, String eve_id, String ecomment) {
		EveCommentVO eveCommentVO=new EveCommentVO();
		eveCommentVO.setMem_id(mem_id);
		eveCommentVO.setEve_id(eve_id);
		eveCommentVO.setEcomment(ecomment);
		dao.insert(eveCommentVO);
		return eveCommentVO;
				
	}
	
	public EveCommentVO updateEveComm( String ecomment_id, String ecomment) {
		EveCommentVO eveCommentVO=new EveCommentVO();
		eveCommentVO.setEcomment_id(ecomment_id);
		eveCommentVO.setEcomment(ecomment);
		dao.insert(eveCommentVO);
		return eveCommentVO;				
	}
	
	public void updateEveCommStatus(String ecomment_id,String ecom_status) {
		dao.updateStatus(ecomment_id, ecom_status);
	}
	
	public EveCommentVO getOneEveComm(String ecomment_id) {
		return dao.findByPrimaryKey(ecomment_id);
	}
	
	public List<EveCommentVO> getAll(){
		return dao.getAll();
	}

}
