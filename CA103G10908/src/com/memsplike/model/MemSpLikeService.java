package com.memsplike.model;

import java.util.List;

public class MemSpLikeService {
	private MemSpLikeDAO_interface dao;
	
	public MemSpLikeService() {
		dao = new MemSpLikeDAO();
	}	
	public void insert(MemSpLikeVO memSpLikeVO) {
		dao.insert(memSpLikeVO);
	}	
	public void delete(String memid, String sptype_id) {
		dao.delete(memid, sptype_id);
	}	
	public void update(MemSpLikeVO memSpLikeVO){
		dao.update(memSpLikeVO);
	}
	
	public MemSpLikeVO getOneByMemIdAndSpTypeId( String memid, String sptype_id ) {
		return dao.findByMemIdAndSpTypeId(memid, sptype_id);
	}
	
	public List<MemSpLikeVO> findByMemId(String memid){
		return dao.findByMemId(memid);
	}
	public List<MemSpLikeVO> findBySpTypeId(String sptype_id){
		return dao.findBySpTypeId(sptype_id);
	}
	public List<MemSpLikeVO> getAll() {
		return dao.getAll();
	}	
}
