package com.mem.model;

import java.util.List;

public interface MemDAO_interface {
	public void insert(MemVO memVO);
	public void update(MemVO memVO);
	public void delete(String mem_id);
	public void updateStatus(String mem_id,String mem_status);
	public MemVO findByPrimaryKey(String mem_id);
	public MemVO logIn(String mem_account, String mem_password); //webµn¤J
	public MemVO findByAccountAndPassword(String mem_Account, String mem_Password);//Androidµn¤J
	public List<MemVO> getAll();
}
