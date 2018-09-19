package com.mem.model;

import java.util.List;

public interface MemDAO_interface {
	public void insert(MemVO memVO);
	public void update(MemVO memVO);
	public void delete(String memID);
	public void updateStatus(String mem_id,String status);
	public MemVO findByPrimaryKey(String memID);
	public List<MemVO> getAll();
}
