package com.evechat.model;

import java.util.List;

import com.eventad.model.EventAdVO;

public interface EveChatDAO_interface {
	public void insert(EveChatVO eveChatVO);
    public void updateEchatCont(EveChatVO eveChatVO);
    public void updateEchatStatus(String echat_id,String echat_status);
    public EveChatVO findByPrimaryKey(String echat_id);
    public List<EveChatVO> getAll();
    public List<EveChatVO> getEve_Echat(String eve_id);
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<EventAdVO> getAll(Map<String, String[]> map);
//  public void delete(String ead_id);

}
