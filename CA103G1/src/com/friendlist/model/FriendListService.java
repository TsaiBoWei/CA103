package com.friendlist.model;

import java.util.List;

import com.Post.model.PostVO;
import com.courlist.model.CourlistVO;
import com.eve.model.EventVO;
import com.plan.model.PlanVO;

public class FriendListService {
	
	private FriendListDAO_interface dao;
	private FriendListDAO_interface dao1;

	public FriendListService() {
		dao = new FriendListDAO();
		dao1=new FriendListDAO_index();
	}
	
	public FriendListVO addFriendList(String fl_memA_id,String fl_memB_id,String fl_friend_name,String fl_status,String fl_block) {
		FriendListVO friendlistVO = new FriendListVO();
		
		friendlistVO.setFl_memA_id(fl_memA_id);
		friendlistVO.setFl_memB_id(fl_memB_id);
		friendlistVO.setFl_friend_name(fl_friend_name);
		friendlistVO.setFl_status(fl_status);
		friendlistVO.setFl_block(fl_block);
		
		dao.insert(friendlistVO);
		return friendlistVO;
	}
	
	public FriendListVO UpdateFriendList(String fl_memA_id,String fl_memB_id,String fl_friend_name,String fl_status,String fl_block) {
		FriendListVO friendlistVO = new FriendListVO();
		
		friendlistVO.setFl_memA_id(fl_memA_id);
		friendlistVO.setFl_memB_id(fl_memB_id);
		friendlistVO.setFl_friend_name(fl_friend_name);
		friendlistVO.setFl_status(fl_status);
		friendlistVO.setFl_block(fl_block);
		dao.update(friendlistVO);
		
		return friendlistVO;
	}
	
	public void deleteFriendList(String fl_memA_id, String fl_memB_id) {
		dao.delete(fl_memA_id, fl_memB_id);
	}
	
	public FriendListVO getOneFriendList(String fl_memA_id, String fl_memB_id) {
		return dao.findByPrimaryKey(fl_memA_id, fl_memB_id);
	}
	
	public List<FriendListVO> getAll(){
		return dao.getAll();
	}
	
	public List<FriendListVO> findFriendListByMem(String fl_memA_id)  {
		return dao.findFriendListByMem(fl_memA_id);
	}
	
	public List<FriendListVO> findFriendListUncomfirmedByMem(String fl_memA_id)  {
		return dao.findFriendListUncomfirmedByMem(fl_memA_id);
	}
	
	

	//­º­¶¥Î
	public List<EventVO> getFriendEves(String fl_mema_id){
		return dao1.getFriendEves(fl_mema_id);
	};
	public List<EventVO> getFriendEvelist(String fl_mema_id){
		return dao1.getFriendEvelist(fl_mema_id);	
	};
	public List<FriendListVO> getFlByMem(String fl_mema_id,String fl_status){
		return dao1.getFlByMem(fl_mema_id, fl_status);
	}
	
	public List<CourlistVO> getFriendCour(String fl_mema_id){
		return dao1.getFriendCour(fl_mema_id);
	}
	
	public List<CourlistVO> getFriendPurCour(String fl_mema_id){
		return dao1.getFriendPurCour(fl_mema_id);
	}
	public List<PostVO> getFriendPost(String fl_mema_id){
		return dao1.getFriendPost(fl_mema_id);
	}
	public List<PlanVO> getFriendPlan(String fl_mema_id){
		return dao1.getFriendPlan(fl_mema_id);
		
	}
	
}
