package com.mem.model;

public class MemService {
	
	MemDAO_interface dao;
	
	public MemService() {
		dao = new MemDAO();
	}
	
	public MemVO addMem(String email, String memName, String psw) {
		
		MemVO memVO = new MemVO();
		memVO.setMemAcccount(email);
		memVO.setMemName(memName);
		memVO.setMemPsw(psw);
		memVO.setMemStatus("MS0");
		dao.insert(memVO);
		
		return memVO;
	}
	
}
