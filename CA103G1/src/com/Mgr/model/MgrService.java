package com.Mgr.model;

import java.util.List;

public class MgrService {
private MgrDAO_interface dao;
	
	public MgrService() {
		dao = new MgrJNDIDAO();
	}
	
	public MgrVO addMgr(String mgr_account,String mgr_name,String mgr_password,byte[] mgr_photo,String mgr_mail) {
		MgrVO mgrVO = new MgrVO();
		
		mgrVO.setMgr_account(mgr_account);
		mgrVO.setMgr_name(mgr_name);
		mgrVO.setMgr_password(mgr_password);
		mgrVO.setMgr_photo(mgr_photo);
		mgrVO.setMgr_mail(mgr_mail);
		
		dao.add(mgrVO);
		
		return mgrVO;
	}
	
	public MgrVO updateMgr(String mgr_id,String mgr_account,String mgr_name,String mgr_password,byte[] mgr_photo,String mgr_mail,String mgr_status) {
		
		MgrVO mgrVO = new MgrVO();
		mgrVO.setMgr_id(mgr_id);
		mgrVO.setMgr_account(mgr_account);
		mgrVO.setMgr_name(mgr_name);
		mgrVO.setMgr_password(mgr_password);
		mgrVO.setMgr_photo(mgr_photo);
		mgrVO.setMgr_mail(mgr_mail);
		mgrVO.setMgr_status(mgr_status);
		dao.update(mgrVO);
		
		return mgrVO;
	}
	
	public void deleteMgr(String mgr_id) {
		 dao.delete(mgr_id);
	}
	
	public MgrVO getOneMgr(String mgr_id) {
		return dao.findByPK(mgr_id);
		
	}
	
	public List<MgrVO> getAll(){
		return dao.getAll();
	}
	
	public MgrVO getMgrLogin(String mgr_account,String mgr_password) {
		return dao.findByLogin(mgr_account, mgr_password);
	}
	
	public MgrVO addMgrRg(String mgr_account,String mgr_name,String mgr_password,byte[] mgr_photo,String mgr_mail,String mgr_status) {
		
		MgrVO mgrVO = new MgrVO();
		
		mgrVO.setMgr_account(mgr_account);
		mgrVO.setMgr_name(mgr_name);
		mgrVO.setMgr_password(mgr_password);
		mgrVO.setMgr_photo(mgr_photo);
		mgrVO.setMgr_mail(mgr_mail);
		mgrVO.setMgr_status(mgr_status);
		dao.addmgr(mgrVO);
		
		return mgrVO;
	}
	
	public MgrVO getMgrLostPS(String mgr_account,String mgr_mail) {
		return dao.findByLostPS(mgr_account, mgr_mail);
	}
	
public MgrVO updateMgrDate(String mgr_id,String mgr_name,String mgr_password,byte[] mgr_photo) {
		
		MgrVO mgrVO = new MgrVO();
		
		mgrVO.setMgr_id(mgr_id);
		mgrVO.setMgr_name(mgr_name);
		mgrVO.setMgr_password(mgr_password);
		mgrVO.setMgr_photo(mgr_photo);
		
		dao.updateDate(mgrVO);
		
		return mgrVO;
	}

}
