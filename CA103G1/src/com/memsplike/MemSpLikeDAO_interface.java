package com.memsplike;

import java.util.List;

public interface MemSpLikeDAO_interface {
	public void insert(MemSpLikeVO memSpLikeVO);
	public void update(MemSpLikeVO memSpLikeVO);
	public List<MemSpLikeVO> findByMemId(String memId);
	public List<MemSpLikeVO> findBySpTypeId(String sptype_id);
	public List<MemSpLikeVO> getAll();
}
