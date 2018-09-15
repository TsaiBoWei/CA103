package com.memsplike.model;

import java.util.List;

public interface MemSpLikeDAO_interface {
	public void insert(MemSpLikeVO memSpLikeVO);
	public void delete(String memId, String sptype_id);
	public void update(MemSpLikeVO memSpLikeVO);
	public MemSpLikeVO findByMemIdAndSpTypeId(String memid, String sptype_id);
	public List<MemSpLikeVO> findByMemId(String memId);
	public List<MemSpLikeVO> findBySpTypeId(String sptype_id);
	public List<MemSpLikeVO> getAll();
}
