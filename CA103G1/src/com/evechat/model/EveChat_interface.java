package com.evechat.model;

import java.util.List;

import com.eventad.model.EventAdVO;

public interface EveChat_interface {
	public void insert(EveChatVO eveChatVO);
    public void updateEchatCont(EveChatVO eveChatVO);
    public void updateEchatStatus(String echat_id,String echat_status);
    public EveChatVO findByPrimaryKey(String echat_id);
    public List<EveChatVO> getAll();
    public List<EveChatVO> getEve_Echat(String eve_id);
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EventAdVO> getAll(Map<String, String[]> map);
//  public void delete(String ead_id);

}
