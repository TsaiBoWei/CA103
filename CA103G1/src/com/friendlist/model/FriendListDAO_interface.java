package com.friendlist.model;

import java.util.List;

public interface FriendListDAO_interface {
	void insert(FriendListVO friendlistVO);
	void update(FriendListVO friendlistVO);
	void delete(String fl_memA_id,String fl_memB_id);
	FriendListVO findByPrimaryKey(String fl_memA_id,String fl_memB_id);
	List<FriendListVO> getAll();
}
