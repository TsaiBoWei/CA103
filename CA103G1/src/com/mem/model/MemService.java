package com.mem.model;

import java.sql.Date;
import java.util.List;

public class MemService {
	
	MemDAO_interface dao;
	
	public MemService() {
		dao = new MemDAO();
	}
	
	public MemVO addMem(String mem_account, String mem_name, String mem_password) {
		
		MemVO memVO = new MemVO();
		memVO.setMem_account(mem_account);
		memVO.setMem_name(mem_name);
		memVO.setMem_password(mem_password);
		memVO.setMem_status("MS0");
		dao.insert(memVO);
		
		return memVO;
	}
	
	public MemVO loginMem(String mem_account, String mem_password) {
		
		MemVO memVO = dao.logIn(mem_account, mem_password);
		return memVO;
	}
	
	public MemVO updateMem(String mem_id, String mem_name, String mem_account, String mem_password, Date mem_birth,
			byte[] mem_photo, String mem_email, String mem_intro) {
		
		MemVO memVO = new MemVO();
		memVO.setMem_id(mem_id);
		memVO.setMem_name(mem_name);
		memVO.setMem_account(mem_account);
		memVO.setMem_password(mem_password);
		memVO.setMem_birth(mem_birth);
		memVO.setMem_email(mem_email);
		memVO.setMem_photo(mem_photo);
		memVO.setMem_intro(mem_intro);
		dao.update(memVO);
		
		return memVO;
	}
	
	public void updateStatus(String mem_account, String mem_status) {
		dao.updateStatus(mem_account,mem_status);	
	}
	
	public MemVO getOneMem(String mem_id) {
		return dao.findByPrimaryKey(mem_id);
	}
	
	public List<MemVO> getAll() {
		return dao.getAll();
	}
	
}
