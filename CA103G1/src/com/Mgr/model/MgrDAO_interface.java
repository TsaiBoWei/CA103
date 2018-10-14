package com.Mgr.model;

import java.util.List;

public interface MgrDAO_interface {
	void add(MgrVO mgrVO);
	void update(MgrVO mgrVO);
	void delete(String mgr_ID);
	MgrVO findByPK(String mgr_ID);
	List<MgrVO> getAll();
	
	void updateStatus(MgrVO mgrVO);
	MgrVO findByLogin(String mgr_account,String mgr_password);
	
	void addmgr(MgrVO mgrVO);
	
	MgrVO findByLostPS(String mgr_account,String mgr_mail);
	
	void updateDate(MgrVO mgrVO);
}
