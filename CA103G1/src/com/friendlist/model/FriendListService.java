package com.friendlist.model;

import java.util.List;

public class FriendListService {
	
	private FriendListDAO_interface dao;

	public FriendListService() {
		dao = new FriendListDAO();
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
}
