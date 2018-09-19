package com.evechat.model;

import java.sql.Timestamp;
import java.util.List;

public class EveChatService {
	
	private EveChatDAO_interface dao;
	
	public EveChatService() {
		dao=new EveChatDAO();
	}
	
	public EveChatVO addEveChat(String mem_id, String eve_id, String echat_content,
			String echat_status) {
		
		EveChatVO eveChatVO=new EveChatVO();
		eveChatVO.setMem_id(mem_id);
		eveChatVO.setEve_id(eve_id);
		eveChatVO.setEchat_content(echat_content);
		eveChatVO.setEchat_status(echat_status);
		dao.insert(eveChatVO);
		return eveChatVO;
	
	}
	
	public EveChatVO updateEveChatContent(String echat_id,String echat_content) {
		EveChatVO eveChatVO=new EveChatVO();
		eveChatVO.setEchat_id(echat_id);
		eveChatVO.setEchat_content(echat_content);
		dao.updateEchatCont(eveChatVO);
		return eveChatVO;
	}
	
	public void updateEchatStatus(String echat_id,String echat_status) {
		dao.updateEchatStatus(echat_id, echat_status);
		
	}
	
	public EveChatVO getOneEchat(String echat_id) {
		return dao.findByPrimaryKey(echat_id);
	}
	
	public List<EveChatVO> getAll(){
		return dao.getAll();
	}
	
	public List<EveChatVO> getEchatsByEve(String eve_id){
		return dao.getEve_Echat(eve_id);
	}

}
