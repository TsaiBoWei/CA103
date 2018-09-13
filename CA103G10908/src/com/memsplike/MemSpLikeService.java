package com.memsplike;

import java.util.List;

public class MemSpLikeService {
	private MemSpLikeDAO_interface dao;
	
	public MemSpLikeService() {
		dao = new MemSpLikeDAO();
	}	
	public void insert(MemSpLikeVO memSpLikeVO) {
		dao.insert(memSpLikeVO);
	}
	public void update(MemSpLikeVO memSpLikeVO){
		dao.update(memSpLikeVO);
	}
	public List<MemSpLikeVO> findByMemId(String memId){
		return dao.findByMemId(memId);
	}
	public List<MemSpLikeVO> findBySpTypeId(String sptype_id){
		return dao.findBySpTypeId(sptype_id);
	}
	public List<MemSpLikeVO> getAll() {
		return dao.getAll();
	}
	
	
}
